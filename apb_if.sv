interface apb_if (input logic pclk, input logic presetn);
  logic [31:0] paddr;
  logic        pwrite;
  logic        psel;
  logic        penable;
  logic [31:0] pwdata;
  logic [31:0] prdata;
  logic        pready;
  logic        pslverr;
  
  clocking cb @(posedge pclk);
    default input #1step output #1;
    output paddr, pwrite, psel, penable, pwdata;
    input  prdata, pready, pslverr;
  endclocking
endinterface