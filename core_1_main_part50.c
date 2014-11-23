#include "xparameters.h"
#include <stdio.h>
#include "xil_io.h"
#include "xil_mmu.h"
#include "xil_cache.h"
#include "xil_exception.h"
#include "xscugic.h"
#include "sleep.h"
#include "xscutimer.h"
#include "xgpio.h"


#define LED_PAT 0xFFFF0000
void        Xil_L1DCacheFlush(void);
extern u32 MMUTable;

#define GPIO_DEVICE_ID		XPAR_AXI_GPIO_0_DEVICE_ID
#define TIMER_DEVICE_ID		XPAR_PS7_SCUTIMER_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_PS7_SCUGIC_0_DEVICE_ID
#define TIMER_IRPT_INTR		XPS_SCU_TMR_INT_ID
#define TIMER_LOAD_VALUE	0xFFFFFFFF
#define CHANNEL				1
#define OP					0xff
#define ADDR 				XPAR_AXI_GPIO_0_BASEADDR
static XGpio Gpio; //GPIO
static XScuGic Intc; //GIC
static XScuTimer Timer;//timer

static int toggle = 0;//used to toggle the LED
static void TimerIntrHandler(void *CallBackRef);
static int SetupInterruptSystem(XScuGic *GicInstancePtr, XScuTimer *TimerInstancePtr, u16 TimerIntrId);

int main()
{


	XScuTimer_Config *TMRConfigPtr;     //timer config

    //Disable cache on OCM
	Xil_SetTlbAttributes(0xFFFF0000,0x14de2);           // S=b1 TEX=b100 AP=b11, Domain=b1111, C=b0, B=b0
	print("CPU1: starting\n\r");

	//GPIO Initilization
	XGpio_Initialize(&Gpio, GPIO_DEVICE_ID);
	XGpio_SetDataDirection(&Gpio, CHANNEL, 0x00);
	XGpio_DiscreteWrite(&Gpio,CHANNEL, 0xff);

    //timer initialisation
    TMRConfigPtr = XScuTimer_LookupConfig(TIMER_DEVICE_ID);
    XScuTimer_CfgInitialize(&Timer, TMRConfigPtr,TMRConfigPtr->BaseAddr);
    XScuTimer_SelfTest(&Timer);

	//load the timer
    XScuTimer_LoadTimer(&Timer, TIMER_LOAD_VALUE);

    SetupInterruptSystem(&Intc, &Timer,TIMER_IRPT_INTR);

    XScuTimer_Start(&Timer);
    print("CPU1: configured\n\r");
    while(1){


    }

    return 0;
}

static int SetupInterruptSystem(XScuGic *GicInstancePtr, XScuTimer *TimerInstancePtr, u16 TimerIntrId)
{


		XScuGic_Config *IntcConfig; //GIC config
		Xil_ExceptionInit();
		//initialise the GIC
		IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);
		XScuGic_CfgInitialize(GicInstancePtr, IntcConfig,
						IntcConfig->CpuBaseAddress);
	    //connect to the hardware
		Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
					(Xil_ExceptionHandler)XScuGic_InterruptHandler,
					GicInstancePtr);

		//set up the timer interrupt
		XScuGic_Connect(GicInstancePtr, TimerIntrId,
						(Xil_ExceptionHandler)TimerIntrHandler,
						(void *)TimerInstancePtr);

		//enable the interrupt for the Timer at GIC
		XScuGic_Enable(GicInstancePtr, TimerIntrId);
		//enable interrupt on the timer
		XScuTimer_EnableInterrupt(TimerInstancePtr);
		// Enable interrupts in the Processor.
		Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);

		return XST_SUCCESS;
	}

static void TimerIntrHandler(void *CallBackRef)
{
	unsigned int cpu0;

	XScuTimer *TimerInstancePtr = (XScuTimer *) CallBackRef;
	XScuTimer_ClearInterruptStatus(TimerInstancePtr);
	//load timer
	XScuTimer_LoadTimer(&Timer, TIMER_LOAD_VALUE);
	//start timer
	cpu0 = Xil_In8(LED_PAT);
	XGpio_DiscreteWrite(&Gpio,CHANNEL,cpu0);

	XScuTimer_Start(&Timer);



}
