class my_scoreboard extends uvm_scoreboard;
  `uvm_component_utils(my_scoreboard)

function new(string name="my_scoreboard", uvm_component parent);
    super.new(name, parent);
endfunction

   uvm_analysis_imp #(my_transaction, my_scoreboard) m_analysis_imp;
   

virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);

    m_analysis_imp = new("m_analysis_imp", this);   

endfunction

virtual function void write(my_transaction item);     
 `uvm_info("scoreboard", $sformatf("result=0x%2h cmd=%b, addr=0x%2h, data=0x%2h", item.result,item.cmd,item.addr,item.data), UVM_MEDIUM)
endfunction


endclass