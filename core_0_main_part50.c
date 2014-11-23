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

static int  SetupIntrSystem(INTC *IntcInstancePtr);
INTC   IntcInstancePtr;
int main()
{
	int delay;
	unsigned int inchar;
	unsigned int newlr;

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
    	xil_printf("value %d",inchar);
    	Xil_Out8(LED_PAT,inchar);

    }

    return 0;
}
static int SetupIntrSystem(INTC *IntcInstancePtr)
{
	int Status;

	XScuGic_Config *IntcConfig;
	IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
	if (NULL == IntcConfig) {
		return XST_FAILURE;
	}
	Status = XScuGic_CfgInitialize(IntcInstancePtr, IntcConfig,
					IntcConfig->CpuBaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}
	Xil_ExceptionInit();
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
			 (Xil_ExceptionHandler)INTC_HANDLER,
			 IntcInstancePtr);
	Xil_ExceptionEnable();

	return XST_SUCCESS;
}
