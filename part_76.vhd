--Copyright (c) 2015, Adam Taylor
--All rights reserved.
--Redistribution and use in source and binary forms, with or without
--modification, are permitted provided that the following conditions are met:
--1. Redistributions of source code must retain the above copyright notice, this
--   list of conditions and the following disclaimer. 
--2. Redistributions in binary form must reproduce the above copyright notice,
--   this list of conditions and the following disclaimer in the documentation
--   and/or other materials provided with the distribution.
--THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
--ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
--WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
--DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
--ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
--(INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
--LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
--ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
--(INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
--SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
--The views and conclusions contained in the software and documentation are those
--of the authors and should not be interpreted as representing official policies, 
--either expressed or implied, of the FreeBSD Project
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;

ENTITY rloc IS PORT(
 clk : IN std_logic;
 rst : IN std_logic;
 ip  : IN std_logic;
 op : OUT std_logic);
END ENTITY;

ARCHITECTURE rtl OF rloc IS 

SIGNAL ip_sync : STD_LOGIC_VECTOR(1 DOWNTO 0) :=(OTHERS =>'0');
SIGNAL shr_reg : STD_LOGIC_VECTOR(15 DOWNTO 0) :=(OTHERS =>'0');


ATTRIBUTE HU_SET : STRING;
ATTRIBUTE HU_SET OF ip_sync : SIGNAL IS "ip_sync";
ATTRIBUTE HU_SET of shr_reg : SIGNAL IS "shr_reg";

ATTRIBUTE RLOC : STRING;
ATTRIBUTE RPM_GRID : string;
ATTRIBUTE RLOC OF ip_sync: SIGNAL IS "X41Y1 X43Y1";
ATTRIBUTE RPM_GRID OF ip_sync : SIGNAL IS "GRID";

ATTRIBUTE rloc OF shr_reg: SIGNAL IS "X0Y0 X0Y1 X0Y2 X0Y3 X0Y4 X0Y5 X0Y6 X0Y7 X0Y8 X0Y9 X0Y10 X0Y11 X0Y12 X0Y13 X0Y14 X0Y15";


BEGIN

ip_reg : PROCESS(clk,rst) 
BEGIN
    IF rst = '1' THEN 
        ip_sync <= (OTHERS=>'0');
    ELSIF rising_edge(clk) THEN 
        ip_sync <= ip_sync(ip_sync'low) & ip; 
    END IF;
END PROCESS;

dl_reg : PROCESS(clk,rst) 
BEGIN
    IF rst = '1' THEN 
        shr_reg <= (OTHERS=>'0');
    ELSIF rising_edge(clk) THEN 
        shr_reg <= shr_reg(shr_reg'high-1 DOWNTO shr_reg'low)&ip_sync(ip_sync'high);
    END IF;
END PROCESS;



op <= shr_reg(shr_reg'high);

END ARCHITECTURE; 