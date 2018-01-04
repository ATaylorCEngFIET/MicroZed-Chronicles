
################################################################
# This is a generated script based on design: zed_tpg
#
# Though there are limitations about the generated script,
# the main purpose of this utility is to make learning
# IP Integrator Tcl commands easier.
################################################################

################################################################
# Check if script is running in correct Vivado version.
################################################################
set scripts_vivado_version 2015.4
set current_vivado_version [version -short]

if { [string first $scripts_vivado_version $current_vivado_version] == -1 } {
   puts ""
   puts "ERROR: This script was generated using Vivado <$scripts_vivado_version> and is being run in <$current_vivado_version> of Vivado. Please run the script in Vivado <$scripts_vivado_version> then open the design in Vivado <$current_vivado_version>. Upgrade the design by running \"Tools => Report => Report IP Status...\", then run write_bd_tcl to create an updated script."

   return 1
}

################################################################
# START
################################################################

# To test this script, run the following commands from Vivado Tcl console:
# source zed_tpg_script.tcl

# If you do not already have a project created,
# you can create a project using the following command:
#    create_project project_1 myproj -part xc7z020clg484-1
#    set_property BOARD_PART em.avnet.com:zed:part0:1.3 [current_project]

# CHECKING IF PROJECT EXISTS
if { [get_projects -quiet] eq "" } {
   puts "ERROR: Please open or create a project!"
   return 1
}



# CHANGE DESIGN NAME HERE
set design_name zed_tpg

# If you do not already have an existing IP Integrator design open,
# you can create a design using the following command:
#    create_bd_design $design_name

# Creating design if needed
set errMsg ""
set nRet 0

set cur_design [current_bd_design -quiet]
set list_cells [get_bd_cells -quiet]

if { ${design_name} eq "" } {
   # USE CASES:
   #    1) Design_name not set

   set errMsg "ERROR: Please set the variable <design_name> to a non-empty value."
   set nRet 1

} elseif { ${cur_design} ne "" && ${list_cells} eq "" } {
   # USE CASES:
   #    2): Current design opened AND is empty AND names same.
   #    3): Current design opened AND is empty AND names diff; design_name NOT in project.
   #    4): Current design opened AND is empty AND names diff; design_name exists in project.

   if { $cur_design ne $design_name } {
      puts "INFO: Changing value of <design_name> from <$design_name> to <$cur_design> since current design is empty."
      set design_name [get_property NAME $cur_design]
   }
   puts "INFO: Constructing design in IPI design <$cur_design>..."

} elseif { ${cur_design} ne "" && $list_cells ne "" && $cur_design eq $design_name } {
   # USE CASES:
   #    5) Current design opened AND has components AND same names.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 1
} elseif { [get_files -quiet ${design_name}.bd] ne "" } {
   # USE CASES: 
   #    6) Current opened design, has components, but diff names, design_name exists in project.
   #    7) No opened design, design_name exists in project.

   set errMsg "ERROR: Design <$design_name> already exists in your project, please set the variable <design_name> to another value."
   set nRet 2

} else {
   # USE CASES:
   #    8) No opened design, design_name not in project.
   #    9) Current opened design, has components, but diff names, design_name not in project.

   puts "INFO: Currently there is no design <$design_name> in project, so creating one..."

   create_bd_design $design_name

   puts "INFO: Making design <$design_name> as current_bd_design."
   current_bd_design $design_name

}

puts "INFO: Currently the variable <design_name> is equal to \"$design_name\"."

if { $nRet != 0 } {
   puts $errMsg
   return $nRet
}

##################################################################
# DESIGN PROCs
##################################################################



# Procedure to create entire design; Provide argument to make
# procedure reusable. If parentCell is "", will use root.
proc create_root_design { parentCell } {

  if { $parentCell eq "" } {
     set parentCell [get_bd_cells /]
  }

  # Get object for parentCell
  set parentObj [get_bd_cells $parentCell]
  if { $parentObj == "" } {
     puts "ERROR: Unable to find parent cell <$parentCell>!"
     return
  }

  # Make sure parentObj is hier blk
  set parentType [get_property TYPE $parentObj]
  if { $parentType ne "hier" } {
     puts "ERROR: Parent <$parentObj> has TYPE = <$parentType>. Expected to be <hier>."
     return
  }

  # Save current instance; Restore later
  set oldCurInst [current_bd_instance .]

  # Set parent object as current
  current_bd_instance $parentObj


  # Create interface ports
  set DDR [ create_bd_intf_port -mode Master -vlnv xilinx.com:interface:ddrx_rtl:1.0 DDR ]
  set FIXED_IO [ create_bd_intf_port -mode Master -vlnv xilinx.com:display_processing_system7:fixedio_rtl:1.0 FIXED_IO ]

  # Create ports
  set Blue [ create_bd_port -dir O -from 3 -to 0 Blue ]
  set CLK100 [ create_bd_port -dir I -type clk CLK100 ]
  set Green [ create_bd_port -dir O -from 3 -to 0 Green ]
  set Red [ create_bd_port -dir O -from 3 -to 0 Red ]
  set vid_hsync [ create_bd_port -dir O vid_hsync ]
  set vid_vsync [ create_bd_port -dir O vid_vsync ]

  # Create instance: axi_interconnect_0, and set properties
  set axi_interconnect_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_0 ]
  set_property -dict [ list \
CONFIG.NUM_MI {2} \
 ] $axi_interconnect_0

  # Create instance: axi_interconnect_1, and set properties
  set axi_interconnect_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_interconnect:2.1 axi_interconnect_1 ]
  set_property -dict [ list \
CONFIG.NUM_MI {1} \
CONFIG.NUM_SI {2} \
 ] $axi_interconnect_1

  # Create instance: axi_vdma_0, and set properties
  set axi_vdma_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:axi_vdma:6.2 axi_vdma_0 ]
  set_property -dict [ list \
CONFIG.c_include_mm2s_dre {1} \
CONFIG.c_include_s2mm_dre {1} \
CONFIG.c_m_axi_mm2s_data_width {32} \
CONFIG.c_m_axis_mm2s_tdata_width {24} \
CONFIG.c_mm2s_max_burst_length {16} \
CONFIG.c_use_mm2s_fsync {0} \
 ] $axi_vdma_0

  # Create instance: ila_0, and set properties
  set ila_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_0 ]
  set_property -dict [ list \
CONFIG.C_ENABLE_ILA_AXI_MON {false} \
CONFIG.C_MONITOR_TYPE {Native} \
CONFIG.C_NUM_OF_PROBES {5} \
 ] $ila_0

  # Create instance: ila_1, and set properties
  set ila_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_1 ]
  set_property -dict [ list \
CONFIG.C_ENABLE_ILA_AXI_MON {false} \
CONFIG.C_MONITOR_TYPE {Native} \
CONFIG.C_NUM_OF_PROBES {6} \
 ] $ila_1

  # Create instance: ila_2, and set properties
  set ila_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_2 ]
  set_property -dict [ list \
CONFIG.C_NUM_OF_PROBES {9} \
CONFIG.C_SLOT_0_AXI_PROTOCOL {AXI4S} \
 ] $ila_2

  # Create instance: ila_3, and set properties
  set ila_3 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_3 ]
  set_property -dict [ list \
CONFIG.C_ENABLE_ILA_AXI_MON {false} \
CONFIG.C_MONITOR_TYPE {Native} \
CONFIG.C_NUM_OF_PROBES {1} \
CONFIG.C_PROBE0_WIDTH {32} \
 ] $ila_3

  # Create instance: ila_4, and set properties
  set ila_4 [ create_bd_cell -type ip -vlnv xilinx.com:ip:ila:6.0 ila_4 ]
  set_property -dict [ list \
CONFIG.C_NUM_OF_PROBES {9} \
CONFIG.C_SLOT_0_AXI_PROTOCOL {AXI4S} \
 ] $ila_4

  # Create instance: proc_sys_reset_0, and set properties
  set proc_sys_reset_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:proc_sys_reset:5.0 proc_sys_reset_0 ]

  # Create instance: processing_system7_0, and set properties
  set processing_system7_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:processing_system7:5.5 processing_system7_0 ]
  set_property -dict [ list \
CONFIG.PCW_EN_CLK1_PORT {1} \
CONFIG.PCW_EN_RST1_PORT {1} \
CONFIG.PCW_FPGA0_PERIPHERAL_FREQMHZ {100} \
CONFIG.PCW_FPGA1_PERIPHERAL_FREQMHZ {40} \
CONFIG.PCW_QSPI_GRP_SINGLE_SS_ENABLE {1} \
CONFIG.PCW_USE_S_AXI_HP0 {1} \
CONFIG.preset {ZedBoard} \
 ] $processing_system7_0

  # Create instance: util_vector_logic_0, and set properties
  set util_vector_logic_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:util_vector_logic:2.0 util_vector_logic_0 ]
  set_property -dict [ list \
CONFIG.C_OPERATION {not} \
CONFIG.C_SIZE {1} \
 ] $util_vector_logic_0

  # Create instance: v_axi4s_vid_out_0, and set properties
  set v_axi4s_vid_out_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_axi4s_vid_out:4.0 v_axi4s_vid_out_0 ]
  set_property -dict [ list \
CONFIG.C_VTG_MASTER_SLAVE {0} \
 ] $v_axi4s_vid_out_0

  # Create instance: v_tc_0, and set properties
  set v_tc_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tc:6.1 v_tc_0 ]
  set_property -dict [ list \
CONFIG.GEN_F0_VBLANK_HEND {800} \
CONFIG.GEN_F0_VBLANK_HSTART {800} \
CONFIG.GEN_F0_VFRAME_SIZE {628} \
CONFIG.GEN_F0_VSYNC_HEND {800} \
CONFIG.GEN_F0_VSYNC_HSTART {800} \
CONFIG.GEN_F0_VSYNC_VEND {604} \
CONFIG.GEN_F0_VSYNC_VSTART {600} \
CONFIG.GEN_F1_VBLANK_HEND {800} \
CONFIG.GEN_F1_VBLANK_HSTART {800} \
CONFIG.GEN_F1_VFRAME_SIZE {628} \
CONFIG.GEN_F1_VSYNC_HEND {800} \
CONFIG.GEN_F1_VSYNC_HSTART {800} \
CONFIG.GEN_F1_VSYNC_VEND {604} \
CONFIG.GEN_F1_VSYNC_VSTART {600} \
CONFIG.GEN_HACTIVE_SIZE {800} \
CONFIG.GEN_HFRAME_SIZE {1056} \
CONFIG.GEN_HSYNC_END {968} \
CONFIG.GEN_HSYNC_START {840} \
CONFIG.GEN_VACTIVE_SIZE {600} \
CONFIG.HAS_AXI4_LITE {false} \
CONFIG.VIDEO_MODE {800x600p} \
CONFIG.enable_detection {false} \
CONFIG.max_clocks_per_line {4096} \
CONFIG.max_lines_per_frame {4096} \
 ] $v_tc_0

  # Create instance: v_tpg_0, and set properties
  set v_tpg_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:v_tpg:7.0 v_tpg_0 ]
  set_property -dict [ list \
CONFIG.HAS_AXI4S_SLAVE {0} \
CONFIG.MAX_COLS {800} \
CONFIG.MAX_DATA_WIDTH {8} \
CONFIG.MAX_ROWS {600} \
 ] $v_tpg_0

  # Create instance: xlconstant_0, and set properties
  set xlconstant_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_0 ]

  # Create instance: xlconstant_1, and set properties
  set xlconstant_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlconstant:1.1 xlconstant_1 ]
  set_property -dict [ list \
CONFIG.CONST_VAL {0} \
 ] $xlconstant_1

  # Create instance: xlslice_0, and set properties
  set xlslice_0 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_0 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {3} \
CONFIG.DIN_TO {0} \
CONFIG.DIN_WIDTH {24} \
CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_0

  # Create instance: xlslice_1, and set properties
  set xlslice_1 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_1 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {11} \
CONFIG.DIN_TO {8} \
CONFIG.DIN_WIDTH {24} \
CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_1

  # Create instance: xlslice_2, and set properties
  set xlslice_2 [ create_bd_cell -type ip -vlnv xilinx.com:ip:xlslice:1.0 xlslice_2 ]
  set_property -dict [ list \
CONFIG.DIN_FROM {19} \
CONFIG.DIN_TO {16} \
CONFIG.DIN_WIDTH {24} \
CONFIG.DOUT_WIDTH {4} \
 ] $xlslice_2

  # Create interface connections
  connect_bd_intf_net -intf_net axi_interconnect_0_M00_AXI [get_bd_intf_pins axi_interconnect_0/M00_AXI] [get_bd_intf_pins v_tpg_0/s_axi_CTRL]
  connect_bd_intf_net -intf_net axi_interconnect_0_M01_AXI [get_bd_intf_pins axi_interconnect_0/M01_AXI] [get_bd_intf_pins axi_vdma_0/S_AXI_LITE]
  connect_bd_intf_net -intf_net axi_interconnect_1_M00_AXI [get_bd_intf_pins axi_interconnect_1/M00_AXI] [get_bd_intf_pins processing_system7_0/S_AXI_HP0]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXIS_MM2S [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins v_axi4s_vid_out_0/video_in]
connect_bd_intf_net -intf_net [get_bd_intf_nets axi_vdma_0_M_AXIS_MM2S] [get_bd_intf_pins axi_vdma_0/M_AXIS_MM2S] [get_bd_intf_pins ila_2/SLOT_0_AXIS]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_MM2S [get_bd_intf_pins axi_interconnect_1/S01_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_MM2S]
  connect_bd_intf_net -intf_net axi_vdma_0_M_AXI_S2MM [get_bd_intf_pins axi_interconnect_1/S00_AXI] [get_bd_intf_pins axi_vdma_0/M_AXI_S2MM]
  connect_bd_intf_net -intf_net processing_system7_0_DDR [get_bd_intf_ports DDR] [get_bd_intf_pins processing_system7_0/DDR]
  connect_bd_intf_net -intf_net processing_system7_0_FIXED_IO [get_bd_intf_ports FIXED_IO] [get_bd_intf_pins processing_system7_0/FIXED_IO]
  connect_bd_intf_net -intf_net processing_system7_0_M_AXI_GP0 [get_bd_intf_pins axi_interconnect_0/S00_AXI] [get_bd_intf_pins processing_system7_0/M_AXI_GP0]
  connect_bd_intf_net -intf_net v_tpg_0_m_axis_video [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins v_tpg_0/m_axis_video]
connect_bd_intf_net -intf_net [get_bd_intf_nets v_tpg_0_m_axis_video] [get_bd_intf_pins axi_vdma_0/S_AXIS_S2MM] [get_bd_intf_pins ila_4/SLOT_0_AXIS]

  # Create port connections
  connect_bd_net -net CLK100_1 [get_bd_ports CLK100] [get_bd_pins ila_0/clk] [get_bd_pins ila_1/clk] [get_bd_pins ila_3/clk]
  connect_bd_net -net proc_sys_reset_0_interconnect_aresetn [get_bd_pins axi_interconnect_0/ARESETN] [get_bd_pins axi_interconnect_1/ARESETN] [get_bd_pins axi_interconnect_1/M00_ARESETN] [get_bd_pins axi_interconnect_1/S00_ARESETN] [get_bd_pins axi_interconnect_1/S01_ARESETN] [get_bd_pins proc_sys_reset_0/interconnect_aresetn]
  connect_bd_net -net proc_sys_reset_0_peripheral_aresetn [get_bd_pins axi_interconnect_0/M00_ARESETN] [get_bd_pins axi_interconnect_0/M01_ARESETN] [get_bd_pins axi_interconnect_0/S00_ARESETN] [get_bd_pins axi_vdma_0/axi_resetn] [get_bd_pins proc_sys_reset_0/peripheral_aresetn] [get_bd_pins util_vector_logic_0/Op1] [get_bd_pins v_axi4s_vid_out_0/aresetn] [get_bd_pins v_tpg_0/ap_rst_n]
  connect_bd_net -net processing_system7_0_FCLK_CLK0 [get_bd_pins axi_interconnect_0/ACLK] [get_bd_pins axi_interconnect_0/M00_ACLK] [get_bd_pins axi_interconnect_0/M01_ACLK] [get_bd_pins axi_interconnect_0/S00_ACLK] [get_bd_pins axi_interconnect_1/ACLK] [get_bd_pins axi_interconnect_1/M00_ACLK] [get_bd_pins axi_interconnect_1/S00_ACLK] [get_bd_pins axi_interconnect_1/S01_ACLK] [get_bd_pins axi_vdma_0/m_axi_mm2s_aclk] [get_bd_pins axi_vdma_0/m_axi_s2mm_aclk] [get_bd_pins axi_vdma_0/m_axis_mm2s_aclk] [get_bd_pins axi_vdma_0/s_axi_lite_aclk] [get_bd_pins axi_vdma_0/s_axis_s2mm_aclk] [get_bd_pins ila_2/clk] [get_bd_pins ila_4/clk] [get_bd_pins proc_sys_reset_0/slowest_sync_clk] [get_bd_pins processing_system7_0/FCLK_CLK0] [get_bd_pins processing_system7_0/M_AXI_GP0_ACLK] [get_bd_pins processing_system7_0/S_AXI_HP0_ACLK] [get_bd_pins v_axi4s_vid_out_0/aclk] [get_bd_pins v_tpg_0/ap_clk]
  connect_bd_net -net processing_system7_0_FCLK_CLK1 [get_bd_pins processing_system7_0/FCLK_CLK1] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_clk] [get_bd_pins v_tc_0/clk]
  connect_bd_net -net processing_system7_0_FCLK_RESET0_N [get_bd_pins proc_sys_reset_0/ext_reset_in] [get_bd_pins processing_system7_0/FCLK_RESET0_N]
  connect_bd_net -net processing_system7_0_FCLK_RESET1_N [get_bd_pins processing_system7_0/FCLK_RESET1_N] [get_bd_pins v_tc_0/resetn]
  connect_bd_net -net util_vector_logic_0_Res [get_bd_pins util_vector_logic_0/Res] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_reset]
  connect_bd_net -net v_axi4s_vid_out_0_locked [get_bd_pins ila_1/probe2] [get_bd_pins v_axi4s_vid_out_0/locked]
  connect_bd_net -net v_axi4s_vid_out_0_overflow [get_bd_pins ila_1/probe3] [get_bd_pins v_axi4s_vid_out_0/overflow]
  connect_bd_net -net v_axi4s_vid_out_0_status [get_bd_pins ila_3/probe0] [get_bd_pins v_axi4s_vid_out_0/status]
  connect_bd_net -net v_axi4s_vid_out_0_underflow [get_bd_pins ila_1/probe5] [get_bd_pins v_axi4s_vid_out_0/underflow]
  connect_bd_net -net v_axi4s_vid_out_0_vid_data [get_bd_pins v_axi4s_vid_out_0/vid_data] [get_bd_pins xlslice_0/Din] [get_bd_pins xlslice_1/Din] [get_bd_pins xlslice_2/Din]
  connect_bd_net -net v_axi4s_vid_out_0_vid_hsync [get_bd_ports vid_hsync] [get_bd_pins ila_1/probe0] [get_bd_pins v_axi4s_vid_out_0/vid_hsync]
  connect_bd_net -net v_axi4s_vid_out_0_vid_vsync [get_bd_ports vid_vsync] [get_bd_pins ila_1/probe1] [get_bd_pins v_axi4s_vid_out_0/vid_vsync]
  connect_bd_net -net v_axi4s_vid_out_0_vtg_ce [get_bd_pins ila_1/probe4] [get_bd_pins v_axi4s_vid_out_0/vtg_ce] [get_bd_pins v_tc_0/gen_clken]
  connect_bd_net -net v_tc_0_active_video_out [get_bd_pins ila_0/probe0] [get_bd_pins v_axi4s_vid_out_0/vtg_active_video] [get_bd_pins v_tc_0/active_video_out]
  connect_bd_net -net v_tc_0_hblank_out [get_bd_pins ila_0/probe1] [get_bd_pins v_axi4s_vid_out_0/vtg_hblank] [get_bd_pins v_tc_0/hblank_out]
  connect_bd_net -net v_tc_0_hsync_out [get_bd_pins ila_0/probe2] [get_bd_pins v_axi4s_vid_out_0/vtg_hsync] [get_bd_pins v_tc_0/hsync_out]
  connect_bd_net -net v_tc_0_vblank_out [get_bd_pins ila_0/probe3] [get_bd_pins v_axi4s_vid_out_0/vtg_vblank] [get_bd_pins v_tc_0/vblank_out]
  connect_bd_net -net v_tc_0_vsync_out [get_bd_pins ila_0/probe4] [get_bd_pins v_axi4s_vid_out_0/vtg_vsync] [get_bd_pins v_tc_0/vsync_out]
  connect_bd_net -net xlconstant_0_dout [get_bd_pins v_axi4s_vid_out_0/aclken] [get_bd_pins v_axi4s_vid_out_0/vid_io_out_ce] [get_bd_pins v_tc_0/clken] [get_bd_pins xlconstant_0/dout]
  connect_bd_net -net xlslice_0_Dout [get_bd_ports Red] [get_bd_pins xlslice_0/Dout]
  connect_bd_net -net xlslice_1_Dout [get_bd_ports Green] [get_bd_pins xlslice_1/Dout]
  connect_bd_net -net xlslice_2_Dout [get_bd_ports Blue] [get_bd_pins xlslice_2/Dout]

  # Create address segments
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_MM2S] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x20000000 -offset 0x0 [get_bd_addr_spaces axi_vdma_0/Data_S2MM] [get_bd_addr_segs processing_system7_0/S_AXI_HP0/HP0_DDR_LOWOCM] SEG_processing_system7_0_HP0_DDR_LOWOCM
  create_bd_addr_seg -range 0x10000 -offset 0x43000000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs axi_vdma_0/S_AXI_LITE/Reg] SEG_axi_vdma_0_Reg
  create_bd_addr_seg -range 0x10000 -offset 0x43C00000 [get_bd_addr_spaces processing_system7_0/Data] [get_bd_addr_segs v_tpg_0/s_axi_CTRL/Reg] SEG_v_tpg_0_Reg

  # Perform GUI Layout
  regenerate_bd_layout -layout_string {
   guistr: "# # String gsaved with Nlview 6.5.5  2015-06-26 bk=1.3371 VDI=38 GEI=35 GUI=JA:1.6
#  -string -flagsOSRD
preplace port DDR -pg 1 -y 400 -defaultsOSRD
preplace port CLK100 -pg 1 -lvl 5:-120 -defaultsOSRD -bot
preplace port FIXED_IO -pg 1 -y 420 -defaultsOSRD
preplace port vid_hsync -pg 1 -y 930 -defaultsOSRD
preplace port vid_vsync -pg 1 -y 950 -defaultsOSRD
preplace portBus Blue -pg 1 -y 1170 -defaultsOSRD
preplace portBus Red -pg 1 -y 1250 -defaultsOSRD
preplace portBus Green -pg 1 -y 1090 -defaultsOSRD
preplace inst v_axi4s_vid_out_0 -pg 1 -lvl 5 -y 820 -defaultsOSRD
preplace inst axi_vdma_0 -pg 1 -lvl 4 -y 230 -defaultsOSRD
preplace inst xlslice_0 -pg 1 -lvl 6 -y 1250 -defaultsOSRD
preplace inst v_tc_0 -pg 1 -lvl 4 -y 730 -defaultsOSRD
preplace inst xlconstant_0 -pg 1 -lvl 3 -y 720 -defaultsOSRD
preplace inst xlslice_1 -pg 1 -lvl 6 -y 1090 -defaultsOSRD
preplace inst v_tpg_0 -pg 1 -lvl 3 -y 260 -defaultsOSRD
preplace inst xlslice_2 -pg 1 -lvl 6 -y 1170 -defaultsOSRD
preplace inst xlconcat_0 -pg 1 -lvl 5 -y 420 -defaultsOSRD
preplace inst proc_sys_reset_0 -pg 1 -lvl 1 -y 260 -defaultsOSRD
preplace inst util_vector_logic_0 -pg 1 -lvl 4 -y 950 -defaultsOSRD
preplace inst ila_0 -pg 1 -lvl 5 -y 1100 -defaultsOSRD
preplace inst ila_1 -pg 1 -lvl 6 -y 820 -defaultsOSRD
preplace inst axi_interconnect_0 -pg 1 -lvl 2 -y 500 -defaultsOSRD
preplace inst axi_interconnect_1 -pg 1 -lvl 5 -y 200 -defaultsOSRD
preplace inst ila_2 -pg 1 -lvl 5 -y 560 -defaultsOSRD
preplace inst ila_3 -pg 1 -lvl 6 -y 1000 -defaultsOSRD
preplace inst ila_4 -pg 1 -lvl 4 -y 50 -defaultsOSRD
preplace inst processing_system7_0 -pg 1 -lvl 6 -y 500 -defaultsOSRD
preplace netloc processing_system7_0_DDR 1 6 1 NJ
preplace netloc v_axi4s_vid_out_0_underflow 1 5 1 N
preplace netloc v_axi4s_vid_out_0_overflow 1 5 1 1850
preplace netloc v_axi4s_vid_out_0_vid_data 1 5 1 1790
preplace netloc v_tpg_0_m_axis_video 1 3 1 1010
preplace netloc axi_vdma_0_s2mm_introut 1 4 1 1440
preplace netloc xlslice_1_Dout 1 6 1 NJ
preplace netloc v_axi4s_vid_out_0_vid_hsync 1 5 2 1860 930 NJ
preplace netloc axi_vdma_0_M_AXI_MM2S 1 4 1 1450
preplace netloc processing_system7_0_M_AXI_GP0 1 1 6 380 350 NJ 350 NJ 350 NJ 350 NJ 350 2310
preplace netloc CLK100_1 1 4 2 1450 1000 1830
preplace netloc axi_vdma_0_M_AXIS_MM2S 1 4 1 1450
preplace netloc v_tc_0_vsync_out 1 4 1 1380
preplace netloc v_tc_0_vblank_out 1 4 1 1390
preplace netloc processing_system7_0_FCLK_RESET0_N 1 0 7 30 360 NJ 360 NJ 360 NJ 450 NJ 500 NJ 660 2290
preplace netloc util_vector_logic_0_Res 1 4 1 NJ
preplace netloc v_axi4s_vid_out_0_locked 1 5 1 1810
preplace netloc processing_system7_0_FCLK_RESET1_N 1 3 4 1050 620 NJ 620 NJ 670 2280
preplace netloc proc_sys_reset_0_interconnect_aresetn 1 1 4 360 110 NJ 110 NJ 110 1460
preplace netloc xlconcat_0_dout 1 5 1 1850
preplace netloc xlconstant_0_dout 1 3 2 1010 850 1460
preplace netloc v_axi4s_vid_out_0_vtg_ce 1 3 3 1060 840 NJ 640 1800
preplace netloc processing_system7_0_FIXED_IO 1 6 1 NJ
preplace netloc axi_vdma_0_mm2s_introut 1 4 1 1470
preplace netloc v_tc_0_hblank_out 1 4 1 1410
preplace netloc xlslice_2_Dout 1 6 1 NJ
preplace netloc axi_interconnect_0_M00_AXI 1 2 1 690
preplace netloc v_tc_0_hsync_out 1 4 1 1400
preplace netloc proc_sys_reset_0_peripheral_aresetn 1 1 4 350 340 710 340 1030 870 NJ
preplace netloc axi_interconnect_0_M01_AXI 1 2 2 680 160 NJ
preplace netloc v_axi4s_vid_out_0_status 1 5 1 1780
preplace netloc processing_system7_0_FCLK_CLK0 1 0 7 20 350 370 330 700 330 1050 460 1480 490 1840 650 2300
preplace netloc axi_interconnect_1_M00_AXI 1 5 1 1860
preplace netloc axi_vdma_0_M_AXI_S2MM 1 4 1 1470
preplace netloc v_tpg_0_interrupt 1 3 2 1020 440 NJ
preplace netloc processing_system7_0_FCLK_CLK1 1 3 4 1040 610 1430 630 NJ 680 2310
preplace netloc v_axi4s_vid_out_0_vid_vsync 1 5 2 1840 940 NJ
preplace netloc v_tc_0_active_video_out 1 4 1 1420
preplace netloc xlslice_0_Dout 1 6 1 NJ
levelinfo -pg 1 0 190 530 860 1220 1630 2070 2330 -top 0 -bot 1400
",
}

  # Restore current instance
  current_bd_instance $oldCurInst

  save_bd_design
}
# End of create_root_design()


##################################################################
# MAIN FLOW
##################################################################

create_root_design ""


