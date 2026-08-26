# Portfolio Summary: Simulated Wearable Manufacturing Quality Dashboard

> **Simulation notice:** All data, results, and quality records in this project are fictional and created for educational portfolio purposes only.

## Overview

Built an end-to-end manufacturing-quality analytics project for a simulated wearable heart-rate monitor, using 2,400 synthetic unit records generated with a fixed random seed for full reproducibility.

## Technical Contribution

- Generated a reproducible synthetic manufacturing dataset in Python (NumPy, pandas) with production line, shift, test station, firmware version, defect category, and three continuous test measures
- Validated data completeness, unit-ID uniqueness, and column typing
- Calculated first-pass yield, failure rate, and rework rate, then segmented results by line, station, shift, and firmware version
- Produced a defect Pareto chart with cumulative-percentage analysis
- Analyzed daily yield trends and excluded low-volume build days from the trend visualization
- Calculated exploratory one-sided Cpu screening indices against simulated upper specification limits
- Reproduced the same KPI, segmentation, and Pareto results in SQLite using CTEs, conditional aggregation, and window functions
- Documented a CAPA-style investigation with containment actions, five-why root-cause analysis, corrective and preventive actions, and effectiveness checks

## Key Simulated Results

| Metric | Result |
|---|---:|
| Units analyzed | 2,400 |
| Overall first-pass yield | 79.5% |
| FPY, FW-SIM-0.2 vs FW-SIM-0.3 | 75.1% vs 84.1% |
| Mean response time, FW-SIM-0.2 vs FW-SIM-0.3 | 4.32 s vs 3.84 s |
| Response-time screening index | Cpu = 0.45 |
| Heart-rate-error screening index | Cpu = 0.60 |

## Skills Demonstrated

Python, pandas, NumPy, Matplotlib, SQL (SQLite), quality KPI analysis, Pareto analysis, trend analysis, exploratory process-performance screening, CAPA and root-cause analysis, reproducible notebooks, and version-controlled technical documentation.

## Limitations

This project does not represent real product performance, manufacturing quality, process validation, regulatory compliance, or an actual CAPA system. The Cpu values are exploratory screening metrics only, since process stability, normality, measurement-system validity, and representative sampling were not established.
