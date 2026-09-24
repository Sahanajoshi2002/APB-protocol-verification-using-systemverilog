APB Slave Memory Verification using SystemVerilog

Overview 
- Generator
- Driver
- Monitor
- Scoreboard
- Environment
- APB Interface
- Testbench / Top
- APB Slave Memory (DUT)

Architecture

Generator
    |
Transaction
    |
  Driver
    |
APB Interface
    |
APB Slave Memory (DUT)
    |
  Monitor
    |
Scoreboard
    ^
    |
Reference / Expected Data

Operations Verified

- APB write transactions
- APB read transactions
- Address and data handling
- Read-data checking
- Expected vs actual result comparison

Technologies

- SystemVerilog
- APB Protocol
- Simulation-based functional verification

Project Structure

APB-Slave-Memory/
├── apb_slave_memory.sv
├── apb_if.sv
├── transaction.sv
├── generator.sv
├── driver.sv
├── monitor.sv
├── scoreboard.sv
├── env.sv
├── tb_apb.sv
└── tb_top.sv

Key Learning

This project helped me build a SystemVerilog-based verification environment and understand transaction generation, stimulus driving, monitoring, environment construction, and scoreboard-based checking.
