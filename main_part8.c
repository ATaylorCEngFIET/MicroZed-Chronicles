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
#include "xil_types.h"
#define XPAR_AXI_XADC_0_DEVICE_ID 0


//void print(char *str);

static XAdcPs XADCMonInst;

int main()
{

	XAdcPs_Config *ConfigPtr;
	XAdcPs *XADCInstPtr = &XADCMonInst;

	//status of initialisation
	int Status_ADC;

	//temperature readings
	u32 TempRawData;
	float TempData;

	//Vcc Int readings
	u32 VccIntRawData;
	float VccIntData;

	//Vcc Aux readings
	u32 VccAuxRawData;
	float VccAuxData;

	//Vbram readings
	u32 VBramRawData;
	float VBramData;

	//VccPInt readings
	u32 VccPIntRawData;
	float VccPIntData;

	//VccPAux readings
	u32 VccPAuxRawData;
	float VccPAuxData;

	//Vddr readings
	u32 VDDRRawData;
	float VDDRData;

	init_platform();

    printf("Adam Edition MicroZed Using Vivado How To Printf \n\r");

    //XADC initilization

     ConfigPtr = XAdcPs_LookupConfig(XPAR_AXI_XADC_0_DEVICE_ID);
     	if (ConfigPtr == NULL) {
     		return XST_FAILURE;
     	}

     Status_ADC = XAdcPs_CfgInitialize(XADCInstPtr,ConfigPtr,ConfigPtr->BaseAddress);
     if(XST_SUCCESS != Status_ADC){
         print("ADC INIT FAILED\n\r");
         return XST_FAILURE;
      }

     //self test
     Status_ADC = XAdcPs_SelfTest(XADCInstPtr);
 	if (Status_ADC != XST_SUCCESS) {
 		return XST_FAILURE;
 	}

 	//stop sequencer
 	XAdcPs_SetSequencerMode(XADCInstPtr,XADCPS_SEQ_MODE_SINGCHAN);

     //disable alarms
     XAdcPs_SetAlarmEnables(XADCInstPtr, 0x0);

     //configure sequencer to just sample internal on chip parameters
     XAdcPs_SetSequencerMode(XADCInstPtr, XADCPS_SEQ_MODE_SAFE);

     //configure the channel enables we want to monitor
     XAdcPs_SetSeqChEnables(XADCInstPtr,XADCPS_SEQ_CH_TEMP|XADCPS_SEQ_CH_VCCINT|XADCPS_SEQ_CH_VCCAUX|XADCPS_SEQ_CH_VBRAM|XADCPS_SEQ_CH_VCCPINT|
     		XADCPS_SEQ_CH_VCCPAUX|XADCPS_SEQ_CH_VCCPDRO);

     while(1){
     TempRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_TEMP);
      TempData = XAdcPs_RawToTemperature(TempRawData);
      printf("Raw Temp %lu Real Temp %f \n\r", TempRawData, TempData);

      VccIntRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCINT);
      VccIntData = XAdcPs_RawToVoltage(VccIntRawData);
      printf("Raw VccInt %lu Real VccInt %f \n\r", VccIntRawData, VccIntData);

      VccAuxRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCAUX);
      VccAuxData = XAdcPs_RawToVoltage(VccAuxRawData);
      printf("Raw VccAux %lu Real VccAux %f \n\r", VccAuxRawData, VccAuxData);

  //    VrefPRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VREFP);
  //    VrefPData = XAdcPs_RawToVoltage(VrefPRawData);
  //    printf("Raw VRefP %lu Real VRefP %f \n\r", VrefPRawData, VrefPData);

  //    VrefNRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VREFN);
  //    VrefNData = XAdcPs_RawToVoltage(VrefNRawData);
   //   printf("Raw VRefN %lu Real VRefN %f \n\r", VrefNRawData, VrefNData);

      VBramRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VBRAM);
      VBramData = XAdcPs_RawToVoltage(VBramRawData);
      printf("Raw VccBram %lu Real VccBram %f \n\r", VBramRawData, VBramData);

      VccPIntRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCPINT);
      VccPIntData = XAdcPs_RawToVoltage(VccPIntRawData);
      printf("Raw VccPInt %lu Real VccPInt %f \n\r", VccPIntRawData, VccPIntData);

      VccPAuxRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCPAUX);
      VccPAuxData = XAdcPs_RawToVoltage(VccPAuxRawData);
      printf("Raw VccPAux %lu Real VccPAux %f \n\r", VccPAuxRawData, VccPAuxData);

      VDDRRawData = XAdcPs_GetAdcData(XADCInstPtr, XADCPS_CH_VCCPDRO);
      VDDRData = XAdcPs_RawToVoltage(VDDRRawData);
      printf("Raw VccDDR %lu Real VccDDR %f \n\r", VDDRRawData, VDDRData);
     }

    return 0;
}
