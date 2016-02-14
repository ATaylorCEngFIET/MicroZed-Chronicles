/*Copyright (c) 2016, Adam Taylor
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
#include "xv_tpg.h"
#include "xvidc.h"

#include "xil_assert.h"
#include "xaxivdma.h"
#include "xaxivdma_i.h"

int run_triple_frame_buffer(XAxiVdma* InstancePtr, int DeviceId, int hsize,
		int vsize, int buf_base_addr, int number_frame_count,
		int enable_frm_cnt_intr);

unsigned int srcBuffer = (XPAR_PS7_DDR_0_S_AXI_BASEADDR  + 0x100000);

u8 tpg_alpha = 0x00;
//void print(char *str);

int main()
{
	int Status;
	XV_tpg ptpg;
	XAxiVdma InstancePtr;
	XV_tpg_Config *ptpg_config;

	init_platform();

    ptpg_config = XV_tpg_LookupConfig(XPAR_V_TPG_0_DEVICE_ID);
    XV_tpg_CfgInitialize(&ptpg, ptpg_config, ptpg_config->BaseAddress);

    printf("Hello World\n\r");

	printf("TPG Initialization\r\n");


	u32 height,width,status;

	status = XV_tpg_IsReady(&ptpg);
	printf("Status %u \n\r", (unsigned int) status);
	status = XV_tpg_IsIdle(&ptpg);
	printf("Status %u \n\r", (unsigned int) status);
	XV_tpg_Set_height(&ptpg, (u32)600);
	XV_tpg_Set_width(&ptpg, (u32)800);
	height = XV_tpg_Get_height(&ptpg);
	width = XV_tpg_Get_width(&ptpg);
	XV_tpg_Set_colorFormat(&ptpg,XVIDC_CSF_RGB);
	XV_tpg_Set_maskId(&ptpg, 0x0);
	XV_tpg_Set_motionSpeed(&ptpg, 0x4);
	printf("info from tpg %u %u \n\r", (unsigned int)height, (unsigned int)width);
	XV_tpg_Set_bckgndId(&ptpg, XTPG_BKGND_COLOR_BARS);
	status = XV_tpg_Get_bckgndId(&ptpg);
	printf("Status %x \n\r", (unsigned int) status);
	XV_tpg_EnableAutoRestart(&ptpg);
	XV_tpg_Start(&ptpg);
	status = XV_tpg_IsIdle(&ptpg);
	printf("Status %u \n\r", (unsigned int) status);


	/* Calling the API to configure and start VDMA without frame counter interrupt */
	Status = run_triple_frame_buffer(&InstancePtr, 0, 800, 600,
						srcBuffer, 100, 0);
	if (Status != XST_SUCCESS) {
		xil_printf("Transfer of frames failed with error = %d\r\n",Status);
		return XST_FAILURE;
	} else {
		xil_printf("Transfer of frames started \r\n");
	}

	u32 vdma_stat;
	vdma_stat = Xil_In32(0x43000000);
	printf("MM2S vdma cntrl %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000004);
	printf("MM2S vdma stat %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000030);
	printf("S2MM vdma cntrl %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000034);
	printf("S2MM vdma stat %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000028);
	printf("Pointers %x\n\r",(unsigned) vdma_stat);

	vdma_stat = Xil_In32(0x4300005c);
	printf("MM2S addr 1 %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000060);
	printf("MM2S addr 2 %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000064);
	printf("MM2S addr 3 %x\n\r",(unsigned) vdma_stat);

	vdma_stat = Xil_In32(0x4300005c);
	printf("S2MM addr 1 %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000060);
	printf("S2MM addr 2 %x\n\r",(unsigned) vdma_stat);
	vdma_stat = Xil_In32(0x43000064);
	printf("S2MM addr 3 %x\n\r",(unsigned) vdma_stat);
	//readout first three lines from store 0
		int i;
		u32 address = 0x00200000;
		u8  pixel1, pixel2, pixel3;
		u32 pixel;
		for(i=0;i<2400;i++){
			pixel1 = Xil_In8(address);
			pixel2 = Xil_In8(address+1);
			pixel3 = Xil_In8(address+2);
			pixel = (pixel3<<16)|(pixel2<<8)|(pixel1);
			printf(" %x\n",(unsigned) pixel);
			address = address + 3;
		}

	while(1){

	}
    cleanup_platform();
    return 0;
}
