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
#include "xadcps.h"
#include "Xscugic.h"
#include "Xil_exception.h"


//XADC info
#define XPAR_AXI_XADC_0_DEVICE_ID 0
//Interrupt Controller
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define INTR_ID				XPAR_XADCPS_INT_ID

static XAdcPs  XADCInst; //XADC
static XScuGic InterruptController;

static int SetupInterruptSystem(XScuGic *IntcInstancePtr,XAdcPs *XAdcPtr,u16 IntrId );
static int XAdcInterruptHandler(void *CallBackRef);
static void adc_config(XAdcPs *XADCInstPtr, u16 XAdcDeviceId);

int main()
{

	//static XAdcPs *XADCInstPtr; //xadc pointer

	//temperature readings
	//u32 TempRawData;
	//float TempData;


	int Status;

	init_platform();
	printf("Xcell Daily blog XADC part 43 \n\r");




	Status = SetupInterruptSystem(&InterruptController, &XADCInst, INTR_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}


	adc_config(&XADCInst,XPAR_AXI_XADC_0_DEVICE_ID );



    return 0;
}


static void adc_config(XAdcPs *XADCInstPtr, u16 XAdcDeviceId)
{

	u32 IntrStatus;
	XAdcPs_Config *ConfigPtr;           //xadc config
	u32 TempRawData;
	float TempData;

	//XADC initilization
	ConfigPtr = XAdcPs_LookupConfig(XPAR_AXI_XADC_0_DEVICE_ID);
	//adc set up
	XAdcPs_CfgInitialize(XADCInstPtr,ConfigPtr,ConfigPtr->BaseAddress);
	//stop sequencer
	XAdcPs_SetSequencerMode(XADCInstPtr,XADCPS_SEQ_MODE_SINGCHAN);
	//disable alarms
	XAdcPs_SetAlarmEnables(XADCInstPtr, 0x0);

	TempRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_TEMP);
	TempRawData = TempRawData+0x03FF;
	XAdcPs_SetAlarmThreshold(XADCInstPtr, XADCPS_ATR_TEMP_UPPER,(TempRawData));
	TempData = XAdcPs_RawToTemperature(TempRawData);
	printf("temp high alarm %lu Real Temp %f \n\r", TempRawData, TempData);

	TempRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_TEMP);
	TempRawData = TempRawData-0x03FF;
	XAdcPs_SetAlarmThreshold(XADCInstPtr, XADCPS_ATR_TEMP_LOWER,(TempRawData));
	TempData = XAdcPs_RawToTemperature(TempRawData);
	printf("temp low alarm %lu Real Temp %f \n\r", TempRawData, TempData);

//	printf("1\n\r");
	IntrStatus = XAdcPs_IntrGetStatus(XADCInstPtr);
//	printf("2 a %lu\n\r",IntrStatus);
	XAdcPs_IntrClear(XADCInstPtr, IntrStatus);
//	printf("2 b \n\r");
	IntrStatus = XAdcPs_IntrGetStatus(XADCInstPtr);
//	printf("2 c %lu\n\r",IntrStatus);
	XAdcPs_SetAlarmEnables(XADCInstPtr, XADCPS_CFR1_ALM_TEMP_MASK);
//	printf("3\n\r");
	XAdcPs_IntrEnable(XADCInstPtr,XADCPS_INTX_ALM0_MASK);//temp
//	printf("4\n\r");

	//configure sequencer to just sample internal on chip parameters
	XAdcPs_SetSeqInputMode(XADCInstPtr, XADCPS_SEQ_MODE_SAFE);
	//configure the channel enables we want to monitor
	XAdcPs_SetSeqChEnables(XADCInstPtr,XADCPS_CH_TEMP|XADCPS_CH_VCCINT|XADCPS_CH_VCCAUX|XADCPS_CH_VBRAM|XADCPS_CH_VCCPINT|
	     		XADCPS_CH_VCCPAUX|XADCPS_CH_VCCPDRO);

	while(1){

      TempRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_TEMP);
      TempData = XAdcPs_RawToTemperature(TempRawData);
    //  printf("Raw Temp %lu Real Temp %f \n\r", TempRawData, TempData);

     }
}

static int SetupInterruptSystem(XScuGic *IntcInstancePtr, XAdcPs *XAdcPtr,u16 IntrId )
{
	XScuGic_Config *IntcConfig; /* Instance of the interrupt controller */
	int Status;

	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig, IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	Status = XScuGic_Connect(IntcInstancePtr, IntrId,(Xil_InterruptHandler)XAdcInterruptHandler,(void *)XAdcPtr);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XScuGic_Enable(IntcInstancePtr, IntrId);

	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
				(Xil_ExceptionHandler) XScuGic_InterruptHandler,
				IntcInstancePtr);

	Xil_ExceptionEnable();
	return XST_SUCCESS;
}

static int XAdcInterruptHandler(void *CallBackRef)
{
	u32 IntrStatusValue;
	u32 TempRawData;
	float TempData;
	XAdcPs *XAdcPtr = (XAdcPs *)CallBackRef;

	IntrStatusValue = XAdcPs_IntrGetStatus(XAdcPtr);

	if (IntrStatusValue & XADCPS_INTX_ALM0_MASK) {
		/*
		 * Set Temperature interrupt flag so the code
		 * in application context can be aware of this interrupt.
		 */

		/* Disable Temperature interrupt */
		XAdcPs_IntrDisable(XAdcPtr,XADCPS_INTX_ALM0_MASK);
		printf("Temperature Interrupt %lu \n\r",IntrStatusValue);
		TempRawData = XAdcPs_GetAdcData(XAdcPtr, XADCPS_CH_TEMP);
		TempData = XAdcPs_RawToTemperature(TempRawData);
		printf("Raw Temp %lu Real Temp %f \n\r", TempRawData, TempData);

	}

	/*
	 * Clear all bits in Interrupt Status Register.
	 */
	XAdcPs_IntrClear(XAdcPtr, IntrStatusValue);

 }
