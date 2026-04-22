# dual-port-ram-arbitration-uvm-verification
UVM-based verification of a dual-port RAM with concurrent access, arbitration handling, and functional coverage-driven validation.
# 🚀 Advanced UVM Verification of True Dual-Port RAM with Conflict Resolution

**UVM-based verification of a dual-clock, conflict-resolving memory with constrained-random testing, functional coverage, and scoreboard-based validation.**

---

## 📌 Project Overview

This project focuses on the **verification of a True Dual-Port RAM (256 x 8)** using **SystemVerilog and UVM**.

The DUT supports:

* Simultaneous read/write operations on two independent ports
* Separate clock domains
* Priority-based arbitration with dynamic conflict resolution

A **complete UVM verification environment** was built to validate functionality, detect corner-case bugs, and ensure data integrity under concurrent operations.

---

## ❓ Why This Project?

Modern SoCs rely heavily on shared memory resources accessed by multiple masters.
Handling **concurrent access, arbitration, and data consistency** is critical.

This project demonstrates:

* Verification of concurrent hardware behavior
* Handling race conditions and write conflicts
* Validating multi-clock domain systems

---

## ⚙️ Design Specifications

* **Memory Size:** 256 x 8
* **Ports:** Dual (Port A & Port B)
* **Clock Domains:** Independent (clk_a, clk_b)
* **Arbitration Rule:**

  * Port A → Highest priority
  * Port B → Relocated to next free address on conflict
* **RTL:** Verilog (kept unchanged)
* **Verification:** SystemVerilog + UVM

---

## 🏗️ UVM Verification Architecture

* **Agents (Port A & Port B)**

  * Driver
  * Monitor
  * Sequencer

* **Virtual Sequencer**

  * Coordinates both ports simultaneously

* **Scoreboard**

  * Reference model for expected memory behavior
  * Performs data comparison and error detection

* **Coverage**

  * Functional coverage for scenario validation

* **Environment**

  * Integrates all UVM components

---

## 🔥 Key Engineering Highlights

* Built a scalable **dual-agent UVM architecture**
* Implemented **scoreboard with predictive reference model**
* Verified arbitration logic under **write-write conflicts**
* Simulated **asynchronous clock domain interactions**
* Used **constrained random testing** for scenario exploration
* Debugged edge cases like **memory full & relocation behavior**

---

## 🧪 Verification Strategy

Combination of:

* Directed testing
* Constrained random testing

---

## 🔍 Test Scenarios

### 🟢 Test 1 – Memory Initialization

* Verified all memory locations initialize to zero

### 🟢 Test 2 – Basic Read/Write

* Independent operations on both ports
* Verified correct data readback

### 🟢 Test 3 – Asynchronous Clock Operation

* Ports driven with different clock frequencies
* Verified independent operation

### 🔴 Test 4 – Conflict Arbitration

* Both ports write to same address
* Port A retains address
* Port B relocates to free location

### 🔴 Test 5 – Memory Full Condition

* Entire memory filled
* Verified behavior when no free space is available

### 🔴 Test 6 – Partial Memory Filling

* Pre-filled memory regions
* Verified correct relocation behavior

### 🟡 Test 7 – Burst Write → Read

* Multiple writes followed by reads
* Data integrity verified

### 🟡 Test 8 – Random Stress Testing

* Constrained random transactions
* High coverage achieved

---

## 📊 Functional Coverage

Coverage includes:

* Read vs Write operations
* Address ranges (low / mid / high / boundary)
* Port A vs Port B access
* Conflict scenarios

### Cross Coverage:

* Operation × Address
* Operation × Port
* Write × Address × Port

---

## 🧾 Scoreboard & Reference Model

* Tracks:

  * Memory contents
  * Used locations
  * Conflict resolution behavior

* Performs:

  * Expected vs Actual comparison
  * UVM-based error reporting

---

## 🐞 Debug & Observations

* Verified correct relocation during conflicts

* Identified edge cases in:

  * Memory full condition
  * Back-to-back conflicts

* Improved constraints to increase coverage

---

## ✅ What Was Verified

* Dual-port concurrent access
* Conflict arbitration logic
* Memory boundary conditions
* Multi-clock domain behavior

---

## ⚠️ What Can Be Improved

* Add SystemVerilog Assertions (SVA)
* Increase rare corner-case coverage
* Add regression automation
* Include code coverage metrics

---

## 🛠 Tools & Technologies

* **Language:** SystemVerilog
* **Methodology:** UVM
* **Simulator:** Cadence Xcelium

---

## 📚 Key Learnings

* Developed complete UVM testbench architecture
* Applied constrained random verification techniques
* Designed functional coverage for corner cases
* Verified complex concurrent memory behavior
* Improved debugging and validation strategies

---

## 🎯 Interview Talking Points

* Explained arbitration and conflict resolution mechanism
* Designed scoreboard with predictive modeling
* Verified concurrent writes under different clock domains
* Used constrained random testing for coverage improvement
* Debugged memory behavior under stress conditions

---

## 👨‍💻 Author

Verification Engineer (Fresher)
Focus: RTL Design + UVM + Digital Verification

