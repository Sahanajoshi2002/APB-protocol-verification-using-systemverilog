class apb_scoreboard;
  
  // The associative array to track expected memory state
  logic [31:0] ref_mem [int];
  
  int error_count = 0;
  int match_count = 0;

  // Called after a write transaction completes
  function void record_write(logic [31:0] addr, logic [31:0] data);
    ref_mem[addr] = data;
  endfunction

  // Called after a read transaction completes to verify data
  function void check_read(logic [31:0] addr, logic [31:0] actual_data);
    logic [31:0] expected_data;
    
    // Look up what we expect
    if (ref_mem.exists(addr))
      expected_data = ref_mem[addr];
    else
      expected_data = 32'hx; // Address was never written

    // Compare
    if (actual_data !== expected_data) begin
      $error("[FAIL] Addr: 0x%0h | Expected: 0x%0h | Actual: 0x%0h", addr, expected_data, actual_data);
      error_count++;
    end else begin
      $display("[PASS] Addr: 0x%0h | Data: 0x%0h matches", addr, actual_data);
      match_count++;
    end
  endfunction

endclass