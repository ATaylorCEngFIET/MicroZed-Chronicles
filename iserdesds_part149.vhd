-- /*Copyright (c) 2016, Adam Taylor
-- All rights reserved.

-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:

-- 1. Redistributions of source code must retain the above copyright notice, this
   -- list of conditions and the following disclaimer. 
-- 2. Redistributions in binary form must reproduce the above copyright notice,
   -- this list of conditions and the following disclaimer in the documentation
   -- and/or other materials provided with the distribution.

-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
-- ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
-- WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
-- DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
-- ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
-- (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
-- LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
-- ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
-- (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
-- SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

-- The views and conclusions contained in the software and documentation are those
-- of the authors and should not be interpreted as representing official policies, 
-- either expressed or implied, of the FreeBSD Project*/
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library UNISIM;
use UNISIM.VComponents.all;

entity iserdesds is
	port ( 
		I: in std_logic;
		IB: in std_logic;
		X: in std_logic;
		RST: in std_logic;
		CLK: in std_logic;
		CLKDIV: in std_logic;
		PIN: out std_logic;
		Q: out std_logic_vector(6 downto 0)
	);
end iserdesds;

architecture Behavioral of iserdesds is

	signal not_clk: std_logic;
	signal d_ibufds, d_delay: std_logic;
	signal shift1, shift2: std_logic;
	signal o: std_logic_vector(6 downto 0);
	
	attribute S: string;
	attribute S of o: signal is "TRUE";
	
begin

	not_clk <= not CLK;

	IBUFDS_ISERDESDS : IBUFDS
		generic map (DIFF_TERM => TRUE)
		port map (O => d_ibufds, I => I, IB => IB);
		
	--PIN <= d_ibufds;
		
	ISERDESE1_ISERDESDS_MASTER : ISERDESE1
		generic map (
			DATA_RATE => "SDR",
			DATA_WIDTH => 7,
			INTERFACE_TYPE => "NETWORKING",
			IOBDELAY => "NONE",
			SERDES_MODE => "MASTER"
		)
		port map (
			Q1 => o(0),
			Q2 => o(1),
			Q3 => o(2),
			Q4 => o(3),
			Q5 => o(4),
			Q6 => o(5),
			SHIFTOUT1 => shift1,
			SHIFTOUT2 => shift2,
			BITSLIP => '0',
			CE1 => '1',
			CE2 => '1',
			CLK => CLK,
			CLKB => not_clk,
			CLKDIV => CLKDIV,
			OCLK => '0',
			DYNCLKDIVSEL => '0',
			DYNCLKSEL => '0',
			D => d_ibufds,
			DDLY => '0',
			O => PIN,
			OFB => '0',
			RST => RST,
			SHIFTIN1 => '0',
			SHIFTIN2 => '0' 
		);

	ISERDESE1_ISERDESDS_SLAVE : ISERDESE1
		generic map (
			DATA_RATE => "SDR",
			DATA_WIDTH => 7,
			INTERFACE_TYPE => "NETWORKING",
			IOBDELAY => "NONE",
			SERDES_MODE => "SLAVE"
		)
		port map (
			Q3 => o(6),
			BITSLIP => '0',
			CE1 => '1',
			CE2 => '1',
			CLK => CLK,
			CLKB => not_clk,
			CLKDIV => CLKDIV,
			OCLK => '0',
			DYNCLKDIVSEL => '0',
			DYNCLKSEL => '0',
			D => '0',
			DDLY => '0',
			OFB => '0',
			RST => RST,
			SHIFTIN1 => shift1,
			SHIFTIN2 => shift2 
		);

	-- Invert outputs if requested
	Q(6) <= o(6) xor X;
	Q(5) <= o(5) xor X;
	Q(4) <= o(4) xor X;
	Q(3) <= o(3) xor X;
	Q(2) <= o(2) xor X;
	Q(1) <= o(1) xor X;
	Q(0) <= o(0) xor X;

end Behavioral;

