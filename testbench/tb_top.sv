`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"
import pack::*;

module tb_top;
bit clk_a, clk_b;

intf_a vif_a (clk_a);
intf_b vif_b (clk_b);

dual_port_ram dut(.clk_a(clk_a), .clk_b(clk_b), .write_enable_a(vif_a.write_enable_a), .write_enable_b(vif_b.write_enable_b), .output_enable_a(vif_a.output_enable_a), .output_enable_b(vif_b.output_enable_b), .address_a(vif_a.address_a), .address_b(vif_b.address_b), .data_in_a(vif_a.data_in_a), .data_in_b(vif_b.data_in_b), .data_out_a(vif_a.data_out_a), .data_out_b(vif_b.data_out_b));

initial begin
	clk_a = 0;

	forever #5 clk_a = ~clk_a;
end

initial begin
	clk_b = 0;
//	forever #7 clk_b = ~clk_b;
	forever #5 clk_b = ~clk_b;

end

initial begin
	void'(uvm_config_db #(virtual intf_a)::set(null, "*", "vif_a", vif_a));
	void'(uvm_config_db #(virtual intf_b)::set(null, "*", "vif_b", vif_b));
	run_test("");
end

initial begin
	$shm_open("waves.shm");
	$shm_probe("ACMTF");
end
endmodule
