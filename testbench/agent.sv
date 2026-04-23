class agent_A extends uvm_agent;
	`uvm_component_utils(agent_A)

	sequencer_A seqr_a;
	driver_A driv_a;
	monitor_A mon_a;

	function new(string name = "agent_A", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seqr_a = sequencer_A::type_id::create("seqr_a", this);
		driv_a = driver_A::type_id::create("driv_a", this);
		mon_a = monitor_A::type_id::create("mon_a", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driv_a.seq_item_port.connect(seqr_a.seq_item_export);
	endfunction
endclass



class agent_B extends uvm_agent;
	`uvm_component_utils(agent_B)

	sequencer_B seqr_b;
	driver_B driv_b;
	monitor_B mon_b;

	function new(string name = "agent_B", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		seqr_b = sequencer_B::type_id::create("seqr_b", this);
		driv_b = driver_B::type_id::create("driv_b", this);
		mon_b = monitor_B::type_id::create("mon_b", this);
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		driv_b.seq_item_port.connect(seqr_b.seq_item_export);
	endfunction
endclass
