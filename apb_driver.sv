class apb_driver;
  
  virtual apb_if vif;
  mailbox #(apb_transaction) gen2drv;

  function new(virtual apb_if vif, mailbox #(apb_transaction) gen2drv);
    this.vif = vif;
    this.gen2drv = gen2drv;
  endfunction

  task reset_bus();
    vif.presetn <= 0;
    vif.psel    <= 0;
    vif.penable <= 0;
    vif.pwrite  <= 0;
    vif.paddr   <= 0;
    vif.pwdata  <= 0;
    #20 vif.presetn <= 1;
  endtask

  task run();
    apb_transaction tx;
    
    forever begin
      // Wait for a transaction from the Generator
      gen2drv.get(tx);
      
      @(posedge vif.pclk);
      // SETUP phase
      vif.psel    <= 1;
      vif.pwrite  <= tx.is_write;
      vif.paddr   <= tx.addr;
      if (tx.is_write) vif.pwdata <= tx.data;
      vif.penable <= 0;
      
      @(posedge vif.pclk);
      // ACCESS phase
      vif.penable <= 1;
      
      wait(vif.pready);
      
      @(posedge vif.pclk);
      // IDLE phase
      vif.psel    <= 0;
      vif.penable <= 0;
    end
  endtask
endclass