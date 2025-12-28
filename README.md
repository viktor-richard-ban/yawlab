# YawLab

YawLab is a **motorsport aerodynamic analysis tool** focused on exploring how **crosswind and aerodynamic yaw** affect drag and downforce during a lap.

The application combines real motorsport telemetry with simplified, benchmark-anchored aerodynamic models to replicate the **data-fusion workflow used in professional race teams**. It is designed for **engineering investigation**, not simulation or performance prediction.

---

## What It Does

- Ingests motorsport telemetry (FastF1)
- Computes vehicle heading from track position
- Computes aerodynamic yaw from relative wind
- Applies an Ahmed / DrivAer-anchored aero reference model
- Derives drag and downforce from CL / CD
- Compares baseline vs crosswind scenarios
- Visualizes all signals as synchronized time-series

---

## Design Philosophy

- Engineering tool, not a dashboard
- Explicit assumptions and transparent models
- Time-aligned analysis over summary metrics
- Focus on trends and sensitivities, not absolutes

---

## Status

YawLab is an active development project intended as a **portfolio demonstration of aero software engineering** concepts.

---

## Disclaimer

All aerodynamic models are simplified and intended for analysis demonstration only.  
This project is not affiliated with Formula 1 or any racing team.
