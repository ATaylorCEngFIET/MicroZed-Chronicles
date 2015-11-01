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
#include "xtmrctr.h"
#include "xil_exception.h"
#include "xscugic.h"
#include "xgpiops.h"
#include "xil_cache.h"

#define TMRCTR_DEVICE_1			XPAR_TMRCTR_0_DEVICE_ID
#define TMRCTR_DEVICE_2			XPAR_AXI_TIMER_1_DEVICE_ID
#define TMRCTR_INTERRUPT_ID		XPS_IRQ_INT_ID
#define TMRCTR_FINTERRUPT_ID	XPS_FIQ_INT_ID
#define INTC_DEVICE_ID			XPAR_PS7_SCUTIMER_0_DEVICE_ID
#define TIMER_CNTR_0	 		0
#define VALUE_ZERO	 			0xF0000000
#define VALUE_ONE	 			0xF8035280
#define FREEZE_ZERO				54
#define FREEZE_ONE				55

XScuGic InterruptController;
XTmrCtr Timer1CounterInst;
XTmrCtr Timer2CounterInst;
XGpioPs Gpio;

static void TmrCtrSetupIntrSystem(XScuGic* IntcInstancePtr,
				XTmrCtr* InstancePtr,
				XTmrCtr* InstancePtr2,
				u16 IntrId,
				u16 IntrId2,
				u8 TmrCtrNumber);

void Timer1CounterHandler(void *CallBackRef, u8 TmrCtrNumber);
void Timer2CounterHandler(void *CallBackRef, u8 TmrCtrNumber);

int main()
{


	XGpioPs_Config *GPIOConfigPtr;

    init_platform();

   // uncomment these to test with the caches disabled
   // Xil_DCacheDisable();
   // Xil_ICacheDisable();
	GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
	XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);

	XGpioPs_SetDirectionPin(&Gpio, FREEZE_ZERO, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, FREEZE_ZERO, 1);
	XGpioPs_SetDirectionPin(&Gpio, FREEZE_ONE, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, FREEZE_ONE, 1);

    printf("Interrupt Latency Demonstration\n\r");

	XTmrCtr_Initialize(&Timer1CounterInst, TMRCTR_DEVICE_1);
	XTmrCtr_Initialize(&Timer2CounterInst, TMRCTR_DEVICE_2);

	TmrCtrSetupIntrSystem(&InterruptController,&Timer1CounterInst,&Timer2CounterInst,
						TMRCTR_INTERRUPT_ID,TMRCTR_FINTERRUPT_ID,TIMER_CNTR_0);

	XTmrCtr_SetHandler(&Timer1CounterInst, Timer1CounterHandler,&Timer1CounterInst);
	XTmrCtr_SetHandler(&Timer2CounterInst, Timer2CounterHandler,&Timer2CounterInst);
	XTmrCtr_SetOptions(&Timer1CounterInst, TIMER_CNTR_0,XTC_INT_MODE_OPTION|XTC_AUTO_RELOAD_OPTION);
	XTmrCtr_SetOptions(&Timer2CounterInst, TIMER_CNTR_0,XTC_INT_MODE_OPTION|XTC_AUTO_RELOAD_OPTION);
	XTmrCtr_SetResetValue(&Timer1CounterInst, TIMER_CNTR_0, VALUE_ZERO);
	XTmrCtr_SetResetValue(&Timer2CounterInst, TIMER_CNTR_0, VALUE_ONE);
	XTmrCtr_Start(&Timer1CounterInst, TIMER_CNTR_0);
	XTmrCtr_Start(&Timer2CounterInst, TIMER_CNTR_0);

	while(1){}


}

//ISR which reads at the value from the timer

void Timer1CounterHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	u32 value;
	u32 result;
	float int_process;
	value = XTmrCtr_GetValue(&Timer1CounterInst, TIMER_CNTR_0);
	result = value - VALUE_ZERO;
	int_process = (float)result * 10e-9;
	printf("Interrupt nIRQ count %x difference %d time %0.9f\n\r",(unsigned int) value,(int) result, int_process);

}

//ISR which freezes the value of the timer

//void Timer1CounterHandler(void *CallBackRef, u8 TmrCtrNumber)
//{
//
//	//int i;
//	u32 value;
//	u32 result;
//	float int_process;
//	XGpioPs_WritePin(&Gpio, FREEZE_ZERO, 1);
//	value = XTmrCtr_GetValue(&Timer1CounterInst, TIMER_CNTR_0);
//	result = value - VALUE_ZERO;
//	int_process = (float)result * 10e-9;
//	printf("Interrupt nIRQ count %x difference %d time %0.9f\n\r",(unsigned int) value,(int) result, int_process);
//	XGpioPs_WritePin(&Gpio, FREEZE_ZERO, 0);
//
//}

//ISR which freezes the value of the timer

//void Timer2CounterHandler(void *CallBackRef, u8 TmrCtrNumber)
//{
//
//	u32 value;
//	u32 result;
//	float int_process;
//	XGpioPs_WritePin(&Gpio, FREEZE_ONE, 1);
//	value = XTmrCtr_GetValue(&Timer2CounterInst, TIMER_CNTR_0);
//	result = value - VALUE_ONE;
//	int_process = (float)result * 10e-9;
//	printf("Interrupt fIRQ count %x difference %d time %0.9f\n\r",(unsigned int) value,(int) result, int_process);
//	XGpioPs_WritePin(&Gpio, FREEZE_ONE, 0);
//
//}

//ISR which reads at the value from the timer

void Timer2CounterHandler(void *CallBackRef, u8 TmrCtrNumber)
{
	u32 value;
	u32 result;
	float int_process;
	value = XTmrCtr_GetValue(&Timer2CounterInst, TIMER_CNTR_0);
	result = value - VALUE_ONE;
	int_process = (float)result * 10e-9;
	printf("Interrupt fIRQ count %x difference %d time %0.9f\n\r",(unsigned int) value,(int) result, int_process);
}

// function which sets up the interrupts.

static void TmrCtrSetupIntrSystem(XScuGic* IntcInstancePtr,
				XTmrCtr* InstancePtr,
				XTmrCtr* InstancePtr2,
				u16 IntrId,
				u16 IntrId2,
				u8 TmrCtrNumber)
{
	XScuGic_Config *IntcConfig;


	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);

	XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);

	XScuGic_Connect(IntcInstancePtr, IntrId,
				 (Xil_ExceptionHandler)XTmrCtr_InterruptHandler,
				 InstancePtr);

	XScuGic_Connect(IntcInstancePtr, IntrId2,
				 (Xil_ExceptionHandler)XTmrCtr_InterruptHandler,
				 InstancePtr2);

	XScuGic_Enable(IntcInstancePtr, IntrId);
	XScuGic_Enable(IntcInstancePtr, IntrId2);

	Xil_ExceptionInit();

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_FIQ_INT,
					(Xil_ExceptionHandler)
					XScuGic_InterruptHandler,
					IntcInstancePtr);

	Xil_ExceptionEnableMask(XIL_EXCEPTION_ALL);

	Xil_Out32(0xf8f00100,0xF);

}


