class apb_transaction;
  
  rand logic [31:0] addr;
  rand logic [31:0] data;
  rand logic        is_write; // 1 for Write, 0 for Read

  // Constraints to keep addresses valid
  // Example: 1KB memory range, word-aligned addresses (multiples of 4)
  constraint c_addr { 
    addr[1:0] == 2'b00; 
    addr < 32'h0000_0400; 
  }

  // Helper function to print the transaction
  function void print(string tag="");
    $display("[%s] %s Addr: 0x%0h | Data: 0x%0h", 
             tag, (is_write ? "WRITE" : "READ "), addr, data);
  endfunction

endclass