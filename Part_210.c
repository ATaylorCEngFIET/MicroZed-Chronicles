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
#include "xbram.h"
#include <xil_exception.h>
#include <xil_printf.h>
#include <xil_io.h>
#include <xil_cache.h>
#include <xstatus.h>
#include <sleep.h>
#include "pm_api_sys.h"
//#include "timer.h"
#include "pm_client.h"
//#define BRAM_DEVICE_ID		XPAR_BRAM_0_DEVICE_ID
#define BRAM_DEVICE_ID XPAR_BRAM_1_DEVICE_ID

#define IPI_INT_ID	XPAR_XIPIPSU_0_INT_ID
#define TEST_CHANNEL_ID	XPAR_XIPIPSU_0_DEVICE_ID


XBram Bram;
XIpiPsu IpiInst;

static XStatus IpiConfigure(XIpiPsu *const IpiInstPtr)
{
	XStatus Status;
	XIpiPsu_Config *IpiCfgPtr;

	/* Look Up the config data */
	IpiCfgPtr = XIpiPsu_LookupConfig(TEST_CHANNEL_ID);
	if (NULL == IpiCfgPtr) {
		Status = XST_FAILURE;
		pm_dbg("%s ERROR in getting CfgPtr\n", __func__);
		return Status;
	}

	/* Init with the Cfg Data */
	Status = XIpiPsu_CfgInitialize(IpiInstPtr, IpiCfgPtr, IpiCfgPtr->BaseAddress);
	if (XST_SUCCESS != Status) {
		pm_dbg("%s ERROR #%d in configuring IPI\n", __func__, Status);
		return Status;
	}
	return Status;
}

int main()
{
    init_platform();

    printf("UltraZed Edition Part 14\n\r");
    printf("http://www.ultrazedchronicles.com\n\r");
	int  i;
	u32 data;
	XPm_NodeStatus ns;
	XBram_Config *ConfigPtr;
	XStatus Stat;

	IpiConfigure(&IpiInst);
	XPm_InitXilpm(&IpiInst);

	enum XPmBootStatus status = XPm_GetBootStatus();

	//XPm_SetRequirement(NODE_TCM_0_A, PM_CAP_CONTEXT, 0, REQUEST_ACK_NO);
	Stat = XPm_GetNodeStatus(NODE_TCM_0_A, &ns);
	printf("Requirements %x Status %x Usage %x \n\r",ns.requirements, ns.status, ns.usage);
	Stat = XPm_GetNodeStatus(NODE_APU_0, &ns);
	printf("Requirements %x Status %x Usage %x \n\r",ns.requirements, ns.status, ns.usage);

	ConfigPtr = XBram_LookupConfig(BRAM_DEVICE_ID);
	XBram_CfgInitialize(&Bram, ConfigPtr,ConfigPtr->CtrlBaseAddress);

	for (i=0; i<256 ;i++){
		data = XBram_ReadReg(ConfigPtr->MemBaseAddress, (i*4));
		printf("Data Read from Address %x %x \n\r",(unsigned int)(i*4),(unsigned int) data );
	}

	for (i=0; i<256 ;i++){
		XBram_WriteReg(ConfigPtr->MemBaseAddress, (i*4), i);
		printf("Data Written to Address %x %x \n\r",(unsigned int)(i*4),(unsigned int)i );
	}

	for (i=0; i<256 ;i++){
		data = XBram_ReadReg(ConfigPtr->MemBaseAddress, (i*4));
		printf("Data Read from Address %x %x \n\r",(unsigned int)(i*4),(unsigned int)data );
	}

    cleanup_platform();
    return 0;
}
