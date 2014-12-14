/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 */

#include <stdio.h>
#include "platform.h"
#include "xadcps.h"
#include "xparameters.h"
#include "xsysmon.h"
static XAdcPs  XADCMonInst;
#define SYSMON_DEVICE_ID	XPAR_SYSMON_0_DEVICE_ID
static XSysMon SysMonInst;

int main()
{

    XAdcPs_Config *XADCConfigPtr;
    XAdcPs *XADCInstPtr = &XADCMonInst;



	XSysMon_Config *SYSConfigPtr ;
	XSysMon* SysMonInstPtr = &SysMonInst;

	u32 address;

    init_platform();



    SYSConfigPtr = XSysMon_LookupConfig(SYSMON_DEVICE_ID);
        	if (SYSConfigPtr == NULL) {
        		return XST_FAILURE;
        	}

    XSysMon_CfgInitialize(SysMonInstPtr, SYSConfigPtr, SYSConfigPtr->BaseAddress);

    address = SYSConfigPtr->BaseAddress;
    printf("XADC using Sysmon -> base address %lx \n\r", address);


    XADCConfigPtr = XAdcPs_LookupConfig(XPAR_XADC_WIZ_0_DEVICE_ID);
            if (XADCConfigPtr == NULL) {
             		return XST_FAILURE;
           	}

     XAdcPs_CfgInitialize(XADCInstPtr,XADCConfigPtr,XADCConfigPtr->BaseAddress);

     address = XADCConfigPtr->BaseAddress;
     printf("XADC using XADPS -> base address %lx \n\r", address);


    return 0;
}
