/*Copyright (c) 2018, Adam Taylor
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
#include "xil_printf.h"
#include "xbram.h"

XBram Bram;
#define BRAM_DEVICE_ID		XPAR_AXI_BRAM_CTRL_0_DEVICE_ID

int main()
{
	int  i;
    init_platform();
	XBram_Config *ConfigPtr;
	u32 data;
     printf("UltraZed Edition Part 14\n\r");
     printf("http://www.ultrazedchronicles.com\n\r");

while(1){
     	for (i=0; i<256 ;i++){
     		data = XBram_ReadReg(ConfigPtr->MemBaseAddress, (i*4));
     		printf("Data Read from Address %x %x \n\r",(unsigned int)(i*4),(unsigned int) data );
     	}

     	for (i=0; i<256 ;i++){
     		XBram_WriteReg(ConfigPtr->MemBaseAddress, (i*4), i);
     		printf("Data Written to Address %x %x \n\r",(unsigned int)(i*4),(unsigned int)i );
     	}

     	for (i=0; i<256 ;i++){
     		data = XBram_ReadReg(ConfigPtr->MemBaseAddress, (i*4));
     		printf("Data Read from Address %x %x \n\r",(unsigned int)(i*4),(unsigned int)data );
     	}
}
    cleanup_platform();
    return 0;
}
