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
int main()
{

	XScuTimer_Config *TMRConfigPtr;     //timer config
	XBram_Config *ConfigPtr;

	unsigned int inchar;
	unsigned int newlr;
	int rx_pix;
	int r, g, b;
	unsigned int state = 0;

	init_platform();

	ConfigPtr = XBram_LookupConfig(BRAM_DEVICE_ID);
	XBram_CfgInitialize(&Bram, ConfigPtr,ConfigPtr->CtrlBaseAddress);

    TMRConfigPtr = XScuTimer_LookupConfig(TIMER_DEVICE_ID);
    XScuTimer_CfgInitialize(&Timer, TMRConfigPtr,TMRConfigPtr->BaseAddr);

    SetupInterruptSystem(&Intc,&Timer,TIMER_IRPT_INTR);

while(1){

   // printf(":>");



	if (state == 0){
		numb_pixels = max_pixel;
		inchar = getchar();
		newlr = getchar();
		printf("option %x",inchar);
		switch (inchar){
			case 0x02:
			 printf("<STX>");
			 state = 1;
			 break;
			case 0x03:
			 printf("<ETX>\n");
			 break;
		}
	}
	if (state == 1){
		inchar = getchar();
		newlr = getchar();
		rx_pix = inchar;
		state = 2;
		printf("pixel number = %d",rx_pix);
	}
	if (state == 2){
		inchar = getchar();
		newlr = getchar();
		g = inchar;
		state = 3;
		printf("green = %x",g);
	}
	if (state == 3){
		inchar = getchar();
		newlr = getchar();
		r = inchar;
		state = 4;
		printf("red = %x",r);
	}
	if (state == 4){
		inchar = getchar();
		newlr = getchar();
		b = inchar;
		state = 5;
		printf("blue = %x",b);
	}
	if (state == 5){
	   inchar = getchar();
	   newlr = getchar();
	   switch (inchar){
			case 0x02:
			 printf("<STX>");
			 state = 6;
			 break;
			case 0x03:
			 printf("<ETX>\n");
			 state = 6;
			 break;
		}
	}
	if (state == 6){
			pixel[rx_pix] = (u32)b | ((u32)r << 8) | ((u32)g <<16);
			load_ram();
			state = 0;
		}
}

    return 0;

}

void load_ram()
{
	int ram_addr = 0x4;
	int read_out =0;
//	u32 out;

	ram_addr = 0x4;
 	read_out = 0;
 	for(read_out =0; read_out <numb_pixels; read_out++){
 		XBram_WriteReg(BRAM_BASE, ram_addr, pixel[read_out]);
 	//	out = XBram_ReadReg(BRAM_BASE, ram_addr);
 	//	printf("RAM %x %lx\n\r",ram_addr, out);
 		ram_addr = ram_addr +4;
 	}
	//enable the data
    XBram_WriteReg(BRAM_BASE, 0, (u32)numb_pixels);
}
