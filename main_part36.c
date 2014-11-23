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
