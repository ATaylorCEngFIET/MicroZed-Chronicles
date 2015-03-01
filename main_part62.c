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
