class apb_monitor;
  
  virtual apb_if vif;
  
  // Mailbox to send captured transactions to the Scoreboard
  mailbox #(apb_transaction) mon2scb;

  function new(virtual apb_if vif, mailbox #(apb_transaction) mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    apb_transaction tx;
    
    forever begin
      @(posedge vif.pclk);
      
      // An APB transaction completes on the cycle where SEL, ENABLE, and READY are all 1
      if (vif.psel && vif.penable && vif.pready) begin
        
        tx = new();
        tx.addr = vif.paddr;
        tx.is_write = vif.pwrite;
        
        // Capture written data or read data depending on transaction type
        if (vif.pwrite)
          tx.data = vif.pwdata;
        else
          tx.data = vif.prdata;
        
        // Send the captured packet to the scoreboard
        mon2scb.put(tx);
      end
    end
  endtask

endclass