# Mini RISC-V CPU Core

A minimal single-cycle RISC-V CPU core built from scratch in Verilog HDL, inspired by the PicoRV32 design philosophy.

## Project Info
- **Tech:** Verilog HDL
- **Simulator:** JDoodle (Icarus Verilog)
- **Difficulty:** Intermediate
- **Architecture:** Single-cycle RISC-V (R-type instructions)

## Modules
| File | Description |
|------|--------------|
| register_file.v | 32 x 32-bit register file (x0 hardwired to 0) |
| alu.v | Arithmetic Logic Unit (ADD, SUB, AND, OR, XOR, SLL, SRL, SLT) |
| decoder.v | Instruction decoder for R-type RISC-V instructions |
| pc_imem.v | Program Counter + Instruction Memory |
| mini_cpu.v | Top-level CPU connecting all modules |
| tb_mini_cpu.v | Testbench running ADD, SUB, AND instructions |

## How It Works
Every CPU cycle follows the Fetch-Decode-Execute-Writeback flow:
1. **Fetch:** PC points to instruction memory, instruction is read
2. **Decode:** Instruction is split into opcode, rd, rs1, rs2, funct3, funct7
3. **Execute:** ALU performs the operation based on decoded fields
4. **Writeback:** Result is written back to the register file

## Pipeline Timing Fix
A key bug was identified and resolved: register writeback requires the `rd` 
and ALU result to be delayed by one clock cycle to stay synchronized with 
the instruction that produced them — a fundamental concept in pipelined CPU design.

## Simulation Results
```
Final: x3=20 (ADD 15+5) x5=10 (SUB 15-5) x7=5 (AND 15&5)
```

## Learning Outcomes
- RISC-V instruction set basics (R-type format)
- Parameterized RTL design
- CPU execution flow: Fetch → Decode → Execute → Writeback
- Debugging timing/synchronization hazards in digital design
