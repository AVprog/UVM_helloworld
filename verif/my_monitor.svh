class my_monitor extends uvm_monitor;
  `uvm_component_utils(my_monitor)

    virtual dut_if dut_vif;

    uvm_analysis_port  #(my_transaction) anls_port;    

  function new(string name="my_monitor", uvm_component parent);
    super.new(name, parent);
  endfunction

  function void build_phase(uvm_phase phase);
    // Get interface reference from config database
    if(!uvm_config_db#(virtual dut_if)::get(this, "", "dut_vif", dut_vif)) begin
      `uvm_error("", "uvm_config_db::get failed")
    end
    anls_port = new ("anls_port",this);

  endfunction 

  extern task run_phase (uvm_phase phase);

endclass: my_monitor

task my_monitor::run_phase (uvm_phase phase);
    forever @(posedge dut_vif.clock) begin

        my_transaction trans = my_transaction::type_id::create("trans_i",this);
        trans.addr=dut_vif.addr;
        trans.data=dut_vif.data;
        trans.cmd=dut_vif.cmd;
        trans.result=dut_vif.result;
        anls_port.write(trans);
    end
endtask