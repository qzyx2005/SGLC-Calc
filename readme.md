# SGLC-Calc: Satellite-to-Ground Laser Communication Simulation Tool

**SGLC-Calc** is a specialized simulation tool developed in MATLAB to facilitate complex link budget analysis for satellite-to-ground laser communication (SGLC). Unlike simplified scripts, this tool integrates a comprehensive suite of atmospheric impairments—including turbulence, rain, snow, fog, and clouds—into a unified, user-friendly interface.

## 1. Description

The software utilizes a **Model-View-Controller (MVC)** architecture to ensure modularity and a standardized data flow from user configuration to dynamic visualization.

### Key Technical Capabilities

* **Standardized Physical Modeling**
    The core engine implements rigorous empirical models, such as the Kim model for fog, the Carbonneau model for rain, and ITU-R recommendations for snow.

* **Bi-directional Asymmetry Analysis**
    The tool explicitly distinguishes between uplink and downlink channels. It accounts for turbulence-induced scintillation differences by applying an aperture averaging factor specifically for the space-to-ground downlink path.

* **Dynamic Geometric Scanning**
    Instead of static calculations, SGLC-Calc features an orbital mechanics module that dynamically updates slant range and atmospheric path length as the satellite traverses elevation angles from 45° to 90°.

* **Cloud Interference Modeling**
    It incorporates a Mie scattering model based on ground station altitude and wavelength to evaluate link reliability under cloudy conditions.

* **Real-time Visualization**
    The GUI provides immediate graphical feedback, including received power profiles, link margin vs. weather curves, and sorted loss breakdown charts to identify system bottlenecks.

---

## 2. Requirements & Environment

To run the executable version of SGLC-Calc, you do not need a full MATLAB installation, but the following environment is required:

* **Operating System:** Windows 10 or higher.
* **MATLAB Runtime:** Version **R2024b (9.17)** is required to run the standalone application.
* **Development Environment:** MATLAB App Designer (required only for source code execution).

---

## 3. Installation & Usage

### Prerequisites for Deployment

Before running the software, verify that **MATLAB Runtime (R2024b)** is installed on your system. If it is not installed:

1.  Download the Windows version of the MATLAB Runtime for R2024b from the MathWorks website:  
    [MathWorks MCR Link](https://www.mathworks.com/products/compiler/mcr/index.html)
2.  Run the installer (Administrator rights are required).
3.  Alternatively, if you have MATLAB installed, you can find the runtime location by entering the following command at the MATLAB prompt:
    ```matlab
    mcrinstaller
    ```

### Running the Application

1.  Navigate to the directory containing `SGLC_Calc_V1.exe`.
2.  Double-click the executable to launch the GUI.
3.  Load the default parameters or manually input your specific satellite orbit and atmospheric conditions.

---

## 4. Simple Example

To perform a basic link budget analysis:

1.  **Step 1:** Select the communication direction (**Uplink** or **Downlink**).
2.  **Step 2:** Input the satellite altitude (e.g., for GEO).
3.  **Step 3:** Choose the weather condition (e.g., "Moderate Rain" with a specific rainfall rate).
4.  **Step 4:** Click **"Calculate"** to generate the link budget table and power distribution plots.

---

## 5. Deployment Information

*Original deployment notes provided by the developer:*

### Files to Deploy and Package

The following files are necessary for standalone deployment:

* `SGLC_Calc_V1.exe`: The main standalone executable.
* `MCRInstaller.exe`: The MATLAB Runtime installer (optional if already installed).
* `readme.txt`: Original definition and prerequisite file.

### Definitions

For more information on deployment terminology, visit the [MathWorks Documentation Center](https://www.mathworks.com/help) and navigate to:
> MATLAB Compiler > Getting Started > About Application Deployment