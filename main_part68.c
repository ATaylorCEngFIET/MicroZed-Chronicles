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
#include "xaxidma.h"
#include"xil_io.h"
#include "xsysmon.h"


//void print(char *str);

#define DMA_DEV_ID			XPAR_AXIDMA_0_DEVICE_ID
#define DDR_BASE_ADDR		XPAR_AXIDMA_0_BASEADDR

#define RX_BUFFER_BASE		(0x00100000)
#define MAX_PKT_LEN			0x40

#define SYSMON_DEVICE_ID	XPAR_SYSMON_0_DEVICE_ID
static XSysMon SysMonInst;




int main()
{

	XAxiDma_Config *CfgPtr;
	XAxiDma AxiDma;

	XSysMon_Config *SYSConfigPtr ;
	XSysMon* SysMonInstPtr = &SysMonInst;

	int Status;

	int i;
	u8 *RxBufferPtr;
	u32 value;
	u32 addr;
	u16 TempData;
	//u16 VccauxData;
	int Temp;
	int reset_done;

    init_platform();

    printf("AXI DMA Example From XADC to On Chip Memory \n\r");

    SYSConfigPtr = XSysMon_LookupConfig(SYSMON_DEVICE_ID);
    if (SYSConfigPtr == NULL) {
        return XST_FAILURE;
    }

    XSysMon_CfgInitialize(SysMonInstPtr, SYSConfigPtr, SYSConfigPtr->BaseAddress);

    CfgPtr = XAxiDma_LookupConfig(DMA_DEV_ID);
    if (!CfgPtr) {
    	printf("No config found for %d\r\n", DMA_DEV_ID);
    	return XST_FAILURE;
    }

    Status = XAxiDma_CfgInitialize(&AxiDma, CfgPtr);
    if (Status != XST_SUCCESS) {
    	printf("Initialization failed %d\r\n", Status);
    	return XST_FAILURE;
    }

    XSysMon_SetSequencerMode(SysMonInstPtr, XSM_SEQ_MODE_SAFE);
    XSysMon_SetAlarmEnables(SysMonInstPtr, 0x0);
    XSysMon_SetSeqChEnables(SysMonInstPtr, XSM_SEQ_CH_TEMP);
    XSysMon_SetAdcClkDivisor(SysMonInstPtr, 32);
    XSysMon_SetSequencerMode(SysMonInstPtr, XSM_SEQ_MODE_CONTINPASS);
    TempData = XSysMon_GetAdcData(SysMonInstPtr, XSM_CH_TEMP);
    Temp = XSysMon_RawToTemperature(TempData);

    printf("%u \r\n",TempData);
    printf("%d \r\n",Temp);

    XSysMon_SetSequencerMode(SysMonInstPtr, XSM_SEQ_MODE_SINGCHAN);
    XSysMon_SetSingleChParams(SysMonInstPtr, XSM_CH_VPVN,FALSE, FALSE, FALSE);

    RxBufferPtr = (u8 *)RX_BUFFER_BASE;

    addr = (u32)RX_BUFFER_BASE;

    /* Disable interrupts, we use polling mode
    */

    XAxiDma_Reset(&AxiDma);
    reset_done = XAxiDma_ResetIsDone(&AxiDma);

    while(reset_done != 1){

    }

    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,XAXIDMA_DEVICE_TO_DMA);
    XAxiDma_IntrDisable(&AxiDma, XAXIDMA_IRQ_ALL_MASK,XAXIDMA_DMA_TO_DEVICE);

    Xil_Out32(0x60000000,0x0000040);


    Status = XAxiDma_SimpleTransfer(&AxiDma,(u32) RX_BUFFER_BASE,0x100, XAXIDMA_DEVICE_TO_DMA);
    if (Status != XST_SUCCESS) {
    	printf("XFER failed %d\r\n", Status);
    	return XST_FAILURE;

    }
    printf("AXI DMA Example From XADC to On Chip Memory nearly Completed\n\r");


    while ((XAxiDma_Busy(&AxiDma,XAXIDMA_DEVICE_TO_DMA))) {
    				/* Wait */
    }

    printf("AXI DMA Example From XADC to On Chip Memory Completed\n\r");

    return 0;
}
