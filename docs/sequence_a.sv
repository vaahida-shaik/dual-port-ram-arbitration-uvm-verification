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




