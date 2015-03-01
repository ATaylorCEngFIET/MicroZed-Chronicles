;Copyright (c) <YEAR>, <OWNER>
;All rights reserved.

;Redistribution and use in source and binary forms, with or without
;modification, are permitted provided that the following conditions are met:

;1. Redistributions of source code must retain the above copyright notice, this
;   list of conditions and the following disclaimer. 
;2. Redistributions in binary form must reproduce the above copyright notice,
;   this list of conditions and the following disclaimer in the documentation
;   and/or other materials provided with the distribution.

;THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
;ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
;WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
;DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
;ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
;(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
;LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
;ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
;(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
;SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

;The views and conclusions contained in the software and documentation are those
;of the authors and should not be interpreted as representing official policies, 
;either expressed or implied, of the FreeBSD Project.

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
