class apb_env;
  
  // Component handles
  apb_driver     drv;
  apb_scoreboard scb;
  virtual apb_if vif;

  // Constructor
  function new(virtual apb_if vif);
    this.vif = vif;
    
    // Instantiate the lower-level components
    drv = new(vif);
    scb = new();
  endfunction

  // --- High-Level Tasks --- 
  
  // Performs a physical write, then tells the scoreboard to remember it
  task do_write(logic [31:0] addr, logic [31:0] data);
    drv.write(addr, data);
    scb.record_write(addr, data);
  endtask

  // Performs a physical read, then passes the result to the scoreboard to check
  task do_read_check(logic [31:0] addr);
    logic [31:0] rdata;
    drv.read(addr, rdata);         // Driver grabs physical data
    scb.check_read(addr, rdata);   // Scoreboard checks it
  endtask

  // --- Main Test Sequence ---
  task run_test();
    $display("--- Starting APB Environment Test ---");
    
    drv.reset_bus();
    
    // 1. Write Sequence
    do_write(32'h0000_0004, 32'hDEADBEEF);
    do_write(32'h0000_0008, 32'hCAFEBABE);
    
    // 2. Read Sequence
    do_read_check(32'h0000_0004);
    do_read_check(32'h0000_0008);
    
    // 3. Overwrite Sequence
    do_write(32'h0000_0004, 32'h12345678);
    do_read_check(32'h0000_0004);
    
    $display("\n--- Test Complete ---");
    $display("Total Matches: %0d | Total Errors: %0d", scb.match_count, scb.error_count);
  endtask

endclass