          // TC-1 initialization check

class test1 extends uvm_test;
	`uvm_component_utils(test1)
	environment env;

	function new(string name = "test1", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		my_sequence_a1 seq_a1;
		my_sequence_b1 seq_b1;

		seq_a1 = my_sequence_a1::type_id::create("seq_a1");
		seq_b1 = my_sequence_b1::type_id::create("seq_b1"); 

		phase.raise_objection(this);
		#10;
		fork
		seq_a1.start(env.ag_a.seqr_a);
		seq_b1.start(env.ag_b.seqr_b);
	join

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass




		//  TC-2 Basic_read_write

class test2 extends uvm_test;
	`uvm_component_utils(test2)
	environment env;

	function new(string name = "test2", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		my_sequence_a2 seq_a2;
		my_sequence_b2 seq_b2;

		seq_a2 = my_sequence_a2::type_id::create("seq_a2");
		seq_b2 = my_sequence_b2::type_id::create("seq_b2"); 

		phase.raise_objection(this);
		#10;
		fork
		seq_a2.start(env.ag_a.seqr_a);
		seq_b2.start(env.ag_b.seqr_b);
	join
		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 50);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass




		//  TC-3 Asynchronous clock

class test3 extends uvm_test;
	`uvm_component_utils(test3)
	environment env;

	function new(string name = "test3", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		my_sequence_a3 seq_a3;
		my_sequence_b3 seq_b3;

		seq_a3 = my_sequence_a3::type_id::create("seq_a3");
		seq_b3 = my_sequence_b3::type_id::create("seq_b3"); 

		phase.raise_objection(this);
		#10;
		fork
		seq_a3.start(env.ag_a.seqr_a);
		seq_b3.start(env.ag_b.seqr_b);
	join

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass



		// TC-4 ¿ Conflict Arbitration		

class test4 extends uvm_test;
	`uvm_component_utils(test4)
	environment env;

	function new(string name = "test4", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		virtual_sequence_4 vseq_4;

		vseq_4 = virtual_sequence_4::type_id::create("vseq_4");
	
		phase.raise_objection(this);
		#10;
		vseq_4.start(env.vseqr);

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass




		// TC-5 Memory_full_condition

class test5 extends uvm_test;
	`uvm_component_utils(test5)
	environment env;

	function new(string name = "test5", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		virtual_sequence_5 vseq_5;

		vseq_5 = virtual_sequence_5::type_id::create("vseq_5");
	
		phase.raise_objection(this);
		#10;
		vseq_5.start(env.vseqr);

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass



			// TC-6 Partial filling

class test6 extends uvm_test;
	`uvm_component_utils(test6)
	environment env;

	function new(string name = "test6", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		virtual_sequence_6 vseq_6;

		vseq_6 = virtual_sequence_6::type_id::create("vseq_6");
	
		phase.raise_objection(this);
		#10;
		vseq_6.start(env.vseqr);

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass




		// TC-7 Multiple writes & then read

class test7 extends uvm_test;
	`uvm_component_utils(test7)
	environment env;

	function new(string name = "test7", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		my_sequence_a7 seq_a7;
		my_sequence_b7 seq_b7;

		seq_a7 = my_sequence_a7::type_id::create("seq_a7");
		seq_b7 = my_sequence_b7::type_id::create("seq_b7"); 

		phase.raise_objection(this);
		#10;
	//	fork
		seq_a7.start(env.ag_a.seqr_a);
		seq_b7.start(env.ag_b.seqr_b);
//	join

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass
 




		// TC-8 Multiple writes & Reads

class test8 extends uvm_test;
	`uvm_component_utils(test8)
	environment env;

	function new(string name = "test8", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		env = environment::type_id::create("env", this);
	endfunction

	task run_phase(uvm_phase phase);

		my_sequence_a8 seq_a8;
		my_sequence_b8 seq_b8;

		seq_a8 = my_sequence_a8::type_id::create("seq_a8");
		seq_b8 = my_sequence_b8::type_id::create("seq_b8"); 

		phase.raise_objection(this);
		#10;
		fork
		seq_a8.start(env.ag_a.seqr_a);
		seq_b8.start(env.ag_b.seqr_b);
	join

		phase.drop_objection(this);
		phase.phase_done.set_drain_time(this, 10);
	endtask

	function void end_of_elaboration_phase(uvm_phase phase);
		super.end_of_elaboration_phase(phase);
		uvm_top.print_topology();
	endfunction
endclass
 
