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
#include "xil_io.h"
#include "xil_mmu.h"
#include "xil_exception.h"
#include "xpseudo_asm.h"
#include "xscugic.h"


#define sev() __asm__("sev")
#define CPU1STARTADR 0xfffffff0
#define LED_PAT 0xFFFF0000

#define INTC		    XScuGic
#define INTC_DEVICE_ID	XPAR_PS7_SCUGIC_0_DEVICE_ID
#define INTC_HANDLER	XScuGic_InterruptHandler
#define OP_DELAY     	100000000
#define SW_INT_ID 		0

static void sgi_handler(void *CallBackRef);
static int  SetupIntrSystem(INTC *IntcInstancePtr);
INTC   IntcInstancePtr;
int main()
{
	//int delay;
	unsigned int inchar;
	unsigned int newlr;
	int Status;

    //Disable cache on OCM
    Xil_SetTlbAttributes(0xFFFF0000,0x14de2);           // S=b1 TEX=b100 AP=b11, Domain=b1111, C=b0, B=b0
    SetupIntrSystem(&IntcInstancePtr);
    print("CPU0: writing startaddress for cpu1\n\r");
    Xil_Out32(CPU1STARTADR, 0x00200000);
    dmb(); //waits until write has finished

    print("CPU0: sending the SEV to wake up CPU1\n\r");
    sev();


    while(1){

    	inchar = getchar();
    	newlr = getchar();
    	//for( delay = 0; delay < OP_DELAY; delay++)//wait
    	//{}
    	xil_printf("value %x",inchar);
    	Xil_Out8(LED_PAT,inchar);

    	//Xil_Out32(0xF8F01f00,0x02008000);
    	Status = XScuGic_SoftwareIntr(&IntcInstancePtr,SW_INT_ID, XSCUGIC_SPI_CPU1_MASK);
    	if (Status != XST_SUCCESS) {
    			print("error triggering SGI");
    			return XST_FAILURE;
    	}
    	print("\n\r setting up SW Interrupts\n\r");
    }

    return 0;
}

static void sgi_handler(void *CallBackRef)
{
	u32 INT;

	//BaseAddress = (u32)CallbackRef;
	INT = Xil_In32(0xF8F0010C);
	print("SGI****");
}

static int SetupIntrSystem(INTC *IntcInstancePtr)
{
	int Status;
    int callback=0;
	XScuGic_Config *IntcConfig;
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);

	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)XScuGic_InterruptHandler,
			 IntcInstancePtr);

	Status = XScuGic_Connect(IntcInstancePtr, SW_INT_ID,
							(Xil_ExceptionHandler)sgi_handler,(void *)IntcInstancePtr);
	if (Status != XST_SUCCESS) {
			print("error setting SGI");
			return XST_FAILURE;
		}
	XScuGic_Enable(IntcInstancePtr, SW_INT_ID);
	Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);

	return XST_SUCCESS;
}
