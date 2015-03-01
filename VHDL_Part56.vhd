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
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity pico_wave_top is
    Port ( clk : in  STD_LOGIC;
           led  : out  STD_LOGIC_VECTOR (3 downto 0));
end pico_wave_top;

architecture Behavioral of pico_wave_top is

component kcpsm6 is
  generic(                 hwbuild : std_logic_vector(7 downto 0) := X"00";
                  interrupt_vector : std_logic_vector(11 downto 0) := X"3FF";
           scratch_pad_memory_size : integer := 64);
  port (                   address : out std_logic_vector(11 downto 0);
                       instruction : in std_logic_vector(17 downto 0);
                       bram_enable : out std_logic;
                           in_port : in std_logic_vector(7 downto 0);
                          out_port : out std_logic_vector(7 downto 0);
                           port_id : out std_logic_vector(7 downto 0);
                      write_strobe : out std_logic;
                    k_write_strobe : out std_logic;
                       read_strobe : out std_logic;
                         interrupt : in std_logic;
                     interrupt_ack : out std_logic;
                             sleep : in std_logic;
                             reset : in std_logic;
                               clk : in std_logic);
  end component kcpsm6;

component test is
  generic(    C_FAMILY : string := "7S"; 
              C_RAM_SIZE_KWORDS : integer := 2;
			  C_JTAG_LOADER_ENABLE : integer := 0);
  Port (      address : in std_logic_vector(11 downto 0);
              instruction : out std_logic_vector(17 downto 0);
              enable : in std_logic;
              rdl : out std_logic;                    
              clk : in std_logic);
  end component test;


SIGNAL instruction : std_logic_vector(17 DOWNTO 0);
SIGNAL address : std_logic_vector(11 DOWNTO 0);
SIGNAL enable : std_logic;
SIGNAL rd1 : std_logic;
SIGNAL led_int : std_logic_vector(7 downto 0);
SIGNAL port_id : std_logic_vector(7 downto 0);
SIGNAL write_strobe:std_logic;
begin

ram_inst : test PORT MAP  (
address => address,
instruction => instruction,
enable => enable,
rdl => rd1,
clk => clk);

pico_inst :  kcpsm6 PORT MAP (

address => address,
instruction => instruction,
bram_enable => enable,
in_port  => (OTHERS =>'0'),
out_port => led_int,
port_id  => port_id, 
write_strobe => write_strobe,
k_write_strobe => open,
read_strobe => open,
interrupt  => '0',
interrupt_ack => open,
sleep => '0',
reset => rd1,
clk => clk);

output_ports: process(clk)
begin
if rising_edge(clk) then
if write_strobe = '1' then
-- 8 General purpose LEDs at port address 01 hex
	if port_id(0) = '1' then
		led <= led_int(3 DOWNTO 0);
end if;
end if;
end if;
end process output_ports;

end Behavioral;
