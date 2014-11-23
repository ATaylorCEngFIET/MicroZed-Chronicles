#include <stdio.h>
#include "platform.h"
#include "xadcps.h"
#include "xgpiops.h"
#include "xil_types.h"
#include "Xscugic.h"
#include "Xil_exception.h"

#define XPAR_AXI_XADC_0_DEVICE_ID 0

#define GPIO_DEVICE_ID		XPAR_XGPIOPS_0_DEVICE_ID
#define INTC_DEVICE_ID		XPAR_SCUGIC_SINGLE_DEVICE_ID
#define GPIO_INTERRUPT_ID	              XPS_GPIO_INT_ID

#define ledpin 47
#define pbsw 51
#define LED_DELAY     100000000
//void print(char *str);

static XAdcPs  XADCMonInst;
static XScuGic Intc; /* The Instance of the Interrupt Controller Driver */
static XGpioPs Gpio; /* The driver instance for GPIO Device. */
int toggle;//used to toggle the LED
static void SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio, u16 GpioIntrId);
static void IntrHandler(void *CallBackRef, int Bank, u32 Status);

int main()
{

	XAdcPs_Config *ConfigPtr;
	XAdcPs *XADCInstPtr = &XADCMonInst;

	int Status;
//	u32 sw;

	XGpioPs_Config *GPIOConfigPtr;

	//status of initialisation
	int Status_ADC;

	//temperature readings
	u32 TempRawData;
	float TempData;

	//Vcc Int readings
	u32 VccIntRawData;
	float VccIntData;

	//Vcc Aux readings
	u32 VccAuxRawData;
	float VccAuxData;

	//Vbram readings
	u32 VBramRawData;
	float VBramData;

	//VccPInt readings
	u32 VccPIntRawData;
	float VccPIntData;

	//VccPAux readings
	u32 VccPAuxRawData;
	float VccPAuxData;

	//Vddr readings
	u32 VDDRRawData;
	float VDDRData;

	init_platform();

    printf("Adam Edition MicroZed Using Vivado How To Printf \n\r");

    //GPIO Initilization
    GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    Status = XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);
    	if (Status != XST_SUCCESS) {
    		 print("GPIO INIT FAILED\n\r");
    		return XST_FAILURE;
    	}

    //set direction and enable output
    XGpioPs_SetDirectionPin(&Gpio, ledpin, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, ledpin, 1);

    //set direction input pin
    XGpioPs_SetDirectionPin(&Gpio, pbsw, 0x0);

    //XADC initilization

     ConfigPtr = XAdcPs_LookupConfig(XPAR_AXI_XADC_0_DEVICE_ID);
     	if (ConfigPtr == NULL) {
     		return XST_FAILURE;
   	}

     Status_ADC = XAdcPs_CfgInitialize(XADCInstPtr,ConfigPtr,ConfigPtr->BaseAddress);
     if(XST_SUCCESS != Status_ADC){
         print("ADC INIT FAILED\n\r");
         return XST_FAILURE;
      }

     //self test
     Status_ADC = XAdcPs_SelfTest(XADCInstPtr);
 	if (Status_ADC != XST_SUCCESS) {
 		return XST_FAILURE;
 	}

 	//stop sequencer
 	XAdcPs_SetSequencerMode(XADCInstPtr,XADCPS_SEQ_MODE_SINGCHAN);

     //disable alarms
     XAdcPs_SetAlarmEnables(XADCInstPtr, 0x0);

     //configure sequencer to just sample internal on chip parameters
     XAdcPs_SetSeqInputMode(XADCInstPtr, XADCPS_SEQ_MODE_SAFE);

     //configure the channel enables we want to monitor
     XAdcPs_SetSeqChEnables(XADCInstPtr,XADCPS_CH_TEMP|XADCPS_CH_VCCINT|XADCPS_CH_VCCAUX|XADCPS_CH_VBRAM|XADCPS_CH_VCCPINT|
     		XADCPS_CH_VCCPAUX|XADCPS_CH_VCCPDRO);

    SetupInterruptSystem(&Intc, &Gpio, GPIO_INTERRUPT_ID);

     while(1){

      TempRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_TEMP);
      TempData = XAdcPs_RawToTemperature(TempRawData);
      printf("Raw Temp %lu Real Temp %f \n\r", TempRawData, TempData);

      VccIntRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCINT);
      VccIntData = XAdcPs_RawToVoltage(VccIntRawData);
      printf("Raw VccInt %lu Real VccInt %f \n\r", VccIntRawData, VccIntData);

      VccAuxRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCAUX);
      VccAuxData = XAdcPs_RawToVoltage(VccAuxRawData);
      printf("Raw VccAux %lu Real VccAux %f \n\r", VccAuxRawData, VccAuxData);

      VBramRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VBRAM);
      VBramData = XAdcPs_RawToVoltage(VBramRawData);
      printf("Raw VccBram %lu Real VccBram %f \n\r", VBramRawData, VBramData);

      VccPIntRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCPINT);
      VccPIntData = XAdcPs_RawToVoltage(VccPIntRawData);
      printf("Raw VccPInt %lu Real VccPInt %f \n\r", VccPIntRawData, VccPIntData);

      VccPAuxRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCPAUX);
      VccPAuxData = XAdcPs_RawToVoltage(VccPAuxRawData);
      printf("Raw VccPAux %lu Real VccPAux %f \n\r", VccPAuxRawData, VccPAuxData);

      VDDRRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCPDRO);
      VDDRData = XAdcPs_RawToVoltage(VDDRRawData);
      printf("Raw VccDDR %lu Real VccDDR %f \n\r", VDDRRawData, VDDRData);

     }

    return 0;
}

static void SetupInterruptSystem(XScuGic *GicInstancePtr, XGpioPs *Gpio, u16 GpioIntrId)
{


		XScuGic_Config *IntcConfig; /* Instance of the interrupt controller */

		Xil_ExceptionInit();

		/*
		 * Initialize the interrupt controller driver so that it is ready to
		 * use.
		 */
		IntcConfig = XScuGic_LookupConfig(INTC_DEVICE_ID);

		XScuGic_CfgInitialize(GicInstancePtr, IntcConfig,
						IntcConfig->CpuBaseAddress);

		/*
		 * Connect the interrupt controller interrupt handler to the hardware
		 * interrupt handling logic in the processor.
		 */
		Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_INT,
					(Xil_ExceptionHandler)XScuGic_InterruptHandler,
					GicInstancePtr);

		/*
		 * Connect the device driver handler that will be called when an
		 * interrupt for the device occurs, the handler defined above performs
		 * the specific interrupt processing for the device.
		 */
		XScuGic_Connect(GicInstancePtr, GpioIntrId,
					(Xil_ExceptionHandler)XGpioPs_IntrHandler,
					(void *)Gpio);

		//Enable  interrupts for all the pins in bank 0.
		XGpioPs_SetIntrTypePin(Gpio, pbsw, XGPIOPS_IRQ_TYPE_EDGE_RISING);

		//Set the handler for gpio interrupts.
		XGpioPs_SetCallbackHandler(Gpio, (void *)Gpio, IntrHandler);

		//Enable the GPIO interrupts of Bank 0.
		XGpioPs_IntrEnablePin(Gpio, pbsw);

		//Enable the interrupt for the GPIO device.
		XScuGic_Enable(GicInstancePtr, GpioIntrId);

		// Enable interrupts in the Processor.
		Xil_ExceptionEnableMask(XIL_EXCEPTION_IRQ);
	}

static void IntrHandler(void *CallBackRef, int Bank, u32 Status)
{
	int delay;
	printf("****button pressed****\n\r");
	toggle = !toggle;
	XGpioPs_WritePin(&Gpio, ledpin, toggle);
	for( delay = 0; delay < LED_DELAY; delay++)//wait
	{}
}
