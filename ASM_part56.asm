NAMEREG s0,led  ;rename S0 register to led

;as 8 bit processor we need four delay loops 256 * 256 * 256 * 256 = 4294967296 
																
CONSTANT max1, 80 ;set delay 
CONSTANT max2, 84 ;set delay 
CONSTANT max3, 1e ;set delay 
CONSTANT max4, 00 ;set delay

main:	LOAD led, 00; load the led output register with 00
flash:	XOR led, FF; xor the value in led register with FF i.e. toggle
		OUTPUT led,01; output led register with port ID of 1 
		CALL delay_init; start delay
		JUMP flash; loop back to beginning

delay_init: LOAD s4, max4;
			LOAD s3, max3;
			LOAD s2, max2;
			LOAD s1, max1;

delay_loop:	SUB s1, 1'd; subtract 1 decimal from s1
			SUBCY s2, 0'd; carry subtraction 
			SUBCY s3, 0'd; carry subtraction
			SUBCY s4, 0'd; carry subtraction 
			JUMP NZ, delay_loop;
			RETURN 
