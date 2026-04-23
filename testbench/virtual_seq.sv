		// Arbitration Conflict

class virtual_sequence_4 extends uvm_sequence;
	`uvm_object_utils(virtual_sequence_4)

	`uvm_declare_p_sequencer(virtual_sequencer)

	my_sequence_4a seq_4a;
	my_sequence_4b seq_4b;
	
	function new(string name = "virtual_sequence_4");
		super.new(name);
	endfunction

	task body();
		transaction tr_a, tr_b, tr_a_rd, tr_b_rd;

		//creating sequences 
			seq_4a = my_sequence_4a::type_id::create("seq_4a");
			seq_4b = my_sequence_4b::type_id::create("seq_4b");


		//port PORT_A writes to address 10
			tr_a = transaction::type_id::create("tr_a");
			tr_a.port_id = PORT_A;
 			assert(tr_a.randomize() with {tr_a.write_enable == 1;});
			
		//assigning transaction handles
			seq_4a.tr = tr_a;

			`uvm_info(get_name()," Writing to Port PORT_A ",UVM_LOW)
			tr_a.display("WRITE");
			seq_4a.start(p_sequencer.seqr_a);

		
		//port PORT_B writes to same address
			tr_b = transaction::type_id::create("tr_b");
			tr_b.port_id = PORT_B;
			assert(tr_b.randomize() with {tr_b.address == tr_a.address; tr_b.write_enable == 1;});

			seq_4b.tr = tr_b;

			`uvm_info(get_name(),"Writing to Port PORT_B",UVM_LOW)
			tr_b.display("WRITE");

			seq_4b.start(p_sequencer.seqr_b);

		//port PORT_A reads
			tr_a_rd = transaction::type_id::create("tr_a_rd");
 			tr_a_rd.port_id = PORT_A;
  			tr_a_rd.write_enable  = 0;
 			tr_a_rd.output_enable = 1;
 			tr_a_rd.address = tr_a.address;
 
 		  	seq_4a.tr = tr_a_rd;

			`uvm_info(get_name(),"Reading Port PORT_A traffic",UVM_LOW)
			tr_a_rd.display("READ");

   			seq_4a.start(p_sequencer.seqr_a);

		//port PORT_B reads
			 tr_b_rd = transaction::type_id::create("tr_b_rd");
  			 tr_b_rd.port_id = PORT_B;
   			 tr_b_rd.write_enable  = 0;
			 tr_b_rd.output_enable = 1;
  			 tr_b_rd.address = tr_b.address;
			
			seq_4b.tr = tr_b_rd;
			`uvm_info(get_name(),"Reading Port PORT_B traffic",UVM_LOW)
			tr_b_rd.display("READ");

 		 	seq_4b.start(p_sequencer.seqr_b);
	

	endtask
endclass




		// Memory Full Condition

class virtual_sequence_5 extends uvm_sequence;

	`uvm_object_utils(virtual_sequence_5)
	`uvm_declare_p_sequencer(virtual_sequencer)

	function new(string name = "virtual_sequence_5");
		super.new(name);
	endfunction 

	task body();

		transaction tr_a,tr_b, tr_a_rd, tr_b_rd;
		my_sequence_4a seq_5a;
		my_sequence_4b seq_5b;

		seq_5a = my_sequence_4a::type_id::create("seq_5a");
		seq_5b = my_sequence_4b::type_id::create("seq_5b");

	// fill the memory

		for(int i = 0; i < DEPTH; i++) begin

			tr_a = transaction::type_id::create("tr_a");
			tr_a.port_id = PORT_A;
			tr_a.write_enable = 1;
			tr_a.output_enable = 0;
			tr_a.address = i;
			tr_a.data_in = $urandom;

			seq_5a.tr = tr_a;

			tr_a.display("Memory data");
			seq_5a.start(p_sequencer.seqr_a);
		end

	// overwrite Through  PORT_A 

		tr_a = transaction::type_id::create("tr_a");
		tr_a.port_id = PORT_A;
 		assert(tr_a.randomize() with {tr_a.write_enable == 1;});

		seq_5a.tr = tr_a;
		`uvm_info(get_name()," Port PORT_A after overwrite",UVM_LOW)
		tr_a.display("WRITE");
		seq_5a.start(p_sequencer.seqr_a);

	// overwrite Through  PORT_B

		tr_b = transaction::type_id::create("tr_b");
		tr_b.port_id = PORT_B;
		assert(tr_b.randomize() with {tr_b.write_enable == 1;});

		seq_5b.tr = tr_b;
		`uvm_info(get_name()," Port PORT_B after overwrite ",UVM_LOW)
		tr_b.display("WRITE");
		seq_5b.start(p_sequencer.seqr_b);

	// PORT_A READ

		tr_a_rd = transaction::type_id::create("tr_a_rd");
		tr_a_rd.port_id = PORT_A;
		tr_a_rd.write_enable = 0;
		tr_a_rd.output_enable = 1;
		tr_a_rd.address = tr_a.address;

		seq_5a.tr = tr_a_rd;
		`uvm_info(get_name()," Port PORT_A READING",UVM_LOW)
		tr_a_rd.display("READ");
		seq_5a.start(p_sequencer.seqr_a);

	// PORT_B read

		tr_b_rd = transaction::type_id::create("tr_b_rd");
		tr_b_rd.port_id = PORT_B;
		tr_b_rd.write_enable = 0;
		tr_b_rd.output_enable = 1;
		tr_b_rd.address = tr_b.address;

		seq_5b.tr = tr_b_rd;
		`uvm_info(get_name()," Port PORT_B READING ",UVM_LOW)
		tr_b_rd.display("READ");
		seq_5b.start(p_sequencer.seqr_b);

endtask
endclass





		// Partial filling

class virtual_sequence_6 extends uvm_sequence;

	`uvm_object_utils(virtual_sequence_6)
	`uvm_declare_p_sequencer(virtual_sequencer)

	function new(string name = "virtual_sequence_6");
		super.new(name);
	endfunction 

	task body();

		transaction tr_a,tr_b, tr_rd;
		my_sequence_4a seq_6a;
		my_sequence_4b seq_6b;

		seq_6a = my_sequence_4a::type_id::create("seq_6a");
		seq_6b = my_sequence_4b::type_id::create("seq_6b");

	// fill the memory - writing to addr 20-24

		for(int i = 20; i < 25; i++) begin

			tr_a = transaction::type_id::create("tr_a");
			tr_a.port_id = PORT_A;
			tr_a.write_enable = 1;
			tr_a.output_enable = 0;
			tr_a.address = i;
			tr_a.data_in = $urandom;

			seq_6a.tr = tr_a;

			tr_a.display("Partial Filling");
			seq_6a.start(p_sequencer.seqr_a);
		end

	// overwrite Through  PORT_A 

		tr_a = transaction::type_id::create("tr_a");
		tr_a.port_id = PORT_A;
 		assert(tr_a.randomize() with {tr_a.write_enable == 1; tr_a.address == 20;});

		seq_6a.tr = tr_a;
		`uvm_info(get_name(),"overwrite Through  PORT_A",UVM_LOW)
		tr_a.display("WRITE");
		seq_6a.start(p_sequencer.seqr_a);

	// overwrite Through  PORT_B

		tr_b = transaction::type_id::create("tr_b");
		tr_b.port_id = PORT_B;
 		assert(tr_b.randomize() with {tr_b.write_enable == 1; tr_b.address == tr_a.address;});

		seq_6b.tr = tr_b;
		`uvm_info(get_name(),"overwrite Through  PORT_B",UVM_LOW)
		tr_b.display("WRITE ");
		seq_6b.start(p_sequencer.seqr_b);

	// reading from addr 20-25

		for(int i = 20; i < 26; i++) begin

			tr_rd = transaction::type_id::create("tr_rd");
			tr_rd.port_id = PORT_A;
			tr_rd.write_enable = 0;
			tr_rd.output_enable = 1;
			tr_rd.address = i;

			seq_6a.tr = tr_rd;

		//	tr_rd.display("READ");
			seq_6a.start(p_sequencer.seqr_a);
		end

endtask
endclass

