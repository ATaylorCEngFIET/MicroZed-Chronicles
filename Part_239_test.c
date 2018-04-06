#include "test.h"
#include "string.h"

void memcpy_test(int *ddr)
{

	int i;
	int data[256];

#pragma HLS INTERFACE m_axi port=ddr depth=256 offset=direct
	for (i =0;i<256;i++){
		data[i] = i;
	}
	memcpy(ddr,data,256*sizeof(int));
}
