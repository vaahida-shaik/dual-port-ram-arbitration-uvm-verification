class environment extends uvm_env;
	`uvm_component_utils(environment)

	agent_A ag_a;
	agent_B ag_b;
	scoreboard sb;
	coverage cov;
	virtual_sequencer vseqr;

	virtual intf_a vif_a;
	virtual intf_b vif_b;

	function new(string name = "environment", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		ag_a = agent_A::type_id::create("ag_a", this);
		ag_b = agent_B::type_id::create("ag_b", this);
		vseqr = virtual_sequencer::type_id::create("vseqr", this);
		sb = scoreboard::type_id::create("sb", this);
		cov = coverage::type_id::create("cov", this);

		void'(uvm_config_db #(virtual intf_a)::get(this, "", "vif_a", vif_a));
		void'(uvm_config_db #(virtual intf_b)::get(this, "", "vif_b", vif_b));

		vseqr.vif_a = vif_a;
		vseqr.vif_b = vif_b;
	endfunction

	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);
		vseqr.seqr_a = ag_a.seqr_a;
		vseqr.seqr_b = ag_b.seqr_b;
		
		ag_a.mon_a.ap_port_A.connect(sb.ap_imp_a);
                ag_b.mon_b.ap_port_B.connect(sb.ap_imp_b);
		
		sb.cov = cov;
		
	endfunction
endclass
