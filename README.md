<div align="center">

# 🚀 SPI Master & SPI Slave Controller
### Verilog HDL Implementation for FPGA

![Verilog](https://img.shields.io/badge/Language-Verilog-blue?style=for-the-badge)
![FPGA](https://img.shields.io/badge/Target-FPGA-success?style=for-the-badge)
![Quartus](https://img.shields.io/badge/Tool-Intel%20Quartus-blueviolet?style=for-the-badge)
![ModelSim](https://img.shields.io/badge/Simulation-ModelSim-orange?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green?style=for-the-badge)

---

## 📖 Project Overview

This project presents a complete **SPI (Serial Peripheral Interface)** communication system designed using **Verilog HDL**. The design includes both **SPI Master** and **SPI Slave** modules with complete RTL implementation and simulation verification.

The Master generates the SPI clock and controls data transmission, while the Slave receives and transmits serial data through the SPI protocol.

---

## ✨ Features

✔ SPI Master Design

✔ SPI Slave Design

✔ Full Duplex Communication

✔ MOSI & MISO Data Transfer

✔ SCLK Generation

✔ Chip Select (CS)

✔ RTL Simulation

✔ Testbench Verification

✔ FPGA Ready Design

---

# 🏗 Architecture

```
               +----------------------+
               |      SPI MASTER      |
               |----------------------|
               | MOSI ----------->    |
               | MISO <-----------    |
               | SCLK ----------->    |
               | CS   ----------->    |
               +----------|-----------+
                          |
                          |
               +----------V-----------+
               |      SPI SLAVE       |
               |----------------------|
               | Receives MOSI Data   |
               | Sends MISO Data      |
               +----------------------+
```

---

## 📂 Repository Structure

```
SPI_Master_Slave/
│
├── RTL/
│   ├── spi_master.v
│   ├── spi_slave.v
│
├── Testbench/
│   ├── spi_master_tb.v
│   ├── spi_slave_tb.v
│
├── Simulation/
│   ├── Waveform.png
│
├── Images/
│   ├── Block_Diagram.png
│   ├── RTL.png
│
└── README.md
```

---

## ⚙️ Tools Used

- Verilog HDL
- Intel Quartus Prime
- ModelSim
- FPGA Development Flow

---

## 📡 SPI Signals

| Signal | Description |
|---------|-------------|
| MOSI | Master Out Slave In |
| MISO | Master In Slave Out |
| SCLK | Serial Clock |
| CS | Chip Select |

---

## 🧪 Verification

Simulation was performed using **ModelSim** to verify:

- Serial Data Transmission
- Serial Data Reception
- Clock Synchronization
- Chip Select Operation
- SPI Timing

---

## 🚀 Applications

- FPGA Designs
- Embedded Systems
- Sensor Interfaces
- EEPROM Communication
- ADC/DAC Interfaces
- Microcontroller Communication

---

## 👩‍💻 Author

**Madhumitha**

RTL Design | Verilog HDL | FPGA | Digital Design

---

<div align="center">

### ⭐ If you found this project useful, please consider giving it a Star!

</div>
