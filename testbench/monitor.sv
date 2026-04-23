class monitor_A extends uvm_monitor;
	`uvm_component_utils(monitor_A)
	uvm_analysis_port #(transaction) ap_port_A;
	virtual intf_a vif_a;
	
	bit [7:0] wr_q[$];           //to store write values
	bit [7:0] addr_q[$];

	function new(string name = "monitor_A", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		ap_port_A = new("ap_port_A", this);
 		void'(uvm_config_db #(virtual intf_a)::get(this, "", "vif_a", vif_a));
	
	endfunction

	task run_phase(uvm_phase phase);
		transaction tr;
		forever begin
			@(vif_a.driv_e);
			@(posedge vif_a.clk_a);
				tr = transaction::type_id::create("tr");
				tr.port_id = PORT_A;
				tr.write_enable = vif_a.write_enable_a;
				tr.output_enable = vif_a.output_enable_a;
				tr.address = vif_a.address_a;
			  tr.data_in = vif_a.data_in_a;
				tr.data_out = vif_a.data_out_a;
				tr.display("MONITORED");
        ap_port_A.write(tr);								
		end
	endtask
endclass




class monitor_B extends uvm_monitor;
	`uvm_component_utils(monitor_B)
	uvm_analysis_port #(transaction) ap_port_B;
	virtual intf_b vif_b;

	function new(string name = "monitor_B", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase (uvm_phase phase);
		super.build_phase(phase);
		ap_port_B = new("ap_port_B", this);
		void'(uvm_config_db #(virtual intf_b)::get(this, "", "vif_b", vif_b));
		endfunction

	task run_phase(uvm_phase phase);
		transaction tr;
		forever begin
			@(vif_b.driv_e);
  			@(posedge vif_b.clk_b);
				tr = transaction::type_id::create("tr");
				tr.port_id = PORT_B;
				tr.write_enable = vif_b.write_enable_b;
				tr.output_enable = vif_b.output_enable_b;
				tr.address = vif_b.address_b;			
				tr.data_in = vif_b.data_in_b;			
				tr.data_out = vif_b.data_out_b;
				tr.display("MONITORED");
				ap_port_B.write(tr);
		end
	endtask
endclass
