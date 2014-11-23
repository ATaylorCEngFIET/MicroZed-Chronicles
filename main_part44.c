/* Kernel includes. */
#include <stdio.h>
#include "FreeRTOS.h"
#include "task.h"
#include "semphr.h"
#include "xadcps.h"
/* Standard demo includes. */
#include "partest.h"

/* Priorities at which the tasks are created. */
#define mainQUEUE_RECEIVE_TASK_PRIORITY		( tskIDLE_PRIORITY + 2 )
#define	mainQUEUE_SEND_TASK_PRIORITY		( tskIDLE_PRIORITY + 1 )

/* The rate at which data is sent to the queue.  The 200ms value is converted
to ticks using the portTICK_PERIOD_MS constant. */
#define mainQUEUE_SEND_FREQUENCY_MS			( 200 / portTICK_PERIOD_MS )

/* The number of items the queue can hold.  This is 1 as the receive task
will remove items as they are added, meaning the send task should always find
the queue empty. */
#define mainQUEUE_LENGTH					( 1 )

/* The LED toggled by the Rx task. */
#define mainTASK_LED						( 0 )

/*-----------------------------------------------------------*/

/*
 * The tasks as described in the comments at the top of this file.
 */
static void prvQueueReceiveTask( void *pvParameters );
static void prvQueueSendTask( void *pvParameters );
void adc_config(XAdcPs *XADCInstPtr, u16 XAdcDeviceId);


/*
 * Called by main() to create the simply blinky style application if
 * mainCREATE_SIMPLE_BLINKY_DEMO_ONLY is set to 1.
 */
void main_blinky( void );

/*-----------------------------------------------------------*/

/* The queue used by both tasks. */
static QueueHandle_t xQueue = NULL;

#include "xadcps.h"
//XADC info
#define XPAR_AXI_XADC_0_DEVICE_ID 0
static XAdcPs  XADCInst; //XADC
/*-----------------------------------------------------------*/

void main_blinky( void )
{
	/* Create the queue. */
	xQueue = xQueueCreate( mainQUEUE_LENGTH, sizeof( uint32_t ) );

	adc_config(&XADCInst,XPAR_AXI_XADC_0_DEVICE_ID );

	if( xQueue != NULL )
	{
		/* Start the two tasks as described in the comments at the top of this
		file. */
		xTaskCreate( prvQueueReceiveTask,				/* The function that implements the task. */
					"Rx", 								/* The text name assigned to the task - for debug only as it is not used by the kernel. */
					configMINIMAL_STACK_SIZE, 			/* The size of the stack to allocate to the task. */
					NULL, 								/* The parameter passed to the task - not used in this case. */
					mainQUEUE_RECEIVE_TASK_PRIORITY, 	/* The priority assigned to the task. */
					NULL );								/* The task handle is not required, so NULL is passed. */

		xTaskCreate( prvQueueSendTask, "TX", configMINIMAL_STACK_SIZE, NULL, mainQUEUE_SEND_TASK_PRIORITY, NULL );

		/* Start the tasks and timer running. */
		vTaskStartScheduler();
	}

	/* If all is well, the scheduler will now be running, and the following
	line will never be reached.  If the following line does execute, then
	there was either insufficient FreeRTOS heap memory available for the idle
	and/or timer tasks to be created, or vTaskStartScheduler() was called from
	User mode.  See the memory management section on the FreeRTOS web site for
	more details on the FreeRTOS heap http://www.freertos.org/a00111.html.  The
	mode from which main() is called is set in the C start up code and must be
	a privileged mode (not user mode). */
	for( ;; );
}
/*-----------------------------------------------------------*/

static void prvQueueSendTask( void *pvParameters )
{
TickType_t xNextWakeTime;
unsigned long ulValueToSend = 100UL;

	/* Remove compiler warning about unused parameter. */
	( void ) pvParameters;

	/* Initialise xNextWakeTime - this only needs to be done once. */
	xNextWakeTime = xTaskGetTickCount();
	printf("task tx");
	for( ;; )
	{
		/* Place this task in the blocked state until it is time to run again. */
		vTaskDelayUntil( &xNextWakeTime, mainQUEUE_SEND_FREQUENCY_MS );
		ulValueToSend = XAdcPs_GetAdcData(&XADCInst, XADCPS_CH_TEMP);
		/* Send to the queue - causing the queue receive task to unblock and
		toggle the LED.  0 is used as the block time so the sending operation
		will not block - it shouldn't need to block as the queue should always
		be empty at this point in the code. */
		xQueueSend( xQueue, &ulValueToSend, 0U );
	}
}
/*-----------------------------------------------------------*/

static void prvQueueReceiveTask( void *pvParameters )
{
unsigned long ulReceivedValue;
unsigned long ulExpectedValue = 43000;

	/* Remove compiler warning about unused parameter. */
	( void ) pvParameters;
	printf("task rx");
	for( ;; )
	{
		/* Wait until something arrives in the queue - this task will block
		indefinitely provided INCLUDE_vTaskSuspend is set to 1 in
		FreeRTOSConfig.h. */
		xQueueReceive( xQueue, &ulReceivedValue, portMAX_DELAY );
		printf("Raw Value = %lu", ulReceivedValue);
		/*  To get here something must have been received from the queue, but
		is it the expected value?  If it is, toggle the LED. */
		if( ulReceivedValue == ulExpectedValue  )
		{
			//vParTestToggleLED( mainTASK_LED );
			vParTestSetLED(mainTASK_LED, 1);
			ulReceivedValue = 0U;
		}
	}
}

void adc_config(XAdcPs *XADCInstPtr, u16 XAdcDeviceId)
{

//	u32 IntrStatus;
	XAdcPs_Config *ConfigPtr;           //xadc config
//	u32 TempRawData;
//	float TempData;
	printf("task xadc");
	//XADC initilization
	ConfigPtr = XAdcPs_LookupConfig(XAdcDeviceId);
	//adc set up
	XAdcPs_CfgInitialize(XADCInstPtr,ConfigPtr,ConfigPtr->BaseAddress);
	//stop sequencer
	XAdcPs_SetSequencerMode(XADCInstPtr,XADCPS_SEQ_MODE_SINGCHAN);
	//disable alarms
	XAdcPs_SetAlarmEnables(XADCInstPtr, 0x0);

	//configure sequencer to just sample internal on chip parameters
	XAdcPs_SetSeqInputMode(XADCInstPtr, XADCPS_SEQ_MODE_SAFE);
	//configure the channel enables we want to monitor
	XAdcPs_SetSeqChEnables(XADCInstPtr,XADCPS_CH_TEMP|XADCPS_CH_VCCINT|XADCPS_CH_VCCAUX|XADCPS_CH_VBRAM|XADCPS_CH_VCCPINT|
	     		XADCPS_CH_VCCPAUX|XADCPS_CH_VCCPDRO);

}
