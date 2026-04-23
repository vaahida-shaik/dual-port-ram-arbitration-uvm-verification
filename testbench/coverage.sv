class coverage extends uvm_component;			

	`uvm_component_utils(coverage)
	transaction tr;
 	
//covergroup
	covergroup cg;
		// Enable signals
		cp_write: coverpoint tr.write_enable {
							bins write = {1};
							bins no_write = {0};
						}

		cp_output: coverpoint tr.output_enable {
								bins read = {1};
								bins no_read = {0};
							}
		// Operation type
		cp_operation: coverpoint {tr.write_enable, tr.output_enable}{
										bins write_only = {2'b10};
										bins read_only = {2'b01};
									}
	
		// Address coverage
		cp_addr: coverpoint tr.address {
							bins low = {[0:85]};
							bins mid = {[86:170]};
							bins high = {[171:255]};
							bins boundary = {0,255};
						}
	
		// Data coverage 
		cp_data: coverpoint tr.data_in {
							bins low = {[0:80]};
							bins mid = {[81:170]};
							bins high = {[171:255]};
						}

		// Port coverage
		cp_port: coverpoint tr.port_id {
							bins portA = {PORT_A};
							bins portB = {PORT_B};
						}

		cp_cross1: cross cp_write, cp_addr;
		cp_cross2: cross cp_operation, cp_addr ;
		cp_cross3: cross cp_operation, cp_port;
		cp_cross4: cross cp_write, cp_addr, cp_port;
		
	endgroup

	function new(string name = "coverage", uvm_component parent = null);
		super.new(name,parent);
		cg = new();
	endfunction

	function void sample(transaction t);
		tr = t;
		cg.sample();
		`uvm_info(get_name(), $sformatf("coverage of %s: %0.2f%% \n", tr.port_id.name(), $get_coverage()), UVM_LOW)
		$display("----------------------------------------------------------------------------------------------------------\n");
	endfunction


endclass
