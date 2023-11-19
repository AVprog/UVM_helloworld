class my_transaction extends uvm_sequence_item;

  `uvm_object_utils(my_transaction)

  rand bit cmd;
  rand int addr;
  rand int data;
  int result;

  constraint c_addr { addr >= 0; addr < 256; }
  constraint c_data { data >= 0; data < 2; }

  function new (string name = "");
    super.new(name);
  endfunction

endclass: my_transaction

class my_sequence extends uvm_sequence#(my_transaction);

  `uvm_object_utils(my_sequence)

  function new (string name = "");
    super.new(name);
  endfunction

  task body;
    int k=0;
    repeat(8) begin
      req = my_transaction::type_id::create("req");
      start_item(req);

      if (!req.randomize()) begin
        `uvm_error("MY_SEQUENCE", "Randomize failed.");
      end

      req.data = k;
      k++;

      // If using ModelSim, which does not support randomize(),
      // we must randomize item using traditional methods, like
      // req.cmd = $urandom;
      // req.addr = $urandom_range(0, 255);
      // req.data = $urandom_range(0, 255);

      finish_item(req);
    end
  endtask: body

endclass: my_sequence
