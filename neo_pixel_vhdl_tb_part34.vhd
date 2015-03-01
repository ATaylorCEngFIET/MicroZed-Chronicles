-- /*Copyright (c) 2015, Adam Taylor
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
LIBRARY  ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY tb IS
END ENTITY;

ARCHITECTURE behavioural OF tb IS 

COMPONENT neo_pixel IS PORT(
  clk   : IN std_logic;
  dout  : OUT std_logic;
  rstb  : OUT STD_LOGIC;
  enb   : OUT STD_LOGIC;
  web   : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
  addrb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  dinb  : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
  doutb : IN STD_LOGIC_VECTOR(31 DOWNTO 0)
);
END COMPONENT;

COMPONENT uzed_blk_mem_gen_0_0 IS
  PORT (
    clka : IN STD_LOGIC;
    rsta : IN STD_LOGIC;
    ena : IN STD_LOGIC;
    wea : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dina : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
    clkb : IN STD_LOGIC;
    rstb : IN STD_LOGIC;
    enb : IN STD_LOGIC;
    web : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    addrb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    dinb : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
    doutb : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
  );
END COMPONENT uzed_blk_mem_gen_0_0;

SUBTYPE vector_size IS std_logic_vector(31 DOWNTO 0);
TYPE neo IS ARRAY (0 to 30) OF vector_size;

CONSTANT mem_data : neo := (
x"0000001e",
x"00DDDAC3",
x"006A4D03",
x"0027C3F1",
x"0046CE04",
x"000FB9ED",
x"00977D04",
x"00C1FDB2",
x"007A9E52",
x"00B34C36",
x"0056640F",
x"00F6D97A",
x"00F88BBB",
x"0012A820",
x"00BB1DF2",
x"00034EC3",
x"0054846C",
x"00EF2B7F",
x"000D685F",
x"005F0F59",
x"006BF532",
x"00F5A778",
x"00C5E351",
x"00BA06D8",
x"00F9C0F1",
x"004BE2D5",
x"0055E0F0",
x"000A44BA",
x"00B9DCB6",
x"00B26C94",
x"00689745");

CONSTANT clk_period : time := 50 ns;

SIGNAL    clk   :  STD_LOGIC:='0';
SIGNAL    rst   :  STD_LOGIC:='0';
SIGNAL    ena   :  STD_LOGIC:='0';
SIGNAL    wea   :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL    addra :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    dina  :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    douta :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    enb   :  STD_LOGIC;
SIGNAL    web   :  STD_LOGIC_VECTOR(3 DOWNTO 0);
SIGNAL    addrb :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    dinb  :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    doutb :  STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL    dout  :  STD_LOGIC;

BEGIN
  
clk_gen :  PROCESS
BEGIN
  LOOP
    clk <= NOT(CLK);
    WAIT FOR(clk_period/2);
    clk <= NOT(CLK);
    WAIT FOR(clk_period/2);
  END LOOP;
END PROCESS;
  
ram_uut : uzed_blk_mem_gen_0_0 PORT MAP(
    clka  => clk,
    rsta  => rst,
    ena   => ena,
    wea   => wea,
    addra => addra,
    dina  => dina,
    douta => douta,
    clkb  => clk,
    rstb  => rst,
    enb   => enb,
    web   => web,
    addrb => addrb,
    dinb  => dinb,
    doutb => doutb);
    
uut : neo_pixel PORT MAP(
  clk   => clk,
  dout  => dout,
  rstb  => OPEN,
  enb   => enb,
  web   => web,
  addrb => addrb,
  dinb  => dinb,
  doutb => doutb);

ram_load : PROCESS
BEGIN
  FOR i IN 0 TO 30 LOOP
    WAIT FOR clk_period;
    WAIT UNTIL rising_edge(clk);
    wea <= (OTHERS=>'1');
    ena <='1';
    addra <= std_logic_vector(to_unsigned(i*4,32));--needs to be on boundaires of four 
    dina <= mem_data(i);
    WAIT UNTIL rising_edge(clk);
    wea <= (OTHERS=>'0');
    ena <='0';
    WAIT FOR 10 ns; 
  END LOOP;
  WAIT;
--  REPORT "simulation Complete" SEVERITY failure;
END PROCESS;

END ARCHITECTURE
