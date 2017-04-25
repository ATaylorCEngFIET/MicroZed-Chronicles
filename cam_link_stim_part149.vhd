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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity cam_link_stim is
--  Port ( );
end cam_link_stim;

architecture Behavioral of cam_link_stim is

component camera_link is port(
        CLK: in std_logic;
		XCLK_P: in std_logic;
		XCLK_N: in std_logic;
		X0_P: in std_logic;
		X0_N: in std_logic;
		X1_P: in std_logic;
		X1_N: in std_logic;
		X2_P: in std_logic;
		X2_N: in std_logic;
		X3_P: in std_logic;
		X3_N: in std_logic;
		
		LOCKED: out std_logic;
		FVAL: out std_logic;
		LVAL: out std_logic;
		DVAL: out std_logic;
		DATA: out std_logic_vector(9 downto 0));
end component camera_link;

type mode is (full, pfull, hfull, qfull, vfull);


constant clk_period  : time := 22.5989 ns;
constant ser_period    : time := 3.228 ns;--clk_period / 7;
constant ser_clk_vec : std_logic_vector(6 DOWNTO 0):="1100011";

constant h_total : integer := 1270;
constant h_act   : integer := 1024;
constant h_blank : integer := 246;

constant v_total : integer := 796;
constant v_act   : integer := 768;
constant v_blank : integer := 28;

signal clk : std_logic;
signal ser_clk : std_logic;
signal op_mode : mode  := full;

signal gen_h_total : integer range 0 to 2047;
signal gen_h_act   : integer range 0 to 2047;
signal gen_h_blank : integer range 0 to 2047;

signal gen_v_total : integer range 0 to 2047;
signal gen_v_act   : integer range 0 to 2047;
signal gen_v_blank : integer range 0 to 2047;

signal line_cnt : integer range 0 to 2047 := 0;
signal frame_cnt: integer range 0 to 2047 := 0;

signal lval : std_logic;
signal fval : std_logic;
signal dval : std_logic;

signal x3 : std_logic_vector(6 DOWNTO 0);
signal x2 : std_logic_vector(6 DOWNTO 0);
signal x1 : std_logic_vector(6 DOWNTO 0);
signal x0 : std_logic_vector(6 DOWNTO 0);
signal xc : std_logic_vector(6 DOWNTO 0);

signal nx3 : std_logic;
signal nx2 : std_logic;
signal nx1 : std_logic;
signal nx0 : std_logic;
signal nxc : std_logic;

signal data : unsigned(9 downto 0);
signal dval_int : std_logic;
signal fval_int : std_logic;
signal lval_int : std_logic;

signal data_rx : std_logic_vector(9 downto 0);
signal dval_rx : std_logic;
signal fval_rx : std_logic;
signal lval_rx : std_logic;

signal clk_dll : std_logic;
signal clk_fb  : std_logic;

begin

MMCM_ADV_CAMERALINK : MMCM_ADV
		generic map (
			CLKFBOUT_MULT_F => 14.0,
			CLKIN1_PERIOD => 22.5989,-- 16.667, -- 60 MHz
			CLKOUT1_DIVIDE => 2, -- CLKFBOUT_MULT_F / CLKOUT1_DIVIDE  = op freq in this case  7 times the clock 
			CLKOUT2_DIVIDE => 14, -- CLKFBOUT_MULT_F / CLKOUT2_DIVIDE  = op freq in this case 1 times the clock
			CLKFBOUT_USE_FINE_PS => TRUE
		)
		port map (
			CLKOUT1 => ser_clk,
			CLKOUT2 => clk,
			CLKFBOUT => clk_fb,
			LOCKED => open,
			CLKINSEL => '1',
			CLKIN1 => clk_dll,
			CLKIN2 => '0',
			PWRDWN => '0',
			RST => '0',
			CLKFBIN => clk_fb,
			DADDR => "0000000",
			DCLK => '0',
			DEN => '0',
			DI => X"0000",
			DWE => '0',
			PSCLK => clk,
			PSEN => '0',
			PSINCDEC => '0',
			PSDONE => open
		);


gen_h_total <= h_total;
gen_h_act   <= h_act;
gen_h_blank <= h_blank;

gen_v_total <= v_total;
gen_v_act   <= v_act;
gen_v_blank <= v_blank;

clk_gen : process
begin
 loop
  clk_dll <= '0';
  wait for (clk_period / 2);
  clk_dll <= '1';
  wait for (clk_period / 2);
 end loop;
end process;

--ser_clk_gen : process
--begin
-- loop
--  ser_clk <= '0';
--  wait for (ser_period / 2);
--  ser_clk <= '1';
--  wait for (ser_period / 2);
-- end loop;
--end process;

gen : process(clk) 
begin
     if rising_edge(clk) then 
      if line_cnt < gen_h_total - 1 then 
       line_cnt <= line_cnt + 1;
      else
       line_cnt <= 0;
       if frame_cnt < gen_v_total - 1 then 
        frame_cnt <= frame_cnt + 1;
       else
        frame_cnt <= 0;
       end if;
      end if;
     end if;
end process;

op : process(line_cnt, frame_cnt)
begin
    if line_cnt < (gen_h_blank) then 
        lval_int <= '0';
    else
        lval_int <= '1';
    end if;
    if frame_cnt < (gen_v_blank) then 
        fval_int <= '0';
    else
        fval_int <= '1';
    end if;
end process;

dval_int <= fval and lval;   
dval <= dval_int;
lval <= lval_int;
fval <= fval_int;
      
data_gen : process(clk)
begin
 if rising_edge(clk) then 
    if dval_int = '1' then 
        data <= data + 1;
    else
        data <= (others =>'0');
    end if;
  end if;
end process;

-- need 7 * pixel clock to generate the data 
op_speed : process(ser_clk,clk)
begin
    if rising_edge(clk) then 
        x3 <= "00000" & data(7) & data(6);
        x2 <= dval_int & fval_int & lval_int & "0000";
        x1 <= "000000" & data(9);
        x0 <= data(8) & std_logic_vector(data(5 downto 0));
        xc <= ser_clk_vec;
     elsif rising_edge(ser_clk) then
        x3 <= '0' & x3(x3'high downto x3'low+1);
        x2 <= '0' & x2(x2'high downto x2'low+1);
        x1 <= '0' & x1(x1'high downto x1'low+1);
        x0 <= '0' & x0(x0'high downto x0'low+1);
        xc <= '1' & xc(xc'high downto xc'low+1);
     end if;
end process;

nx3 <=  not x3(x3'low);
nx2 <=  not x2(x2'low);
nx1 <=  not x1(x1'low);
nx0 <=  not x0(x0'low);
nxc <=  not xc(xc'low);


uut: camera_link  port map(
        CLK => clk,
		XCLK_P => xc(xc'low),
		XCLK_N => nxc,
		X0_P => x0(x0'low),
		X0_N => nx0,
		X1_P => x1(x1'low),
		X1_N => nx1,
		X2_P => x2(x2'low),
		X2_N => nx2,
		X3_P => x3(x3'low),
		X3_N => nx3,
		
		LOCKED => open, 
		FVAL => fval_rx,
		LVAL => lval_rx,
		DVAL => dval_rx,
		DATA => data_rx);
 
end Behavioral;
