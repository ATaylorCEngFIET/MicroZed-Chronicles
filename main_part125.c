/*Copyright (c) 2016, Adam Taylor
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

#include "xparameters.h"
#include "xiicps.h"
#include "xiicps_ext.h"
#include "pca9534.h"
#include "tca9548.h"
#include "adv7511.h"
#include "xaxivdma.h"
#include "xaxivdma_ext.h"
#include "onsemi_python_sw.h"
	#define onsemi_python_t	onsemi_vita_t
#include "xcfa.h"
#include "cat9554.h"

#define EMBV_IIC_MUX_I2CIO      TCA9548_I2C0_SEL
#define EMBV_IIC_MUX_HDMII      TCA9548_I2C1_SEL
#define EMBV_IIC_MUX_HDMIO      TCA9548_I2C2_SEL
#define EMBV_IIC_MUX_HDMIO_DDC  TCA9548_I2C3_SEL
#define EMBV_IIC_MUX_AUD        TCA9548_I2C4_SEL
#define EMBV_IIC_MUX_CAM        TCA9548_I2C5_SEL

typedef struct {
	XIicPs iicps0;
	XAxiVdma axivdma0;
	XCfa cfa;
	onsemi_python_t python_receiver;

	XIicPs *piicps0;
	XAxiVdma *paxivdma0;
	XCfa *pcfa;
	onsemi_python_t *pPython_receiver;

} demo_t;

demo_t demo;
demo_t *pdemo;

int main()
{
	int status;
	u8 camera_alpha = 0xFF;
	u8 tpg_alpha = 0x00;
	char c;

	pdemo = &demo;
	pdemo->piicps0 = &(pdemo->iicps0);
	pdemo->paxivdma0 = &(pdemo->axivdma0);

	pdemo->pcfa = &(pdemo->cfa);
	pdemo->pPython_receiver = &(pdemo->python_receiver);

	XIicPs_Config *piicps_config;
	XAxiVdma_Config *paxivdma_config;
	XCfa_Config *pcfa_config;

	xil_printf("\n\r");
	xil_printf("------------------------------------------------------\n\r");
	xil_printf("--            MicroZed Chronicles Part 125          --\n\r");
	xil_printf("--               AVNET EVK Demo Application         --\n\r");
	xil_printf("------------------------------------------------------\n\r");
	xil_printf("\n\r");

	piicps_config = XIicPs_LookupConfig(XPAR_XIICPS_0_DEVICE_ID);
	XIicPs_CfgInitialize(pdemo->piicps0, piicps_config,
			piicps_config->BaseAddress);
	XIicPs_Reset(pdemo->piicps0);
	XIicPs_SetSClk(pdemo->piicps0, 100000);

	paxivdma_config = XAxiVdma_LookupConfig(XPAR_AXIVDMA_0_DEVICE_ID);
	XAxiVdma_CfgInitialize(pdemo->paxivdma0, paxivdma_config,
			paxivdma_config->BaseAddress);

	pcfa_config = XCfa_LookupConfig(XPAR_V_CFA_0_DEVICE_ID);
	XCfa_CfgInitialize(pdemo->pcfa, pcfa_config, pcfa_config->BaseAddress);

	onsemi_python_init(pdemo->pPython_receiver, "PYTHON-1300-C",
			XPAR_ONSEMI_PYTHON_SPI_0_S00_AXI_BASEADDR,
			XPAR_ONSEMI_PYTHON_CAM_0_S00_AXI_BASEADDR);
	onsemi_python_spi_config(pdemo->pPython_receiver,
			4);
	pdemo->pPython_receiver->uManualTap = 25; // IDELAY setting (0-31)

	printf("HDMI Initialization\r\n");

	// I2C MUX Reset
	tca9548_i2c_mux_select(pdemo->piicps0, EMBV_IIC_MUX_I2CIO);
	status = 0x08;
	pca9534_set_pins_direction(pdemo->piicps0, status);
	pca9534_set_pin_value(pdemo->piicps0, 7, 1);		// Disable I2C MUX Reset

	// HDMI Ouput Initialization
	tca9548_i2c_mux_select(pdemo->piicps0, EMBV_IIC_MUX_I2CIO);
	pca9534_set_pin_value(pdemo->piicps0, 4, 0);// Disable HDMI Output Power Down

	tca9548_i2c_mux_select(pdemo->piicps0, EMBV_IIC_MUX_HDMIO);
	adv7511_configure(pdemo->piicps0);

    printf("PYTHON Initialization\r\n");

	// Camera Power Sequence
	tca9548_i2c_mux_select(pdemo->piicps0, EMBV_IIC_MUX_CAM);
	cat9554_initialize(pdemo->piicps0);
	usleep(10);

	// Make sure all disable first
	cat9554_vddpix_off(pdemo->piicps0);
	usleep(10);
	cat9554_vdd33_off(pdemo->piicps0);
	usleep(10);
	cat9554_vdd18_off(pdemo->piicps0);
	usleep(1000);

	// Turn them on one by one
	cat9554_vdd18_en(pdemo->piicps0);
	usleep(10);
	cat9554_vdd33_en(pdemo->piicps0);
	usleep(10);
	cat9554_vddpix_en(pdemo->piicps0);
	usleep(10);

	onsemi_python_sensor_initialize(
			pdemo->pPython_receiver, SENSOR_INIT_ENABLE, 0);
	onsemi_python_sensor_initialize(
			pdemo->pPython_receiver, SENSOR_INIT_STREAMON, 0);
	onsemi_python_sensor_cds(pdemo->pPython_receiver, 0);
	onsemi_python_cam_reg_write(pdemo->pPython_receiver,
			ONSEMI_PYTHON_CAM_SYNCGEN_HTIMING1_REG, 0x00300500);

	printf("CFA Initialization\r\n");
	XCfa_Reset(pdemo->pcfa);
	XCfa_SetBayerPhase(pdemo->pcfa, XCFA_RGRG_COMBINATION);
	XCfa_RegUpdateEnable(pdemo->pcfa);
	XCfa_Enable(pdemo->pcfa);

	printf("VDMA Initialization\r\n");

	XAxiVdma_Reset(pdemo->paxivdma0, XAXIVDMA_WRITE);
	XAxiVdma_Reset(pdemo->paxivdma0, XAXIVDMA_READ);
	WriteSetup(pdemo->paxivdma0, 0x10000000, 0, 1, 1, 0, 0, 1280, 1024, 2048,
			2048);
	ReadSetup(pdemo->paxivdma0, 0x10000000, 0, 1, 1, 0, 0, 1280, 1024, 2048,
			2048);
	StartTransfer(pdemo->paxivdma0);

	printf("System Ready!\r\n");

    while(1){

    }


	return 0;
}
