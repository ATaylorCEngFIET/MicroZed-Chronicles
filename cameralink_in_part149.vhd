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

entity cameralink_in is
	port (
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
		INVERT: in std_logic_vector(4 downto 0);
		FIFO_RST: in std_logic;
		FIFO_RDEN: in std_logic;
		LOCKED: out std_logic;
		FVAL: out std_logic;
		LVAL: out std_logic;
		DVAL: out std_logic;
		DATA: out std_logic_vector(23 downto 0)
	);
end cameralink_in;

architecture Behavioral of cameralink_in is

	component iserdesds is
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
	end component;
	signal reset: std_logic;
	signal locked_int: std_logic := '0';
	signal iserdes_rst: std_logic;
	signal clk_ibuf, clkx7_mmcm, clkx7_bufg, clk_fb, clk_mmcm, clk_bufg, pll_locked: std_logic;
	signal state: integer range 0 to 11;
	signal counter, stable_counter: std_logic_vector(15 downto 0);
	signal clclk, clclk_ref: std_logic_vector(6 downto 0);
	signal d: std_logic_vector(27 downto 0);
	signal fifo_rst_int, fifo_wren, fifo_empty: std_logic;
	signal fifo_di, fifo_do: std_logic_vector(31 downto 0);
	signal psen, psincdec, psdone: std_logic := '0';
	
begin

	-- PLL
	MMCM_ADV_CAMERALINK : MMCM_ADV
		generic map (
			CLKFBOUT_MULT_F => 14.0,
			CLKIN1_PERIOD => 16.667,
			CLKOUT1_DIVIDE => 2,
			CLKOUT2_DIVIDE => 14,
			CLKFBOUT_USE_FINE_PS => TRUE
		)
		port map (
			CLKOUT1 => clkx7_mmcm,
			CLKOUT2 => clk_mmcm,
			CLKFBOUT => clk_fb,
			LOCKED => pll_locked,
			CLKINSEL => '1',
			CLKIN1 => clk_ibuf,
			CLKIN2 => '0',
			PWRDWN => '0',
			RST => '0',
			CLKFBIN => clk_fb,
			DADDR => "0000000",
			DCLK => '0',
			DEN => '0',
			DI => X"0000",
			DWE => '0',
			PSCLK => clk_bufg,
			PSEN => psen,
			PSINCDEC => psincdec,
			PSDONE => psdone
		);
	
	BUFG_CLKX7 : BUFG
	port map (O => clkx7_bufg, I => clkx7_mmcm);

	BUFG_CLK : BUFG
	port map (O => clk_bufg, I => clk_mmcm);

	ISERDESDS_XCLK : ISERDESDS
		port map (
			I => XCLK_P, 
			IB => XCLK_N,
			X => INVERT(4),
			RST => iserdes_rst,
			CLK => clkx7_bufg,
			CLKDIV => clk_bufg,
			PIN => clk_ibuf,
			Q => clclk
		);
		
	ISERDESDS_X0 : ISERDESDS
		port map (
			I => X0_P, 
			IB => X0_N,
			X => INVERT(0),
			RST => iserdes_rst,
			CLK => clkx7_bufg,
			CLKDIV => clk_bufg,
			Q => d(6 downto 0)
		);

	ISERDESDS_X1 : ISERDESDS
		port map (
			I => X1_P, 
			IB => X1_N,
			X => INVERT(1),
			RST => iserdes_rst,
			CLK => clkx7_bufg,
			CLKDIV => clk_bufg,
			Q => d(13 downto 7)
		);

	ISERDESDS_X2 : ISERDESDS
		port map (
			I => X2_P, 
			IB => X2_N,
			X => INVERT(2),
			RST => iserdes_rst,
			CLK => clkx7_bufg,
			CLKDIV => clk_bufg,
			Q => d(20 downto 14)
		);

	ISERDESDS_X3 : ISERDESDS
		port map (
			I => X3_P, 
			IB => X3_N,
			X => INVERT(3),
			RST => iserdes_rst,
			CLK => clkx7_bufg,
			CLKDIV => clk_bufg,
			Q => d(27 downto 21)
		);

	-- Wait for PLL to be ready before CameraLink alignment
	reset <= not pll_locked;

	-- Alignment state machine
	process (reset, clk_bufg)
	begin
		if reset = '1' then
			state <= 0;
			locked_int <= '0';
			psen <= '0';
		elsif rising_edge(clk_bufg) then
			-- Reset ISERDES modules
			if state = 0 then
				state <= 1;
				locked_int <= '0';
				psen <= '0';
				iserdes_rst <= '1';
			elsif state = 1 then
				state <= 2;
				counter <= (others => '0');
				iserdes_rst <= '0';
			-- Wait for ISERDES outputs to settle
			elsif state = 2 then
				counter <= counter + 1;
				if counter(3) = '1' then
					counter <= (others => '0');
					stable_counter <= (others => '0');
					clclk_ref <= clclk;
					state <= 3;
				end if;
			-- Stability check
			elsif state = 3 then
				counter <= counter + 1;
				if clclk_ref /= clclk then
					-- Not stable, advance
					psen <= '1';
					psincdec <= '1';
					stable_counter <= (others => '0');
					state <= 4;
				elsif counter(15) = '1' then
					-- Stable, increment stable count
					stable_counter <= stable_counter + 1;
					-- Has signal been stable for 32 phases?
					if stable_counter(5) = '1' then
						-- Signal is stable, are we at proper camera link clock phase?
						if clclk = "1100011" then
							counter <= (others => '0');
							state <= 5;
						-- If wrong phase, keep advancing
						else
							psen <= '1';
							psincdec <= '1';
							stable_counter <= (others => '0');
							state <= 4;
						end if;
					else
						-- We haven't tested 32 stable phases, advance to next phase
						psen <= '1';
						psincdec <= '1';
						state <= 4;
					end if;
				end if;
			-- Wait for phase shift to complete
			elsif state = 4 then
				psen <= '0';
				if psdone = '1' then
					counter <= (others => '0');
					clclk_ref <= clclk;
					state <= 3;
				end if;
			-- We're at the correct cameralink clock phase, advance until unstable
			elsif state = 5 then
				counter <= counter + 1;
				if clclk /= "1100011" then
					counter <= (others => '0');
					stable_counter <= (others => '0');
					state <= 7;
				elsif counter(15) = '1' then
					-- Stable, keep advancing
					psen <= '1';
					psincdec <= '1';
					state <= 6;
				end if;
			-- Wait for phase shift to complete
			elsif state = 6 then
				psen <= '0';
				if psdone = '1' then
					counter <= (others => '0');
					state <= 5;
				end if;
			-- We're at the correct cameralink clock phase, reverse until unstable
			elsif state = 7 then
				counter <= counter + 1;
				-- Unstable?
				if clclk /= "1100011" then
					-- If we've already been through a large stable area, then we're at the leading edge of the stable range
					if stable_counter > 31 then
						state <= 9;
						counter <= (others => '0');
					-- Otherwise, we need to keep reversing until we get into the large stable range
					else
						psen <= '1';
						psincdec <= '0';
						stable_counter <= (others => '0');
						state <= 8;
					end if;
				elsif counter(15) = '1' then
					-- Stable, increment stable count and reverse another step
					stable_counter <= stable_counter + 1;
					psen <= '1';
					psincdec <= '0';
					state <= 8;
				end if;
			-- Wait for phase shift to complete
			elsif state = 8 then
				psen <= '0';
				if psdone = '1' then
					counter <= (others => '0');
					state <= 7;
				end if;
			-- Advance back to middle of stable range
			elsif state = 9 then
				counter <= counter + 1;
				if counter(14 downto 0) = stable_counter(15 downto 1) then
					state <= 11;
				else
					psen <= '1';
					psincdec <= '1';
					state <= 10;
				end if;
			-- Wait for phase shift to complete
			elsif state = 10 then
				psen <= '0';
				if psdone = '1' then
					state <= 9;
				end if;
			-- Alignment complete
			elsif state = 11 then
				locked_int <= '1';
			end if;
		end if;
	end process;

	LOCKED <= locked_int;
	
	-- FIFO for CameraLink data stream
	FIFO18E1_CAMERALINK_IN : FIFO18E1
		generic map (
			DATA_WIDTH => 36,
			DO_REG => 1,
			EN_SYN => FALSE,
			FIFO_MODE => "FIFO18_36",
			FIRST_WORD_FALL_THROUGH => TRUE
		)
		port map (
			DO => fifo_do,
			EMPTY => fifo_empty,
			RDCLK => CLK,
			RDEN => FIFO_RDEN,
			REGCE => '1',
			RST => fifo_rst_int,
			RSTREG => '0',
			WRCLK => clk_bufg,
			WREN => fifo_wren,
			DI => fifo_di,
			DIP => "0000"
		);
	
	fifo_rst_int <= (not locked_int) or FIFO_RST;
	fifo_wren <= locked_int and d(20);
	fifo_di <= "000000" & d(19 downto 18) & d(26 downto 25) & d(17 downto 12) & d(24 downto 23) & d(11 downto 6) & d(22 downto 21) & d(5 downto 0);
	FVAL <= fifo_do(25);
	LVAL <= fifo_do(24);
	DVAL <= not fifo_empty;
	DATA <= fifo_do(23 downto 0);

end Behavioral;
