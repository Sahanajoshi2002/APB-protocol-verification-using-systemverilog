class apb_generator;
  
  // Mailbox to send transactions to the Driver
  mailbox #(apb_transaction) gen2drv;
  
  // How many transactions to generate
  int num_transactions;

  function new(mailbox #(apb_transaction) gen2drv);
    this.gen2drv = gen2drv;
  endfunction

  task run();
    apb_transaction tx;
    
    for (int i = 0; i < num_transactions; i++) begin
      tx = new();
      
      // Randomize the transaction
      if (!tx.randomize()) begin
        $fatal("Generator: Transaction randomization failed!");
      end
      
      // Send it into the mailbox
      gen2drv.put(tx);
    end
    
    $display("[GENERATOR] Finished creating %0d transactions.", num_transactions);
  endtask

endclass