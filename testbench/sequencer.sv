class sequencer_A extends uvm_sequencer #(transaction);
	`uvm_component_utils(sequencer_A)
	virtual intf_a vif_a;

	function new(string name = "sequencer_A", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		void'(uvm_config_db #(virtual intf_a)::get(this, "", "vif_a", vif_a));
	endfunction

endclass






class sequencer_B extends uvm_sequencer #(transaction);
	`uvm_component_utils(sequencer_B)
	virtual intf_b vif_b;

	function new(string name = "sequencer_B", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	virtual function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		void'(uvm_config_db #(virtual intf_b)::get(this, "", "vif_b", vif_b));
	endfunction

endclass
