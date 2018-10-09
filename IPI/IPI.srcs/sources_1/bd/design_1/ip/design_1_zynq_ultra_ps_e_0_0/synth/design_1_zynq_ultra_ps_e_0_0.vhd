-- (c) Copyright 1995-2018 Xilinx, Inc. All rights reserved.
-- 
-- This file contains confidential and proprietary information
-- of Xilinx, Inc. and is protected under U.S. and
-- international copyright and other intellectual property
-- laws.
-- 
-- DISCLAIMER
-- This disclaimer is not a license and does not grant any
-- rights to the materials distributed herewith. Except as
-- otherwise provided in a valid license issued to you by
-- Xilinx, and to the maximum extent permitted by applicable
-- law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
-- WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
-- AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
-- BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
-- INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
-- (2) Xilinx shall not be liable (whether in contract or tort,
-- including negligence, or under any other theory of
-- liability) for any loss or damage of any kind or nature
-- related to, arising under or in connection with these
-- materials, including for any direct, or any indirect,
-- special, incidental, or consequential loss or damage
-- (including loss of data, profits, goodwill, or any type of
-- loss or damage suffered as a result of any action brought
-- by a third party) even if such damage or loss was
-- reasonably foreseeable or Xilinx had been advised of the
-- possibility of the same.
-- 
-- CRITICAL APPLICATIONS
-- Xilinx products are not designed or intended to be fail-
-- safe, or for use in any application requiring fail-safe
-- performance, such as life-support or safety devices or
-- systems, Class III medical devices, nuclear facilities,
-- applications related to the deployment of airbags, or any
-- other applications that could lead to death, personal
-- injury, or severe property or environmental damage
-- (individually and collectively, "Critical
-- Applications"). Customer assumes the sole risk and
-- liability of any use of Xilinx products in Critical
-- Applications, subject only to applicable laws and
-- regulations governing limitations on product liability.
-- 
-- THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
-- PART OF THIS FILE AT ALL TIMES.
-- 
-- DO NOT MODIFY THIS FILE.

-- IP VLNV: xilinx.com:ip:zynq_ultra_ps_e:3.2
-- IP Revision: 1

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY design_1_zynq_ultra_ps_e_0_0 IS
  PORT (
    maxihpm0_fpd_aclk : IN STD_LOGIC;
    maxigp0_awid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_awaddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
    maxigp0_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    maxigp0_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp0_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp0_awlock : OUT STD_LOGIC;
    maxigp0_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxigp0_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp0_awvalid : OUT STD_LOGIC;
    maxigp0_awuser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_awready : IN STD_LOGIC;
    maxigp0_wdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    maxigp0_wstrb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_wlast : OUT STD_LOGIC;
    maxigp0_wvalid : OUT STD_LOGIC;
    maxigp0_wready : IN STD_LOGIC;
    maxigp0_bid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp0_bvalid : IN STD_LOGIC;
    maxigp0_bready : OUT STD_LOGIC;
    maxigp0_arid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_araddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
    maxigp0_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    maxigp0_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp0_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp0_arlock : OUT STD_LOGIC;
    maxigp0_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxigp0_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp0_arvalid : OUT STD_LOGIC;
    maxigp0_aruser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_arready : IN STD_LOGIC;
    maxigp0_rid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp0_rdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    maxigp0_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp0_rlast : IN STD_LOGIC;
    maxigp0_rvalid : IN STD_LOGIC;
    maxigp0_rready : OUT STD_LOGIC;
    maxigp0_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxigp0_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxihpm1_fpd_aclk : IN STD_LOGIC;
    maxigp1_awid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_awaddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
    maxigp1_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    maxigp1_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp1_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp1_awlock : OUT STD_LOGIC;
    maxigp1_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxigp1_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp1_awvalid : OUT STD_LOGIC;
    maxigp1_awuser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_awready : IN STD_LOGIC;
    maxigp1_wdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    maxigp1_wstrb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_wlast : OUT STD_LOGIC;
    maxigp1_wvalid : OUT STD_LOGIC;
    maxigp1_wready : IN STD_LOGIC;
    maxigp1_bid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp1_bvalid : IN STD_LOGIC;
    maxigp1_bready : OUT STD_LOGIC;
    maxigp1_arid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_araddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
    maxigp1_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
    maxigp1_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp1_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp1_arlock : OUT STD_LOGIC;
    maxigp1_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxigp1_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
    maxigp1_arvalid : OUT STD_LOGIC;
    maxigp1_aruser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_arready : IN STD_LOGIC;
    maxigp1_rid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    maxigp1_rdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    maxigp1_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    maxigp1_rlast : IN STD_LOGIC;
    maxigp1_rvalid : IN STD_LOGIC;
    maxigp1_rready : OUT STD_LOGIC;
    maxigp1_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    maxigp1_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
    pl_ps_irq0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
    pl_resetn0 : OUT STD_LOGIC;
    pl_clk0 : OUT STD_LOGIC
  );
END design_1_zynq_ultra_ps_e_0_0;

ARCHITECTURE design_1_zynq_ultra_ps_e_0_0_arch OF design_1_zynq_ultra_ps_e_0_0 IS
  ATTRIBUTE DowngradeIPIdentifiedWarnings : STRING;
  ATTRIBUTE DowngradeIPIdentifiedWarnings OF design_1_zynq_ultra_ps_e_0_0_arch: ARCHITECTURE IS "yes";
  COMPONENT zynq_ultra_ps_e_v3_2_1_zynq_ultra_ps_e IS
    GENERIC (
      C_DP_USE_AUDIO : INTEGER;
      C_DP_USE_VIDEO : INTEGER;
      C_MAXIGP0_DATA_WIDTH : INTEGER;
      C_MAXIGP1_DATA_WIDTH : INTEGER;
      C_MAXIGP2_DATA_WIDTH : INTEGER;
      C_SAXIGP0_DATA_WIDTH : INTEGER;
      C_SAXIGP1_DATA_WIDTH : INTEGER;
      C_SAXIGP2_DATA_WIDTH : INTEGER;
      C_SAXIGP3_DATA_WIDTH : INTEGER;
      C_SAXIGP4_DATA_WIDTH : INTEGER;
      C_SAXIGP5_DATA_WIDTH : INTEGER;
      C_SAXIGP6_DATA_WIDTH : INTEGER;
      C_USE_DIFF_RW_CLK_GP0 : INTEGER;
      C_USE_DIFF_RW_CLK_GP1 : INTEGER;
      C_USE_DIFF_RW_CLK_GP2 : INTEGER;
      C_USE_DIFF_RW_CLK_GP3 : INTEGER;
      C_USE_DIFF_RW_CLK_GP4 : INTEGER;
      C_USE_DIFF_RW_CLK_GP5 : INTEGER;
      C_USE_DIFF_RW_CLK_GP6 : INTEGER;
      C_EN_FIFO_ENET0 : STRING;
      C_EN_FIFO_ENET1 : STRING;
      C_EN_FIFO_ENET2 : STRING;
      C_EN_FIFO_ENET3 : STRING;
      C_PL_CLK0_BUF : STRING;
      C_PL_CLK1_BUF : STRING;
      C_PL_CLK2_BUF : STRING;
      C_PL_CLK3_BUF : STRING;
      C_TRACE_PIPELINE_WIDTH : INTEGER;
      C_EN_EMIO_TRACE : INTEGER;
      C_TRACE_DATA_WIDTH : INTEGER;
      C_USE_DEBUG_TEST : INTEGER;
      C_SD0_INTERNAL_BUS_WIDTH : INTEGER;
      C_SD1_INTERNAL_BUS_WIDTH : INTEGER;
      C_NUM_F2P_0_INTR_INPUTS : INTEGER;
      C_NUM_F2P_1_INTR_INPUTS : INTEGER;
      C_EMIO_GPIO_WIDTH : INTEGER;
      C_NUM_FABRIC_RESETS : INTEGER
    );
    PORT (
      maxihpm0_fpd_aclk : IN STD_LOGIC;
      maxigp0_awid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_awaddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
      maxigp0_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      maxigp0_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp0_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp0_awlock : OUT STD_LOGIC;
      maxigp0_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp0_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp0_awvalid : OUT STD_LOGIC;
      maxigp0_awuser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_awready : IN STD_LOGIC;
      maxigp0_wdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      maxigp0_wstrb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_wlast : OUT STD_LOGIC;
      maxigp0_wvalid : OUT STD_LOGIC;
      maxigp0_wready : IN STD_LOGIC;
      maxigp0_bid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp0_bvalid : IN STD_LOGIC;
      maxigp0_bready : OUT STD_LOGIC;
      maxigp0_arid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_araddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
      maxigp0_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      maxigp0_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp0_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp0_arlock : OUT STD_LOGIC;
      maxigp0_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp0_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp0_arvalid : OUT STD_LOGIC;
      maxigp0_aruser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_arready : IN STD_LOGIC;
      maxigp0_rid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp0_rdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      maxigp0_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp0_rlast : IN STD_LOGIC;
      maxigp0_rvalid : IN STD_LOGIC;
      maxigp0_rready : OUT STD_LOGIC;
      maxigp0_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp0_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxihpm1_fpd_aclk : IN STD_LOGIC;
      maxigp1_awid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_awaddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
      maxigp1_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      maxigp1_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp1_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp1_awlock : OUT STD_LOGIC;
      maxigp1_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp1_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp1_awvalid : OUT STD_LOGIC;
      maxigp1_awuser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_awready : IN STD_LOGIC;
      maxigp1_wdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      maxigp1_wstrb : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_wlast : OUT STD_LOGIC;
      maxigp1_wvalid : OUT STD_LOGIC;
      maxigp1_wready : IN STD_LOGIC;
      maxigp1_bid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp1_bvalid : IN STD_LOGIC;
      maxigp1_bready : OUT STD_LOGIC;
      maxigp1_arid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_araddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
      maxigp1_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      maxigp1_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp1_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp1_arlock : OUT STD_LOGIC;
      maxigp1_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp1_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp1_arvalid : OUT STD_LOGIC;
      maxigp1_aruser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_arready : IN STD_LOGIC;
      maxigp1_rid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp1_rdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      maxigp1_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp1_rlast : IN STD_LOGIC;
      maxigp1_rvalid : IN STD_LOGIC;
      maxigp1_rready : OUT STD_LOGIC;
      maxigp1_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp1_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxihpm0_lpd_aclk : IN STD_LOGIC;
      maxigp2_awid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp2_awaddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
      maxigp2_awlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      maxigp2_awsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp2_awburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp2_awlock : OUT STD_LOGIC;
      maxigp2_awcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp2_awprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp2_awvalid : OUT STD_LOGIC;
      maxigp2_awuser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp2_awready : IN STD_LOGIC;
      maxigp2_wdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      maxigp2_wstrb : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp2_wlast : OUT STD_LOGIC;
      maxigp2_wvalid : OUT STD_LOGIC;
      maxigp2_wready : IN STD_LOGIC;
      maxigp2_bid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp2_bresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp2_bvalid : IN STD_LOGIC;
      maxigp2_bready : OUT STD_LOGIC;
      maxigp2_arid : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp2_araddr : OUT STD_LOGIC_VECTOR(39 DOWNTO 0);
      maxigp2_arlen : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      maxigp2_arsize : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp2_arburst : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp2_arlock : OUT STD_LOGIC;
      maxigp2_arcache : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp2_arprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      maxigp2_arvalid : OUT STD_LOGIC;
      maxigp2_aruser : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp2_arready : IN STD_LOGIC;
      maxigp2_rid : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      maxigp2_rdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      maxigp2_rresp : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      maxigp2_rlast : IN STD_LOGIC;
      maxigp2_rvalid : IN STD_LOGIC;
      maxigp2_rready : OUT STD_LOGIC;
      maxigp2_awqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      maxigp2_arqos : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxihpc0_fpd_rclk : IN STD_LOGIC;
      saxihpc0_fpd_wclk : IN STD_LOGIC;
      saxihpc0_fpd_aclk : IN STD_LOGIC;
      saxigp0_aruser : IN STD_LOGIC;
      saxigp0_awuser : IN STD_LOGIC;
      saxigp0_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp0_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp0_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp0_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp0_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp0_awlock : IN STD_LOGIC;
      saxigp0_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp0_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp0_awvalid : IN STD_LOGIC;
      saxigp0_awready : OUT STD_LOGIC;
      saxigp0_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp0_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp0_wlast : IN STD_LOGIC;
      saxigp0_wvalid : IN STD_LOGIC;
      saxigp0_wready : OUT STD_LOGIC;
      saxigp0_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp0_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ddrc_ext_refresh_rank0_req : IN STD_LOGIC;
      ddrc_ext_refresh_rank1_req : IN STD_LOGIC;
      ddrc_refresh_pl_clk : IN STD_LOGIC;
      saxigp0_bvalid : OUT STD_LOGIC;
      saxigp0_bready : IN STD_LOGIC;
      saxigp0_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp0_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp0_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp0_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp0_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp0_arlock : IN STD_LOGIC;
      saxigp0_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp0_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp0_arvalid : IN STD_LOGIC;
      saxigp0_arready : OUT STD_LOGIC;
      saxigp0_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp0_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp0_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp0_rlast : OUT STD_LOGIC;
      saxigp0_rvalid : OUT STD_LOGIC;
      saxigp0_rready : IN STD_LOGIC;
      saxigp0_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp0_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp0_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp0_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp0_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp0_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxihpc1_fpd_rclk : IN STD_LOGIC;
      saxihpc1_fpd_wclk : IN STD_LOGIC;
      saxihpc1_fpd_aclk : IN STD_LOGIC;
      saxigp1_aruser : IN STD_LOGIC;
      saxigp1_awuser : IN STD_LOGIC;
      saxigp1_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp1_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp1_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp1_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp1_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp1_awlock : IN STD_LOGIC;
      saxigp1_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp1_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp1_awvalid : IN STD_LOGIC;
      saxigp1_awready : OUT STD_LOGIC;
      saxigp1_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp1_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp1_wlast : IN STD_LOGIC;
      saxigp1_wvalid : IN STD_LOGIC;
      saxigp1_wready : OUT STD_LOGIC;
      saxigp1_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp1_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp1_bvalid : OUT STD_LOGIC;
      saxigp1_bready : IN STD_LOGIC;
      saxigp1_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp1_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp1_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp1_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp1_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp1_arlock : IN STD_LOGIC;
      saxigp1_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp1_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp1_arvalid : IN STD_LOGIC;
      saxigp1_arready : OUT STD_LOGIC;
      saxigp1_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp1_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp1_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp1_rlast : OUT STD_LOGIC;
      saxigp1_rvalid : OUT STD_LOGIC;
      saxigp1_rready : IN STD_LOGIC;
      saxigp1_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp1_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp1_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp1_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp1_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp1_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxihp0_fpd_rclk : IN STD_LOGIC;
      saxihp0_fpd_wclk : IN STD_LOGIC;
      saxihp0_fpd_aclk : IN STD_LOGIC;
      saxigp2_aruser : IN STD_LOGIC;
      saxigp2_awuser : IN STD_LOGIC;
      saxigp2_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp2_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp2_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp2_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp2_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp2_awlock : IN STD_LOGIC;
      saxigp2_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp2_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp2_awvalid : IN STD_LOGIC;
      saxigp2_awready : OUT STD_LOGIC;
      saxigp2_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp2_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp2_wlast : IN STD_LOGIC;
      saxigp2_wvalid : IN STD_LOGIC;
      saxigp2_wready : OUT STD_LOGIC;
      saxigp2_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp2_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp2_bvalid : OUT STD_LOGIC;
      saxigp2_bready : IN STD_LOGIC;
      saxigp2_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp2_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp2_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp2_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp2_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp2_arlock : IN STD_LOGIC;
      saxigp2_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp2_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp2_arvalid : IN STD_LOGIC;
      saxigp2_arready : OUT STD_LOGIC;
      saxigp2_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp2_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp2_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp2_rlast : OUT STD_LOGIC;
      saxigp2_rvalid : OUT STD_LOGIC;
      saxigp2_rready : IN STD_LOGIC;
      saxigp2_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp2_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp2_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp2_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp2_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp2_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxihp1_fpd_rclk : IN STD_LOGIC;
      saxihp1_fpd_wclk : IN STD_LOGIC;
      saxihp1_fpd_aclk : IN STD_LOGIC;
      saxigp3_aruser : IN STD_LOGIC;
      saxigp3_awuser : IN STD_LOGIC;
      saxigp3_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp3_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp3_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp3_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp3_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp3_awlock : IN STD_LOGIC;
      saxigp3_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp3_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp3_awvalid : IN STD_LOGIC;
      saxigp3_awready : OUT STD_LOGIC;
      saxigp3_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp3_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp3_wlast : IN STD_LOGIC;
      saxigp3_wvalid : IN STD_LOGIC;
      saxigp3_wready : OUT STD_LOGIC;
      saxigp3_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp3_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp3_bvalid : OUT STD_LOGIC;
      saxigp3_bready : IN STD_LOGIC;
      saxigp3_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp3_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp3_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp3_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp3_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp3_arlock : IN STD_LOGIC;
      saxigp3_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp3_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp3_arvalid : IN STD_LOGIC;
      saxigp3_arready : OUT STD_LOGIC;
      saxigp3_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp3_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp3_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp3_rlast : OUT STD_LOGIC;
      saxigp3_rvalid : OUT STD_LOGIC;
      saxigp3_rready : IN STD_LOGIC;
      saxigp3_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp3_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp3_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp3_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp3_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp3_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxihp2_fpd_rclk : IN STD_LOGIC;
      saxihp2_fpd_wclk : IN STD_LOGIC;
      saxihp2_fpd_aclk : IN STD_LOGIC;
      saxigp4_aruser : IN STD_LOGIC;
      saxigp4_awuser : IN STD_LOGIC;
      saxigp4_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp4_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp4_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp4_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp4_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp4_awlock : IN STD_LOGIC;
      saxigp4_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp4_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp4_awvalid : IN STD_LOGIC;
      saxigp4_awready : OUT STD_LOGIC;
      saxigp4_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp4_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp4_wlast : IN STD_LOGIC;
      saxigp4_wvalid : IN STD_LOGIC;
      saxigp4_wready : OUT STD_LOGIC;
      saxigp4_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp4_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp4_bvalid : OUT STD_LOGIC;
      saxigp4_bready : IN STD_LOGIC;
      saxigp4_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp4_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp4_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp4_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp4_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp4_arlock : IN STD_LOGIC;
      saxigp4_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp4_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp4_arvalid : IN STD_LOGIC;
      saxigp4_arready : OUT STD_LOGIC;
      saxigp4_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp4_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp4_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp4_rlast : OUT STD_LOGIC;
      saxigp4_rvalid : OUT STD_LOGIC;
      saxigp4_rready : IN STD_LOGIC;
      saxigp4_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp4_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp4_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp4_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp4_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp4_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxihp3_fpd_rclk : IN STD_LOGIC;
      saxihp3_fpd_wclk : IN STD_LOGIC;
      saxihp3_fpd_aclk : IN STD_LOGIC;
      saxigp5_aruser : IN STD_LOGIC;
      saxigp5_awuser : IN STD_LOGIC;
      saxigp5_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp5_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp5_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp5_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp5_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp5_awlock : IN STD_LOGIC;
      saxigp5_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp5_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp5_awvalid : IN STD_LOGIC;
      saxigp5_awready : OUT STD_LOGIC;
      saxigp5_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp5_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp5_wlast : IN STD_LOGIC;
      saxigp5_wvalid : IN STD_LOGIC;
      saxigp5_wready : OUT STD_LOGIC;
      saxigp5_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp5_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp5_bvalid : OUT STD_LOGIC;
      saxigp5_bready : IN STD_LOGIC;
      saxigp5_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp5_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp5_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp5_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp5_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp5_arlock : IN STD_LOGIC;
      saxigp5_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp5_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp5_arvalid : IN STD_LOGIC;
      saxigp5_arready : OUT STD_LOGIC;
      saxigp5_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp5_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp5_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp5_rlast : OUT STD_LOGIC;
      saxigp5_rvalid : OUT STD_LOGIC;
      saxigp5_rready : IN STD_LOGIC;
      saxigp5_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp5_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp5_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp5_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp5_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp5_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxi_lpd_rclk : IN STD_LOGIC;
      saxi_lpd_wclk : IN STD_LOGIC;
      saxi_lpd_aclk : IN STD_LOGIC;
      saxigp6_aruser : IN STD_LOGIC;
      saxigp6_awuser : IN STD_LOGIC;
      saxigp6_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp6_awaddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp6_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp6_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp6_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp6_awlock : IN STD_LOGIC;
      saxigp6_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp6_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp6_awvalid : IN STD_LOGIC;
      saxigp6_awready : OUT STD_LOGIC;
      saxigp6_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp6_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxigp6_wlast : IN STD_LOGIC;
      saxigp6_wvalid : IN STD_LOGIC;
      saxigp6_wready : OUT STD_LOGIC;
      saxigp6_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp6_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp6_bvalid : OUT STD_LOGIC;
      saxigp6_bready : IN STD_LOGIC;
      saxigp6_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp6_araddr : IN STD_LOGIC_VECTOR(48 DOWNTO 0);
      saxigp6_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp6_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp6_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp6_arlock : IN STD_LOGIC;
      saxigp6_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp6_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxigp6_arvalid : IN STD_LOGIC;
      saxigp6_arready : OUT STD_LOGIC;
      saxigp6_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      saxigp6_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxigp6_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxigp6_rlast : OUT STD_LOGIC;
      saxigp6_rvalid : OUT STD_LOGIC;
      saxigp6_rready : IN STD_LOGIC;
      saxigp6_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp6_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp6_rcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp6_wcount : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxigp6_racount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxigp6_wacount : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxiacp_fpd_aclk : IN STD_LOGIC;
      saxiacp_awuser : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxiacp_aruser : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxiacp_awid : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      saxiacp_awaddr : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
      saxiacp_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxiacp_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxiacp_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxiacp_awlock : IN STD_LOGIC;
      saxiacp_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxiacp_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxiacp_awvalid : IN STD_LOGIC;
      saxiacp_awready : OUT STD_LOGIC;
      saxiacp_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxiacp_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      saxiacp_wlast : IN STD_LOGIC;
      saxiacp_wvalid : IN STD_LOGIC;
      saxiacp_wready : OUT STD_LOGIC;
      saxiacp_bid : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      saxiacp_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxiacp_bvalid : OUT STD_LOGIC;
      saxiacp_bready : IN STD_LOGIC;
      saxiacp_arid : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      saxiacp_araddr : IN STD_LOGIC_VECTOR(39 DOWNTO 0);
      saxiacp_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      saxiacp_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxiacp_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxiacp_arlock : IN STD_LOGIC;
      saxiacp_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxiacp_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      saxiacp_arvalid : IN STD_LOGIC;
      saxiacp_arready : OUT STD_LOGIC;
      saxiacp_rid : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      saxiacp_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      saxiacp_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      saxiacp_rlast : OUT STD_LOGIC;
      saxiacp_rvalid : OUT STD_LOGIC;
      saxiacp_rready : IN STD_LOGIC;
      saxiacp_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      saxiacp_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_aclk : IN STD_LOGIC;
      sacefpd_wuser : IN STD_LOGIC;
      sacefpd_buser : OUT STD_LOGIC;
      sacefpd_ruser : OUT STD_LOGIC;
      sacefpd_awuser : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      sacefpd_awsnoop : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      sacefpd_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      sacefpd_awregion : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_awqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      sacefpd_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sacefpd_awid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      sacefpd_awdomain : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_awbar : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_awaddr : IN STD_LOGIC_VECTOR(43 DOWNTO 0);
      sacefpd_awlock : IN STD_LOGIC;
      sacefpd_awvalid : IN STD_LOGIC;
      sacefpd_awready : OUT STD_LOGIC;
      sacefpd_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      sacefpd_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      sacefpd_wlast : IN STD_LOGIC;
      sacefpd_wvalid : IN STD_LOGIC;
      sacefpd_wready : OUT STD_LOGIC;
      sacefpd_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_bid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      sacefpd_bvalid : OUT STD_LOGIC;
      sacefpd_bready : IN STD_LOGIC;
      sacefpd_aruser : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      sacefpd_arsnoop : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      sacefpd_arregion : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_arqos : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      sacefpd_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      sacefpd_arid : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      sacefpd_ardomain : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_arbar : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      sacefpd_araddr : IN STD_LOGIC_VECTOR(43 DOWNTO 0);
      sacefpd_arlock : IN STD_LOGIC;
      sacefpd_arvalid : IN STD_LOGIC;
      sacefpd_arready : OUT STD_LOGIC;
      sacefpd_rresp : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_rid : OUT STD_LOGIC_VECTOR(5 DOWNTO 0);
      sacefpd_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
      sacefpd_rlast : OUT STD_LOGIC;
      sacefpd_rvalid : OUT STD_LOGIC;
      sacefpd_rready : IN STD_LOGIC;
      sacefpd_acsnoop : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      sacefpd_acprot : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      sacefpd_acaddr : OUT STD_LOGIC_VECTOR(43 DOWNTO 0);
      sacefpd_acvalid : OUT STD_LOGIC;
      sacefpd_acready : IN STD_LOGIC;
      sacefpd_cddata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
      sacefpd_cdlast : IN STD_LOGIC;
      sacefpd_cdvalid : IN STD_LOGIC;
      sacefpd_cdready : OUT STD_LOGIC;
      sacefpd_crresp : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      sacefpd_crvalid : IN STD_LOGIC;
      sacefpd_crready : OUT STD_LOGIC;
      sacefpd_wack : IN STD_LOGIC;
      sacefpd_rack : IN STD_LOGIC;
      emio_can0_phy_tx : OUT STD_LOGIC;
      emio_can0_phy_rx : IN STD_LOGIC;
      emio_can1_phy_tx : OUT STD_LOGIC;
      emio_can1_phy_rx : IN STD_LOGIC;
      emio_enet0_gmii_rx_clk : IN STD_LOGIC;
      emio_enet0_speed_mode : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_enet0_gmii_crs : IN STD_LOGIC;
      emio_enet0_gmii_col : IN STD_LOGIC;
      emio_enet0_gmii_rxd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet0_gmii_rx_er : IN STD_LOGIC;
      emio_enet0_gmii_rx_dv : IN STD_LOGIC;
      emio_enet0_gmii_tx_clk : IN STD_LOGIC;
      emio_enet0_gmii_txd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet0_gmii_tx_en : OUT STD_LOGIC;
      emio_enet0_gmii_tx_er : OUT STD_LOGIC;
      emio_enet0_mdio_mdc : OUT STD_LOGIC;
      emio_enet0_mdio_i : IN STD_LOGIC;
      emio_enet0_mdio_o : OUT STD_LOGIC;
      emio_enet0_mdio_t : OUT STD_LOGIC;
      emio_enet1_gmii_rx_clk : IN STD_LOGIC;
      emio_enet1_speed_mode : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_enet1_gmii_crs : IN STD_LOGIC;
      emio_enet1_gmii_col : IN STD_LOGIC;
      emio_enet1_gmii_rxd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet1_gmii_rx_er : IN STD_LOGIC;
      emio_enet1_gmii_rx_dv : IN STD_LOGIC;
      emio_enet1_gmii_tx_clk : IN STD_LOGIC;
      emio_enet1_gmii_txd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet1_gmii_tx_en : OUT STD_LOGIC;
      emio_enet1_gmii_tx_er : OUT STD_LOGIC;
      emio_enet1_mdio_mdc : OUT STD_LOGIC;
      emio_enet1_mdio_i : IN STD_LOGIC;
      emio_enet1_mdio_o : OUT STD_LOGIC;
      emio_enet1_mdio_t : OUT STD_LOGIC;
      emio_enet2_gmii_rx_clk : IN STD_LOGIC;
      emio_enet2_speed_mode : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_enet2_gmii_crs : IN STD_LOGIC;
      emio_enet2_gmii_col : IN STD_LOGIC;
      emio_enet2_gmii_rxd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet2_gmii_rx_er : IN STD_LOGIC;
      emio_enet2_gmii_rx_dv : IN STD_LOGIC;
      emio_enet2_gmii_tx_clk : IN STD_LOGIC;
      emio_enet2_gmii_txd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet2_gmii_tx_en : OUT STD_LOGIC;
      emio_enet2_gmii_tx_er : OUT STD_LOGIC;
      emio_enet2_mdio_mdc : OUT STD_LOGIC;
      emio_enet2_mdio_i : IN STD_LOGIC;
      emio_enet2_mdio_o : OUT STD_LOGIC;
      emio_enet2_mdio_t : OUT STD_LOGIC;
      emio_enet3_gmii_rx_clk : IN STD_LOGIC;
      emio_enet3_speed_mode : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_enet3_gmii_crs : IN STD_LOGIC;
      emio_enet3_gmii_col : IN STD_LOGIC;
      emio_enet3_gmii_rxd : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet3_gmii_rx_er : IN STD_LOGIC;
      emio_enet3_gmii_rx_dv : IN STD_LOGIC;
      emio_enet3_gmii_tx_clk : IN STD_LOGIC;
      emio_enet3_gmii_txd : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet3_gmii_tx_en : OUT STD_LOGIC;
      emio_enet3_gmii_tx_er : OUT STD_LOGIC;
      emio_enet3_mdio_mdc : OUT STD_LOGIC;
      emio_enet3_mdio_i : IN STD_LOGIC;
      emio_enet3_mdio_o : OUT STD_LOGIC;
      emio_enet3_mdio_t : OUT STD_LOGIC;
      emio_enet0_tx_r_data_rdy : IN STD_LOGIC;
      emio_enet0_tx_r_rd : OUT STD_LOGIC;
      emio_enet0_tx_r_valid : IN STD_LOGIC;
      emio_enet0_tx_r_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet0_tx_r_sop : IN STD_LOGIC;
      emio_enet0_tx_r_eop : IN STD_LOGIC;
      emio_enet0_tx_r_err : IN STD_LOGIC;
      emio_enet0_tx_r_underflow : IN STD_LOGIC;
      emio_enet0_tx_r_flushed : IN STD_LOGIC;
      emio_enet0_tx_r_control : IN STD_LOGIC;
      emio_enet0_dma_tx_end_tog : OUT STD_LOGIC;
      emio_enet0_dma_tx_status_tog : IN STD_LOGIC;
      emio_enet0_tx_r_status : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_enet0_rx_w_wr : OUT STD_LOGIC;
      emio_enet0_rx_w_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet0_rx_w_sop : OUT STD_LOGIC;
      emio_enet0_rx_w_eop : OUT STD_LOGIC;
      emio_enet0_rx_w_status : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
      emio_enet0_rx_w_err : OUT STD_LOGIC;
      emio_enet0_rx_w_overflow : IN STD_LOGIC;
      emio_enet0_rx_w_flush : OUT STD_LOGIC;
      emio_enet0_tx_r_fixed_lat : OUT STD_LOGIC;
      fmio_gem0_fifo_tx_clk_to_pl_bufg : OUT STD_LOGIC;
      fmio_gem0_fifo_rx_clk_to_pl_bufg : OUT STD_LOGIC;
      emio_enet1_tx_r_data_rdy : IN STD_LOGIC;
      emio_enet1_tx_r_rd : OUT STD_LOGIC;
      emio_enet1_tx_r_valid : IN STD_LOGIC;
      emio_enet1_tx_r_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet1_tx_r_sop : IN STD_LOGIC;
      emio_enet1_tx_r_eop : IN STD_LOGIC;
      emio_enet1_tx_r_err : IN STD_LOGIC;
      emio_enet1_tx_r_underflow : IN STD_LOGIC;
      emio_enet1_tx_r_flushed : IN STD_LOGIC;
      emio_enet1_tx_r_control : IN STD_LOGIC;
      emio_enet1_dma_tx_end_tog : OUT STD_LOGIC;
      emio_enet1_dma_tx_status_tog : IN STD_LOGIC;
      emio_enet1_tx_r_status : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_enet1_rx_w_wr : OUT STD_LOGIC;
      emio_enet1_rx_w_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet1_rx_w_sop : OUT STD_LOGIC;
      emio_enet1_rx_w_eop : OUT STD_LOGIC;
      emio_enet1_rx_w_status : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
      emio_enet1_rx_w_err : OUT STD_LOGIC;
      emio_enet1_rx_w_overflow : IN STD_LOGIC;
      emio_enet1_rx_w_flush : OUT STD_LOGIC;
      emio_enet1_tx_r_fixed_lat : OUT STD_LOGIC;
      fmio_gem1_fifo_tx_clk_to_pl_bufg : OUT STD_LOGIC;
      fmio_gem1_fifo_rx_clk_to_pl_bufg : OUT STD_LOGIC;
      emio_enet2_tx_r_data_rdy : IN STD_LOGIC;
      emio_enet2_tx_r_rd : OUT STD_LOGIC;
      emio_enet2_tx_r_valid : IN STD_LOGIC;
      emio_enet2_tx_r_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet2_tx_r_sop : IN STD_LOGIC;
      emio_enet2_tx_r_eop : IN STD_LOGIC;
      emio_enet2_tx_r_err : IN STD_LOGIC;
      emio_enet2_tx_r_underflow : IN STD_LOGIC;
      emio_enet2_tx_r_flushed : IN STD_LOGIC;
      emio_enet2_tx_r_control : IN STD_LOGIC;
      emio_enet2_dma_tx_end_tog : OUT STD_LOGIC;
      emio_enet2_dma_tx_status_tog : IN STD_LOGIC;
      emio_enet2_tx_r_status : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_enet2_rx_w_wr : OUT STD_LOGIC;
      emio_enet2_rx_w_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet2_rx_w_sop : OUT STD_LOGIC;
      emio_enet2_rx_w_eop : OUT STD_LOGIC;
      emio_enet2_rx_w_status : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
      emio_enet2_rx_w_err : OUT STD_LOGIC;
      emio_enet2_rx_w_overflow : IN STD_LOGIC;
      emio_enet2_rx_w_flush : OUT STD_LOGIC;
      emio_enet2_tx_r_fixed_lat : OUT STD_LOGIC;
      fmio_gem2_fifo_tx_clk_to_pl_bufg : OUT STD_LOGIC;
      fmio_gem2_fifo_rx_clk_to_pl_bufg : OUT STD_LOGIC;
      emio_enet3_tx_r_data_rdy : IN STD_LOGIC;
      emio_enet3_tx_r_rd : OUT STD_LOGIC;
      emio_enet3_tx_r_valid : IN STD_LOGIC;
      emio_enet3_tx_r_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet3_tx_r_sop : IN STD_LOGIC;
      emio_enet3_tx_r_eop : IN STD_LOGIC;
      emio_enet3_tx_r_err : IN STD_LOGIC;
      emio_enet3_tx_r_underflow : IN STD_LOGIC;
      emio_enet3_tx_r_flushed : IN STD_LOGIC;
      emio_enet3_tx_r_control : IN STD_LOGIC;
      emio_enet3_dma_tx_end_tog : OUT STD_LOGIC;
      emio_enet3_dma_tx_status_tog : IN STD_LOGIC;
      emio_enet3_tx_r_status : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_enet3_rx_w_wr : OUT STD_LOGIC;
      emio_enet3_rx_w_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      emio_enet3_rx_w_sop : OUT STD_LOGIC;
      emio_enet3_rx_w_eop : OUT STD_LOGIC;
      emio_enet3_rx_w_status : OUT STD_LOGIC_VECTOR(44 DOWNTO 0);
      emio_enet3_rx_w_err : OUT STD_LOGIC;
      emio_enet3_rx_w_overflow : IN STD_LOGIC;
      emio_enet3_rx_w_flush : OUT STD_LOGIC;
      emio_enet3_tx_r_fixed_lat : OUT STD_LOGIC;
      fmio_gem3_fifo_tx_clk_to_pl_bufg : OUT STD_LOGIC;
      fmio_gem3_fifo_rx_clk_to_pl_bufg : OUT STD_LOGIC;
      emio_enet0_tx_sof : OUT STD_LOGIC;
      emio_enet0_sync_frame_tx : OUT STD_LOGIC;
      emio_enet0_delay_req_tx : OUT STD_LOGIC;
      emio_enet0_pdelay_req_tx : OUT STD_LOGIC;
      emio_enet0_pdelay_resp_tx : OUT STD_LOGIC;
      emio_enet0_rx_sof : OUT STD_LOGIC;
      emio_enet0_sync_frame_rx : OUT STD_LOGIC;
      emio_enet0_delay_req_rx : OUT STD_LOGIC;
      emio_enet0_pdelay_req_rx : OUT STD_LOGIC;
      emio_enet0_pdelay_resp_rx : OUT STD_LOGIC;
      emio_enet0_tsu_inc_ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet0_tsu_timer_cmp_val : OUT STD_LOGIC;
      emio_enet1_tx_sof : OUT STD_LOGIC;
      emio_enet1_sync_frame_tx : OUT STD_LOGIC;
      emio_enet1_delay_req_tx : OUT STD_LOGIC;
      emio_enet1_pdelay_req_tx : OUT STD_LOGIC;
      emio_enet1_pdelay_resp_tx : OUT STD_LOGIC;
      emio_enet1_rx_sof : OUT STD_LOGIC;
      emio_enet1_sync_frame_rx : OUT STD_LOGIC;
      emio_enet1_delay_req_rx : OUT STD_LOGIC;
      emio_enet1_pdelay_req_rx : OUT STD_LOGIC;
      emio_enet1_pdelay_resp_rx : OUT STD_LOGIC;
      emio_enet1_tsu_inc_ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet1_tsu_timer_cmp_val : OUT STD_LOGIC;
      emio_enet2_tx_sof : OUT STD_LOGIC;
      emio_enet2_sync_frame_tx : OUT STD_LOGIC;
      emio_enet2_delay_req_tx : OUT STD_LOGIC;
      emio_enet2_pdelay_req_tx : OUT STD_LOGIC;
      emio_enet2_pdelay_resp_tx : OUT STD_LOGIC;
      emio_enet2_rx_sof : OUT STD_LOGIC;
      emio_enet2_sync_frame_rx : OUT STD_LOGIC;
      emio_enet2_delay_req_rx : OUT STD_LOGIC;
      emio_enet2_pdelay_req_rx : OUT STD_LOGIC;
      emio_enet2_pdelay_resp_rx : OUT STD_LOGIC;
      emio_enet2_tsu_inc_ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet2_tsu_timer_cmp_val : OUT STD_LOGIC;
      emio_enet3_tx_sof : OUT STD_LOGIC;
      emio_enet3_sync_frame_tx : OUT STD_LOGIC;
      emio_enet3_delay_req_tx : OUT STD_LOGIC;
      emio_enet3_pdelay_req_tx : OUT STD_LOGIC;
      emio_enet3_pdelay_resp_tx : OUT STD_LOGIC;
      emio_enet3_rx_sof : OUT STD_LOGIC;
      emio_enet3_sync_frame_rx : OUT STD_LOGIC;
      emio_enet3_delay_req_rx : OUT STD_LOGIC;
      emio_enet3_pdelay_req_rx : OUT STD_LOGIC;
      emio_enet3_pdelay_resp_rx : OUT STD_LOGIC;
      emio_enet3_tsu_inc_ctrl : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet3_tsu_timer_cmp_val : OUT STD_LOGIC;
      fmio_gem_tsu_clk_to_pl_bufg : OUT STD_LOGIC;
      fmio_gem_tsu_clk_from_pl : IN STD_LOGIC;
      emio_enet_tsu_clk : IN STD_LOGIC;
      emio_enet0_enet_tsu_timer_cnt : OUT STD_LOGIC_VECTOR(93 DOWNTO 0);
      emio_enet0_ext_int_in : IN STD_LOGIC;
      emio_enet1_ext_int_in : IN STD_LOGIC;
      emio_enet2_ext_int_in : IN STD_LOGIC;
      emio_enet3_ext_int_in : IN STD_LOGIC;
      emio_enet0_dma_bus_width : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet1_dma_bus_width : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet2_dma_bus_width : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_enet3_dma_bus_width : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      emio_gpio_i : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      emio_gpio_o : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      emio_gpio_t : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      emio_i2c0_scl_i : IN STD_LOGIC;
      emio_i2c0_scl_o : OUT STD_LOGIC;
      emio_i2c0_scl_t : OUT STD_LOGIC;
      emio_i2c0_sda_i : IN STD_LOGIC;
      emio_i2c0_sda_o : OUT STD_LOGIC;
      emio_i2c0_sda_t : OUT STD_LOGIC;
      emio_i2c1_scl_i : IN STD_LOGIC;
      emio_i2c1_scl_o : OUT STD_LOGIC;
      emio_i2c1_scl_t : OUT STD_LOGIC;
      emio_i2c1_sda_i : IN STD_LOGIC;
      emio_i2c1_sda_o : OUT STD_LOGIC;
      emio_i2c1_sda_t : OUT STD_LOGIC;
      emio_uart0_txd : OUT STD_LOGIC;
      emio_uart0_rxd : IN STD_LOGIC;
      emio_uart0_ctsn : IN STD_LOGIC;
      emio_uart0_rtsn : OUT STD_LOGIC;
      emio_uart0_dsrn : IN STD_LOGIC;
      emio_uart0_dcdn : IN STD_LOGIC;
      emio_uart0_rin : IN STD_LOGIC;
      emio_uart0_dtrn : OUT STD_LOGIC;
      emio_uart1_txd : OUT STD_LOGIC;
      emio_uart1_rxd : IN STD_LOGIC;
      emio_uart1_ctsn : IN STD_LOGIC;
      emio_uart1_rtsn : OUT STD_LOGIC;
      emio_uart1_dsrn : IN STD_LOGIC;
      emio_uart1_dcdn : IN STD_LOGIC;
      emio_uart1_rin : IN STD_LOGIC;
      emio_uart1_dtrn : OUT STD_LOGIC;
      emio_sdio0_clkout : OUT STD_LOGIC;
      emio_sdio0_fb_clk_in : IN STD_LOGIC;
      emio_sdio0_cmdout : OUT STD_LOGIC;
      emio_sdio0_cmdin : IN STD_LOGIC;
      emio_sdio0_cmdena : OUT STD_LOGIC;
      emio_sdio0_datain : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_sdio0_dataout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_sdio0_dataena : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_sdio0_cd_n : IN STD_LOGIC;
      emio_sdio0_wp : IN STD_LOGIC;
      emio_sdio0_ledcontrol : OUT STD_LOGIC;
      emio_sdio0_buspower : OUT STD_LOGIC;
      emio_sdio0_bus_volt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_sdio1_clkout : OUT STD_LOGIC;
      emio_sdio1_fb_clk_in : IN STD_LOGIC;
      emio_sdio1_cmdout : OUT STD_LOGIC;
      emio_sdio1_cmdin : IN STD_LOGIC;
      emio_sdio1_cmdena : OUT STD_LOGIC;
      emio_sdio1_datain : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_sdio1_dataout : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_sdio1_dataena : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      emio_sdio1_cd_n : IN STD_LOGIC;
      emio_sdio1_wp : IN STD_LOGIC;
      emio_sdio1_ledcontrol : OUT STD_LOGIC;
      emio_sdio1_buspower : OUT STD_LOGIC;
      emio_sdio1_bus_volt : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_spi0_sclk_i : IN STD_LOGIC;
      emio_spi0_sclk_o : OUT STD_LOGIC;
      emio_spi0_sclk_t : OUT STD_LOGIC;
      emio_spi0_m_i : IN STD_LOGIC;
      emio_spi0_m_o : OUT STD_LOGIC;
      emio_spi0_mo_t : OUT STD_LOGIC;
      emio_spi0_s_i : IN STD_LOGIC;
      emio_spi0_s_o : OUT STD_LOGIC;
      emio_spi0_so_t : OUT STD_LOGIC;
      emio_spi0_ss_i_n : IN STD_LOGIC;
      emio_spi0_ss_o_n : OUT STD_LOGIC;
      emio_spi0_ss1_o_n : OUT STD_LOGIC;
      emio_spi0_ss2_o_n : OUT STD_LOGIC;
      emio_spi0_ss_n_t : OUT STD_LOGIC;
      emio_spi1_sclk_i : IN STD_LOGIC;
      emio_spi1_sclk_o : OUT STD_LOGIC;
      emio_spi1_sclk_t : OUT STD_LOGIC;
      emio_spi1_m_i : IN STD_LOGIC;
      emio_spi1_m_o : OUT STD_LOGIC;
      emio_spi1_mo_t : OUT STD_LOGIC;
      emio_spi1_s_i : IN STD_LOGIC;
      emio_spi1_s_o : OUT STD_LOGIC;
      emio_spi1_so_t : OUT STD_LOGIC;
      emio_spi1_ss_i_n : IN STD_LOGIC;
      emio_spi1_ss_o_n : OUT STD_LOGIC;
      emio_spi1_ss1_o_n : OUT STD_LOGIC;
      emio_spi1_ss2_o_n : OUT STD_LOGIC;
      emio_spi1_ss_n_t : OUT STD_LOGIC;
      pl_ps_trace_clk : IN STD_LOGIC;
      ps_pl_tracectl : OUT STD_LOGIC;
      ps_pl_tracedata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      trace_clk_out : OUT STD_LOGIC;
      emio_ttc0_wave_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc0_clk_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc1_wave_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc1_clk_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc2_wave_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc2_clk_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc3_wave_o : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_ttc3_clk_i : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      emio_wdt0_clk_i : IN STD_LOGIC;
      emio_wdt0_rst_o : OUT STD_LOGIC;
      emio_wdt1_clk_i : IN STD_LOGIC;
      emio_wdt1_rst_o : OUT STD_LOGIC;
      emio_hub_port_overcrnt_usb3_0 : IN STD_LOGIC;
      emio_hub_port_overcrnt_usb3_1 : IN STD_LOGIC;
      emio_hub_port_overcrnt_usb2_0 : IN STD_LOGIC;
      emio_hub_port_overcrnt_usb2_1 : IN STD_LOGIC;
      emio_u2dsport_vbus_ctrl_usb3_0 : OUT STD_LOGIC;
      emio_u2dsport_vbus_ctrl_usb3_1 : OUT STD_LOGIC;
      emio_u3dsport_vbus_ctrl_usb3_0 : OUT STD_LOGIC;
      emio_u3dsport_vbus_ctrl_usb3_1 : OUT STD_LOGIC;
      adma_fci_clk : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      pl2adma_cvld : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      pl2adma_tack : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      adma2pl_cack : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      adma2pl_tvld : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      perif_gdma_clk : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      perif_gdma_cvld : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      perif_gdma_tack : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      gdma_perif_cack : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      gdma_perif_tvld : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      pl_clock_stop : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      pll_aux_refclk_lpd : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      pll_aux_refclk_fpd : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      dp_audio_ref_clk : OUT STD_LOGIC;
      dp_video_ref_clk : OUT STD_LOGIC;
      dp_s_axis_audio_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      dp_s_axis_audio_tid : IN STD_LOGIC;
      dp_s_axis_audio_tvalid : IN STD_LOGIC;
      dp_s_axis_audio_tready : OUT STD_LOGIC;
      dp_m_axis_mixed_audio_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      dp_m_axis_mixed_audio_tid : OUT STD_LOGIC;
      dp_m_axis_mixed_audio_tvalid : OUT STD_LOGIC;
      dp_m_axis_mixed_audio_tready : IN STD_LOGIC;
      dp_s_axis_audio_clk : IN STD_LOGIC;
      dp_live_video_in_vsync : IN STD_LOGIC;
      dp_live_video_in_hsync : IN STD_LOGIC;
      dp_live_video_in_de : IN STD_LOGIC;
      dp_live_video_in_pixel1 : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
      dp_video_in_clk : IN STD_LOGIC;
      dp_video_out_hsync : OUT STD_LOGIC;
      dp_video_out_vsync : OUT STD_LOGIC;
      dp_video_out_pixel1 : OUT STD_LOGIC_VECTOR(35 DOWNTO 0);
      dp_aux_data_in : IN STD_LOGIC;
      dp_aux_data_out : OUT STD_LOGIC;
      dp_aux_data_oe_n : OUT STD_LOGIC;
      dp_live_gfx_alpha_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      dp_live_gfx_pixel1_in : IN STD_LOGIC_VECTOR(35 DOWNTO 0);
      dp_hot_plug_detect : IN STD_LOGIC;
      dp_external_custom_event1 : IN STD_LOGIC;
      dp_external_custom_event2 : IN STD_LOGIC;
      dp_external_vsync_event : IN STD_LOGIC;
      dp_live_video_de_out : OUT STD_LOGIC;
      pl_ps_eventi : IN STD_LOGIC;
      ps_pl_evento : OUT STD_LOGIC;
      ps_pl_standbywfe : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_standbywfi : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      pl_ps_apugic_irq : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      pl_ps_apugic_fiq : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      rpu_eventi0 : IN STD_LOGIC;
      rpu_eventi1 : IN STD_LOGIC;
      rpu_evento0 : OUT STD_LOGIC;
      rpu_evento1 : OUT STD_LOGIC;
      nfiq0_lpd_rpu : IN STD_LOGIC;
      nfiq1_lpd_rpu : IN STD_LOGIC;
      nirq0_lpd_rpu : IN STD_LOGIC;
      nirq1_lpd_rpu : IN STD_LOGIC;
      irq_ipi_pl_0 : OUT STD_LOGIC;
      irq_ipi_pl_1 : OUT STD_LOGIC;
      irq_ipi_pl_2 : OUT STD_LOGIC;
      irq_ipi_pl_3 : OUT STD_LOGIC;
      stm_event : IN STD_LOGIC_VECTOR(59 DOWNTO 0);
      pl_ps_trigger_0 : IN STD_LOGIC;
      pl_ps_trigger_1 : IN STD_LOGIC;
      pl_ps_trigger_2 : IN STD_LOGIC;
      pl_ps_trigger_3 : IN STD_LOGIC;
      ps_pl_trigack_0 : OUT STD_LOGIC;
      ps_pl_trigack_1 : OUT STD_LOGIC;
      ps_pl_trigack_2 : OUT STD_LOGIC;
      ps_pl_trigack_3 : OUT STD_LOGIC;
      ps_pl_trigger_0 : OUT STD_LOGIC;
      ps_pl_trigger_1 : OUT STD_LOGIC;
      ps_pl_trigger_2 : OUT STD_LOGIC;
      ps_pl_trigger_3 : OUT STD_LOGIC;
      pl_ps_trigack_0 : IN STD_LOGIC;
      pl_ps_trigack_1 : IN STD_LOGIC;
      pl_ps_trigack_2 : IN STD_LOGIC;
      pl_ps_trigack_3 : IN STD_LOGIC;
      ftm_gpo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      ftm_gpi : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pl_ps_irq0 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      pl_ps_irq1 : IN STD_LOGIC_VECTOR(0 DOWNTO 0);
      pl_resetn0 : OUT STD_LOGIC;
      pl_resetn1 : OUT STD_LOGIC;
      pl_resetn2 : OUT STD_LOGIC;
      pl_resetn3 : OUT STD_LOGIC;
      osc_rtc_clk : OUT STD_LOGIC;
      pl_pmu_gpi : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pmu_pl_gpo : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      aib_pmu_afifm_fpd_ack : IN STD_LOGIC;
      aib_pmu_afifm_lpd_ack : IN STD_LOGIC;
      pmu_aib_afifm_fpd_req : OUT STD_LOGIC;
      pmu_aib_afifm_lpd_req : OUT STD_LOGIC;
      pmu_error_from_pl : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      pmu_error_to_pl : OUT STD_LOGIC_VECTOR(46 DOWNTO 0);
      pl_acpinact : IN STD_LOGIC;
      pl_clk0 : OUT STD_LOGIC;
      pl_clk1 : OUT STD_LOGIC;
      pl_clk2 : OUT STD_LOGIC;
      pl_clk3 : OUT STD_LOGIC;
      ps_pl_irq_can0 : OUT STD_LOGIC;
      ps_pl_irq_can1 : OUT STD_LOGIC;
      ps_pl_irq_enet0 : OUT STD_LOGIC;
      ps_pl_irq_enet1 : OUT STD_LOGIC;
      ps_pl_irq_enet2 : OUT STD_LOGIC;
      ps_pl_irq_enet3 : OUT STD_LOGIC;
      ps_pl_irq_enet0_wake : OUT STD_LOGIC;
      ps_pl_irq_enet1_wake : OUT STD_LOGIC;
      ps_pl_irq_enet2_wake : OUT STD_LOGIC;
      ps_pl_irq_enet3_wake : OUT STD_LOGIC;
      ps_pl_irq_gpio : OUT STD_LOGIC;
      ps_pl_irq_i2c0 : OUT STD_LOGIC;
      ps_pl_irq_i2c1 : OUT STD_LOGIC;
      ps_pl_irq_uart0 : OUT STD_LOGIC;
      ps_pl_irq_uart1 : OUT STD_LOGIC;
      ps_pl_irq_sdio0 : OUT STD_LOGIC;
      ps_pl_irq_sdio1 : OUT STD_LOGIC;
      ps_pl_irq_sdio0_wake : OUT STD_LOGIC;
      ps_pl_irq_sdio1_wake : OUT STD_LOGIC;
      ps_pl_irq_spi0 : OUT STD_LOGIC;
      ps_pl_irq_spi1 : OUT STD_LOGIC;
      ps_pl_irq_qspi : OUT STD_LOGIC;
      ps_pl_irq_ttc0_0 : OUT STD_LOGIC;
      ps_pl_irq_ttc0_1 : OUT STD_LOGIC;
      ps_pl_irq_ttc0_2 : OUT STD_LOGIC;
      ps_pl_irq_ttc1_0 : OUT STD_LOGIC;
      ps_pl_irq_ttc1_1 : OUT STD_LOGIC;
      ps_pl_irq_ttc1_2 : OUT STD_LOGIC;
      ps_pl_irq_ttc2_0 : OUT STD_LOGIC;
      ps_pl_irq_ttc2_1 : OUT STD_LOGIC;
      ps_pl_irq_ttc2_2 : OUT STD_LOGIC;
      ps_pl_irq_ttc3_0 : OUT STD_LOGIC;
      ps_pl_irq_ttc3_1 : OUT STD_LOGIC;
      ps_pl_irq_ttc3_2 : OUT STD_LOGIC;
      ps_pl_irq_csu_pmu_wdt : OUT STD_LOGIC;
      ps_pl_irq_lp_wdt : OUT STD_LOGIC;
      ps_pl_irq_usb3_0_endpoint : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_irq_usb3_0_otg : OUT STD_LOGIC;
      ps_pl_irq_usb3_1_endpoint : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_irq_usb3_1_otg : OUT STD_LOGIC;
      ps_pl_irq_adma_chan : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      ps_pl_irq_usb3_0_pmu_wakeup : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ps_pl_irq_gdma_chan : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      ps_pl_irq_csu : OUT STD_LOGIC;
      ps_pl_irq_csu_dma : OUT STD_LOGIC;
      ps_pl_irq_efuse : OUT STD_LOGIC;
      ps_pl_irq_xmpu_lpd : OUT STD_LOGIC;
      ps_pl_irq_ddr_ss : OUT STD_LOGIC;
      ps_pl_irq_nand : OUT STD_LOGIC;
      ps_pl_irq_fp_wdt : OUT STD_LOGIC;
      ps_pl_irq_pcie_msi : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ps_pl_irq_pcie_legacy : OUT STD_LOGIC;
      ps_pl_irq_pcie_dma : OUT STD_LOGIC;
      ps_pl_irq_pcie_msc : OUT STD_LOGIC;
      ps_pl_irq_dport : OUT STD_LOGIC;
      ps_pl_irq_fpd_apb_int : OUT STD_LOGIC;
      ps_pl_irq_fpd_atb_error : OUT STD_LOGIC;
      ps_pl_irq_dpdma : OUT STD_LOGIC;
      ps_pl_irq_apm_fpd : OUT STD_LOGIC;
      ps_pl_irq_gpu : OUT STD_LOGIC;
      ps_pl_irq_sata : OUT STD_LOGIC;
      ps_pl_irq_xmpu_fpd : OUT STD_LOGIC;
      ps_pl_irq_apu_cpumnt : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_irq_apu_cti : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_irq_apu_pmu : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_irq_apu_comm : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      ps_pl_irq_apu_l2err : OUT STD_LOGIC;
      ps_pl_irq_apu_exterr : OUT STD_LOGIC;
      ps_pl_irq_apu_regs : OUT STD_LOGIC;
      ps_pl_irq_intf_ppd_cci : OUT STD_LOGIC;
      ps_pl_irq_intf_fpd_smmu : OUT STD_LOGIC;
      ps_pl_irq_atb_err_lpd : OUT STD_LOGIC;
      ps_pl_irq_aib_axi : OUT STD_LOGIC;
      ps_pl_irq_ams : OUT STD_LOGIC;
      ps_pl_irq_lpd_apm : OUT STD_LOGIC;
      ps_pl_irq_rtc_alaram : OUT STD_LOGIC;
      ps_pl_irq_rtc_seconds : OUT STD_LOGIC;
      ps_pl_irq_clkmon : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel0 : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel1 : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel2 : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel7 : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel8 : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel9 : OUT STD_LOGIC;
      ps_pl_irq_ipi_channel10 : OUT STD_LOGIC;
      ps_pl_irq_rpu_pm : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      ps_pl_irq_ocm_error : OUT STD_LOGIC;
      ps_pl_irq_lpd_apb_intr : OUT STD_LOGIC;
      ps_pl_irq_r5_core0_ecc_error : OUT STD_LOGIC;
      ps_pl_irq_r5_core1_ecc_error : OUT STD_LOGIC;
      test_adc_clk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      test_adc_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      test_adc2_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      test_db : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      test_adc_out : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      test_ams_osc : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      test_mon_data : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      test_dclk : IN STD_LOGIC;
      test_den : IN STD_LOGIC;
      test_dwe : IN STD_LOGIC;
      test_daddr : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      test_di : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      test_drdy : OUT STD_LOGIC;
      test_do : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      test_convst : IN STD_LOGIC;
      pstp_pl_clk : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      pstp_pl_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      pstp_pl_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      pstp_pl_ts : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      fmio_test_gem_scanmux_1 : IN STD_LOGIC;
      fmio_test_gem_scanmux_2 : IN STD_LOGIC;
      test_char_mode_fpd_n : IN STD_LOGIC;
      test_char_mode_lpd_n : IN STD_LOGIC;
      fmio_test_io_char_scan_clock : IN STD_LOGIC;
      fmio_test_io_char_scanenable : IN STD_LOGIC;
      fmio_test_io_char_scan_in : IN STD_LOGIC;
      fmio_test_io_char_scan_out : OUT STD_LOGIC;
      fmio_test_io_char_scan_reset_n : IN STD_LOGIC;
      fmio_char_afifslpd_test_select_n : IN STD_LOGIC;
      fmio_char_afifslpd_test_input : IN STD_LOGIC;
      fmio_char_afifslpd_test_output : OUT STD_LOGIC;
      fmio_char_afifsfpd_test_select_n : IN STD_LOGIC;
      fmio_char_afifsfpd_test_input : IN STD_LOGIC;
      fmio_char_afifsfpd_test_output : OUT STD_LOGIC;
      io_char_audio_in_test_data : IN STD_LOGIC;
      io_char_audio_mux_sel_n : IN STD_LOGIC;
      io_char_video_in_test_data : IN STD_LOGIC;
      io_char_video_mux_sel_n : IN STD_LOGIC;
      io_char_video_out_test_data : OUT STD_LOGIC;
      io_char_audio_out_test_data : OUT STD_LOGIC;
      fmio_test_qspi_scanmux_1_n : IN STD_LOGIC;
      fmio_test_sdio_scanmux_1 : IN STD_LOGIC;
      fmio_test_sdio_scanmux_2 : IN STD_LOGIC;
      fmio_sd0_dll_test_in_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      fmio_sd0_dll_test_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      fmio_sd1_dll_test_in_n : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      fmio_sd1_dll_test_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      test_pl_scan_chopper_si : IN STD_LOGIC;
      test_pl_scan_chopper_so : OUT STD_LOGIC;
      test_pl_scan_chopper_trig : IN STD_LOGIC;
      test_pl_scan_clk0 : IN STD_LOGIC;
      test_pl_scan_clk1 : IN STD_LOGIC;
      test_pl_scan_edt_clk : IN STD_LOGIC;
      test_pl_scan_edt_in_apu : IN STD_LOGIC;
      test_pl_scan_edt_in_cpu : IN STD_LOGIC;
      test_pl_scan_edt_in_ddr : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      test_pl_scan_edt_in_fp : IN STD_LOGIC_VECTOR(9 DOWNTO 0);
      test_pl_scan_edt_in_gpu : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      test_pl_scan_edt_in_lp : IN STD_LOGIC_VECTOR(8 DOWNTO 0);
      test_pl_scan_edt_in_usb3 : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      test_pl_scan_edt_out_apu : OUT STD_LOGIC;
      test_pl_scan_edt_out_cpu0 : OUT STD_LOGIC;
      test_pl_scan_edt_out_cpu1 : OUT STD_LOGIC;
      test_pl_scan_edt_out_cpu2 : OUT STD_LOGIC;
      test_pl_scan_edt_out_cpu3 : OUT STD_LOGIC;
      test_pl_scan_edt_out_ddr : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      test_pl_scan_edt_out_fp : OUT STD_LOGIC_VECTOR(9 DOWNTO 0);
      test_pl_scan_edt_out_gpu : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      test_pl_scan_edt_out_lp : OUT STD_LOGIC_VECTOR(8 DOWNTO 0);
      test_pl_scan_edt_out_usb3 : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      test_pl_scan_edt_update : IN STD_LOGIC;
      test_pl_scan_reset_n : IN STD_LOGIC;
      test_pl_scanenable : IN STD_LOGIC;
      test_pl_scan_pll_reset : IN STD_LOGIC;
      test_pl_scan_spare_in0 : IN STD_LOGIC;
      test_pl_scan_spare_in1 : IN STD_LOGIC;
      test_pl_scan_spare_out0 : OUT STD_LOGIC;
      test_pl_scan_spare_out1 : OUT STD_LOGIC;
      test_pl_scan_wrap_clk : IN STD_LOGIC;
      test_pl_scan_wrap_ishift : IN STD_LOGIC;
      test_pl_scan_wrap_oshift : IN STD_LOGIC;
      test_pl_scan_slcr_config_clk : IN STD_LOGIC;
      test_pl_scan_slcr_config_rstn : IN STD_LOGIC;
      test_pl_scan_slcr_config_si : IN STD_LOGIC;
      test_pl_scan_spare_in2 : IN STD_LOGIC;
      test_pl_scanenable_slcr_en : IN STD_LOGIC;
      test_pl_pll_lock_out : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
      test_pl_scan_slcr_config_so : OUT STD_LOGIC;
      tst_rtc_calibreg_in : IN STD_LOGIC_VECTOR(20 DOWNTO 0);
      tst_rtc_calibreg_out : OUT STD_LOGIC_VECTOR(20 DOWNTO 0);
      tst_rtc_calibreg_we : IN STD_LOGIC;
      tst_rtc_clk : IN STD_LOGIC;
      tst_rtc_osc_clk_out : OUT STD_LOGIC;
      tst_rtc_sec_counter_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      tst_rtc_seconds_raw_int : OUT STD_LOGIC;
      tst_rtc_testclock_select_n : IN STD_LOGIC;
      tst_rtc_tick_counter_out : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
      tst_rtc_timesetreg_in : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
      tst_rtc_timesetreg_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      tst_rtc_disable_bat_op : IN STD_LOGIC;
      tst_rtc_osc_cntrl_in : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      tst_rtc_osc_cntrl_out : OUT STD_LOGIC_VECTOR(3 DOWNTO 0);
      tst_rtc_osc_cntrl_we : IN STD_LOGIC;
      tst_rtc_sec_reload : IN STD_LOGIC;
      tst_rtc_timesetreg_we : IN STD_LOGIC;
      tst_rtc_testmode_n : IN STD_LOGIC;
      test_usb0_funcmux_0_n : IN STD_LOGIC;
      test_usb1_funcmux_0_n : IN STD_LOGIC;
      test_usb0_scanmux_0_n : IN STD_LOGIC;
      test_usb1_scanmux_0_n : IN STD_LOGIC;
      lpd_pll_test_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      pl_lpd_pll_test_ck_sel_n : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      pl_lpd_pll_test_fract_clk_sel_n : IN STD_LOGIC;
      pl_lpd_pll_test_fract_en_n : IN STD_LOGIC;
      pl_lpd_pll_test_mux_sel : IN STD_LOGIC;
      pl_lpd_pll_test_sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      fpd_pll_test_out : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
      pl_fpd_pll_test_ck_sel_n : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      pl_fpd_pll_test_fract_clk_sel_n : IN STD_LOGIC;
      pl_fpd_pll_test_fract_en_n : IN STD_LOGIC;
      pl_fpd_pll_test_mux_sel : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      pl_fpd_pll_test_sel : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
      fmio_char_gem_selection : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      fmio_char_gem_test_select_n : IN STD_LOGIC;
      fmio_char_gem_test_input : IN STD_LOGIC;
      fmio_char_gem_test_output : OUT STD_LOGIC;
      test_ddr2pl_dcd_skewout : OUT STD_LOGIC;
      test_pl2ddr_dcd_sample_pulse : IN STD_LOGIC;
      test_bscan_en_n : IN STD_LOGIC;
      test_bscan_tdi : IN STD_LOGIC;
      test_bscan_updatedr : IN STD_LOGIC;
      test_bscan_shiftdr : IN STD_LOGIC;
      test_bscan_reset_tap_b : IN STD_LOGIC;
      test_bscan_misr_jtag_load : IN STD_LOGIC;
      test_bscan_intest : IN STD_LOGIC;
      test_bscan_extest : IN STD_LOGIC;
      test_bscan_clockdr : IN STD_LOGIC;
      test_bscan_ac_mode : IN STD_LOGIC;
      test_bscan_ac_test : IN STD_LOGIC;
      test_bscan_init_memory : IN STD_LOGIC;
      test_bscan_mode_c : IN STD_LOGIC;
      test_bscan_tdo : OUT STD_LOGIC;
      i_dbg_l0_txclk : IN STD_LOGIC;
      i_dbg_l0_rxclk : IN STD_LOGIC;
      i_dbg_l1_txclk : IN STD_LOGIC;
      i_dbg_l1_rxclk : IN STD_LOGIC;
      i_dbg_l2_txclk : IN STD_LOGIC;
      i_dbg_l2_rxclk : IN STD_LOGIC;
      i_dbg_l3_txclk : IN STD_LOGIC;
      i_dbg_l3_rxclk : IN STD_LOGIC;
      i_afe_rx_symbol_clk_by_2_pl : IN STD_LOGIC;
      pl_fpd_spare_0_in : IN STD_LOGIC;
      pl_fpd_spare_1_in : IN STD_LOGIC;
      pl_fpd_spare_2_in : IN STD_LOGIC;
      pl_fpd_spare_3_in : IN STD_LOGIC;
      pl_fpd_spare_4_in : IN STD_LOGIC;
      fpd_pl_spare_0_out : OUT STD_LOGIC;
      fpd_pl_spare_1_out : OUT STD_LOGIC;
      fpd_pl_spare_2_out : OUT STD_LOGIC;
      fpd_pl_spare_3_out : OUT STD_LOGIC;
      fpd_pl_spare_4_out : OUT STD_LOGIC;
      pl_lpd_spare_0_in : IN STD_LOGIC;
      pl_lpd_spare_1_in : IN STD_LOGIC;
      pl_lpd_spare_2_in : IN STD_LOGIC;
      pl_lpd_spare_3_in : IN STD_LOGIC;
      pl_lpd_spare_4_in : IN STD_LOGIC;
      lpd_pl_spare_0_out : OUT STD_LOGIC;
      lpd_pl_spare_1_out : OUT STD_LOGIC;
      lpd_pl_spare_2_out : OUT STD_LOGIC;
      lpd_pl_spare_3_out : OUT STD_LOGIC;
      lpd_pl_spare_4_out : OUT STD_LOGIC;
      o_dbg_l0_phystatus : OUT STD_LOGIC;
      o_dbg_l0_rxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l0_rxdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_rxvalid : OUT STD_LOGIC;
      o_dbg_l0_rxstatus : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      o_dbg_l0_rxelecidle : OUT STD_LOGIC;
      o_dbg_l0_rstb : OUT STD_LOGIC;
      o_dbg_l0_txdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l0_txdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_rate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_powerdown : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_txelecidle : OUT STD_LOGIC;
      o_dbg_l0_txdetrx_lpback : OUT STD_LOGIC;
      o_dbg_l0_rxpolarity : OUT STD_LOGIC;
      o_dbg_l0_tx_sgmii_ewrap : OUT STD_LOGIC;
      o_dbg_l0_rx_sgmii_en_cdet : OUT STD_LOGIC;
      o_dbg_l0_sata_corerxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l0_sata_corerxdatavalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_sata_coreready : OUT STD_LOGIC;
      o_dbg_l0_sata_coreclockready : OUT STD_LOGIC;
      o_dbg_l0_sata_corerxsignaldet : OUT STD_LOGIC;
      o_dbg_l0_sata_phyctrltxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l0_sata_phyctrltxidle : OUT STD_LOGIC;
      o_dbg_l0_sata_phyctrltxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_sata_phyctrlrxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l0_sata_phyctrltxrst : OUT STD_LOGIC;
      o_dbg_l0_sata_phyctrlrxrst : OUT STD_LOGIC;
      o_dbg_l0_sata_phyctrlreset : OUT STD_LOGIC;
      o_dbg_l0_sata_phyctrlpartial : OUT STD_LOGIC;
      o_dbg_l0_sata_phyctrlslumber : OUT STD_LOGIC;
      o_dbg_l1_phystatus : OUT STD_LOGIC;
      o_dbg_l1_rxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l1_rxdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_rxvalid : OUT STD_LOGIC;
      o_dbg_l1_rxstatus : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      o_dbg_l1_rxelecidle : OUT STD_LOGIC;
      o_dbg_l1_rstb : OUT STD_LOGIC;
      o_dbg_l1_txdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l1_txdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_rate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_powerdown : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_txelecidle : OUT STD_LOGIC;
      o_dbg_l1_txdetrx_lpback : OUT STD_LOGIC;
      o_dbg_l1_rxpolarity : OUT STD_LOGIC;
      o_dbg_l1_tx_sgmii_ewrap : OUT STD_LOGIC;
      o_dbg_l1_rx_sgmii_en_cdet : OUT STD_LOGIC;
      o_dbg_l1_sata_corerxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l1_sata_corerxdatavalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_sata_coreready : OUT STD_LOGIC;
      o_dbg_l1_sata_coreclockready : OUT STD_LOGIC;
      o_dbg_l1_sata_corerxsignaldet : OUT STD_LOGIC;
      o_dbg_l1_sata_phyctrltxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l1_sata_phyctrltxidle : OUT STD_LOGIC;
      o_dbg_l1_sata_phyctrltxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_sata_phyctrlrxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l1_sata_phyctrltxrst : OUT STD_LOGIC;
      o_dbg_l1_sata_phyctrlrxrst : OUT STD_LOGIC;
      o_dbg_l1_sata_phyctrlreset : OUT STD_LOGIC;
      o_dbg_l1_sata_phyctrlpartial : OUT STD_LOGIC;
      o_dbg_l1_sata_phyctrlslumber : OUT STD_LOGIC;
      o_dbg_l2_phystatus : OUT STD_LOGIC;
      o_dbg_l2_rxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l2_rxdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_rxvalid : OUT STD_LOGIC;
      o_dbg_l2_rxstatus : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      o_dbg_l2_rxelecidle : OUT STD_LOGIC;
      o_dbg_l2_rstb : OUT STD_LOGIC;
      o_dbg_l2_txdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l2_txdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_rate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_powerdown : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_txelecidle : OUT STD_LOGIC;
      o_dbg_l2_txdetrx_lpback : OUT STD_LOGIC;
      o_dbg_l2_rxpolarity : OUT STD_LOGIC;
      o_dbg_l2_tx_sgmii_ewrap : OUT STD_LOGIC;
      o_dbg_l2_rx_sgmii_en_cdet : OUT STD_LOGIC;
      o_dbg_l2_sata_corerxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l2_sata_corerxdatavalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_sata_coreready : OUT STD_LOGIC;
      o_dbg_l2_sata_coreclockready : OUT STD_LOGIC;
      o_dbg_l2_sata_corerxsignaldet : OUT STD_LOGIC;
      o_dbg_l2_sata_phyctrltxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l2_sata_phyctrltxidle : OUT STD_LOGIC;
      o_dbg_l2_sata_phyctrltxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_sata_phyctrlrxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l2_sata_phyctrltxrst : OUT STD_LOGIC;
      o_dbg_l2_sata_phyctrlrxrst : OUT STD_LOGIC;
      o_dbg_l2_sata_phyctrlreset : OUT STD_LOGIC;
      o_dbg_l2_sata_phyctrlpartial : OUT STD_LOGIC;
      o_dbg_l2_sata_phyctrlslumber : OUT STD_LOGIC;
      o_dbg_l3_phystatus : OUT STD_LOGIC;
      o_dbg_l3_rxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l3_rxdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_rxvalid : OUT STD_LOGIC;
      o_dbg_l3_rxstatus : OUT STD_LOGIC_VECTOR(2 DOWNTO 0);
      o_dbg_l3_rxelecidle : OUT STD_LOGIC;
      o_dbg_l3_rstb : OUT STD_LOGIC;
      o_dbg_l3_txdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l3_txdatak : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_rate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_powerdown : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_txelecidle : OUT STD_LOGIC;
      o_dbg_l3_txdetrx_lpback : OUT STD_LOGIC;
      o_dbg_l3_rxpolarity : OUT STD_LOGIC;
      o_dbg_l3_tx_sgmii_ewrap : OUT STD_LOGIC;
      o_dbg_l3_rx_sgmii_en_cdet : OUT STD_LOGIC;
      o_dbg_l3_sata_corerxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l3_sata_corerxdatavalid : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_sata_coreready : OUT STD_LOGIC;
      o_dbg_l3_sata_coreclockready : OUT STD_LOGIC;
      o_dbg_l3_sata_corerxsignaldet : OUT STD_LOGIC;
      o_dbg_l3_sata_phyctrltxdata : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_dbg_l3_sata_phyctrltxidle : OUT STD_LOGIC;
      o_dbg_l3_sata_phyctrltxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_sata_phyctrlrxrate : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
      o_dbg_l3_sata_phyctrltxrst : OUT STD_LOGIC;
      o_dbg_l3_sata_phyctrlrxrst : OUT STD_LOGIC;
      o_dbg_l3_sata_phyctrlreset : OUT STD_LOGIC;
      o_dbg_l3_sata_phyctrlpartial : OUT STD_LOGIC;
      o_dbg_l3_sata_phyctrlslumber : OUT STD_LOGIC;
      dbg_path_fifo_bypass : OUT STD_LOGIC;
      i_afe_pll_pd_hs_clock_r : IN STD_LOGIC;
      i_afe_mode : IN STD_LOGIC;
      i_bgcal_afe_mode : IN STD_LOGIC;
      o_afe_cmn_calib_comp_out : OUT STD_LOGIC;
      i_afe_cmn_bg_enable_low_leakage : IN STD_LOGIC;
      i_afe_cmn_bg_iso_ctrl_bar : IN STD_LOGIC;
      i_afe_cmn_bg_pd : IN STD_LOGIC;
      i_afe_cmn_bg_pd_bg_ok : IN STD_LOGIC;
      i_afe_cmn_bg_pd_ptat : IN STD_LOGIC;
      i_afe_cmn_calib_en_iconst : IN STD_LOGIC;
      i_afe_cmn_calib_enable_low_leakage : IN STD_LOGIC;
      i_afe_cmn_calib_iso_ctrl_bar : IN STD_LOGIC;
      o_afe_pll_dco_count : OUT STD_LOGIC_VECTOR(12 DOWNTO 0);
      o_afe_pll_clk_sym_hs : OUT STD_LOGIC;
      o_afe_pll_fbclk_frac : OUT STD_LOGIC;
      o_afe_rx_pipe_lfpsbcn_rxelecidle : OUT STD_LOGIC;
      o_afe_rx_pipe_sigdet : OUT STD_LOGIC;
      o_afe_rx_symbol : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
      o_afe_rx_symbol_clk_by_2 : OUT STD_LOGIC;
      o_afe_rx_uphy_save_calcode : OUT STD_LOGIC;
      o_afe_rx_uphy_startloop_buf : OUT STD_LOGIC;
      o_afe_rx_uphy_rx_calib_done : OUT STD_LOGIC;
      i_afe_rx_rxpma_rstb : IN STD_LOGIC;
      i_afe_rx_uphy_restore_calcode_data : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_afe_rx_pipe_rxeqtraining : IN STD_LOGIC;
      i_afe_rx_iso_hsrx_ctrl_bar : IN STD_LOGIC;
      i_afe_rx_iso_lfps_ctrl_bar : IN STD_LOGIC;
      i_afe_rx_iso_sigdet_ctrl_bar : IN STD_LOGIC;
      i_afe_rx_hsrx_clock_stop_req : IN STD_LOGIC;
      o_afe_rx_uphy_save_calcode_data : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
      o_afe_rx_hsrx_clock_stop_ack : OUT STD_LOGIC;
      o_afe_pg_avddcr : OUT STD_LOGIC;
      o_afe_pg_avddio : OUT STD_LOGIC;
      o_afe_pg_dvddcr : OUT STD_LOGIC;
      o_afe_pg_static_avddcr : OUT STD_LOGIC;
      o_afe_pg_static_avddio : OUT STD_LOGIC;
      i_pll_afe_mode : IN STD_LOGIC;
      i_afe_pll_coarse_code : IN STD_LOGIC_VECTOR(10 DOWNTO 0);
      i_afe_pll_en_clock_hs_div2 : IN STD_LOGIC;
      i_afe_pll_fbdiv : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
      i_afe_pll_load_fbdiv : IN STD_LOGIC;
      i_afe_pll_pd : IN STD_LOGIC;
      i_afe_pll_pd_pfd : IN STD_LOGIC;
      i_afe_pll_rst_fdbk_div : IN STD_LOGIC;
      i_afe_pll_startloop : IN STD_LOGIC;
      i_afe_pll_v2i_code : IN STD_LOGIC_VECTOR(5 DOWNTO 0);
      i_afe_pll_v2i_prog : IN STD_LOGIC_VECTOR(4 DOWNTO 0);
      i_afe_pll_vco_cnt_window : IN STD_LOGIC;
      i_afe_rx_mphy_gate_symbol_clk : IN STD_LOGIC;
      i_afe_rx_mphy_mux_hsb_ls : IN STD_LOGIC;
      i_afe_rx_pipe_rx_term_enable : IN STD_LOGIC;
      i_afe_rx_uphy_biasgen_iconst_core_mirror_enable : IN STD_LOGIC;
      i_afe_rx_uphy_biasgen_iconst_io_mirror_enable : IN STD_LOGIC;
      i_afe_rx_uphy_biasgen_irconst_core_mirror_enable : IN STD_LOGIC;
      i_afe_rx_uphy_enable_cdr : IN STD_LOGIC;
      i_afe_rx_uphy_enable_low_leakage : IN STD_LOGIC;
      i_afe_rx_rxpma_refclk_dig : IN STD_LOGIC;
      i_afe_rx_uphy_hsrx_rstb : IN STD_LOGIC;
      i_afe_rx_uphy_pdn_hs_des : IN STD_LOGIC;
      i_afe_rx_uphy_pd_samp_c2c : IN STD_LOGIC;
      i_afe_rx_uphy_pd_samp_c2c_eclk : IN STD_LOGIC;
      i_afe_rx_uphy_pso_clk_lane : IN STD_LOGIC;
      i_afe_rx_uphy_pso_eq : IN STD_LOGIC;
      i_afe_rx_uphy_pso_hsrxdig : IN STD_LOGIC;
      i_afe_rx_uphy_pso_iqpi : IN STD_LOGIC;
      i_afe_rx_uphy_pso_lfpsbcn : IN STD_LOGIC;
      i_afe_rx_uphy_pso_samp_flops : IN STD_LOGIC;
      i_afe_rx_uphy_pso_sigdet : IN STD_LOGIC;
      i_afe_rx_uphy_restore_calcode : IN STD_LOGIC;
      i_afe_rx_uphy_run_calib : IN STD_LOGIC;
      i_afe_rx_uphy_rx_lane_polarity_swap : IN STD_LOGIC;
      i_afe_rx_uphy_startloop_pll : IN STD_LOGIC;
      i_afe_rx_uphy_hsclk_division_factor : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      i_afe_rx_uphy_rx_pma_opmode : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_afe_tx_enable_hsclk_division : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      i_afe_tx_enable_ldo : IN STD_LOGIC;
      i_afe_tx_enable_ref : IN STD_LOGIC;
      i_afe_tx_enable_supply_hsclk : IN STD_LOGIC;
      i_afe_tx_enable_supply_pipe : IN STD_LOGIC;
      i_afe_tx_enable_supply_serializer : IN STD_LOGIC;
      i_afe_tx_enable_supply_uphy : IN STD_LOGIC;
      i_afe_tx_hs_ser_rstb : IN STD_LOGIC;
      i_afe_tx_hs_symbol : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
      i_afe_tx_mphy_tx_ls_data : IN STD_LOGIC;
      i_afe_tx_pipe_tx_enable_idle_mode : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      i_afe_tx_pipe_tx_enable_lfps : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      i_afe_tx_pipe_tx_enable_rxdet : IN STD_LOGIC;
      i_afe_TX_uphy_txpma_opmode : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
      i_afe_TX_pmadig_digital_reset_n : IN STD_LOGIC;
      i_afe_TX_serializer_rst_rel : IN STD_LOGIC;
      i_afe_TX_pll_symb_clk_2 : IN STD_LOGIC;
      i_afe_TX_ana_if_rate : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
      i_afe_TX_en_dig_sublp_mode : IN STD_LOGIC;
      i_afe_TX_LPBK_SEL : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
      i_afe_TX_iso_ctrl_bar : IN STD_LOGIC;
      i_afe_TX_ser_iso_ctrl_bar : IN STD_LOGIC;
      i_afe_TX_lfps_clk : IN STD_LOGIC;
      i_afe_TX_serializer_rstb : IN STD_LOGIC;
      o_afe_TX_dig_reset_rel_ack : OUT STD_LOGIC;
      o_afe_TX_pipe_TX_dn_rxdet : OUT STD_LOGIC;
      o_afe_TX_pipe_TX_dp_rxdet : OUT STD_LOGIC;
      i_afe_tx_pipe_tx_fast_est_common_mode : IN STD_LOGIC;
      o_dbg_l0_txclk : OUT STD_LOGIC;
      o_dbg_l0_rxclk : OUT STD_LOGIC;
      o_dbg_l1_txclk : OUT STD_LOGIC;
      o_dbg_l1_rxclk : OUT STD_LOGIC;
      o_dbg_l2_txclk : OUT STD_LOGIC;
      o_dbg_l2_rxclk : OUT STD_LOGIC;
      o_dbg_l3_txclk : OUT STD_LOGIC;
      o_dbg_l3_rxclk : OUT STD_LOGIC;
      emio_i2c0_scl_t_n : OUT STD_LOGIC;
      emio_i2c0_sda_t_n : OUT STD_LOGIC;
      emio_enet0_mdio_t_n : OUT STD_LOGIC;
      emio_enet1_mdio_t_n : OUT STD_LOGIC;
      emio_enet2_mdio_t_n : OUT STD_LOGIC;
      emio_enet3_mdio_t_n : OUT STD_LOGIC;
      emio_gpio_t_n : OUT STD_LOGIC_VECTOR(0 DOWNTO 0);
      emio_i2c1_scl_t_n : OUT STD_LOGIC;
      emio_i2c1_sda_t_n : OUT STD_LOGIC;
      emio_spi0_sclk_t_n : OUT STD_LOGIC;
      emio_spi0_mo_t_n : OUT STD_LOGIC;
      emio_spi0_so_t_n : OUT STD_LOGIC;
      emio_spi0_ss_n_t_n : OUT STD_LOGIC;
      emio_spi1_sclk_t_n : OUT STD_LOGIC;
      emio_spi1_mo_t_n : OUT STD_LOGIC;
      emio_spi1_so_t_n : OUT STD_LOGIC;
      emio_spi1_ss_n_t_n : OUT STD_LOGIC
    );
  END COMPONENT zynq_ultra_ps_e_v3_2_1_zynq_ultra_ps_e;
  ATTRIBUTE X_CORE_INFO : STRING;
  ATTRIBUTE X_CORE_INFO OF design_1_zynq_ultra_ps_e_0_0_arch: ARCHITECTURE IS "zynq_ultra_ps_e_v3_2_1_zynq_ultra_ps_e,Vivado 2018.2";
  ATTRIBUTE CHECK_LICENSE_TYPE : STRING;
  ATTRIBUTE CHECK_LICENSE_TYPE OF design_1_zynq_ultra_ps_e_0_0_arch : ARCHITECTURE IS "design_1_zynq_ultra_ps_e_0_0,zynq_ultra_ps_e_v3_2_1_zynq_ultra_ps_e,{}";
  ATTRIBUTE CORE_GENERATION_INFO : STRING;
  ATTRIBUTE CORE_GENERATION_INFO OF design_1_zynq_ultra_ps_e_0_0_arch: ARCHITECTURE IS "design_1_zynq_ultra_ps_e_0_0,zynq_ultra_ps_e_v3_2_1_zynq_ultra_ps_e,{x_ipProduct=Vivado 2018.2,x_ipVendor=xilinx.com,x_ipLibrary=ip,x_ipName=zynq_ultra_ps_e,x_ipVersion=3.2,x_ipCoreRevision=1,x_ipLanguage=VHDL,x_ipSimLanguage=MIXED,C_DP_USE_AUDIO=0,C_DP_USE_VIDEO=0,C_MAXIGP0_DATA_WIDTH=128,C_MAXIGP1_DATA_WIDTH=128,C_MAXIGP2_DATA_WIDTH=32,C_SAXIGP0_DATA_WIDTH=128,C_SAXIGP1_DATA_WIDTH=128,C_SAXIGP2_DATA_WIDTH=128,C_SAXIGP3_DATA_WIDTH=128,C_SAXIGP4_DATA_WIDTH=128,C_SAXIGP5_DATA_WIDTH=128,C_SAXIGP6_" & 
"DATA_WIDTH=128,C_USE_DIFF_RW_CLK_GP0=0,C_USE_DIFF_RW_CLK_GP1=0,C_USE_DIFF_RW_CLK_GP2=0,C_USE_DIFF_RW_CLK_GP3=0,C_USE_DIFF_RW_CLK_GP4=0,C_USE_DIFF_RW_CLK_GP5=0,C_USE_DIFF_RW_CLK_GP6=0,C_EN_FIFO_ENET0=0,C_EN_FIFO_ENET1=0,C_EN_FIFO_ENET2=0,C_EN_FIFO_ENET3=0,C_PL_CLK0_BUF=TRUE,C_PL_CLK1_BUF=FALSE,C_PL_CLK2_BUF=FALSE,C_PL_CLK3_BUF=FALSE,C_TRACE_PIPELINE_WIDTH=8,C_EN_EMIO_TRACE=0,C_TRACE_DATA_WIDTH=32,C_USE_DEBUG_TEST=0,C_SD0_INTERNAL_BUS_WIDTH=4,C_SD1_INTERNAL_BUS_WIDTH=4,C_NUM_F2P_0_INTR_INPUTS=1,C_" & 
"NUM_F2P_1_INTR_INPUTS=1,C_EMIO_GPIO_WIDTH=1,C_NUM_FABRIC_RESETS=1}";
  ATTRIBUTE X_INTERFACE_INFO : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER : STRING;
  ATTRIBUTE X_INTERFACE_PARAMETER OF pl_clk0: SIGNAL IS "XIL_INTERFACENAME PL_CLK0, FREQ_HZ 99999999, PHASE 0.000, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0";
  ATTRIBUTE X_INTERFACE_INFO OF pl_clk0: SIGNAL IS "xilinx.com:signal:clock:1.0 PL_CLK0 CLK";
  ATTRIBUTE X_INTERFACE_PARAMETER OF pl_resetn0: SIGNAL IS "XIL_INTERFACENAME PL_RESETN0, POLARITY ACTIVE_LOW";
  ATTRIBUTE X_INTERFACE_INFO OF pl_resetn0: SIGNAL IS "xilinx.com:signal:reset:1.0 PL_RESETN0 RST";
  ATTRIBUTE X_INTERFACE_PARAMETER OF pl_ps_irq0: SIGNAL IS "XIL_INTERFACENAME PL_PS_IRQ0, SENSITIVITY LEVEL_HIGH, PortWidth 1";
  ATTRIBUTE X_INTERFACE_INFO OF pl_ps_irq0: SIGNAL IS "xilinx.com:signal:interrupt:1.0 PL_PS_IRQ0 INTERRUPT";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arqos: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARQOS";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awqos: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWQOS";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_rlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD RLAST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_rid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD RID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_aruser: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARUSER";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arcache: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARCACHE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arlock: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARLOCK";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARBURST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARLEN";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_arid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD ARID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_bid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD BID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_wlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD WLAST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awuser: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWUSER";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awcache: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWCACHE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awlock: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWLOCK";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWBURST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWLEN";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWADDR";
  ATTRIBUTE X_INTERFACE_PARAMETER OF maxigp1_awid: SIGNAL IS "XIL_INTERFACENAME M_AXI_HPM1_FPD, NUM_WRITE_OUTSTANDING 8, NUM_READ_OUTSTANDING 8, DATA_WIDTH 128, PROTOCOL AXI4, FREQ_HZ 99999999, ID_WIDTH 16, ADDR_WIDTH 40, AWUSER_WIDTH 16, ARUSER_WIDTH 16, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, MAX_BURST_LENGTH 256, PHASE 0.000, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_T" & 
"HREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp1_awid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM1_FPD AWID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF maxihpm1_fpd_aclk: SIGNAL IS "XIL_INTERFACENAME M_AXI_HPM1_FPD_ACLK, ASSOCIATED_BUSIF M_AXI_HPM1_FPD, FREQ_HZ 99999999, PHASE 0.000, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0";
  ATTRIBUTE X_INTERFACE_INFO OF maxihpm1_fpd_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 M_AXI_HPM1_FPD_ACLK CLK";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arqos: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARQOS";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awqos: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWQOS";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_rready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD RREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_rvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD RVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_rlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD RLAST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_rresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD RRESP";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_rdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD RDATA";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_rid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD RID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_aruser: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARUSER";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARPROT";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arcache: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARCACHE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arlock: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARLOCK";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARBURST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARLEN";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_araddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARADDR";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_arid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD ARID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_bready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD BREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_bvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD BVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_bresp: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD BRESP";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_bid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD BID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_wready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD WREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_wvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD WVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_wlast: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD WLAST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_wstrb: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD WSTRB";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_wdata: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD WDATA";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awready: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWREADY";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awuser: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWUSER";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awvalid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWVALID";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awprot: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWPROT";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awcache: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWCACHE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awlock: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWLOCK";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awburst: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWBURST";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awsize: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWSIZE";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awlen: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWLEN";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awaddr: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWADDR";
  ATTRIBUTE X_INTERFACE_PARAMETER OF maxigp0_awid: SIGNAL IS "XIL_INTERFACENAME M_AXI_HPM0_FPD, NUM_WRITE_OUTSTANDING 8, NUM_READ_OUTSTANDING 8, DATA_WIDTH 128, PROTOCOL AXI4, FREQ_HZ 99999999, ID_WIDTH 16, ADDR_WIDTH 40, AWUSER_WIDTH 16, ARUSER_WIDTH 16, WUSER_WIDTH 0, RUSER_WIDTH 0, BUSER_WIDTH 0, READ_WRITE_MODE READ_WRITE, HAS_BURST 1, HAS_LOCK 1, HAS_PROT 1, HAS_CACHE 1, HAS_QOS 1, HAS_REGION 0, HAS_WSTRB 1, HAS_BRESP 1, HAS_RRESP 1, SUPPORTS_NARROW_BURST 1, MAX_BURST_LENGTH 256, PHASE 0.000, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0, NUM_READ_T" & 
"HREADS 4, NUM_WRITE_THREADS 4, RUSER_BITS_PER_BYTE 0, WUSER_BITS_PER_BYTE 0";
  ATTRIBUTE X_INTERFACE_INFO OF maxigp0_awid: SIGNAL IS "xilinx.com:interface:aximm:1.0 M_AXI_HPM0_FPD AWID";
  ATTRIBUTE X_INTERFACE_PARAMETER OF maxihpm0_fpd_aclk: SIGNAL IS "XIL_INTERFACENAME M_AXI_HPM0_FPD_ACLK, ASSOCIATED_BUSIF M_AXI_HPM0_FPD, FREQ_HZ 99999999, PHASE 0.000, CLK_DOMAIN design_1_zynq_ultra_ps_e_0_0_pl_clk0";
  ATTRIBUTE X_INTERFACE_INFO OF maxihpm0_fpd_aclk: SIGNAL IS "xilinx.com:signal:clock:1.0 M_AXI_HPM0_FPD_ACLK CLK";
BEGIN
  U0 : zynq_ultra_ps_e_v3_2_1_zynq_ultra_ps_e
    GENERIC MAP (
      C_DP_USE_AUDIO => 0,
      C_DP_USE_VIDEO => 0,
      C_MAXIGP0_DATA_WIDTH => 128,
      C_MAXIGP1_DATA_WIDTH => 128,
      C_MAXIGP2_DATA_WIDTH => 32,
      C_SAXIGP0_DATA_WIDTH => 128,
      C_SAXIGP1_DATA_WIDTH => 128,
      C_SAXIGP2_DATA_WIDTH => 128,
      C_SAXIGP3_DATA_WIDTH => 128,
      C_SAXIGP4_DATA_WIDTH => 128,
      C_SAXIGP5_DATA_WIDTH => 128,
      C_SAXIGP6_DATA_WIDTH => 128,
      C_USE_DIFF_RW_CLK_GP0 => 0,
      C_USE_DIFF_RW_CLK_GP1 => 0,
      C_USE_DIFF_RW_CLK_GP2 => 0,
      C_USE_DIFF_RW_CLK_GP3 => 0,
      C_USE_DIFF_RW_CLK_GP4 => 0,
      C_USE_DIFF_RW_CLK_GP5 => 0,
      C_USE_DIFF_RW_CLK_GP6 => 0,
      C_EN_FIFO_ENET0 => "0",
      C_EN_FIFO_ENET1 => "0",
      C_EN_FIFO_ENET2 => "0",
      C_EN_FIFO_ENET3 => "0",
      C_PL_CLK0_BUF => "TRUE",
      C_PL_CLK1_BUF => "FALSE",
      C_PL_CLK2_BUF => "FALSE",
      C_PL_CLK3_BUF => "FALSE",
      C_TRACE_PIPELINE_WIDTH => 8,
      C_EN_EMIO_TRACE => 0,
      C_TRACE_DATA_WIDTH => 32,
      C_USE_DEBUG_TEST => 0,
      C_SD0_INTERNAL_BUS_WIDTH => 4,
      C_SD1_INTERNAL_BUS_WIDTH => 4,
      C_NUM_F2P_0_INTR_INPUTS => 1,
      C_NUM_F2P_1_INTR_INPUTS => 1,
      C_EMIO_GPIO_WIDTH => 1,
      C_NUM_FABRIC_RESETS => 1
    )
    PORT MAP (
      maxihpm0_fpd_aclk => maxihpm0_fpd_aclk,
      maxigp0_awid => maxigp0_awid,
      maxigp0_awaddr => maxigp0_awaddr,
      maxigp0_awlen => maxigp0_awlen,
      maxigp0_awsize => maxigp0_awsize,
      maxigp0_awburst => maxigp0_awburst,
      maxigp0_awlock => maxigp0_awlock,
      maxigp0_awcache => maxigp0_awcache,
      maxigp0_awprot => maxigp0_awprot,
      maxigp0_awvalid => maxigp0_awvalid,
      maxigp0_awuser => maxigp0_awuser,
      maxigp0_awready => maxigp0_awready,
      maxigp0_wdata => maxigp0_wdata,
      maxigp0_wstrb => maxigp0_wstrb,
      maxigp0_wlast => maxigp0_wlast,
      maxigp0_wvalid => maxigp0_wvalid,
      maxigp0_wready => maxigp0_wready,
      maxigp0_bid => maxigp0_bid,
      maxigp0_bresp => maxigp0_bresp,
      maxigp0_bvalid => maxigp0_bvalid,
      maxigp0_bready => maxigp0_bready,
      maxigp0_arid => maxigp0_arid,
      maxigp0_araddr => maxigp0_araddr,
      maxigp0_arlen => maxigp0_arlen,
      maxigp0_arsize => maxigp0_arsize,
      maxigp0_arburst => maxigp0_arburst,
      maxigp0_arlock => maxigp0_arlock,
      maxigp0_arcache => maxigp0_arcache,
      maxigp0_arprot => maxigp0_arprot,
      maxigp0_arvalid => maxigp0_arvalid,
      maxigp0_aruser => maxigp0_aruser,
      maxigp0_arready => maxigp0_arready,
      maxigp0_rid => maxigp0_rid,
      maxigp0_rdata => maxigp0_rdata,
      maxigp0_rresp => maxigp0_rresp,
      maxigp0_rlast => maxigp0_rlast,
      maxigp0_rvalid => maxigp0_rvalid,
      maxigp0_rready => maxigp0_rready,
      maxigp0_awqos => maxigp0_awqos,
      maxigp0_arqos => maxigp0_arqos,
      maxihpm1_fpd_aclk => maxihpm1_fpd_aclk,
      maxigp1_awid => maxigp1_awid,
      maxigp1_awaddr => maxigp1_awaddr,
      maxigp1_awlen => maxigp1_awlen,
      maxigp1_awsize => maxigp1_awsize,
      maxigp1_awburst => maxigp1_awburst,
      maxigp1_awlock => maxigp1_awlock,
      maxigp1_awcache => maxigp1_awcache,
      maxigp1_awprot => maxigp1_awprot,
      maxigp1_awvalid => maxigp1_awvalid,
      maxigp1_awuser => maxigp1_awuser,
      maxigp1_awready => maxigp1_awready,
      maxigp1_wdata => maxigp1_wdata,
      maxigp1_wstrb => maxigp1_wstrb,
      maxigp1_wlast => maxigp1_wlast,
      maxigp1_wvalid => maxigp1_wvalid,
      maxigp1_wready => maxigp1_wready,
      maxigp1_bid => maxigp1_bid,
      maxigp1_bresp => maxigp1_bresp,
      maxigp1_bvalid => maxigp1_bvalid,
      maxigp1_bready => maxigp1_bready,
      maxigp1_arid => maxigp1_arid,
      maxigp1_araddr => maxigp1_araddr,
      maxigp1_arlen => maxigp1_arlen,
      maxigp1_arsize => maxigp1_arsize,
      maxigp1_arburst => maxigp1_arburst,
      maxigp1_arlock => maxigp1_arlock,
      maxigp1_arcache => maxigp1_arcache,
      maxigp1_arprot => maxigp1_arprot,
      maxigp1_arvalid => maxigp1_arvalid,
      maxigp1_aruser => maxigp1_aruser,
      maxigp1_arready => maxigp1_arready,
      maxigp1_rid => maxigp1_rid,
      maxigp1_rdata => maxigp1_rdata,
      maxigp1_rresp => maxigp1_rresp,
      maxigp1_rlast => maxigp1_rlast,
      maxigp1_rvalid => maxigp1_rvalid,
      maxigp1_rready => maxigp1_rready,
      maxigp1_awqos => maxigp1_awqos,
      maxigp1_arqos => maxigp1_arqos,
      maxihpm0_lpd_aclk => '0',
      maxigp2_awready => '0',
      maxigp2_wready => '0',
      maxigp2_bid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      maxigp2_bresp => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      maxigp2_bvalid => '0',
      maxigp2_arready => '0',
      maxigp2_rid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      maxigp2_rdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      maxigp2_rresp => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      maxigp2_rlast => '0',
      maxigp2_rvalid => '0',
      saxihpc0_fpd_rclk => '0',
      saxihpc0_fpd_wclk => '0',
      saxihpc0_fpd_aclk => '0',
      saxigp0_aruser => '0',
      saxigp0_awuser => '0',
      saxigp0_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp0_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp0_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp0_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp0_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp0_awlock => '0',
      saxigp0_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp0_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp0_awvalid => '0',
      saxigp0_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp0_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp0_wlast => '0',
      saxigp0_wvalid => '0',
      ddrc_ext_refresh_rank0_req => '0',
      ddrc_ext_refresh_rank1_req => '0',
      ddrc_refresh_pl_clk => '0',
      saxigp0_bready => '0',
      saxigp0_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp0_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp0_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp0_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp0_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp0_arlock => '0',
      saxigp0_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp0_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp0_arvalid => '0',
      saxigp0_rready => '0',
      saxigp0_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp0_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxihpc1_fpd_rclk => '0',
      saxihpc1_fpd_wclk => '0',
      saxihpc1_fpd_aclk => '0',
      saxigp1_aruser => '0',
      saxigp1_awuser => '0',
      saxigp1_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp1_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp1_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp1_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp1_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp1_awlock => '0',
      saxigp1_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp1_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp1_awvalid => '0',
      saxigp1_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp1_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp1_wlast => '0',
      saxigp1_wvalid => '0',
      saxigp1_bready => '0',
      saxigp1_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp1_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp1_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp1_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp1_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp1_arlock => '0',
      saxigp1_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp1_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp1_arvalid => '0',
      saxigp1_rready => '0',
      saxigp1_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp1_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxihp0_fpd_rclk => '0',
      saxihp0_fpd_wclk => '0',
      saxihp0_fpd_aclk => '0',
      saxigp2_aruser => '0',
      saxigp2_awuser => '0',
      saxigp2_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp2_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp2_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp2_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp2_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp2_awlock => '0',
      saxigp2_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp2_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp2_awvalid => '0',
      saxigp2_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp2_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp2_wlast => '0',
      saxigp2_wvalid => '0',
      saxigp2_bready => '0',
      saxigp2_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp2_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp2_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp2_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp2_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp2_arlock => '0',
      saxigp2_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp2_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp2_arvalid => '0',
      saxigp2_rready => '0',
      saxigp2_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp2_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxihp1_fpd_rclk => '0',
      saxihp1_fpd_wclk => '0',
      saxihp1_fpd_aclk => '0',
      saxigp3_aruser => '0',
      saxigp3_awuser => '0',
      saxigp3_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp3_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp3_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp3_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp3_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp3_awlock => '0',
      saxigp3_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp3_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp3_awvalid => '0',
      saxigp3_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp3_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp3_wlast => '0',
      saxigp3_wvalid => '0',
      saxigp3_bready => '0',
      saxigp3_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp3_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp3_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp3_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp3_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp3_arlock => '0',
      saxigp3_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp3_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp3_arvalid => '0',
      saxigp3_rready => '0',
      saxigp3_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp3_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxihp2_fpd_rclk => '0',
      saxihp2_fpd_wclk => '0',
      saxihp2_fpd_aclk => '0',
      saxigp4_aruser => '0',
      saxigp4_awuser => '0',
      saxigp4_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp4_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp4_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp4_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp4_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp4_awlock => '0',
      saxigp4_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp4_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp4_awvalid => '0',
      saxigp4_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp4_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp4_wlast => '0',
      saxigp4_wvalid => '0',
      saxigp4_bready => '0',
      saxigp4_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp4_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp4_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp4_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp4_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp4_arlock => '0',
      saxigp4_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp4_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp4_arvalid => '0',
      saxigp4_rready => '0',
      saxigp4_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp4_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxihp3_fpd_rclk => '0',
      saxihp3_fpd_wclk => '0',
      saxihp3_fpd_aclk => '0',
      saxigp5_aruser => '0',
      saxigp5_awuser => '0',
      saxigp5_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp5_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp5_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp5_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp5_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp5_awlock => '0',
      saxigp5_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp5_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp5_awvalid => '0',
      saxigp5_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp5_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp5_wlast => '0',
      saxigp5_wvalid => '0',
      saxigp5_bready => '0',
      saxigp5_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp5_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp5_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp5_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp5_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp5_arlock => '0',
      saxigp5_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp5_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp5_arvalid => '0',
      saxigp5_rready => '0',
      saxigp5_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp5_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxi_lpd_rclk => '0',
      saxi_lpd_wclk => '0',
      saxi_lpd_aclk => '0',
      saxigp6_aruser => '0',
      saxigp6_awuser => '0',
      saxigp6_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp6_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp6_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp6_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp6_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp6_awlock => '0',
      saxigp6_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp6_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp6_awvalid => '0',
      saxigp6_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxigp6_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxigp6_wlast => '0',
      saxigp6_wvalid => '0',
      saxigp6_bready => '0',
      saxigp6_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      saxigp6_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 49)),
      saxigp6_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxigp6_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp6_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxigp6_arlock => '0',
      saxigp6_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp6_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxigp6_arvalid => '0',
      saxigp6_rready => '0',
      saxigp6_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxigp6_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxiacp_fpd_aclk => '0',
      saxiacp_awuser => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxiacp_aruser => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxiacp_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 5)),
      saxiacp_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 40)),
      saxiacp_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxiacp_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxiacp_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxiacp_awlock => '0',
      saxiacp_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxiacp_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxiacp_awvalid => '0',
      saxiacp_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      saxiacp_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      saxiacp_wlast => '0',
      saxiacp_wvalid => '0',
      saxiacp_bready => '0',
      saxiacp_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 5)),
      saxiacp_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 40)),
      saxiacp_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      saxiacp_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxiacp_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      saxiacp_arlock => '0',
      saxiacp_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxiacp_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      saxiacp_arvalid => '0',
      saxiacp_rready => '0',
      saxiacp_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      saxiacp_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_aclk => '0',
      sacefpd_wuser => '0',
      sacefpd_awuser => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      sacefpd_awsnoop => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      sacefpd_awsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      sacefpd_awregion => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_awqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_awprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      sacefpd_awlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      sacefpd_awid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      sacefpd_awdomain => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      sacefpd_awcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_awburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      sacefpd_awbar => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      sacefpd_awaddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 44)),
      sacefpd_awlock => '0',
      sacefpd_awvalid => '0',
      sacefpd_wstrb => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      sacefpd_wdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      sacefpd_wlast => '0',
      sacefpd_wvalid => '0',
      sacefpd_bready => '0',
      sacefpd_aruser => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      sacefpd_arsnoop => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_arsize => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      sacefpd_arregion => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_arqos => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_arprot => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      sacefpd_arlen => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      sacefpd_arid => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      sacefpd_ardomain => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      sacefpd_arcache => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      sacefpd_arburst => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      sacefpd_arbar => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      sacefpd_araddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 44)),
      sacefpd_arlock => '0',
      sacefpd_arvalid => '0',
      sacefpd_rready => '0',
      sacefpd_acready => '0',
      sacefpd_cddata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 128)),
      sacefpd_cdlast => '0',
      sacefpd_cdvalid => '0',
      sacefpd_crresp => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 5)),
      sacefpd_crvalid => '0',
      sacefpd_wack => '0',
      sacefpd_rack => '0',
      emio_can0_phy_rx => '0',
      emio_can1_phy_rx => '0',
      emio_enet0_gmii_rx_clk => '0',
      emio_enet0_gmii_crs => '0',
      emio_enet0_gmii_col => '0',
      emio_enet0_gmii_rxd => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet0_gmii_rx_er => '0',
      emio_enet0_gmii_rx_dv => '0',
      emio_enet0_gmii_tx_clk => '0',
      emio_enet0_mdio_i => '0',
      emio_enet1_gmii_rx_clk => '0',
      emio_enet1_gmii_crs => '0',
      emio_enet1_gmii_col => '0',
      emio_enet1_gmii_rxd => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet1_gmii_rx_er => '0',
      emio_enet1_gmii_rx_dv => '0',
      emio_enet1_gmii_tx_clk => '0',
      emio_enet1_mdio_i => '0',
      emio_enet2_gmii_rx_clk => '0',
      emio_enet2_gmii_crs => '0',
      emio_enet2_gmii_col => '0',
      emio_enet2_gmii_rxd => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet2_gmii_rx_er => '0',
      emio_enet2_gmii_rx_dv => '0',
      emio_enet2_gmii_tx_clk => '0',
      emio_enet2_mdio_i => '0',
      emio_enet3_gmii_rx_clk => '0',
      emio_enet3_gmii_crs => '0',
      emio_enet3_gmii_col => '0',
      emio_enet3_gmii_rxd => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet3_gmii_rx_er => '0',
      emio_enet3_gmii_rx_dv => '0',
      emio_enet3_gmii_tx_clk => '0',
      emio_enet3_mdio_i => '0',
      emio_enet0_tx_r_data_rdy => '0',
      emio_enet0_tx_r_valid => '0',
      emio_enet0_tx_r_data => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet0_tx_r_sop => '1',
      emio_enet0_tx_r_eop => '1',
      emio_enet0_tx_r_err => '0',
      emio_enet0_tx_r_underflow => '0',
      emio_enet0_tx_r_flushed => '0',
      emio_enet0_tx_r_control => '0',
      emio_enet0_dma_tx_status_tog => '0',
      emio_enet0_rx_w_overflow => '0',
      emio_enet1_tx_r_data_rdy => '0',
      emio_enet1_tx_r_valid => '0',
      emio_enet1_tx_r_data => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet1_tx_r_sop => '1',
      emio_enet1_tx_r_eop => '1',
      emio_enet1_tx_r_err => '0',
      emio_enet1_tx_r_underflow => '0',
      emio_enet1_tx_r_flushed => '0',
      emio_enet1_tx_r_control => '0',
      emio_enet1_dma_tx_status_tog => '0',
      emio_enet1_rx_w_overflow => '0',
      emio_enet2_tx_r_data_rdy => '0',
      emio_enet2_tx_r_valid => '0',
      emio_enet2_tx_r_data => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet2_tx_r_sop => '1',
      emio_enet2_tx_r_eop => '1',
      emio_enet2_tx_r_err => '0',
      emio_enet2_tx_r_underflow => '0',
      emio_enet2_tx_r_flushed => '0',
      emio_enet2_tx_r_control => '0',
      emio_enet2_dma_tx_status_tog => '0',
      emio_enet2_rx_w_overflow => '0',
      emio_enet3_tx_r_data_rdy => '0',
      emio_enet3_tx_r_valid => '0',
      emio_enet3_tx_r_data => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      emio_enet3_tx_r_sop => '1',
      emio_enet3_tx_r_eop => '1',
      emio_enet3_tx_r_err => '0',
      emio_enet3_tx_r_underflow => '0',
      emio_enet3_tx_r_flushed => '0',
      emio_enet3_tx_r_control => '0',
      emio_enet3_dma_tx_status_tog => '0',
      emio_enet3_rx_w_overflow => '0',
      emio_enet0_tsu_inc_ctrl => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      emio_enet1_tsu_inc_ctrl => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      emio_enet2_tsu_inc_ctrl => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      emio_enet3_tsu_inc_ctrl => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      fmio_gem_tsu_clk_from_pl => '0',
      emio_enet_tsu_clk => '0',
      emio_enet0_ext_int_in => '0',
      emio_enet1_ext_int_in => '0',
      emio_enet2_ext_int_in => '0',
      emio_enet3_ext_int_in => '0',
      emio_gpio_i => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      emio_i2c0_scl_i => '0',
      emio_i2c0_sda_i => '0',
      emio_i2c1_scl_i => '0',
      emio_i2c1_sda_i => '0',
      emio_uart0_rxd => '0',
      emio_uart0_ctsn => '0',
      emio_uart0_dsrn => '0',
      emio_uart0_dcdn => '0',
      emio_uart0_rin => '0',
      emio_uart1_rxd => '0',
      emio_uart1_ctsn => '0',
      emio_uart1_dsrn => '0',
      emio_uart1_dcdn => '0',
      emio_uart1_rin => '0',
      emio_sdio0_fb_clk_in => '0',
      emio_sdio0_cmdin => '0',
      emio_sdio0_datain => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      emio_sdio0_cd_n => '0',
      emio_sdio0_wp => '1',
      emio_sdio1_fb_clk_in => '0',
      emio_sdio1_cmdin => '0',
      emio_sdio1_datain => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      emio_sdio1_cd_n => '0',
      emio_sdio1_wp => '1',
      emio_spi0_sclk_i => '0',
      emio_spi0_m_i => '0',
      emio_spi0_s_i => '0',
      emio_spi0_ss_i_n => '1',
      emio_spi1_sclk_i => '0',
      emio_spi1_m_i => '0',
      emio_spi1_s_i => '0',
      emio_spi1_ss_i_n => '1',
      pl_ps_trace_clk => '0',
      emio_ttc0_clk_i => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      emio_ttc1_clk_i => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      emio_ttc2_clk_i => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      emio_ttc3_clk_i => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      emio_wdt0_clk_i => '0',
      emio_wdt1_clk_i => '0',
      emio_hub_port_overcrnt_usb3_0 => '0',
      emio_hub_port_overcrnt_usb3_1 => '0',
      emio_hub_port_overcrnt_usb2_0 => '0',
      emio_hub_port_overcrnt_usb2_1 => '0',
      adma_fci_clk => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      pl2adma_cvld => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      pl2adma_tack => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      perif_gdma_clk => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      perif_gdma_cvld => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      perif_gdma_tack => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      pl_clock_stop => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      pll_aux_refclk_lpd => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      pll_aux_refclk_fpd => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      dp_s_axis_audio_tdata => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      dp_s_axis_audio_tid => '0',
      dp_s_axis_audio_tvalid => '0',
      dp_m_axis_mixed_audio_tready => '0',
      dp_s_axis_audio_clk => '0',
      dp_live_video_in_vsync => '0',
      dp_live_video_in_hsync => '0',
      dp_live_video_in_de => '0',
      dp_live_video_in_pixel1 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 36)),
      dp_video_in_clk => '0',
      dp_aux_data_in => '0',
      dp_live_gfx_alpha_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      dp_live_gfx_pixel1_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 36)),
      dp_hot_plug_detect => '0',
      dp_external_custom_event1 => '0',
      dp_external_custom_event2 => '0',
      dp_external_vsync_event => '0',
      pl_ps_eventi => '0',
      pl_ps_apugic_irq => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      pl_ps_apugic_fiq => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      rpu_eventi0 => '0',
      rpu_eventi1 => '0',
      nfiq0_lpd_rpu => '1',
      nfiq1_lpd_rpu => '1',
      nirq0_lpd_rpu => '1',
      nirq1_lpd_rpu => '1',
      stm_event => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 60)),
      pl_ps_trigger_0 => '0',
      pl_ps_trigger_1 => '0',
      pl_ps_trigger_2 => '0',
      pl_ps_trigger_3 => '0',
      pl_ps_trigack_0 => '0',
      pl_ps_trigack_1 => '0',
      pl_ps_trigack_2 => '0',
      pl_ps_trigack_3 => '0',
      ftm_gpi => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      pl_ps_irq0 => pl_ps_irq0,
      pl_ps_irq1 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 1)),
      pl_resetn0 => pl_resetn0,
      pl_pmu_gpi => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      aib_pmu_afifm_fpd_ack => '0',
      aib_pmu_afifm_lpd_ack => '0',
      pmu_error_from_pl => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      pl_acpinact => '0',
      pl_clk0 => pl_clk0,
      test_adc_clk => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      test_adc_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      test_adc2_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      test_dclk => '0',
      test_den => '0',
      test_dwe => '0',
      test_daddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      test_di => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      test_convst => '0',
      pstp_pl_clk => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      pstp_pl_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      pstp_pl_ts => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      fmio_test_gem_scanmux_1 => '0',
      fmio_test_gem_scanmux_2 => '0',
      test_char_mode_fpd_n => '0',
      test_char_mode_lpd_n => '0',
      fmio_test_io_char_scan_clock => '0',
      fmio_test_io_char_scanenable => '0',
      fmio_test_io_char_scan_in => '0',
      fmio_test_io_char_scan_reset_n => '0',
      fmio_char_afifslpd_test_select_n => '0',
      fmio_char_afifslpd_test_input => '0',
      fmio_char_afifsfpd_test_select_n => '0',
      fmio_char_afifsfpd_test_input => '0',
      io_char_audio_in_test_data => '0',
      io_char_audio_mux_sel_n => '0',
      io_char_video_in_test_data => '0',
      io_char_video_mux_sel_n => '0',
      fmio_test_qspi_scanmux_1_n => '0',
      fmio_test_sdio_scanmux_1 => '0',
      fmio_test_sdio_scanmux_2 => '0',
      fmio_sd0_dll_test_in_n => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      fmio_sd1_dll_test_in_n => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      test_pl_scan_chopper_si => '0',
      test_pl_scan_chopper_trig => '0',
      test_pl_scan_clk0 => '0',
      test_pl_scan_clk1 => '0',
      test_pl_scan_edt_clk => '0',
      test_pl_scan_edt_in_apu => '0',
      test_pl_scan_edt_in_cpu => '0',
      test_pl_scan_edt_in_ddr => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      test_pl_scan_edt_in_fp => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 10)),
      test_pl_scan_edt_in_gpu => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      test_pl_scan_edt_in_lp => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 9)),
      test_pl_scan_edt_in_usb3 => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      test_pl_scan_edt_update => '0',
      test_pl_scan_reset_n => '0',
      test_pl_scanenable => '0',
      test_pl_scan_pll_reset => '0',
      test_pl_scan_spare_in0 => '0',
      test_pl_scan_spare_in1 => '0',
      test_pl_scan_wrap_clk => '0',
      test_pl_scan_wrap_ishift => '0',
      test_pl_scan_wrap_oshift => '0',
      test_pl_scan_slcr_config_clk => '0',
      test_pl_scan_slcr_config_rstn => '0',
      test_pl_scan_slcr_config_si => '0',
      test_pl_scan_spare_in2 => '0',
      test_pl_scanenable_slcr_en => '0',
      tst_rtc_calibreg_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 21)),
      tst_rtc_calibreg_we => '0',
      tst_rtc_clk => '0',
      tst_rtc_testclock_select_n => '0',
      tst_rtc_timesetreg_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 32)),
      tst_rtc_disable_bat_op => '0',
      tst_rtc_osc_cntrl_in => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      tst_rtc_osc_cntrl_we => '0',
      tst_rtc_sec_reload => '0',
      tst_rtc_timesetreg_we => '0',
      tst_rtc_testmode_n => '0',
      test_usb0_funcmux_0_n => '0',
      test_usb1_funcmux_0_n => '0',
      test_usb0_scanmux_0_n => '0',
      test_usb1_scanmux_0_n => '0',
      pl_lpd_pll_test_ck_sel_n => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      pl_lpd_pll_test_fract_clk_sel_n => '0',
      pl_lpd_pll_test_fract_en_n => '0',
      pl_lpd_pll_test_mux_sel => '0',
      pl_lpd_pll_test_sel => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      pl_fpd_pll_test_ck_sel_n => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      pl_fpd_pll_test_fract_clk_sel_n => '0',
      pl_fpd_pll_test_fract_en_n => '0',
      pl_fpd_pll_test_mux_sel => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      pl_fpd_pll_test_sel => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 4)),
      fmio_char_gem_selection => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      fmio_char_gem_test_select_n => '0',
      fmio_char_gem_test_input => '0',
      test_pl2ddr_dcd_sample_pulse => '0',
      test_bscan_en_n => '0',
      test_bscan_tdi => '0',
      test_bscan_updatedr => '0',
      test_bscan_shiftdr => '0',
      test_bscan_reset_tap_b => '0',
      test_bscan_misr_jtag_load => '0',
      test_bscan_intest => '0',
      test_bscan_extest => '0',
      test_bscan_clockdr => '0',
      test_bscan_ac_mode => '0',
      test_bscan_ac_test => '0',
      test_bscan_init_memory => '0',
      test_bscan_mode_c => '0',
      i_dbg_l0_txclk => '0',
      i_dbg_l0_rxclk => '0',
      i_dbg_l1_txclk => '0',
      i_dbg_l1_rxclk => '0',
      i_dbg_l2_txclk => '0',
      i_dbg_l2_rxclk => '0',
      i_dbg_l3_txclk => '0',
      i_dbg_l3_rxclk => '0',
      i_afe_rx_symbol_clk_by_2_pl => '0',
      pl_fpd_spare_0_in => '0',
      pl_fpd_spare_1_in => '0',
      pl_fpd_spare_2_in => '0',
      pl_fpd_spare_3_in => '0',
      pl_fpd_spare_4_in => '0',
      pl_lpd_spare_0_in => '0',
      pl_lpd_spare_1_in => '0',
      pl_lpd_spare_2_in => '0',
      pl_lpd_spare_3_in => '0',
      pl_lpd_spare_4_in => '0',
      i_afe_pll_pd_hs_clock_r => '0',
      i_afe_mode => '0',
      i_bgcal_afe_mode => '0',
      i_afe_cmn_bg_enable_low_leakage => '0',
      i_afe_cmn_bg_iso_ctrl_bar => '0',
      i_afe_cmn_bg_pd => '0',
      i_afe_cmn_bg_pd_bg_ok => '0',
      i_afe_cmn_bg_pd_ptat => '0',
      i_afe_cmn_calib_en_iconst => '0',
      i_afe_cmn_calib_enable_low_leakage => '0',
      i_afe_cmn_calib_iso_ctrl_bar => '0',
      i_afe_rx_rxpma_rstb => '0',
      i_afe_rx_uphy_restore_calcode_data => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      i_afe_rx_pipe_rxeqtraining => '0',
      i_afe_rx_iso_hsrx_ctrl_bar => '0',
      i_afe_rx_iso_lfps_ctrl_bar => '0',
      i_afe_rx_iso_sigdet_ctrl_bar => '0',
      i_afe_rx_hsrx_clock_stop_req => '0',
      i_pll_afe_mode => '0',
      i_afe_pll_coarse_code => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 11)),
      i_afe_pll_en_clock_hs_div2 => '0',
      i_afe_pll_fbdiv => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 16)),
      i_afe_pll_load_fbdiv => '0',
      i_afe_pll_pd => '0',
      i_afe_pll_pd_pfd => '0',
      i_afe_pll_rst_fdbk_div => '0',
      i_afe_pll_startloop => '0',
      i_afe_pll_v2i_code => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 6)),
      i_afe_pll_v2i_prog => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 5)),
      i_afe_pll_vco_cnt_window => '0',
      i_afe_rx_mphy_gate_symbol_clk => '0',
      i_afe_rx_mphy_mux_hsb_ls => '0',
      i_afe_rx_pipe_rx_term_enable => '0',
      i_afe_rx_uphy_biasgen_iconst_core_mirror_enable => '0',
      i_afe_rx_uphy_biasgen_iconst_io_mirror_enable => '0',
      i_afe_rx_uphy_biasgen_irconst_core_mirror_enable => '0',
      i_afe_rx_uphy_enable_cdr => '0',
      i_afe_rx_uphy_enable_low_leakage => '0',
      i_afe_rx_rxpma_refclk_dig => '0',
      i_afe_rx_uphy_hsrx_rstb => '0',
      i_afe_rx_uphy_pdn_hs_des => '0',
      i_afe_rx_uphy_pd_samp_c2c => '0',
      i_afe_rx_uphy_pd_samp_c2c_eclk => '0',
      i_afe_rx_uphy_pso_clk_lane => '0',
      i_afe_rx_uphy_pso_eq => '0',
      i_afe_rx_uphy_pso_hsrxdig => '0',
      i_afe_rx_uphy_pso_iqpi => '0',
      i_afe_rx_uphy_pso_lfpsbcn => '0',
      i_afe_rx_uphy_pso_samp_flops => '0',
      i_afe_rx_uphy_pso_sigdet => '0',
      i_afe_rx_uphy_restore_calcode => '0',
      i_afe_rx_uphy_run_calib => '0',
      i_afe_rx_uphy_rx_lane_polarity_swap => '0',
      i_afe_rx_uphy_startloop_pll => '0',
      i_afe_rx_uphy_hsclk_division_factor => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      i_afe_rx_uphy_rx_pma_opmode => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      i_afe_tx_enable_hsclk_division => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      i_afe_tx_enable_ldo => '0',
      i_afe_tx_enable_ref => '0',
      i_afe_tx_enable_supply_hsclk => '0',
      i_afe_tx_enable_supply_pipe => '0',
      i_afe_tx_enable_supply_serializer => '0',
      i_afe_tx_enable_supply_uphy => '0',
      i_afe_tx_hs_ser_rstb => '0',
      i_afe_tx_hs_symbol => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 20)),
      i_afe_tx_mphy_tx_ls_data => '0',
      i_afe_tx_pipe_tx_enable_idle_mode => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      i_afe_tx_pipe_tx_enable_lfps => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      i_afe_tx_pipe_tx_enable_rxdet => '0',
      i_afe_TX_uphy_txpma_opmode => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 8)),
      i_afe_TX_pmadig_digital_reset_n => '0',
      i_afe_TX_serializer_rst_rel => '0',
      i_afe_TX_pll_symb_clk_2 => '0',
      i_afe_TX_ana_if_rate => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 2)),
      i_afe_TX_en_dig_sublp_mode => '0',
      i_afe_TX_LPBK_SEL => STD_LOGIC_VECTOR(TO_UNSIGNED(0, 3)),
      i_afe_TX_iso_ctrl_bar => '0',
      i_afe_TX_ser_iso_ctrl_bar => '0',
      i_afe_TX_lfps_clk => '0',
      i_afe_TX_serializer_rstb => '0',
      i_afe_tx_pipe_tx_fast_est_common_mode => '0'
    );
END design_1_zynq_ultra_ps_e_0_0_arch;
