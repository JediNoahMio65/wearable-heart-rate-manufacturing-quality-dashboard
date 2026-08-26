# Simulated CAPA-Style Manufacturing Quality Investigation

> **Simulation notice:** This document uses fictional manufacturing, test, and quality data created for educational portfolio purposes only. It is not a real CAPA record, product investigation, manufacturing record, regulatory submission, or evidence of device performance.

## 1. Investigation Summary

| Field | Simulated Record |
|---|---|
| Investigation ID | CAPA-MFG-SIM-001 |
| Title | Elevated Manufacturing Failure Rate and Response-Time Performance Variation |
| Data source | `data/synthetic_manufacturing_data.csv` |
| Analysis sources | Python notebooks 02–03 and SQL notebook/script 04 / `sql/01_manufacturing_quality_analysis.sql` |
| Product | Simulated wearable heart-rate monitor |
| Investigation status | Closed for educational portfolio scenario |
| Scope | 2,400 simulated unit records built from July 1–28, 2026 |

## 2. Problem Statement

Analysis of 2,400 simulated manufacturing records identified a first-pass yield below the 95% reference line used in the dashboard. Overall simulated first-pass yield was approximately 79.5%.

The simulated process also showed elevated variation relative to the defined upper limits for two performance measures:

| Metric | Simulated Mean | Upper Specification Limit | Simulated Screening Index |
|---|---:|---:|---:|
| Response time | 4.09 seconds | 5.00 seconds | Cpu = 0.45 |
| Heart-rate error | 2.62 bpm | 5.00 bpm | Cpu = 0.60 |

These values are exploratory screening results only. They do not establish formal process capability because the synthetic dataset is limited and process stability was not formally demonstrated.

## 3. Evidence Reviewed

| Analysis Area | Simulated Finding |
|---|---|
| Overall quality | Approximately 79.5% first-pass yield across 2,400 units |
| Yield trend | Average FPY increased from 76.0% during the first seven build days to 85.2% during the final seven eligible build days |
| Firmware comparison | FW-SIM-0.2 had 75.1% FPY and 4.32-second mean response time; FW-SIM-0.3 had 84.1% FPY and 3.84-second mean response time |
| Response-time screening | Overall mean response time was 4.09 seconds with simulated Cpu of 0.45 against a 5.00-second upper specification limit |
| Heart-rate-error screening | Overall mean heart-rate error was 2.62 bpm with simulated Cpu of 0.60 against a 5.00-bpm upper specification limit |
| Defect analysis | Defect categories were ranked using a Pareto analysis in `dashboards/defect_pareto.png` |
| Production segmentation | Results were reviewed by production line, test station, firmware version, build date, shift, and defect category |

## 4. Containment Actions

The following actions are simulated controls for the portfolio scenario:

| Action ID | Simulated Containment Action | Purpose | Status |
|---|---|---|---|
| CA-01 | Place FW-SIM-0.2 configuration under simulated production hold | Prevent additional builds using the lower-yield configuration | Complete |
| CA-02 | Require 100% review of response-time results for units exceeding 4.5 seconds | Identify units approaching the 5.00-second limit | Complete |
| CA-03 | Flag low-signal-quality failures for test-station review | Focus investigation on station-related signal-quality variation | Complete |
| CA-04 | Maintain lot-level traceability for line, shift, station, and firmware version | Support continued trend analysis | Complete |

## 5. Simulated Root-Cause Analysis

### 5.1 Investigation Hypothesis

The primary simulated contributor to elevated failure rate and response-time variation was the FW-SIM-0.2 configuration, which used the earlier signal-processing configuration.

This hypothesis is supported by the observed performance difference:

| Firmware Version | Units Tested | FPY | Mean Response Time |
|---|---:|---:|---:|
| FW-SIM-0.2 | 1,244 | 75.1% | 4.32 seconds |
| FW-SIM-0.3 | 1,156 | 84.1% | 3.84 seconds |

### 5.2 Five-Why Analysis

| Why? | Simulated Answer |
|---|---|
| Why was first-pass yield below the 95% reference? | A meaningful portion of units failed response-time, heart-rate-error, low-signal-quality, assembly, or cosmetic criteria. |
| Why were response-time failures elevated? | The earlier firmware configuration produced a higher mean response time and more units near or above the upper specification limit. |
| Why did the earlier configuration have slower response? | FW-SIM-0.2 used a simulated eight-second smoothing window that retained more prior signal history. |
| Why was the smoothing window not optimized earlier? | The simulated initial design prioritized value stability without a quantitative manufacturing review of response-time variation. |
| Why was that review absent? | The simulated manufacturing readiness checklist did not explicitly require review of signal-processing parameters against production yield and response-time performance. |

### 5.3 Root-Cause Statement

The simulated root cause was an earlier firmware signal-processing configuration, FW-SIM-0.2, whose eight-second smoothing window increased response-time variation and reduced first-pass yield. A contributing simulated process gap was the absence of a manufacturing-readiness review criterion linking signal-processing configuration choices to response-time and yield performance.

## 6. Corrective and Preventive Actions

| Action ID | Type | Simulated Action | Owner | Due Date | Status |
|---|---|---|---|---|---|
| CAPA-01 | Corrective | Replace FW-SIM-0.2 with FW-SIM-0.3 for simulated production builds. | Simulated firmware engineering | Simulated | Complete |
| CAPA-02 | Corrective | Re-test representative units using response-time and signal-quality checks after firmware transition. | Simulated test engineering | Simulated | Complete |
| CAPA-03 | Corrective | Review test-station signal-quality performance and investigate stations with below-average yield. | Simulated manufacturing quality | Simulated | Complete |
| CAPA-04 | Preventive | Add response-time variation and yield review to the simulated firmware-change checklist. | Simulated quality systems | Simulated | Complete |
| CAPA-05 | Preventive | Add weekly FPY, defect-Pareto, and station-level trend review to the simulated quality dashboard routine. | Simulated operations quality | Simulated | Complete |
| CAPA-06 | Preventive | Escalate any simulated production configuration with FPY below 85% or response-time Cpu below 1.00 for review. | Simulated quality engineering | Simulated | Complete |

## 7. Effectiveness Check

| Check | Acceptance Criterion | Simulated Result | Status |
|---|---|---|---|
| Firmware FPY comparison | FW-SIM-0.3 FPY exceeds FW-SIM-0.2 FPY | 84.1% versus 75.1% | Pass |
| Response-time comparison | FW-SIM-0.3 has lower mean response time than FW-SIM-0.2 | 3.84 s versus 4.32 s | Pass |
| Yield-trend review | Final seven eligible build days show improved average FPY versus first seven days | 85.2% versus 76.0% | Pass |
| Signal-quality regression review | No evidence of a simulated adverse reduction in mean signal-quality score after firmware transition | 90.5 vs. 90.6 | Pass |
| Ongoing monitoring | FPY, response-time distribution, defects, and test-station performance remain visible in dashboard analysis | Implemented in portfolio workflow | Pass |

## 8. Residual Risk and Limitations

The simulated data indicates improvement after the FW-SIM-0.3 configuration, but the overall FPY remains below the 95% dashboard reference and the simulated Cpu values remain below 1.00.

Therefore, this simulated CAPA is closed only for the limited educational scenario. A real manufacturing process would require additional sampling, confirmation of process stability, investigation of high-priority Pareto defects, and formal verification that the corrective action does not adversely affect product requirements.

## 9. Linked Portfolio Artifacts

- Dataset: `data/synthetic_manufacturing_data.csv`
- Exploratory analysis: `notebooks/02_exploratory_quality_analysis.ipynb`
- Trend and capability screening: `notebooks/03_quality_trends_and_process_performance.ipynb`
- SQL analysis: `notebooks/04_sql_quality_analysis.ipynb`
- SQL query script: `sql/01_manufacturing_quality_analysis.sql`
- Defect Pareto chart: `dashboards/defect_pareto.png`
- Quality trends chart: `dashboards/quality_trends_and_process_performance.png`
