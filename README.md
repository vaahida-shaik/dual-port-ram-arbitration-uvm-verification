# dual-port-ram-arbitration-uvm-verification

UVM-based verification of a True Dual-Port RAM with conflict arbitration, relocation logic, assertions, functional coverage, and constrained-random validation.

---

# 🚀 UVM Verification of True Dual-Port RAM with Smart Arbitration & Conflict Resolution

**Complete SystemVerilog + UVM verification environment for a dual-clock RAM supporting concurrent access, relocation-based arbitration, memory-full handling, assertions, and coverage-driven verification.**

---

# 📌 Project Overview

This project implements and verifies a **True Dual-Port RAM (256 × 8)** using **Verilog RTL** and a **SystemVerilog UVM testbench**.

The design supports:

* Simultaneous access from two independent ports
* Separate clock domains
* Concurrent read/write operations
* Smart arbitration during write conflicts
* Memory-full protection
* Dynamic relocation for Port B writes

A scalable UVM environment was developed to verify functionality, corner cases, protocol legality, and concurrent memory behavior.

---

# ❓ Problem Statement

In shared-memory systems, multiple masters may attempt to access the same memory simultaneously.

This creates challenges such as:

* Write-write conflicts
* Data corruption
* Concurrent access synchronization
* Memory allocation handling
* Arbitration fairness

This project focuses on verifying these real hardware scenarios using advanced UVM methodologies.

---

# ⚙️ DUT Specifications

| Feature       | Description                    |
| ------------- | ------------------------------ |
| Memory Type   | True Dual-Port RAM             |
| Memory Size   | 256 × 8                        |
| Address Width | 8-bit                          |
| Data Width    | 8-bit                          |
| Ports         | Port A & Port B                |
| Clock Domains | Independent (`clk_a`, `clk_b`) |
| Read Type     | Synchronous                    |
| Arbitration   | Conflict-aware relocation      |
| RTL Language  | Verilog                        |

---

# 🧠 Arbitration Logic

The DUT implements a custom conflict-resolution mechanism.

## ✔ Port A Behavior

* Always writes directly to requested address
* Has implicit priority during conflicts

## ✔ Port B Behavior

If both ports write to the same address simultaneously:

* Conflict is detected
* Port B searches for the next available free memory location
* Data is relocated dynamically
* If memory is full → write is skipped

This behavior was fully modeled and verified inside the reference model and scoreboard.

---

# 🏗️ UVM Testbench Architecture

The verification environment follows a modular layered UVM architecture.

## Components

### 🔹 Agent A & Agent B

Each agent contains:

* Sequencer
* Driver
* Monitor

Dedicated agents independently drive and monitor Port A and Port B.

---

### 🔹 Virtual Sequencer

Coordinates:

* Simultaneous transactions
* Conflict scenarios
* Parallel sequence execution

Used heavily for arbitration verification.

---

### 🔹 Drivers

Responsibilities:

* Drive DUT interface signals
* Synchronize transactions with independent clocks
* Handle read/write operations

---

### 🔹 Monitors

Responsibilities:

* Sample DUT transactions
* Capture outputs
* Forward transactions to scoreboard

---

### 🔹 Scoreboard

Implements:

* Predictive reference model
* Expected memory tracking
* Used-location tracking
* Conflict relocation prediction
* Read data comparison

Performs:

* PASS/FAIL checking
* Data integrity validation
* Arbitration validation

---

### 🔹 Reference Model

Tracks:

* Expected memory contents
* Used memory locations
* Port-specific arbitration behavior

Implements same relocation logic as DUT.

---

### 🔹 Functional Coverage

Coverage-driven verification implemented using:

* Covergroups
* Cross coverage
* Operation classification
* Port interaction tracking

---

# 🔥 Key Verification Features

## ✔ Constrained Random Verification

Randomized:

* Addresses
* Read/write operations
* Concurrent accesses

Constraints ensure:

* Legal transactions
* Proper read/write combinations

---

## ✔ Asynchronous Clock Verification

Both ports operate on independent clocks.

Verified:

* Concurrent operations
* Timing independence
* Cross-domain behavior

---

## ✔ Smart Arbitration Verification

Validated:

* Same-address write conflicts
* Dynamic relocation
* Memory-full behavior
* Partial-filled memory relocation

---

## ✔ Functional Coverage

Coverage collected for:

* Write operations
* Read operations
* Address ranges
* Port accesses
* Arbitration scenarios

Cross coverage includes:

* Operation × Address
* Operation × Port
* Write × Address × Port

---

## ✔ SystemVerilog Assertions (SVA)

Assertions added for:

* Illegal simultaneous read/write
* Conflict detection
* Unknown address detection
* Output validity checks

Coverage property added for arbitration conflict detection.

---

# 🧪 Test Scenarios Implemented

---

## ✅ TC-1 : Memory Initialization

Verified:

* All memory locations initialize to zero
* Read operations after reset return expected values

---

## ✅ TC-2 : Basic Read/Write

Verified:

* Independent reads and writes on both ports
* Correct data storage and retrieval

---

## ✅ TC-3 : Asynchronous Clock Operation

Verified:

* Dual independent clock operation
* Concurrent access under asynchronous timing

---

## ✅ TC-4 : Arbitration Conflict Handling

Scenario:

* Both ports write to same address simultaneously

Verified:

* Port A retains original address
* Port B relocates to next free location
* No data corruption

---

## ✅ TC-5 : Memory Full Condition

Scenario:

* Entire memory pre-filled

Verified:

* Port B skips write when no free location exists
* Existing memory contents remain intact

---

## ✅ TC-6 : Partial Memory Filling

Scenario:

* Selected address ranges pre-filled

Verified:

* Port B correctly relocates to nearest free location

---

## ✅ TC-7 : Multiple Writes Followed by Reads

Verified:

* Sequential write bursts
* Correct readback from all addresses

---

## ✅ TC-8 : Alternate Read/Write Operations

Verified:

* Back-to-back write/read behavior
* Dynamic transaction handling
* Stable data integrity

---

# 📊 Functional Coverage Model

Coverage points implemented for:

## Operation Coverage

* Read
* Write

## Address Coverage

* Low range
* Mid range
* High range
* Boundary addresses

## Data Coverage

* Low data values
* Mid data values
* High data values

## Port Coverage

* Port A accesses
* Port B accesses

---

## Cross Coverage

* Write × Address
* Operation × Address
* Operation × Port
* Write × Address × Port

---

# 🧾 Assertions Implemented

## ✔ Valid Operation Assertions

Ensures:

* Read and write are never enabled simultaneously

---

## ✔ Conflict Detection Coverage

Covers:

* Same-address concurrent writes

---

## ✔ Output Validity Assertions

Ensures:

* Output enable is not active during writes

---

## ✔ Unknown Address Assertions

Detects:

* X/Z values on address lines

---

# 🛠️ Tools & Technologies

| Category     | Tool / Language          |
| ------------ | ------------------------ |
| RTL Design   | Verilog                  |
| Verification | SystemVerilog            |
| Methodology  | UVM                      |
| Assertions   | SystemVerilog Assertions |
| Simulator    | Cadence Xcelium          |
| Waveforms    | SHM Waves                |

---


# ▶️ Compilation & Simulation
Xcelium compile command:

```bash
xrun -64 \
     +access+rwc \
     -uvm \
     design.sv \
     assertion.sv \
     package.sv \
     interface.sv \
     top.sv
```
**command to run:** irun -f run.f +UVM_TESTNAME=<name of the test>
**command to see waveform:** irun -access +rwc -f run.f +UVM_TESTNAME=<name of test> -gui
                                               
---

# 📈 Verification Achievements

✔ Verified concurrent dual-port operations
✔ Validated arbitration and relocation logic
✔ Tested asynchronous clock behavior
✔ Implemented predictive scoreboard model
✔ Achieved functional coverage across major scenarios
✔ Added protocol-level assertions
✔ Verified memory-full and partial-fill edge cases

---

# 🐞 Debug Challenges Solved

## Conflict Relocation Debugging

Resolved issues involving:

* Same-cycle write conflicts
* Incorrect relocation handling
* Data overwrite prevention

---

## Scoreboard Synchronization

Handled:

* Dual-clock transaction ordering
* Expected memory prediction
* Concurrent monitor updates

---

## Edge Case Handling

Debugged:

* Memory-full conditions
* Boundary addresses
* Back-to-back transactions

---

# ⚠️ Current Limitations / Future Improvements

## Possible Enhancements

* Add reset support in DUT
* Add burst transaction support
* Add code coverage metrics
* Add UVM register model
* Add formal verification
* Add randomized asynchronous clock ratios
* Add assertions for relocation correctness
* Add regression automation scripts

---

# 📚 Key Learnings

Through this project:

* Built a complete scalable UVM environment
* Learned concurrent memory verification
* Implemented predictive scoreboarding
* Worked with asynchronous clock domains
* Applied constrained-random verification
* Developed functional coverage models
* Integrated assertions with UVM
* Verified complex arbitration logic

---

# 🎯 Strong Interview Discussion Points

## Design Topics

* True dual-port RAM architecture
* Arbitration and relocation strategy
* Concurrent memory access handling

## Verification Topics

* Dual-agent UVM architecture
* Virtual sequencer coordination
* Predictive reference modeling
* Functional coverage planning
* Assertion-based verification
* Asynchronous clock verification

## Debug Topics

* Race condition handling
* Concurrent transaction synchronization
* Memory conflict debugging

---

# 👨‍💻 Author

Verification Engineer (Fresher)
Focus Areas:

* RTL Design
* SystemVerilog
* UVM Verification
* Assertions (SVA)
* Functional Coverage
* Digital Design Verification
