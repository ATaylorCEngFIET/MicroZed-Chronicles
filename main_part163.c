/*Copyright (c) 2017, Adam Taylor
All rights reserved.
Redistribution and use in source and binary forms, with or without
modification, are permitted provided that the following conditions are met:
1. Redistributions of source code must retain the above copyright notice, this
   list of conditions and the following disclaimer. 
2. Redistributions in binary form must reproduce the above copyright notice,
   this list of conditions and the following disclaimer in the documentation
   and/or other materials provided with the distribution.
THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
The views and conclusions contained in the software and documentation are those
of the authors and should not be interpreted as representing official policies, 
either expressed or implied, of the FreeBSD Project*/

#include <stdio.h>
#include "platform.h"
#include "xgpiops.h"
#include "xil_types.h"
#include "Xscugic.h"
#include "Xil_exception.h"
#include "unistd.h"
#include "xpseudo_asm.h"
#include "xreg_cortexa9.h"

#define wfi() __asm__("wfi")

#define GPIO_DEVICE_ID		XPAR_XGPIOPS_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define GPIO_INTERRUPT_ID	XPS_GPIO_INT_ID

#define l2cpl310_reg15 	0xF8F02F80
#define scu_control_reg 0xF8F00000
#define topsw_clk 		0xF800016C
#define slcr_unlock 	0xF8000008
#define ddrc_ctrl_reg1 	0xF8006060
#define ddrc_para_reg3 	0xF8006020
#define ddr_clk_ctrl 	0xF8000124
#define dci_clk_ctrl 	0xF8000128
#define arm_pll_ctrl 	0xF8000100
#define ddr_pll_ctrl 	0xF8000104
#define io_pll_ctrl  	0xF8000108
#define arm_clk_ctrl 	0xF8000120
#define gpio_int_en0 	0xE000A210
#define pll_status 		0xF800010C
#define uart_sel	    0xF8000154
#define aper_reg        0xF800012C

#define ledpin 47
#define pbsw 51

static XScuGic Intc; /* The Instance of the Interrupt Controller Driver */
static XGpioPs Gpio; /* The driver instance for GPIO Device. */
int toggle;//used to toggle the LED
static void SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio, u16 GpioIntrId);
static void IntrHandler(void *CallBackRef, int Bank, u32 Status);

int main()
{
	int Status;

	XGpioPs_Config *GPIOConfigPtr;

	init_platform();

    printf("low power example\n\r");

    //GPIO Initilization
    GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    Status = XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);
    	if (Status != XST_SUCCESS) {
    		 print("GPIO INIT FAILED\n\r");
    		return XST_FAILURE;
    	}

    //set direction and enable output
    XGpioPs_SetDirectionPin(&Gpio, ledpin, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, ledpin, 1);

    //set direction input pin
    XGpioPs_SetDirectionPin(&Gpio, pbsw, 0x0);

    SetupInterruptSystem(&Intc, &Gpio, GPIO_INTERRUPT_ID);

	u32 data;

	XGpioPs_WritePin(&Gpio, ledpin, 1);

	//cpsidf();

	Xil_Out32(slcr_unlock,0xDF0D);//unlock SLCR registers for writing first

	data = Xil_In32(aper_reg);  //clock gate unused peripherals
	printf("aper_reg = %x\n\r", (unsigned int) data);
	data = 0x1600001;
	Xil_Out32(aper_reg,data);
	data = Xil_In32(aper_reg);
	printf("aper_reg = %x\n\r", (unsigned int) data);

	data = Xil_In32(arm_clk_ctrl);  //clock gate unused peripherals
	printf("arm_clk_ctrl = %x\n\r", (unsigned int) data);

	//data = Xil_In32(uart_sel);
	//printf("uart_sel = %x\n\r", (unsigned int) data);
	//data |= 0x00000030;
	//Xil_Out32(uart_sel,data);
	data = Xil_In32(uart_sel);
	printf("uart_sel = %x\n\r", (unsigned int) data);
	usleep(1000000);
	data = Xil_In32(arm_clk_ctrl);
	printf("arm_clk_ctrl = %x\n\r", (unsigned int) data);
	//data = Xil_In32(gpio_int_en0);
	data = 0x00000400;
	Xil_Out32(gpio_int_en0,data);
	data = Xil_In32(gpio_int_en0);
	printf("gpio_int_en0 = %x\n\r", (unsigned int) data);
	usleep(1000000);

//configure cache for low power mode
	data = Xil_In32(l2cpl310_reg15);
	printf("ls cache reg 15 power = %x\n\r", (unsigned int) data);
	data = 0x3; //enable standby mode and dynamic clock gating
	Xil_Out32(l2cpl310_reg15,data);
	data = Xil_In32(l2cpl310_reg15);
	printf("ls cache reg 15 power = %x\n\r", (unsigned int) data);
	usleep(1000000);

//configure scu
	data = Xil_In32(scu_control_reg);
	printf("scu control reg = %x\n\r", (unsigned int) data);
	data |=  0x00000020; //enable standby mode and dynamic clock gating
	Xil_Out32(scu_control_reg,data);
	data = Xil_In32(scu_control_reg);
	printf("scu control reg = %x\n\r", (unsigned int) data);
	usleep(1000000);

//configure slcr
	data = Xil_In32(topsw_clk);
	printf("slcr control reg = %x\n\r", (unsigned int) data);
	data |=  0x00000001; //enable standby mode and dynamic clock gating
	Xil_Out32(topsw_clk,data);
	data = Xil_In32(topsw_clk);
	printf("slcr control reg = %x\n\r", (unsigned int) data);
	usleep(1000000);

//set CP15
	data = mfcp(XREG_CP15_POWER_CTRL);
	printf("cp15 Reg = %x\n\r", (unsigned int) data);

	mtcp(XREG_CP15_POWER_CTRL,0x701);
	data = mfcp(XREG_CP15_POWER_CTRL);
	printf("cp15 Reg = %x\n\r", (unsigned int) data);
	usleep(1000000);

//set up ddr
	data = Xil_In32(ddrc_ctrl_reg1);
	data |= 0x00001000; //enable standby mode and dynamic clock gating
	Xil_Out32(ddrc_ctrl_reg1,data);

	data = Xil_In32(ddrc_para_reg3);
	data |= 0x00100000; //enable standby mode and dynamic clock gating
	Xil_Out32(ddrc_para_reg3,data);

	data = Xil_In32(ddr_clk_ctrl);
	data &= 0xFFFFFFF0; //enable standby mode and dynamic clock gating
	Xil_Out32(ddr_clk_ctrl,data);

	data = Xil_In32(dci_clk_ctrl);
	data &= 0xFFFFFFF0; //enable standby mode and dynamic clock gating
	Xil_Out32(dci_clk_ctrl,data);

//	arm_pll_ctrl
	data = Xil_In32(arm_pll_ctrl);
	data |= 0x00000010; //enable standby mode and dynamic clock gating
	Xil_Out32(arm_pll_ctrl,data);

	data = Xil_In32(ddr_pll_ctrl);
	data |= 0x00000010; //enable standby mode and dynamic clock gating
	Xil_Out32(ddr_pll_ctrl,data);

	data = Xil_In32(io_pll_ctrl);
	data |= 0x00000010; //enable standby mode and dynamic clock gating
	Xil_Out32(io_pll_ctrl,data);

	data = Xil_In32(arm_pll_ctrl);
	data |= 0x00000002; //enable standby mode and dynamic clock gating
	Xil_Out32(arm_pll_ctrl,data);

	data = Xil_In32(ddr_pll_ctrl);
	data |= 0x00000002; //enable standby mode and dynamic clock gating
	Xil_Out32(ddr_pll_ctrl,data);

	data = Xil_In32(io_pll_ctrl);
	data |= 0x00000002; //enable standby mode and dynamic clock gating
	Xil_Out32(io_pll_ctrl,data);

	data = Xil_In32(arm_clk_ctrl);
	data |= 0x0003f00; //enable standby mode and dynamic clock gating
	Xil_Out32(arm_clk_ctrl,data);


	wfi();

	XGpioPs_WritePin(&Gpio, ledpin, 0);
	while(1){

	toggle = !toggle;
	//XGpioPs_WritePin(&Gpio, ledpin, toggle);
	//printf("hello world\n\r");
	usleep(1000000);

    }

    return 0;
}

static void SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio, u16 GpioIntrId)
{


		XScuGic_Config *IntcConfig; /* Instance of the interrupt controller */

		Xil_ExceptionInit();

		/*
		 * Initialize the interrupt controller driver so that it is ready to
		 * use.
		 */
		IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);

		XScuGic_CfgInitialize(GicInstancePtr, IntcConfig,
						IntcConfig->CpuBaseAddress);

		/*
		 * Connect the interrupt controller interrupt handler to the hardware
		 * interrupt handling logic in the processor.
		 */
		Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
					(Xil_ExceptionHandler)XScuGic_InterruptHandler,
					GicInstancePtr);

		/*
		 * Connect the device driver handler that will be called when an
		 * interrupt for the device occurs, the handler defined above performs
		 * the specific interrupt processing for the device.
		 */
		XScuGic_Connect(GicInstancePtr, GpioIntrId,
					(Xil_ExceptionHandler)XGpioPs_IntrHandler,
					(void *)Gpio);

		//Enable  interrupts for all the pins in bank 1.
		XGpioPs_SetIntrTypePin(Gpio, pbsw, XGPIOPS_IRQ_TYPE_LEVEL_HIGH);

		//Set the handler for gpio interrupts.
		XGpioPs_SetCallbackHandler(Gpio, (void *)Gpio, IntrHandler);
		XGpioPs_IntrClear(Gpio, 1,0xFFFFFFFF);
		//Enable the GPIO interrupts of Bank 1.
		XGpioPs_IntrEnablePin(Gpio, pbsw);

		//Enable the interrupt for the GPIO device.
		XScuGic_Enable(GicInstancePtr, GpioIntrId);

		// Enable interrupts in the Processor.
		Xil_ExceptionEnableMask(XIL_EXCEPTION_ALL);
	}

static void IntrHandler(void *CallBackRef, int Bank, u32 Status)
{
	u32 ddrc;
	XGpioPs_WritePin(&Gpio, ledpin, 0);
	ddrc = 0x1177cb4; //enable standby mode and dynamic clock gating
	Xil_Out32(arm_clk_ctrl,ddrc);

	ddrc = Xil_In32(io_pll_ctrl);
	//printf("io_pll_ctrl = %x\n\r", (unsigned int) ddrc);
	ddrc &= ~0x00000002; //remove standby mode and dynamic clock gating
	Xil_Out32(io_pll_ctrl,ddrc);

	ddrc = Xil_In32(ddr_pll_ctrl);
	//printf("ddr_pll_ctrl = %x\n\r", (unsigned int) ddrc);
	ddrc &= ~0x00000002; //remove standby mode and dynamic clock gating
	Xil_Out32(ddr_pll_ctrl,ddrc);

	ddrc = Xil_In32(arm_pll_ctrl);
	//printf("arm_pll_ctrl = %x\n\r", (unsigned int) ddrc);
	ddrc &= ~0x00000002; //remove standby mode and dynamic clock gating
	Xil_Out32(arm_pll_ctrl,ddrc);

	ddrc = Xil_In32(pll_status);
	while(ddrc != 0x0000003f){ //wait for DLL to lock and be stable
		ddrc = Xil_In32(pll_status);
	}

	ddrc = Xil_In32(arm_pll_ctrl);
	//printf("arm_pll_ctrl = %x\n\r", (unsigned int) ddrc);
	ddrc &= ~0x00000010; //enable standby mode and dynamic clock gating
	Xil_Out32(arm_pll_ctrl,ddrc);
	ddrc = Xil_In32(arm_pll_ctrl);
	//printf("arm_pll_ctrl = %x\n\r", (unsigned int) ddrc);

	ddrc = Xil_In32(ddr_pll_ctrl);
	//printf("ddr_pll_ctrl = %x\n\r", (unsigned int) ddrc);
	ddrc &= ~0x00000010; //enable standby mode and dynamic clock gating
	Xil_Out32(ddr_pll_ctrl,ddrc);
	ddrc = Xil_In32(ddr_pll_ctrl);
	//printf("ddr_pll_ctrl = %x\n\r", (unsigned int) ddrc);

	ddrc = Xil_In32(io_pll_ctrl);
	ddrc &= ~0x00000010; //enable standby mode and dynamic clock gating
	Xil_Out32(io_pll_ctrl,ddrc);
	ddrc = Xil_In32(io_pll_ctrl);



	XGpioPs_IntrDisablePin(&Gpio, pbsw);
	//printf("****button pressed****\n\r");


	//usleep(1000000);
	XGpioPs_IntrClear(&Gpio, 1,0xFFFFFFFF); //clear interrupts after delay to remove bounce
	XGpioPs_IntrEnablePin(&Gpio, pbsw);
}
