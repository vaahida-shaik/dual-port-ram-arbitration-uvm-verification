class driver_A extends uvm_driver #(transaction);
	`uvm_component_utils(driver_A)
	virtual intf_a vif_a;

	function new(string name = "driver_A", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		void'(uvm_config_db #(virtual intf_a)::get(this, "", "vif_a", vif_a));
		vif_a.write_enable_a  = 0;
  		vif_a.output_enable_a = 0;
  		vif_a.address_a       = '0;
 		vif_a.data_in_a       = '0;
	endfunction

	task run_phase(uvm_phase phase);
		transaction tr;
		
		forever begin
			
    			seq_item_port.get_next_item(tr);
				tr.port_id = PORT_A;
 				vif_a.write_enable_a <= tr.write_enable;
				vif_a.output_enable_a <= tr.output_enable;
				vif_a.address_a <= tr.address;
				vif_a.data_in_a <= tr.data_in;

				tr.display("DRIVED");
        @(posedge vif_a.clk_a);                      //DUT captures here
				->vif_a.driv_e;
				seq_item_port.item_done();

			
		end
	endtask
endclass




class driver_B extends uvm_driver #(transaction);
	`uvm_component_utils(driver_B)
	virtual intf_b vif_b;

	function new(string name = "driver_B", uvm_component parent = null);
		super.new(name, parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
		void'(uvm_config_db #(virtual intf_b)::get(this, "", "vif_b", vif_b));
		vif_b.write_enable_b  = 0;
    		vif_b.output_enable_b = 0;
    		vif_b.address_b       = '0;
    		vif_b.data_in_b       = '0;
	endfunction

	task run_phase(uvm_phase phase);
		transaction tr;

		forever begin

			seq_item_port.get_next_item(tr);
				tr.port_id = PORT_B;
				vif_b.write_enable_b <= tr.write_enable;
				vif_b.output_enable_b <= tr.output_enable;
				vif_b.address_b <= tr.address;
				vif_b.data_in_b <= tr.data_in;
				tr.display("DRIVED");
	      @(posedge vif_b.clk_b);
				->vif_b.driv_e;
				seq_item_port.item_done();

			
		end
	endtask
endclass
