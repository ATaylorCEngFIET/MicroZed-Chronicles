
#include <stdio.h>
#include "platform.h"
#include "xil_printf.h"
#include "xsecure_aes.h"

#define XSECURE_DATA_SIZE	(68)
#define XSECURE_IV_SIZE		(12)
#define XSECURE_KEY_SIZE	(32)

u8 Key[XSECURE_KEY_SIZE]={0xF8, 0x78, 0xB8, 0x38, 0xD8, 0x58, 0x98, 0x18, 0xE8,
		0x68, 0xA8, 0x28, 0xC8, 0x48, 0x88, 0x08, 0xF0, 0x70, 0xB0, 0x30, 0xD0,
		0x50, 0x90, 0x10, 0xE0, 0x60, 0xA0, 0x20, 0xC0, 0x40, 0x80, 0x00};


u8 Iv[XSECURE_IV_SIZE]={0xD2, 0x45, 0x0E, 0x07, 0xEA, 0x5D, 0xE0, 0x42, 0x6C, 0x0F, 0xA1, 0x33};

u8 Data[XSECURE_DATA_SIZE]__attribute__ ((aligned (64)))={0x12, 0x34, 0x56, 0x78, 0x08, 0xF0, 0x70, 0xB0, 0x30,
		0xD0, 0x50, 0x90, 0x10,	0xE0, 0x60, 0xA0, 0x20, 0xC0, 0x40, 0x80, 0x00, 0xA5, 0xDE, 0x08, 0xD8, 0x58,
		0x98, 0xA5, 0xA5, 0xFE, 0xDC, 0xA1, 0x01, 0x34, 0xAB, 0xCD, 0xEF, 0x12, 0x34, 0x56, 0x78, 0x90, 0x09,
		0x87, 0x65, 0x43, 0x21, 0x12, 0x34, 0x87, 0x65, 0x41, 0x24, 0x45, 0x66, 0x79, 0x87, 0x43, 0x09, 0x71,
		0x36, 0x27, 0x46, 0x38, 0x01, 0xAD, 0x10, 0x56};

#define XSECURE_CSUDMA_DEVICEID	XPAR_XCSUDMA_0_DEVICE_ID

XSecure_Aes Secure_Aes;
XCsuDma CsuDma;

int main()
{

	XCsuDma_Config *Config;
	s32 Status;
	u32 Index;
	u8 EncData[XSECURE_DATA_SIZE + XSECURE_SECURE_GCM_TAG_SIZE]__attribute__ ((aligned (64)));


    init_platform();

    print("Adiuvo Engineering & Training AES CSU Example \n\r");

	Config = XCsuDma_LookupConfig(XSECURE_CSUDMA_DEVICEID);
	if (NULL == Config) {
		return XST_FAILURE;
	}

	Status = XCsuDma_CfgInitialize(&CsuDma, Config, Config->BaseAddress);
	if (Status != XST_SUCCESS) {
		return XST_FAILURE;
	}

	XSecure_AesInitialize(&Secure_Aes, &CsuDma,
				XSECURE_CSU_AES_KEY_SRC_KUP,
				(u32 *)Iv, (u32 *)Key);

	xil_printf("Data to be encrypted: \n\r");
	for (Index = 0; Index < XSECURE_DATA_SIZE; Index++) {
		xil_printf("%02x", Data[Index]);
	}
	xil_printf( "\r\n\n");

	XSecure_AesEncryptInit(&Secure_Aes, EncData, XSECURE_DATA_SIZE);
	XSecure_AesEncryptUpdate(&Secure_Aes, Data, XSECURE_DATA_SIZE);

	xil_printf("Encrypted data: \n\r");
	for (Index = 0; Index < XSECURE_DATA_SIZE; Index++) {
		xil_printf("%02x", EncData[Index]);
	}
	xil_printf( "\r\n");

	xil_printf("GCM tag: \n\r");
	for (Index = 0; Index < XSECURE_SECURE_GCM_TAG_SIZE; Index++) {
		xil_printf("%02x", EncData[XSECURE_DATA_SIZE + Index]);
	}
	xil_printf( "\r\n\n");

    cleanup_platform();
    return 0;
}
