# ⚡ Electric Field Line Visualization in MATLAB

This repository contains a MATLAB script that visualizes the electric field lines created by two point charges using numerical integration (ODE45). The user can specify the charge magnitudes, distance between the charges, and the number of field lines. 
The simulation uses vector field analysis and differential equations to plot the field lines.

## 📌 Features

- Supports arbitrary values of `q1`, `q2` (nonzero point charges)
- User-defined number of field lines and charge separation
- Symmetric field line plotting in both directions
- Visual representation of positive and negative charges

## 🧠 How it Works

- The differential equation governing the field line direction is derived from the ratio of electric field components \( dy/dx = E_y / E_x \).
- Field lines are computed using MATLAB’s built-in `ode45` solver.
- The charges are plotted as filled circles with different colors to indicate polarity.

## 🧪 Dependencies

- MATLAB (any version supporting `ode45`)
- No toolboxes required

## ▶️ How to Use

Run the following command in MATLAB:

```matlab
field_lines
