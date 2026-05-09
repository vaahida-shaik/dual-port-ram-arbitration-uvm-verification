class ref_mod extends uvm_object;
	`uvm_object_utils(ref_mod)

  	logic [DATA_WIDTH-1:0] exp_mem[0:DEPTH-1];
  	bit flag_used [0:DEPTH-1] ;

  	function new(string name = "ref_mod");
   		 super.new(name);
		 foreach(exp_mem[i]) begin
	   		exp_mem[i] = 8'b0;
	    		flag_used[i] = 0;
   		 end

  	endfunction

  
  	function void write_a(transaction tr);
		exp_mem[tr.address] = tr.data_in;
		flag_used[tr.address] = 1;
	endfunction

	function void write_b(transaction tr);

		int free_addr;
	   
		if(flag_used[tr.address] == 0) begin
			exp_mem[tr.address] = tr.data_in;
            		flag_used[tr.address] = 1;
		end
				
		else begin
			free_addr = -1;
			for(int i = tr.address+1; i < DEPTH; i++) begin
				if(flag_used[i] == 0) begin
					free_addr = i;
					break;
				end
			end

			if(free_addr != -1) begin
				exp_mem[free_addr] = tr.data_in;
				flag_used[free_addr] = 1;
			end
		end
	
	endfunction
	
	function logic [DATA_WIDTH-1:0] read(transaction tr);
		return exp_mem[tr.address];
	endfunction
	
endclass



`uvm_analysis_imp_decl (_port_a)
`uvm_analysis_imp_decl (_port_b)

class scoreboard extends uvm_component;
	`uvm_component_utils(scoreboard)
  
	uvm_analysis_imp_port_a #(transaction, scoreboard) ap_imp_a;
  	uvm_analysis_imp_port_b #(transaction, scoreboard) ap_imp_b;

  	virtual intf_a vif_a;
	virtual intf_b vif_b;

	ref_mod rm;
	transaction read_q[$];
	coverage cov;

  	function new(string name="scoreboard", uvm_component parent=null);
   		 super.new(name, parent);
  	endfunction

  	function void build_phase(uvm_phase phase);
   		super.build_phase(phase);
		void'(uvm_config_db #(virtual intf_a)::get(this, "", "vif_a", vif_a));
		void'(uvm_config_db #(virtual intf_b)::get(this, "", "vif_b", vif_b));

   		ap_imp_a = new("ap_imp_a", this);
   		ap_imp_b = new("ap_imp_b", this);

		rm = ref_mod::type_id::create("rm");
	endfunction

  // Called whenever monitor sends a transaction
  	function void write_port_a(transaction tr);
		tr.port_id = PORT_A;

		if(tr.write_enable) 
			rm.write_a(tr);
		else if(tr.output_enable)
			read_q.push_back(tr);
	cov.sample(tr);
		->vif_a.sb_e;
 	 endfunction
	
  	function void write_port_b(transaction tr);
		tr.port_id = PORT_B;
		if(tr.write_enable)
			rm.write_b(tr);
		else if(tr.output_enable)
			read_q.push_back(tr);

		cov.sample(tr);
		->vif_b.sb_e;
	endfunction		
	
	function void check_read();
		transaction tr;
		logic [DATA_WIDTH-1:0] exp_out;
		
			while(read_q.size() > 0) begin
				tr = read_q.pop_front();
				exp_out = rm.read(tr);

				if(exp_out === tr.data_out)
					`uvm_info(get_type_name(), $sformatf("SB PASS  of %s: output_enable = %0b | address = %2h | exp_out = %2h | data_out = %2h ", tr.port_id.name(), tr.output_enable, tr.address, exp_out, tr.data_out), UVM_LOW)
				else
					`uvm_error(get_type_name(), $sformatf("SB FAIL of %s: output_enable = %0b | address = %2h | exp_out = %2h | data_out = %2h ", tr.port_id.name(), tr.output_enable, tr.address, exp_out, tr.data_out))

			end		
	endfunction

	function void check_phase(uvm_phase phase);
		super.check_phase(phase);
		$display("\n ------------------------------------------------------------------ CHECK PAHSE ----------------------------------------------------------- \n");
		check_read();
		
	endfunction
endclass
