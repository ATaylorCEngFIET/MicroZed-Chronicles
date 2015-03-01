/*Copyright (c) 2015, Adam Taylor
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
#include "xparameters.h"
#include "Xscugic.h"
#include "Xil_exception.h"
#include "xgpiops.h"

#define FPGA_INT		    XPS_IRQ_INT_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define intpin 				54
#define pbsw 				51
#define GPIO_DEVICE_ID		XPAR_XGPIOPS_0_DEVICE_ID
#define GPIO_INTERRUPT_ID	XPS_GPIO_INT_ID

static void FPGAIntrHandler(void *CallBackRef);
static void SetupInterruptSystem(XScuGic *GicInstancePtr, u32 *FPGAPtr, u16 FPGAIntrId,
		XGpioPs *Gpio, u16 GpioIntrId);
static void GPIOIntrHandler(void *CallBackRef, int Bank, u32 Status);

static XScuGic Intc; //GIC
static XGpioPs Gpio; //GPIO
static u32 FPGA;

int main()
{
	XGpioPs_Config *GPIOConfigPtr;      //gpio config
	//int io;



	init_platform();

	//GPIO Initilization
	GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
	XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);
	//set direction and enable output

	XGpioPs_SetDirectionPin(&Gpio, intpin, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, intpin, 1);
	XGpioPs_WritePin(&Gpio, intpin, 0);

    //set direction input pin
    XGpioPs_SetDirectionPin(&Gpio, pbsw, 0);

    SetupInterruptSystem(&Intc,&FPGA,FPGA_INT,&Gpio, GPIO_INTERRUPT_ID);

    printf("system running\n\r");
while(1){
}

    return 0;

}

static void SetupInterruptSystem(XScuGic *GicInstancePtr, u32 *FPGAPtr, u16 FPGAIntrId,
		 XGpioPs *Gpio, u16 GpioIntrId)
{


		XScuGic_Config *IntcConfig; //GIC config
		Xil_ExceptionInit();

		//initialise the GIC
		IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
		XScuGic_CfgInitialize(GicInstancePtr, IntcConfig,
						IntcConfig->CpuBaseAddress);

		//connect to the hardware
		Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
					(Xil_ExceptionHandler)XScuGic_InterruptHandler,
					GicInstancePtr);

		//set up the timer interrupt
		XScuGic_Connect(GicInstancePtr, FPGAIntrId,
						(Xil_ExceptionHandler)FPGAIntrHandler,
						(void *)FPGAPtr);

	    //set up the GPIO interrupt
		XScuGic_Connect(GicInstancePtr, GpioIntrId,
						(Xil_ExceptionHandler)XGpioPs_IntrHandler,
						(void *)Gpio);

		//Enable  interrupts for all the pins in bank 0.
		XGpioPs_SetIntrTypePin(Gpio, pbsw, XGPIOPS_IRQ_TYPE_EDGE_RISING);
		//Set the handler for gpio interrupts.
		XGpioPs_SetCallbackHandler(Gpio, (void *)Gpio, GPIOIntrHandler);
		//Enable the GPIO interrupts of Bank 0.
		XGpioPs_IntrEnablePin(Gpio, pbsw);
		//Enable the interrupt for the GPIO device.
		XScuGic_Enable(GicInstancePtr, GpioIntrId);

		//enable the interrupt for the Timer at GIC
		XScuGic_Enable(GicInstancePtr, FPGAIntrId);

		// Enable interrupts in the Processor.
		Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);
		printf("Interrupt Set Up\n\r");
	}

static void FPGAIntrHandler(void *CallBackRef)
{

	printf("FPGA Interrupt Event\n\r");
	XGpioPs_WritePin(&Gpio, intpin, 0);

}

static void GPIOIntrHandler(void *CallBackRef, int Bank, u32 Status)
{
	printf("Push button Interrupt Event\n\r");
	XGpioPs *Gpioint = (XGpioPs *)CallBackRef;
	XGpioPs_WritePin(&Gpio, intpin, 1);
	XGpioPs_IntrClearPin(Gpioint, pbsw);

}
