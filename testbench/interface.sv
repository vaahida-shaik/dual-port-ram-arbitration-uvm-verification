// signals of port A
interface intf_a (input bit clk_a);
	import pack::*;
	bit write_enable_a;
	bit output_enable_a;
	logic [ADDR_WIDTH-1:0] address_a;
	logic [DATA_WIDTH-1:0] data_in_a;
	logic [DATA_WIDTH-1:0] data_out_a;

	event driv_e, sb_e;          //for synchronization of components
endinterface


//signals of port B
interface intf_b (input bit clk_b);
	import pack::*;

	bit write_enable_b;
	bit output_enable_b;
	logic [ADDR_WIDTH-1:0] address_b;
	logic [DATA_WIDTH-1:0] data_in_b;
	logic [DATA_WIDTH-1:0] data_out_b;

	event driv_e, sb_e;             //for synchronization of components
endinterface	
