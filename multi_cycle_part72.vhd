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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY multi_cycle_example IS PORT(
	clk : IN std_logic;
	data_in :IN std_logic_vector(15 DOWNTO 0);
	data_out :OUT std_logic_vector(15 DOWNTO 0));
END ENTITY;

ARCHITECTURE rtl OF multi_cycle_example IS 

SIGNAL data_reg_ip : std_logic_vector(15 DOWNTO 0):=(OTHERS=>'0');
SIGNAL data_reg_op : std_logic_vector(15 DOWNTO 0):=(OTHERS=>'0');
SIGNAL cnt : integer RANGE 0 TO 1 := 0;

BEGIN

PROCESS(clk)
BEGIN
  IF rising_edge(clk) THEN 
    data_reg_ip <= data_in; --capture the data input
    IF cnt = 1 THEN
      data_reg_op <= data_reg_ip;
    END IF;
  END IF;
END PROCESS;


 PROCESS(clk) 
BEGIN
  IF rising_edge(clk) THEN
    cnt <= (cnt + 1) MOD 2; -- counter, wraps around 
  END IF;
END PROCESS;

data_out <= data_reg_op; 

END ARCHITECTURE;

