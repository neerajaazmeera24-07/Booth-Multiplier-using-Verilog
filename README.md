# Booth Multiplier using Verilog

## Overview

This project implements an **8-bit Signed Booth Multiplier** using **Verilog HDL** based on a **modular Register Transfer Level (RTL) architecture**. The design performs signed binary multiplication efficiently by implementing **Booth's Algorithm**, reducing the number of addition and subtraction operations compared to conventional multiplication methods.

The architecture separates the **Control Unit (Finite State Machine)** and the **Datapath**, making the design scalable, modular, and easier to verify.

---

## Features

- 8-bit Signed Booth Multiplication
- Modular RTL Design
- Separate Control Unit and Datapath
- FSM-based Control Logic
- Arithmetic Right Shift Operation
- Register-based Datapath
- Adder/Subtractor ALU
- Counter-controlled Iterations
- Synthesizable Verilog Code
- Verilog Testbench for Functional Verification

---

## Booth Algorithm

Booth's Algorithm performs multiplication by examining two bits:

- Current LSB of Multiplier (Q0)
- Previous Bit (Q-1)

| Q0 | Q-1 | Operation |
|----|------|-----------|
|0|0|No Operation|
|0|1|Add Multiplicand|
|1|0|Subtract Multiplicand|
|1|1|No Operation|

After each operation, an **Arithmetic Right Shift** is performed and the process repeats until all bits are processed.

---

## Project Architecture

The project follows a modular RTL architecture.

```
                    +----------------------+
                    |   Control Unit (FSM) |
                    +----------+-----------+
                               |
                     Control Signals
                               |
                               v
                +-----------------------------+
                |         Datapath            |
                |                             |
                |  Accumulator Register (A)   |
                |  Multiplier Register (Q)    |
                |  Multiplicand Register (M)  |
                |  Q(-1) Flip-Flop            |
                |  Adder/Subtractor           |
                |  Counter                    |
                +-------------+---------------+
                              |
                              |
                       Product Output
```
## Datapath Components

### Multiplicand Register (M)

Stores the multiplicand throughout the multiplication process.

### Multiplier Register (Q)

Stores the multiplier and performs arithmetic right shift after every iteration.

### Accumulator Register (A)

Stores intermediate partial products generated during multiplication.

### Q(-1) Flip-Flop

Stores the previous least significant bit of the multiplier, which is required for Booth encoding.

### ALU

Performs

- Addition
- Subtraction

depending on the Booth encoding.

### Counter

Counts the number of iterations.

For an 8-bit multiplier,

Number of iterations = 8.

---

## Control Unit

The controller is implemented using a Finite State Machine (FSM).

### States

- Idle
- Load Registers
- Check Q0 and Q(-1)
- Add
- Subtract
- Arithmetic Shift
- Decrement Counter
- Done

The FSM generates all required control signals for the datapath.

---

## RTL Modules

| Module | Description |
|----------|-------------|
|booth_multiplier_top.v|Top-level module|
|control_unit.v|FSM Controller|
|datapath.v|Main datapath|
|register.v|Generic register|
|adder_subtractor.v|Arithmetic Unit|
|arithmetic_shift.v|Arithmetic Shift Logic|
|counter.v|Iteration Counter|
|comparator.v|Booth Bit Comparator|

---

## Simulation

The design is verified using a Verilog Testbench.

### Test Cases

| Multiplicand | Multiplier | Expected Output |
|--------------|------------|-----------------|
|5|3|15|
|8|4|32|
|-5|3|-15|
|5|-3|-15|
|-8|-4|32|
|0|15|0|
|127|2|254|
|-128|1|-128|

Simulation waveforms confirm the correct functionality for both positive and negative signed multiplication.

---

## Example Simulation

```
Multiplicand = 5
Multiplier   = 3

Expected Product = 15

Simulation Result = 15

PASS

---

## Design Flow

```
Start

↓

Load Registers

↓

Check (Q0,Q-1)

↓

Add / Subtract

↓

Arithmetic Right Shift

↓

Counter--

↓

Counter == 0 ?

↓

No → Repeat

↓

Yes

↓

Done
```

---

## Tools Used

- Verilog HDL
- ModelSim
- Vivado Simulator
- GTKWave (optional)
- Git
- GitHub

---

## How to Run

### Compile

```
vlog rtl/*.v tb/booth_multiplier_tb.v
```

### Simulate

```
vsim booth_multiplier_tb
```

### Run Simulation

```
run -all
```

### View Waveforms

```
add wave *
```

---

## Applications

- Digital Signal Processing (DSP)
- Processor Arithmetic Logic Units
- Embedded Systems
- FPGA Design
- ASIC Design
- Computer Architecture

---

## Future Improvements

- Parameterized Booth Multiplier
- Radix-4 Booth Algorithm
- Wallace Tree Integration
- Pipelined Architecture
- FPGA Implementation
- SystemVerilog Verification Environment

---

## Learning Outcomes

Through this project, the following concepts were implemented and understood:

- Register Transfer Level (RTL) Design
- Modular Hardware Design
- Finite State Machine (FSM)
- Booth Multiplication Algorithm
- Sequential Circuit Design
- Datapath and Controller Separation
- Arithmetic Shift Operations
- Verilog Testbench Development
- Simulation and Functional Verification
