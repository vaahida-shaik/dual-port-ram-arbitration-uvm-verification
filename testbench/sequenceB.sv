		// memory initialization

class my_sequence_b1 extends uvm_sequence #(transaction);
	`uvm_object_utils(my_sequence_b1)

	`uvm_declare_p_sequencer(sequencer_B)
	virtual intf_b vif_b;

	function new(string name = "my_sequence_b1");
		super.new(name);
	endfunction

	task body();
		transaction tr;
		vif_b = p_sequencer.vif_b;

		for(int i = 0; i < (1<< ADDR_WIDTH); i++) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_B;
			tr.write_enable = 0; 
			tr.address = i;
			tr.output_enable = 1;
			tr.display("GENERATED");
			finish_item(tr);
			@(vif_b.sb_e);
		end
		
		endtask
endclass





		// basic read_write

class my_sequence_b2 extends uvm_sequence #(transaction);
	`uvm_object_utils(my_sequence_b2)

	`uvm_declare_p_sequencer(sequencer_B)
	virtual intf_b vif_b;

	function new(string name = "my_sequence_b2");
		super.new(name);
	endfunction

	task body();
		transaction tr, tr_rd;
		vif_b = p_sequencer.vif_b;

		// writes to port PORT_B
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_B;
			assert(tr.randomize() with {
				tr.write_enable == 1; 
				tr.address inside {[0:10]};
			});
			tr.display("WRITE");
			finish_item(tr);
			@(vif_b.sb_e);

		// reads from port PORT_B
			tr_rd = transaction::type_id::create("tr_rd");
			start_item(tr_rd);
			tr_rd.port_id = PORT_B;
			tr_rd.write_enable = 1'b0;
			tr_rd.output_enable = 1'b1;
			tr_rd.address = tr.address;
			$display("\n");

			tr_rd.display("READ");
			finish_item(tr_rd);
			@(vif_b.sb_e);

		endtask
endclass




		//Asynchronous clock

class my_sequence_b3 extends uvm_sequence #(transaction);
	`uvm_object_utils(my_sequence_b3)

	`uvm_declare_p_sequencer(sequencer_B)
	virtual intf_b vif_b;

	function new(string name = "my_sequence_b3");
		super.new(name);
	endfunction

	task body();
		transaction tr;
		vif_b = p_sequencer.vif_b;

		repeat(10) begin
			tr = transaction::type_id::create("tr");
			tr.port_id = PORT_B;
			start_item(tr);
			assert(tr.randomize());			
			tr.display("GENERATED");			
			finish_item(tr);
			@(vif_b.sb_e);
		end
		
	endtask
endclass





 	// ARBITRATION CONFLICT & MEMORY FULL CONDITION & PARTIAL FILLING

class my_sequence_4b extends uvm_sequence #(transaction);

	`uvm_object_utils(my_sequence_4b)
	`uvm_declare_p_sequencer(sequencer_B)
	
	transaction tr;
	virtual intf_b vif_b;

	function new(string name = "my_sequence_4b");
		super.new(name);
	endfunction

	task body();
		vif_b = p_sequencer.vif_b;
		
			start_item(tr);
			finish_item(tr);
			@(vif_b.sb_e);
					
	endtask
endclass




		// Multiple writes & then read

class my_sequence_b7 extends uvm_sequence #(transaction);

	`uvm_object_utils(my_sequence_b7)
	`uvm_declare_p_sequencer(sequencer_B)
	virtual intf_b vif_b;

	function new(string name = "my_sequence_b7");
		super.new(name);
	endfunction

	task body();
		transaction tr, tr_rd;
		vif_b = p_sequencer.vif_b;

		for(int i = 10; i<20; i++) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_B;
			assert(tr.randomize() with {tr.write_enable == 1; tr.address == i;});
			tr.display("WRITE");
			finish_item(tr);
			@(vif_b.sb_e);
		end

		for(int i = 10; i < 20; i++) begin
			tr = transaction::type_id::create("tr");
			tr.port_id = PORT_B;
			start_item(tr);
			tr.write_enable = 0;
			tr.output_enable = 1;
		       	tr.address = i;
			tr.display("READ");	
			finish_item(tr);
			@(vif_b.sb_e);
		end

		endtask
endclass




		// Alternate write & read

class my_sequence_b8 extends uvm_sequence #(transaction);

	`uvm_object_utils(my_sequence_b8)
	`uvm_declare_p_sequencer(sequencer_B)
	virtual intf_b vif_b;

	function new(string name = "my_sequence_b8");
		super.new(name);
	endfunction

	task body();
		transaction tr, tr_rd;
		vif_b = p_sequencer.vif_b;

		repeat(5) begin
			tr = transaction::type_id::create("tr");
			start_item(tr);
			tr.port_id = PORT_B;
			assert(tr.randomize() with {tr.write_enable == 1;});
			tr.display("WRITE");
			finish_item(tr);
			@(vif_b.sb_e);
	
			tr_rd = transaction::type_id::create("tr_rd");
			tr_rd.port_id = PORT_B;
			start_item(tr_rd);
			tr_rd.write_enable = 0;
			tr_rd.output_enable = 1;
		       	tr_rd.address = tr.address;
			tr_rd.display("READ");
			finish_item(tr_rd);
			@(vif_b.sb_e);
		end


			
		endtask
endclass
