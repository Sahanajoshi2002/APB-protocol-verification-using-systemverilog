module tb_apb_slave;

  logic pclk;
  logic presetn;
  
  // The interface from before
  apb_if vif(pclk, presetn);

  // --- DROP YOUR RTL HERE ---
  // Replace 'your_actual_rtl_module' with the exact name of your Verilog module.
  // We map the interface signals (vif.xxx) to the physical pins of your RTL.
  your_actual_rtl_module dut (
    .pclk    (vif.pclk),
    .presetn (vif.presetn),
    .paddr   (vif.paddr),
    .psel    (vif.psel),
    .penable (vif.penable),
    .pwrite  (vif.pwrite),
    .pwdata  (vif.pwdata),
    .prdata  (vif.prdata),
    .pready  (vif.pready),
    .pslverr (vif.pslverr)
  );

  // --- EVERYTHING ELSE STAYS EXACTLY THE SAME ---
  
  // The associative array scoreboard
  logic [31:0] ref_mem [int];
  int error_count = 0;
  int match_count = 0;

  // Clock generation...
  // reset_dut() task...
  // apb_write() task...
  // apb_read_check() task...
  // initial begin test sequence...

endmodule