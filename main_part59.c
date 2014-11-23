/*
 * Copyright (c) 2009 Xilinx, Inc.  All rights reserved.
 *
 * Xilinx, Inc.
 * XILINX IS PROVIDING THIS DESIGN, CODE, OR INFORMATION "AS IS" AS A
 * COURTESY TO YOU.  BY PROVIDING THIS DESIGN, CODE, OR INFORMATION AS
 * ONE POSSIBLE   IMPLEMENTATION OF THIS FEATURE, APPLICATION OR
 * STANDARD, XILINX IS MAKING NO REPRESENTATION THAT THIS IMPLEMENTATION
 * IS FREE FROM ANY CLAIMS OF INFRINGEMENT, AND YOU ARE RESPONSIBLE
 * FOR OBTAINING ANY RIGHTS YOU MAY REQUIRE FOR YOUR IMPLEMENTATION.
 * XILINX EXPRESSLY DISCLAIMS ANY WARRANTY WHATSOEVER WITH RESPECT TO
 * THE ADEQUACY OF THE IMPLEMENTATION, INCLUDING BUT NOT LIMITED TO
 * ANY WARRANTIES OR REPRESENTATIONS THAT THIS IMPLEMENTATION IS FREE
 * FROM CLAIMS OF INFRINGEMENT, IMPLIED WARRANTIES OF MERCHANTABILITY
 * AND FITNESS FOR A PARTICULAR PURPOSE.
 *
 */

/*
 * helloworld.c: simple test application
 */

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


