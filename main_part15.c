#include <stdio.h>
#include "platform.h"
#include "xadcps.h"
#include "xgpiops.h"
#include "xil_types.h"
#include "Xscugic.h"
#include "Xil_exception.h"
#include "xscutimer.h"
//XADC info
#define XPAR_AXI_XADC_0_DEVICE_ID 0

//GPIO info
#define GPIO_DEVICE_ID		XPAR_XGPIOPS_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define GPIO_INTERRUPT_ID	XPS_GPIO_INT_ID

//timer info
#define TIMER_DEVICE_ID		XPAR_XSCUTIMER_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define TIMER_IRPT_INTR		XPAR_SCUTIMER_INTR

#define ledpin 47
#define pbsw 51
#define LED_DELAY     100000000
#define TIMER_LOAD_VALUE	0xFFFFFFFF
//void print(char *str);

static XAdcPs  XADCMonInst; //XADC
static XScuGic Intc; //GIC
static XGpioPs Gpio; //GPIO
static XScuTimer Timer;//timer

static int toggle = 0;//used to toggle the LED

static void SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio, u16 GpioIntrId,
		XScuTimer *TimerInstancePtr, u16 TimerIntrId);

static void GPIOIntrHandler(void *CallBackRef, int Bank, u32 Status);
static void TimerIntrHandler(void *CallBackRef);

int main()
{

	 XAdcPs_Config *ConfigPtr;           //xadc config
	 XScuTimer_Config *TMRConfigPtr;     //timer config
	 XGpioPs_Config *GPIOConfigPtr;      //gpio config
	 XAdcPs *XADCInstPtr = &XADCMonInst; //xadc pointer


	 init_platform();

     printf("\n\rAdam Edition MicroZed Using Vivado How To Printf \n\r");

     //GPIO Initilization
     GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
     XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);
     //set direction and enable output
     XGpioPs_SetDirectionPin(&Gpio, ledpin, 1);
     XGpioPs_SetOutputEnablePin(&Gpio, ledpin, 1);
    //set direction input pin
     XGpioPs_SetDirectionPin(&Gpio, pbsw, 0x0);

     //timer initialisation
     TMRConfigPtr = XScuTimer_LookupConfig(TIMER_DEVICE_ID);
     XScuTimer_CfgInitialize(&Timer, TMRConfigPtr,TMRConfigPtr->BaseAddr);
     XScuTimer_SelfTest(&Timer);
 	 //load the timer
 	 XScuTimer_LoadTimer(&Timer, TIMER_LOAD_VALUE);
 	 //XScuTimer_EnableAutoReload(&Timer);
 	 //start timer
 	 //XScuTimer_Start(&Timer);

 	 //XADC initilization
 	 ConfigPtr = XAdcPs_LookupConfig(XPAR_AXI_XADC_0_DEVICE_ID);
 	 //adc set up
     XAdcPs_CfgInitialize(XADCInstPtr,ConfigPtr,ConfigPtr->BaseAddress);
     //self test adc
     XAdcPs_SelfTest(XADCInstPtr);
 	 //stop sequencer
 	 XAdcPs_SetSequencerMode(XADCInstPtr,XADCPS_SEQ_MODE_SINGCHAN);
     //disable alarms
     XAdcPs_SetAlarmEnables(XADCInstPtr, 0x0);
     //configure sequencer to just sample internal on chip parameters
     XAdcPs_SetSeqInputMode(XADCInstPtr, XADCPS_SEQ_MODE_SAFE);
     //configure the channel enables we want to monitor
     XAdcPs_SetSeqChEnables(XADCInstPtr,XADCPS_CH_TEMP|XADCPS_CH_VCCINT|XADCPS_CH_VCCAUX|XADCPS_CH_VBRAM|XADCPS_CH_VCCPINT|
     		XADCPS_CH_VCCPAUX|XADCPS_CH_VCCPDRO);

     //set up the interrupts
     SetupInterruptSystem(&Intc, &Gpio, GPIO_INTERRUPT_ID,&Timer,TIMER_IRPT_INTR);

     while(1){
     }

     return 0;
}

static void SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio, u16 GpioIntrId,
		XScuTimer *TimerInstancePtr, u16 TimerIntrId)
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
	    //set up the GPIO interrupt
		XScuGic_Connect(GicInstancePtr, GpioIntrId,
					(Xil_ExceptionHandler)XGpioPs_IntrHandler,
					(void *)Gpio);
		//set up the timer interrupt
		XScuGic_Connect(GicInstancePtr, TimerIntrId,
						(Xil_ExceptionHandler)TimerIntrHandler,
						(void *)TimerInstancePtr);
		//Enable  interrupts for all the pins in bank 0.
		XGpioPs_SetIntrTypePin(Gpio, pbsw, XGPIOPS_IRQ_TYPE_EDGE_RISING);
		//Set the handler for gpio interrupts.
		XGpioPs_SetCallbackHandler(Gpio, (void *)Gpio, GPIOIntrHandler);
		//Enable the GPIO interrupts of Bank 0.
		XGpioPs_IntrEnablePin(Gpio, pbsw);
		//Enable the interrupt for the GPIO device.
		XScuGic_Enable(GicInstancePtr, GpioIntrId);
		//enable the interrupt for the Timer at GIC
		XScuGic_Enable(GicInstancePtr, TimerIntrId);
		//enable interrupt on the timer
		XScuTimer_EnableInterrupt(TimerInstancePtr);
		// Enable interrupts in the Processor.
		Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);
	}

static void TimerIntrHandler(void *CallBackRef)
{

	XScuTimer *TimerInstancePtr = (XScuTimer *) CallBackRef;
	XScuTimer_ClearInterruptStatus(TimerInstancePtr);
	printf("****Timer Event!!!!!!!!!!!!!****\n\r");

}


static void GPIOIntrHandler(void *CallBackRef, int Bank, u32 Status)
{
	int delay;
	XGpioPs *Gpioint = (XGpioPs *)CallBackRef;

	printf("****button pressed****\n\r");

	if (toggle == 0 )
		toggle = 1;
	else
		toggle = 0;

	//load timer
	XScuTimer_LoadTimer(&Timer, TIMER_LOAD_VALUE);
	//start timer
	XScuTimer_Start(&Timer);
	XGpioPs_WritePin(Gpioint, ledpin, toggle);

	for( delay = 0; delay < LED_DELAY; delay++)//wait
	{}
	XGpioPs_IntrClearPin(Gpioint, pbsw);
}
