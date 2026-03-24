# 🚗 ADAS CNN Hardware Accelerator (VLSI)

---

## 📑 Table of Contents

* Introduction
* Features
* Technologies
* Architecture
* Quickstart
* Documentation
* Results
* Project Structure
* Conclusion

---

## 📖 Introduction

The ADAS CNN Hardware Accelerator is a Verilog RTL project that implements a Convolutional Neural Network (CNN) accelerator for automotive applications.

This design performs 3×3 convolution and ReLU activation using a sliding window architecture controlled by a Finite State Machine (FSM).

The project demonstrates a complete VLSI front-end flow, including:

* RTL Design
* Simulation
* Synthesis
* Timing Analysis

---

## ✨ Features

The CNN Accelerator provides the following features:

* ⚡ 3×3 Convolution Engine
* 🔁 FSM-Controlled Processing
* 🪟 Sliding Window Architecture
* 🧠 Multi-channel CNN Support
* 🔢 Fixed-Point Arithmetic Design
* ⚙️ DSP Block Utilization
* 📡 Streaming Output Generation
* 🧩 Modular Design (Scalable)

---

## 🛠️ Technologies

Technologies used in this project:

* **Language:** Verilog HDL
* **Simulation:** ModelSim
* **Synthesis:** Intel Quartus Prime
* **Timing Analysis:** TimeQuest Analyzer

---

## 🧠 Architecture

### CNN Accelerator Architecture

<img width="1337" height="671" alt="CNN Architecture" src="https://github.com/user-attachments/assets/37917162-a0d2-47bc-a047-7dd227bd93bd" />


## 🧠 CNN Architecture Explanation

The Convolutional Neural Network (CNN) architecture consists of multiple layers that work together to extract features and perform classification.

### 🔹 Convolutional Layer

* Performs feature extraction using filters (kernels)
* Detects edges, textures, and patterns in the input image
* Implemented in hardware using MAC (Multiply-Accumulate) operations

### 🔹 Activation Layer (ReLU)

* Introduces non-linearity into the system
* Removes negative values:

  ```
  f(x) = max(0, x)
  ```
* Helps the network learn complex patterns

### 🔹 Pooling Layer

* Reduces the spatial size of feature maps
* Preserves important features while reducing computation
* In this project, Max Pooling (2×2) is used

### 🔹 Fully Connected Layer (Conceptual)

* Used in full CNN models for classification
* Converts extracted features into final predictions
* Not fully implemented in this hardware design (simplified accelerator)

### 🔹 Output Layer

* Produces the final processed result
* In this project, represents the output of the CNN pipeline

---

## ⚙️ Hardware Mapping (This Project)

The CNN architecture is simplified and mapped into hardware as:

```
Input → Convolution → ReLU → Pooling → Output
```

* Convolution → Implemented using MAC units and DSP blocks
* ReLU → Simple comparator logic
* Pooling → Max selection logic
* Pipeline registers → Improve timing and throughput

---


---

### 2️⃣ Run Simulation (ModelSim)

```bash
vlog rtl/*.v tb/*.v
vsim cnn_tb
run -all
```

---

### 3️⃣ Run Synthesis (Quartus)

* Add all RTL files
* Set top module → `cnn_top`
* Add `constraints/cnn.sdc`
* Click **Start Compilation**

---

### 4️⃣ Timing Analysis

* Open **TimeQuest Analyzer**
* Run **Report Timing**
* Verify **Positive Slack**

---

## 📚 Documentation

### 🔄 Data Flow

```text
Input Image → Sliding Window → Convolution → ReLU → Output
```

---

### ⚙️ Key Modules

| Module     | Function              |
| ---------- | --------------------- |
| cnn_top.v  | FSM + control logic   |
| conv3x3.v  | Convolution operation |
| mac_unit.v | Multiply-accumulate   |
| relu.v     | Activation            |
| max_pool.v | Pooling               |

---

## 📊 Results

* ✔ Simulation Successful
* ✔ Synthesis Completed
* ✔ Quartus Compilation Successful
* ✔ DSP Blocks Utilized
* ✔ Timing Closure Achieved (Positive Slack)

---

## 📁 Project Structure

```text
ADAS-CNN-Accelerator/
 ┣ rtl/
 ┃ ┣ cnn_top.v
 ┃ ┣ conv3x3.v
 ┃ ┣ mac_unit.v
 ┃ ┣ relu.v
 ┃ ┗ max_pool.v
 ┣ tb/
 ┃ ┗ cnn_tb.v
 ┣ docs/
 ┃ ┣ waveform.png
 ┃ ┣ rtl_view.png
 ┃ ┣ synthesis.png
 ┃ ┗ timing.png
 ┣ constraints/
 ┃ ┗ cnn.sdc
 ┗ README.md
```

---

## ⭐ Conclusion

This project demonstrates a complete CNN hardware accelerator design for ADAS applications, covering the full VLSI flow from RTL design to timing closure.

It is highly valuable for:

* VLSI Interviews
* FPGA Development
* Hardware AI Acceleration
---

