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

#include "xparameters.h"
#include "xil_cache.h"
#include "PmodAD2.h"
#include "xspips.h"


#define SPI_MIO				XPAR_XSPIPS_0_DEVICE_ID
#define max_count  			4095
static XSpiPs SpiInstance_MIO;
u8 op_buff[4] = {0x00,0x01,0x02,0xaa};

#ifdef XPAR_MICROBLAZE_ID
#include "microblaze_sleep.h"
#else
#include "sleep.h"
#endif

void DemoInitialize();
void DemoRun();
//static void SendHandler(PmodAD2 *InstancePtr);

//static void ReceiveHandler(PmodAD2 *InstancePtr);

PmodAD2 myDevice;

//void print(char *str);

int main()
{

    Xil_ICacheEnable();
	Xil_DCacheEnable();


	DemoInitialize();
	DemoRun();

    return 0;
}



void DemoInitialize()
{

	XSpiPs_Config *SpiConfig_MIO;
	int Status;


	xil_printf("UART Established\n\r");

	SpiConfig_MIO = XSpiPs_LookupConfig((u16)SPI_MIO);

	Status = XSpiPs_CfgInitialize(&SpiInstance_MIO, SpiConfig_MIO,SpiConfig_MIO->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XSpiPs_SetOptions(&SpiInstance_MIO, XSPIPS_MASTER_OPTION | XSPIPS_CLK_PHASE_1_OPTION);

	XSpiPs_SetClkPrescaler(&SpiInstance_MIO, XSPIPS_CLK_PRESCALE_128);
	//internal reference
	op_buff[0] = 0x10;
	op_buff[1] = 0x00;
	op_buff[2] = 0x00;
	op_buff[3] = 0x01;
	XSpiPs_PolledTransfer(&SpiInstance_MIO, op_buff, NULL,4);
	//power up
	op_buff[0] = 0x08;
	op_buff[1] = 0x00;
	op_buff[2] = 0x00;
	op_buff[3] = 0xff;
	XSpiPs_PolledTransfer(&SpiInstance_MIO, op_buff, NULL,4);

	AD2_begin(&myDevice, XPAR_PMODAD2_0_AXI_LITE_IIC_BASEADDR, AD2_IIC_ADDR);
	//AD2_SetupInterruptSystem(&myDevice, XPAR_PS7_SCUGIC_0_DEVICE_ID, XPAR_FABRIC_AXI_IIC_0_IIC2INTC_IRPT_INTR, SendHandler, ReceiveHandler);
	//XIic_Start(&myDevice.AD2Iic);
}


void DemoRun()
{
	//u16 an[4],
	u16 conv;
	u8 buf[2] = {0,0};
	double val;
	u16 count;
	//int nan = 4, i = 0;
	printf("Demo Started\n\r");
	AD2_WriteConfig(&myDevice, AD2_DEFAULT_CONFIG);
	//Default config is 0xF0, all channels on
	printf("AD2 Configured\n\r");
    op_buff[0] = 0x03;
    op_buff[3] = 0x00;
	while(1) {

		AD2_ReadConv(&myDevice, buf, 2);
		conv = (buf[0] << 8) | buf[1];
		val = (double) AD2_CONV_VALUE(conv);
		val = (val * 3.3)/4096.0;
		printf("CHANNEL %d = %d.%d V\n\r", AD2_CONV_CHANNEL(conv), (int)val, (int)(val*100)%100);
		//an[AD2_CONV_CHANNEL(conv)] = AD2_CONV_VALUE(conv);

		if (count == 2048) {
			count = 0;
		}
		else {
			count ++;
		}
		op_buff[1] = 0xff & count >>8;
		op_buff[1] = 0xf0 | op_buff[1];
		op_buff[2] = (u8) count;
		XSpiPs_PolledTransfer(&SpiInstance_MIO, op_buff, NULL,4);
		//usleep(1000000);
	}

}


