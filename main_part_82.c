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

#define SPI_EMIO			XPAR_XSPIPS_0_DEVICE_ID
#define SPI_MIO				XPAR_XSPIPS_1_DEVICE_ID
#define test_op 0x89		//pattern to be output
#define DELAY     10000000
static XSpiPs SpiInstance_EMIO;
static XSpiPs SpiInstance_MIO;
int main()
{

	XSpiPs_Config *SpiConfig_EMIO;
	XSpiPs_Config *SpiConfig_MIO;
	int Status;
	int delay;
	u8 write_buffer[1];

    init_platform();

    printf("SPI Demo MicroZed Chronicles\n\r");

    SpiConfig_EMIO = XSpiPs_LookupConfig((u16)SPI_EMIO);
    SpiConfig_MIO = XSpiPs_LookupConfig((u16)SPI_MIO);

    Status = XSpiPs_CfgInitialize(&SpiInstance_EMIO, SpiConfig_EMIO,
    		SpiConfig_EMIO->BaseAddress);
    if (Status != XST_SUCCESS) {
        		return XST_FAILURE;
        	}

    Status = XSpiPs_CfgInitialize(&SpiInstance_MIO, SpiConfig_MIO,
       		SpiConfig_MIO->BaseAddress);
       if (Status != XST_SUCCESS) {
           		return XST_FAILURE;
           	}

    XSpiPs_SetOptions(&SpiInstance_EMIO,
    				XSPIPS_MASTER_OPTION |  XSPIPS_FORCE_SSELECT_OPTION);

    XSpiPs_SetOptions(&SpiInstance_MIO,
    				XSPIPS_MASTER_OPTION |  XSPIPS_FORCE_SSELECT_OPTION);

    XSpiPs_SetClkPrescaler(&SpiInstance_EMIO, XSPIPS_CLK_PRESCALE_256);

    XSpiPs_SetClkPrescaler(&SpiInstance_MIO, XSPIPS_CLK_PRESCALE_256);

    memset(write_buffer, 0x00, sizeof(write_buffer));
    write_buffer[0] = (u8) test_op;

    printf("Outputting word\n\r");
   // XSpiPs_Enable(&SpiInstance);
    while(1){

    	XSpiPs_SetSlaveSelect(&SpiInstance_EMIO, 0x01);
    	XSpiPs_PolledTransfer(&SpiInstance_EMIO, write_buffer, NULL, 1);
    	XSpiPs_SetSlaveSelect(&SpiInstance_MIO, 0x01);
    	XSpiPs_PolledTransfer(&SpiInstance_MIO, write_buffer, NULL, 1);
    	 for( delay = 0; delay < DELAY; delay++)//wait
    	         {}

    }

    return 0;
}
