class transaction extends uvm_sequence_item;
	`uvm_object_utils(transaction)
	
	rand bit write_enable;
	rand bit output_enable;
	rand bit [ADDR_WIDTH-1:0] address;
	rand logic [DATA_WIDTH-1:0] data_in;
	logic [DATA_WIDTH-1:0] data_out;
	port_e port_id;
	
	constraint c2{ write_enable dist{1:=50, 0:=50};}
	constraint c3{output_enable == !write_enable;}

	//constraint c1{!(write_enable && output_enable);}

	function new(string name  = "transaction");
		super.new(name);
	endfunction

	function void display(string tag);
		`uvm_info(get_name(), $sformatf("%6s Data of Port %s: write_enable = %0b | output_enable = %0b | address = %2h | data_in = %2h | data_out = %2h ", tag, port_id.name(), write_enable, output_enable, address, data_in, data_out), UVM_LOW)
	endfunction

endclass
