set_global_assignment -entity "soc_system" -library "lib_soc_system" -name IP_TOOL_NAME "Qsys"
set_global_assignment -entity "soc_system" -library "lib_soc_system" -name IP_TOOL_VERSION "18.0"
set_global_assignment -entity "soc_system" -library "lib_soc_system" -name IP_TOOL_ENV "Qsys"
set_global_assignment -library "lib_soc_system" -name SPD_FILE [file join $::quartus(sip_path) "../soc_system.spd"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "../../soc_system.qsys"]

set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "soc_system.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_synchronizer.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_reset_controller.sdc"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_irq_mapper_001.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_irq_mapper.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_width_adapter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_address_alignment.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_uncompressor.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1_rsp_mux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_arbitrator.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1_rsp_demux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1_cmd_mux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1_cmd_demux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_traffic_limiter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_reorder_memory.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_sc_fifo.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_pipeline_base.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1_router_001.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_1_router.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_axi_slave_ni.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_master_agent.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_master_translator.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_avalon_st_adapter_001.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_avalon_st_adapter_001_error_adapter_0.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_avalon_st_adapter.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_avalon_st_adapter_error_adapter_0.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_rsp_mux_003.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_rsp_mux_002.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_rsp_mux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_rsp_demux_002.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_rsp_demux_001.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_rsp_demux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_cmd_mux_002.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_cmd_mux_001.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_cmd_mux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_cmd_demux_003.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_cmd_demux_002.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_cmd_demux.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter_uncmpr.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter_13_1.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_burst_adapter_new.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_incr_burst_converter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_wrap_burst_converter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_default_burst_converter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_pipeline_stage.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_router_007.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_router_006.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_router_005.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_router_003.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_router_002.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_mm_interconnect_0_router.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_agent.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_axi_master_ni.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_merlin_slave_translator.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_sysid_qsys.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_onchip_memory2_0.hex"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_onchip_memory2_0.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_master_non_sec.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_master_non_sec_p2b_adapter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_master_non_sec_b2p_adapter.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_packets_to_master.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_packets_to_bytes.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_bytes_to_packets.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_master_non_sec_timing_adt.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_jtag_interface.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_jtag_dc_streaming.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_jtag_sld_node.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_jtag_streaming.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_clock_crosser.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_std_synchronizer_nocut.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_idle_remover.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_idle_inserter.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_st_jtag_interface.sdc"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_led_pio.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_jtag_uart.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/intr_capturer.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_hps_io.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/verbosity_pkg.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_utilities_pkg.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/avalon_mm_pkg.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_mm_slave_bfm.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_interrupt_sink.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_clock_source.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/altera_avalon_reset_source.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_hps_io_border_memory.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_hps_io_border_hps_io.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_hps_io_border.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/questa_mvc_svapi.svh"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mgc_common_axi.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mgc_axi_master.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/mgc_axi_slave.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_fpga_interfaces_f2h_cold_reset_req.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_fpga_interfaces_f2h_debug_reset_req.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_fpga_interfaces_f2h_warm_reset_req.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_fpga_interfaces_f2h_stm_hw_events.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_hps_0_fpga_interfaces.sv"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_dipsw_pio.v"]
set_global_assignment -library "lib_soc_system" -name MISC_FILE [file join $::quartus(sip_path) "submodules/soc_system_button_pio.v"]
