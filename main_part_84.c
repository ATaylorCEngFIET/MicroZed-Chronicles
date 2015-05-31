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
#include "xparameters.h"	/* SDK generated parameters */
#include "xspips.h"		    /* SPI device driver */
#include "xil_types.h"
#include "xgpiops.h"

#include "APEAUS.h"

#define SPI_EMIO			XPAR_XSPIPS_0_DEVICE_ID

#define res 54
#define vdd 55
#define bat 56
#define dc	57
#define sig 58
#define DELAY     100000000
#define char_size 8
#define line_start 127

static XSpiPs SpiInstance_EMIO;
static XGpioPs Gpio; //GPIO

void config_oled();
void blank_oled();
void conv_alg();





u8 init_vector[23] ={0xae,0xd5,0x80,0xa8,0x1f,0xd3,0x00,0x40,0x8d,0x14,0xa1,0xc8,0xda,0x02,0x81,0x8f,0xd9,0xf1,0xdb,0x40,
0xa4,0xa6, 0xaf};

u8 page_0[128]; //page 0
u8 page_1[128]; //page 1
u8 page_2[128]; //page 2
u8 page_3[128]; //page 3

//CHANGE THESE TO CHANGE THE DISPLAY VALUE
u8 line_1[16] = {88,99,101,108,108,0,68,97,105,108,121,0,0,0,0,0} ;//aligns to char numbers in APEAUS.h need conversion
u8 line_2[16] = {65,00,84,65,89,76,79,82,0,0,0,0,0,0,0,0} ;
u8 line_3[16] = {67,72,82,79,78,73,67,76,69,83,0,0,0,0,0,0} ;
u8 line_4[16] = {77,73,67,82,79,90,69,68,0,40,105,115,104,41,0,0} ;

u8 data_conv[8]; //contains each converted char
u8 results[8];
int power_up =0;

int main()
{

	XSpiPs_Config *SpiConfig_EMIO;
	XGpioPs_Config *GPIOConfigPtr;    //gpio config

	int delay;
	u8 cmd[1];
	int byte_i, temp;
	int loop;
    init_platform();

    printf("SPI Demo MicroZed Chronicles\n\r");

    SpiConfig_EMIO = XSpiPs_LookupConfig((u16)SPI_EMIO);
    XSpiPs_CfgInitialize(&SpiInstance_EMIO, SpiConfig_EMIO,SpiConfig_EMIO->BaseAddress);
    XSpiPs_SetOptions(&SpiInstance_EMIO,XSPIPS_MASTER_OPTION |  XSPIPS_FORCE_SSELECT_OPTION);
    XSpiPs_SetClkPrescaler(&SpiInstance_EMIO, XSPIPS_CLK_PRESCALE_256);

    GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
    XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);

    //set direction and enable output
    XGpioPs_SetDirectionPin(&Gpio, sig, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, sig, 1);

    XGpioPs_SetDirectionPin(&Gpio, res, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, res, 1);

    XGpioPs_SetDirectionPin(&Gpio, vdd, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, vdd, 1);

    XGpioPs_SetDirectionPin(&Gpio, bat, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, bat, 1);

    XGpioPs_SetDirectionPin(&Gpio, dc, 1);
    XGpioPs_SetOutputEnablePin(&Gpio, dc, 1);

    XGpioPs_WritePin(&Gpio, sig, 0);
    XGpioPs_WritePin(&Gpio, res, 0);
    XGpioPs_WritePin(&Gpio, vdd, 1);
    XGpioPs_WritePin(&Gpio, bat, 1);
    XGpioPs_WritePin(&Gpio, dc, 1);

    XGpioPs_WritePin(&Gpio, vdd, 0);
	for( delay = 0; delay < DELAY; delay++)//wait
	{}
    XGpioPs_WritePin(&Gpio, res, 1);
    config_oled();
    XGpioPs_WritePin(&Gpio, bat, 0);
    blank_oled();//clear screen


//output page 1
 for(loop=0;loop<16;loop++){
    	temp = (line_1[loop] * 8);
    	for(byte_i=0;byte_i<8;byte_i++){
    		data_conv[byte_i] = font[temp+byte_i];
    	}
    	conv_alg(data_conv); //convert to array
    	for(byte_i=0;byte_i<8;byte_i++){
    		page_0[(line_start-(char_size*loop))-byte_i] = results[byte_i];
    	}
 }
    cmd[0] = (u8) 0xB0;
    XGpioPs_WritePin(&Gpio, dc, 0);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
    XGpioPs_WritePin(&Gpio, dc, 1);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, page_0, NULL, 128);

//output page 2
    for(loop=0;loop<16;loop++){
    //loop =0;
       	temp = (line_2[loop] * 8);
       	for(byte_i=0;byte_i<8;byte_i++){
       		data_conv[byte_i] = font[temp+byte_i];
       	}
       	conv_alg(data_conv); //convert to array
       	for(byte_i=0;byte_i<8;byte_i++){
       		page_1[(line_start-(char_size*loop))-byte_i] = results[byte_i];
       	}
    }
       cmd[0] = (u8) 0xB1;
       XGpioPs_WritePin(&Gpio, dc, 0);
       XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
       XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
       XGpioPs_WritePin(&Gpio, dc, 1);
       XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
       XSpiPs_PolledTransfer(&SpiInstance_EMIO, page_1, NULL, 128);

//output page 3
   for(loop=0;loop<16;loop++){
   //loop =0;
		temp = (line_3[loop] * 8);
		for(byte_i=0;byte_i<8;byte_i++){
			data_conv[byte_i] = font[temp+byte_i];
		}
		conv_alg(data_conv); //convert to array
		for(byte_i=0;byte_i<8;byte_i++){
			page_2[(line_start-(char_size*loop))-byte_i] = results[byte_i];
		}
   }
	  cmd[0] = (u8) 0xB2;
	  XGpioPs_WritePin(&Gpio, dc, 0);
	  XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
	  XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
	  XGpioPs_WritePin(&Gpio, dc, 1);
	  XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
	  XSpiPs_PolledTransfer(&SpiInstance_EMIO, page_2, NULL, 128);

//output page 4
  for(loop=0;loop<16;loop++){
  //loop =0;
		temp = (line_4[loop] * 8);
		for(byte_i=0;byte_i<8;byte_i++){
			data_conv[byte_i] = font[temp+byte_i];
		}
		conv_alg(data_conv); //convert to array
		for(byte_i=0;byte_i<8;byte_i++){
			page_3[(line_start-(char_size*loop))-byte_i] = results[byte_i];
		}
  }
	 cmd[0] = (u8) 0xB3;
	 XGpioPs_WritePin(&Gpio, dc, 0);
	 XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
	 XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
	 XGpioPs_WritePin(&Gpio, dc, 1);
	 XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
	 XSpiPs_PolledTransfer(&SpiInstance_EMIO, page_3, NULL, 128);

    return 0;
}


void conv_alg(u8 data[8])
//this function converts the the font from being in the horizontal format to vertical required for the OLED
{
	u8 temp;
	u8 temp1[8];
	int loop;
	int i;
	u8 temp_res[8];

for(i=0;i<8;i++){ //loop for the bit position
	for(loop=0;loop<8;loop++){//loop for each word
		temp = data[loop]>>i;
		temp1[loop] = temp & 0x01;// mask out all but lsb for each input byte
	}
	temp_res[i] = (temp1[0]<<7)|(temp1[1]<<6)|(temp1[2]<<5)|(temp1[3]<<4)| (temp1[4]<<3)|(temp1[5]<<2)|(temp1[6]<<1)|temp1[7];
}
for(i=0;i<8;i++){
	results[i] = temp_res[7-i];
}

}

void config_oled()
{
	printf("****configuring oled!!!!!!!!!!!!!****\n\r");
    XGpioPs_WritePin(&Gpio, dc, 0);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, init_vector, NULL, 23);
    XGpioPs_WritePin(&Gpio, dc, 1);
    printf("****done configuring oled!!!!!!!!!!!!!****\n\r");
}

void blank_oled()
{
	u8 cmd[1];
	u8 data[1];
	int loop;

	cmd[0] = (u8) 0xB0;
	data[0] = (u8) 0x00;
    XGpioPs_WritePin(&Gpio, dc, 0);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
    XGpioPs_WritePin(&Gpio, dc, 1);
    for(loop=0;loop<128;loop++){
    	XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    	XSpiPs_PolledTransfer(&SpiInstance_EMIO, data, NULL, 1);
    }

	cmd[0] = (u8) 0xB2;
	data[0] = (u8) 0x00;
    XGpioPs_WritePin(&Gpio, dc, 0);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
    XGpioPs_WritePin(&Gpio, dc, 1);
    for(loop=0;loop<128;loop++){
    	XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    	XSpiPs_PolledTransfer(&SpiInstance_EMIO, data, NULL, 1);
    }

	cmd[0] = (u8) 0xB1;
	data[0] = (u8) 0x00;
    XGpioPs_WritePin(&Gpio, dc, 0);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
    XGpioPs_WritePin(&Gpio, dc, 1);
    for(loop=0;loop<128;loop++){
    	XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    	XSpiPs_PolledTransfer(&SpiInstance_EMIO, data, NULL, 1);
    }

	cmd[0] = (u8) 0xB3;
	data[0] = (u8) 0x00;
    XGpioPs_WritePin(&Gpio, dc, 0);
    XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    XSpiPs_PolledTransfer(&SpiInstance_EMIO, cmd, NULL, 1);
    XGpioPs_WritePin(&Gpio, dc, 1);
    for(loop=0;loop<128;loop++){
    	XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    	XSpiPs_PolledTransfer(&SpiInstance_EMIO, data, NULL, 1);
    }

}

