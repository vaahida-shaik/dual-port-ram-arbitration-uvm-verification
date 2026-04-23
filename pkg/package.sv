`timescale 1ns/1ps

import uvm_pkg::*;
`include "uvm_macros.svh"

package pack;

	parameter int ADDR_WIDTH = 8;
 	parameter int DATA_WIDTH = 8;
    	parameter int DEPTH = 1 << ADDR_WIDTH;
	 
	 typedef enum {PORT_A, PORT_B} port_e; 					// CG only support integral types

	`include "seq_item.sv"

	`include "sequencer.sv"
	`include "virtual_seqr.sv"

	`include "sequence_a.sv"
	`include "sequence_b.sv"
	`include "virtual_seq.sv"

	`include "driver.sv"
	`include "monitor.sv"
	`include "agent.sv"

	`include "coverage.sv"
	`include "scoreboard.sv"
	`include "env.sv"
	`include "test.sv"
endpackage: pack
