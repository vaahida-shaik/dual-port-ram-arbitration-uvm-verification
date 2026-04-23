class virtual_sequencer extends uvm_sequencer;
	`uvm_component_utils(virtual_sequencer)

	sequencer_A seqr_a;
	sequencer_B seqr_b;

	virtual intf_a vif_a;
	virtual intf_b vif_b;

	function new(string name = "virtual_sequencer", uvm_component parent = null);
		super.new(name, parent);
	endfunction
endclass
