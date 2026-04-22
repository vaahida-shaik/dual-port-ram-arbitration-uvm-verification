		// memory initialization

class my_sequence_a1 extends uvm_sequence #(transaction);
	`uvm_object_utils(my_sequence_a1)

	`uvm_declare_p_sequencer(sequencer_A)
	virtual intf_a vif_a;

	function new(string name = "my_sequence_a1");
		super.new(name);
	endfunction

	task body();
		transaction tr;
		vif_a = p_sequencer.vif_a;

		$display("================================================================================ INITIAL_CHECK_A ================================================================================ \n");

		foreach(tr.address[i]) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_A;
			assert(tr.randomize() with {tr.write_enable == 0; tr.address == i;});
			tr.display("GENERATED");
			finish_item(tr);
			@(vif_a.sb_e);
		end
		
		endtask
endclass





		// basic read_write

class my_sequence_a2 extends uvm_sequence #(transaction);
	`uvm_object_utils(my_sequence_a2)

	`uvm_declare_p_sequencer(sequencer_A)
	virtual intf_a vif_a;

	function new(string name = "my_sequence_a2");
		super.new(name);
	endfunction

	task body();
		transaction tr, tr_rd;
		vif_a = p_sequencer.vif_a;

		$display("================================================================================ Basic_READ_WRITE_A ================================================================================ \n");

		// writes to port PORT_A
			tr = transaction::type_id::create("tr");
			start_item(tr);
		//	assert(tr.randomize() with {tr.write_enable == 1;});
			assert(tr.randomize() with {tr.write_enable == 1; tr.address == 0;});
			tr.display("WRITE");
			finish_item(tr);
			@(vif_a.sb_e);

		// reads from port PORT_A
			tr_rd = transaction::type_id::create("tr_rd");
			start_item(tr_rd);
			tr_rd.port_id = PORT_A;
			tr_rd.write_enable = 1'b0;
			tr_rd.output_enable = 1'b1;
			tr_rd.address = tr.address;
			tr_rd.display("READ");
			finish_item(tr_rd);
			@(vif_a.sb_e);

		
		endtask
endclass




		//Asynchronous clock

class my_sequence_a3 extends uvm_sequence #(transaction);
	`uvm_object_utils(my_sequence_a3)

	`uvm_declare_p_sequencer(sequencer_A)
	virtual intf_a vif_a;

	function new(string name = "my_sequence_a3");
		super.new(name);
	endfunction

	task body();
		transaction tr;
		vif_a = p_sequencer.vif_a;

		$display("================================================================================ ASYNCHRONOUS_CLOCK_A ================================================================================ \n");

		repeat(5) begin
			tr = transaction::type_id::create("tr");
			tr.port_id = PORT_A;
			start_item(tr);
			assert(tr.randomize());			
			tr.display("GENERATED");			
			finish_item(tr);
			@(vif_a.sb_e);
		end
		
	endtask
endclass





 	// ARBITRATION CONFLICT & MEMORY FULL CONDITION & PARTIAL FILLING

class my_sequence_4a extends uvm_sequence #(transaction);

	`uvm_object_utils(my_sequence_4a)
	`uvm_declare_p_sequencer(sequencer_A)
	
	transaction tr;
	virtual intf_a vif_a;

	function new(string name = "my_sequence_4a");
		super.new(name);
	endfunction

	task body();
		vif_a = p_sequencer.vif_a;
		
			start_item(tr);
			finish_item(tr);
			@(vif_a.sb_e);
					
	endtask
endclass




		// Multiple writes & then read

class my_sequence_a7 extends uvm_sequence #(transaction);

	`uvm_object_utils(my_sequence_a7)
	`uvm_declare_p_sequencer(sequencer_A)
	virtual intf_a vif_a;

	function new(string name = "my_sequence_a7");
		super.new(name);
	endfunction

	task body();
		transaction tr, tr_rd;
		vif_a = p_sequencer.vif_a;

		$display("================================================================================ MULTIPLE_WRITE -> READ ================================================================================ \n");

		for(int i = 10; i<20; i++) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_A;
			assert(tr.randomize() with {tr.write_enable == 1; tr.address == i;});
			tr.display("WRITE");
			finish_item(tr);
			@(vif_a.sb_e);
		end
		for(int i =10; i<20;i++) begin
			tr = transaction::type_id::create("tr");
			tr.port_id = PORT_A;
			start_item(tr);
			assert(tr.randomize() with {tr.write_enable == 0; tr.address == i;});
			tr.display("READ");	
			finish_item(tr);
			@(vif_a.sb_e);
		end

		endtask
endclass




		// Alternate write & read

class my_sequence_a8 extends uvm_sequence #(transaction);

	`uvm_object_utils(my_sequence_a8)
	`uvm_declare_p_sequencer(sequencer_A)
	virtual intf_a vif_a;

	function new(string name = "my_sequence_a8");
		super.new(name);
	endfunction

	task body();
		transaction tr, tr_rd;
		vif_a = p_sequencer.vif_a;

		$display("================================================================================ ALTERNATE_WRITE_READ ================================================================================ \n");

		repeat(5) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_A;
			assert(tr.randomize() with {tr.write_enable == 1;});
			tr.display("WRITE");
			finish_item(tr);
			@(vif_a.sb_e);
	
			tr_rd = transaction::type_id::create("tr_rd");
			tr_rd.port_id = PORT_A;
			start_item(tr_rd);
			assert(tr_rd.randomize() with {tr_rd.write_enable == 0; tr_rd.address == tr.address;});
			tr_rd.display("READ");
			finish_item(tr_rd);
			@(vif_a.sb_e);
		end


			
		endtask
endclass
