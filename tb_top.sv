`include "apb_if.sv"
`include "apb_transaction.sv"
`include "apb_generator.sv"
`include "apb_driver.sv"
`include "apb_monitor.sv"
`include "apb_scoreboard.sv"
`include "apb_env.sv"

program apb_test(apb_if vif);
  apb_environment env;

  initial begin
    env = new(vif);
    env.driv.reset();
    env.run();
    repeat(5) @(posedge vif.pclk);
    $display("========================================");
    $display("[TEST] Simulation complete.");
    $display("========================================");
    $finish;
  end
endprogram

module tb_top;
  logic pclk;
  logic presetn;

  initial begin
    pclk = 0;
    forever #5 pclk = ~pclk;
  end

  initial begin
    presetn = 0;
    #20 presetn = 1;
  end

  apb_if vif(pclk, presetn);
  apb_test test(vif);

  apb_slave_memory dut (
    .pclk    (vif.pclk),
    .presetn (vif.presetn),
    .paddr   (vif.paddr),
    .pwrite  (vif.pwrite),
    .psel    (vif.psel),
    .penable (vif.penable),
    .pwdata  (vif.pwdata),
    .prdata  (vif.prdata),
    .pready  (vif.pready),
    .pslverr (vif.pslverr)
  );

  initial begin
    $dumpfile("apb_waves.vcd");
    $dumpvars(0, tb_top);
  end
endmodule