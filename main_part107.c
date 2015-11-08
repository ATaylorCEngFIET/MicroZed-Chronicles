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
#include "xsysmon.h"
#include "xscugic.h"
#include "Xil_exception.h"

#define SYSMON_DEVICE_ID 	XPAR_SYSMON_0_DEVICE_ID
#define INTR_ID				XPS_IRQ_INT_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID

#define TX_BUFFER_SIZE	1
#define RX_BUFFER_SIZE  64

XSysMon SysMonInst;
XScuGic InterruptController;

u32 XADC_Buf[RX_BUFFER_SIZE];
int samples;

static int SetupInterruptSystem(XScuGic *IntcInstancePtr, XSysMon *XAdcPtr,u16 IntrId );
void XAdcInterruptHandler(void *CallBackRef);

int main()
{
	u32 IntrStatusValue;
	int Status;
	XSysMon_Config *ConfigPtr;
	XSysMon *SysMonInstPtr = &SysMonInst;

	init_platform();
	printf("we are up!!!\n");

	ConfigPtr = XSysMon_LookupConfig(SYSMON_DEVICE_ID);
	if (ConfigPtr == NULL) {
			xil_printf("no config\r\n");
			return XST_FAILURE;
	}

	XSysMon_CfgInitialize(SysMonInstPtr, ConfigPtr, ConfigPtr->BaseAddress);

	Status = SetupInterruptSystem(&InterruptController, &SysMonInst, INTR_ID);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XSysMon_SetSequencerMode(SysMonInstPtr, XSM_SEQ_MODE_SAFE);
	XSysMon_SetSequencerMode(SysMonInstPtr, XSM_SEQ_MODE_SINGCHAN);
	XSysMon_SetSingleChParams(SysMonInstPtr,XSM_CH_VPVN,1,0,0);
	XSysMon_SetAlarmEnables(SysMonInstPtr, 0x0);
	XSysMon_SetCalibEnables(SysMonInstPtr,XSM_CFR1_CAL_VALID_MASK );
	XSysMon_GetStatus(SysMonInstPtr); /* Clear the old status */

	IntrStatusValue = Xil_In16(ConfigPtr->BaseAddress+XSM_CFR0_OFFSET);
	printf("CFG0 %x \n",(unsigned int) IntrStatusValue);
	IntrStatusValue = Xil_In16(ConfigPtr->BaseAddress+XSM_CFR1_OFFSET);
	printf("CFG1 %x \n",(unsigned int)IntrStatusValue);
	IntrStatusValue = Xil_In16(ConfigPtr->BaseAddress+XSM_CFR2_OFFSET);
	printf("CFG2 %x \n",(unsigned int)IntrStatusValue);
	IntrStatusValue = Xil_In16(ConfigPtr->BaseAddress+XSM_IPIER_OFFSET);
	printf("Interrupt Enable register %x \n",(unsigned int)IntrStatusValue);
	IntrStatusValue = Xil_In16(ConfigPtr->BaseAddress+XSM_GIER_OFFSET);
	printf("Global Int Enable %x \n",(unsigned int)IntrStatusValue);
	printf("configured\n");
	samples = 0;
	XSysMon_IntrEnable(SysMonInstPtr, XSM_IPIXR_EOC_MASK);
	XSysMon_IntrGlobalEnable(SysMonInstPtr);

while(1){

}

}

static int SetupInterruptSystem(XScuGic *IntcInstancePtr, XSysMon *XAdcPtr,u16 IntrId )
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

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_FIQ_INT,
					(Xil_ExceptionHandler)
					XScuGic_InterruptHandler,
					IntcInstancePtr);

	Xil_ExceptionEnableMask(XIL_EXCEPTION_ALL);

	Xil_Out32(0xf8f00100,0xF);
	return XST_SUCCESS;
}

void XAdcInterruptHandler(void *CallBackRef)
{
	int Index;

	if (samples < RX_BUFFER_SIZE ){
		XADC_Buf[samples] = XSysMon_GetAdcData(&SysMonInst, XSM_CH_VPVN);
		samples ++;
	}
	else{
		for(Index =0; Index <RX_BUFFER_SIZE; Index++){
			printf("%d\n", (int)(XADC_Buf[Index]>>4)); //shift as 12 bits are the MS 12 bits
		}
		XSysMon_IntrGlobalDisable(&SysMonInst);
	}

	XSysMon_IntrClear(&SysMonInst, XSM_IPIXR_EOC_MASK);

 }






