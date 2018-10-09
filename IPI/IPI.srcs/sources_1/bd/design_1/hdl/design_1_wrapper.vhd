--Copyright 1986-2018 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2018.2 (win64) Build 2258646 Thu Jun 14 20:03:12 MDT 2018
--Date        : Sun Oct  7 09:13:37 2018
--Host        : DESKTOP-HQKVQ13 running 64-bit major release  (build 9200)
--Command     : generate_target design_1_wrapper.bd
--Design      : design_1_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
library UNISIM;
use UNISIM.VCOMPONENTS.ALL;
entity design_1_wrapper is
end design_1_wrapper;

architecture STRUCTURE of design_1_wrapper is
  component design_1 is
  end component design_1;
begin
design_1_i: component design_1
 ;
end STRUCTURE;
