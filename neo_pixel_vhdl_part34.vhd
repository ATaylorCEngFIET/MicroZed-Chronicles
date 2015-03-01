-- Copyright (c) 2015, Adam Taylor
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
-- either expressed or implied, of the FreeBSD Project
LIBRARY IEEE;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY neo_pixel IS PORT(
  clk   : IN std_logic;
  dout  : OUT std_logic;
  rstb  : OUT STD_LOGIC;
  enb   : OUT STD_LOGIC;
  web   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  addrb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  dinb  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  doutb : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END ENTITY;

ARCHITECTURE rtl OF neo_pixel IS 

TYPE FSM IS (idle,wait1,led,count,reset,addr_out,wait2,grab,wait_done,done_addr); 

CONSTANT done  : std_logic_vector(25 DOWNTO 0) := "00000000000000000000000001";  --shows when shift reg empty
CONSTANT zero  : std_logic_vector(24 DOWNTO 0) := "1111111000000000000000000"; --waveform for a zero bit
CONSTANT one   : std_logic_vector(24 DOWNTO 0) := "1111111111111100000000000"; --waveform for a one bit 
CONSTANT numb_pixels : integer := 24; --number of bits in a pixel
CONSTANT reset_duration : integer := 1000;--number cclocks in the reset period

SIGNAL shift_reg : std_logic_vector(24 DOWNTO 0) := (OTHERS=>'0'); -- shift reg containing the output pixel waveform
SIGNAL shift_dne : std_logic_vector(25 DOWNTO 0) := (OTHERS=>'0'); -- shift reg for timing the output shift reg for next load
SIGNAL current_state : fsm := idle; --fsm to control the pixel beign output 
SIGNAL prev_state : fsm := idle; --previous state 

SIGNAL load_shr : std_logic :='0'; --loads the shr with the next pixel 
SIGNAL pix_cnt  : integer RANGE 0 TO 31 := 0; --counts the position in the pixel to op 
SIGNAL rst_cnt  : integer RANGE 0 TO 1023 := 0; --counts number of clocks in the reset period 50 us @ 20 MHz
SIGNAL led_numb : integer RANGE 0 TO 1023; --number of LED in the string
SIGNAL ram_addr : integer RANGE 0 TO 1023:=0; --address to read from RAM
SIGNAL led_cnt  : integer RANGE 0 TO 1023;--counts leds it has addressed 
SIGNAL pixel    : std_logic_vector(23 DOWNTO 0); --holds led value to be output

BEGIN

web  <= (OTHERS => '0');
rstb <=  '0';
dinb <= (OTHERS =>'0');

pixel_cntrl :  PROCESS(clk)
BEGIN
  IF rising_edge(CLK) THEN 
    load_shr <= '0';
    enb <= '0';
    CASE current_state IS 
    WHEN idle =>
      current_state <= wait1;
      rst_cnt  <= 0;
      addrb <= std_logic_vector(to_unsigned(ram_addr,32));
      enb<='1';
    WHEN wait1 =>
      current_state <= led;
    WHEN led => 
      led_numb <= to_integer(unsigned(doutb));
      IF to_integer(unsigned(doutb)) = 0 THEN 
        current_state <= idle;
      ELSE
        current_state <= addr_out;
        ram_addr <= ram_addr +4;
      END IF;
    WHEN count => 
      IF pix_cnt = (numb_pixels-1) THEN
        IF led_cnt = (led_numb-1) THEN 
         current_state <= reset;
         pix_cnt <= 0;
         ram_addr <= 0;
        ELSE
         ram_addr <= ram_addr+4;
         current_state <= done_addr;
         led_cnt <= led_cnt + 1;
        END IF;
      ELSE
      current_state <= wait_done;
      END IF;
    WHEN done_addr =>
      IF (shift_dne(shift_dne'high-1) = '1') THEN 
        current_state <= addr_out;
      END IF;
    WHEN wait_done =>
      IF (shift_dne(shift_dne'high-1) = '1') THEN 
         load_shr <='1';
         pix_cnt <= pix_cnt + 1;  
         current_state <= count;    
        END IF; 
    WHEN addr_out =>
      addrb <= std_logic_vector(to_unsigned(ram_addr,32));
      enb<='1';
      current_state <= wait2;
    WHEN wait2 =>
      current_state <= grab;
      prev_state <= wait2;
    WHEN grab =>
      pixel <= doutb(doutb'high-8 DOWNTO doutb'low);
      load_shr <= '1';
      current_state <= wait_done;
      pix_cnt <=0;
    WHEN reset =>
      pix_cnt <= 0;
      led_cnt <= 0;
      IF rst_cnt = (reset_duration-1) THEN 
        current_state <= idle;
        ram_addr <= 0;
      ELSE
        rst_cnt <= rst_cnt + 1;
      END IF;
    END CASE;
  END IF;
END PROCESS;

shr_op : PROCESS(clk)
BEGIN
  IF rising_edge(clk) THEN 
    IF load_shr ='1' THEN
      shift_dne <= done;
      IF pixel((numb_pixels-1)-pix_cnt) = '1' THEN
        shift_reg <= one;  
      ELSE
        shift_reg <= zero;
      END IF;
    ELSE
      shift_reg <= shift_reg(shift_reg'high-1 DOWNTO shift_reg'low) & '0';
      shift_dne <= shift_dne(shift_dne'high-1 DOWNTO shift_reg'low) & '0';
    END IF;
  END IF;
END PROCESS;

dout <= shift_reg(shift_reg'high);     

END ARCHITECTURE;
