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
#include "xgpiops.h"
#include "test.h"
#include "test2.h"
#include "xbram.h"

#define pico_one 				54
#define pico_two 				55

#define prog_one				0
#define prog_two				1

#define GPIO_DEVICE_ID			XPAR_XGPIOPS_0_DEVICE_ID

#define PICO_0_DEVICE_ID		XPAR_BRAM_0_DEVICE_ID
#define PICO_0_BASE 			XPAR_BRAM_0_BASEADDR

#define PICO_1_DEVICE_ID		XPAR_BRAM_1_DEVICE_ID
#define PICO_1_BASE 			XPAR_BRAM_1_BASEADDR

static XGpioPs Gpio; //GPIO
static XBram PICO_0_Mem;
static XBram PICO_1_Mem;

void reset_assert_0();
void reset_clear_0();
void reset_assert_1();
void reset_clear_1();
void load_pico0(int prog);
void load_pico1(int prog);

int main()
{

	XGpioPs_Config *GPIOConfigPtr;
	XBram_Config *Pico_0_ConfigPtr;
	XBram_Config *Pico_1_ConfigPtr;

	int choice = 0;

	init_platform();
	printf("Xcell Daily blog  part 59 \n\r");

	Pico_0_ConfigPtr = XBram_LookupConfig(PICO_0_DEVICE_ID);
	XBram_CfgInitialize(&PICO_0_Mem, Pico_0_ConfigPtr,Pico_0_ConfigPtr->CtrlBaseAddress);

	Pico_1_ConfigPtr = XBram_LookupConfig(PICO_1_DEVICE_ID);
	XBram_CfgInitialize(&PICO_1_Mem, Pico_1_ConfigPtr,Pico_1_ConfigPtr->CtrlBaseAddress);

	GPIOConfigPtr = XGpioPs_LookupConfig(XPAR_XGPIOPS_0_DEVICE_ID);
	XGpioPs_CfgInitialize(&Gpio, GPIOConfigPtr,GPIOConfigPtr->BaseAddr);

	XGpioPs_SetDirectionPin(&Gpio, pico_one, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, pico_one, 1);

	XGpioPs_SetDirectionPin(&Gpio, pico_two, 1);
	XGpioPs_SetOutputEnablePin(&Gpio, pico_two, 1);

while(1){

 	printf("Please select option\n\r"); //present menu of options
 	printf("PicoBlaze One 2 Hz:  1\n\r");
 	printf("PicoBalze One 4 Hz:  2\n\r");

 	printf("PicoBlaze Two 2 Hz:  3 \n\r");
 	printf("PicoBalze Two 4 Hz:  4\n\r");

 	printf("PicoBalze One Assert Reset:  5\n\r");
 	printf("PicoBalze One Clear Reset:   6\n\r");

 	printf("PicoBalze Two Assert Reset:  7\n\r");
 	printf("PicoBalze Two Clear Reset:   8\n\r");

 	scanf("%d",&choice);

 	if (choice == 1){load_pico0((int) prog_one);}
 	if (choice == 2){load_pico0((int) prog_two);}
 	if (choice == 3){load_pico1((int) prog_one);}
 	if (choice == 4){load_pico1((int) prog_two);}
 	if (choice == 5){reset_assert_0();}
 	if (choice == 6){reset_clear_0();}
 	if (choice == 7){reset_assert_1();}
 	if (choice == 8){reset_clear_1();}
}

    return 0;
}

void load_pico0(int prog)
{
	int ram_addr = 0x0;
	int read_out =0;
	//u32 out;

	ram_addr = 0x0;
 	read_out = 0;
 	reset_assert_0();
 	if (prog == 0){
 		for(read_out =0; read_out <511; read_out++){
 			XBram_WriteReg(PICO_0_BASE, ram_addr, test[read_out]);
 			ram_addr = ram_addr + 4;
 		}
 	}
 	if (prog == 1){
 		for(read_out =0; read_out <511; read_out++){
 			XBram_WriteReg(PICO_0_BASE, ram_addr, test2[read_out]);
 			ram_addr = ram_addr + 4;
 		}
 	}

	reset_clear_0();
}

void load_pico1(int prog)
{
	int ram_addr = 0x0;
	int read_out =0;
	//u32 out;
	ram_addr = 0x0;
 	read_out = 0;
 	reset_assert_1();
 	if (prog == 0){
 	 		for(read_out =0; read_out <511; read_out++){
 	 			XBram_WriteReg(PICO_1_BASE, ram_addr, test[read_out]);
 	 			ram_addr = ram_addr + 4;
 	 		}
 	 	}
 	 	if (prog == 1){
 	 		for(read_out =0; read_out <511; read_out++){
 	 			XBram_WriteReg(PICO_1_BASE, ram_addr, test2[read_out]);
 	 			ram_addr = ram_addr + 4;
	 		}
 	 	}

 	reset_clear_1();
}

void reset_assert_0(int pin)
{
	XGpioPs_WritePin(&Gpio, pico_one, 1);
}

void reset_clear_0(int pin)
{
	XGpioPs_WritePin(&Gpio, pico_one, 0);
}

void reset_assert_1(int pin)
{
	XGpioPs_WritePin(&Gpio, pico_two, 1);
}

void reset_clear_1(int pin)
{
	XGpioPs_WritePin(&Gpio, pico_two, 0);
}


