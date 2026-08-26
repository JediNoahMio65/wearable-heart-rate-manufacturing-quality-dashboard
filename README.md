# Wearable Heart-Rate Manufacturing Quality Dashboard

A portfolio project demonstrating Python, SQL, statistical quality analysis, and CAPA-style investigation using **synthetic manufacturing data** for a simulated wearable heart-rate monitor.

> **Simulation notice:** All manufacturing records, device details, performance measures, requirements, quality findings, and CAPA actions in this repository are fictional and created for educational portfolio purposes only. This project is not associated with a real device, manufacturer, production process, clinical study, regulatory submission, or quality-system record.

## Project Objective

Analyze synthetic manufacturing and test data for a simulated wearable heart-rate monitor to identify quality trends, compare manufacturing segments and firmware configurations, assess exploratory process-performance metrics, and document a data-supported corrective-action investigation.

## Key Findings

| Finding | Simulated Result |
|---|---:|
| Total units analyzed | 2,400 |
| Overall first-pass yield | Approximately 79.5% |
| FPY, first 7 build days | 76.0% |
| FPY, final 7 eligible build days | 85.2% |
| FW-SIM-0.2 first-pass yield | 75.1% |
| FW-SIM-0.3 first-pass yield | 84.1% |
| FW-SIM-0.2 mean response time | 4.32 seconds |
| FW-SIM-0.3 mean response time | 3.84 seconds |
| Overall response-time screening index | Cpu = 0.45 |
| Overall heart-rate-error screening index | Cpu = 0.60 |

**Interpretation:** The simulated FW-SIM-0.3 configuration showed higher first-pass yield and lower mean response time than FW-SIM-0.2. The portfolio investigation treats the earlier firmware configuration and response-time variation as a simulated quality-improvement opportunity.

## Dashboard Visuals

### Defect Pareto Analysis

![Simulated defect Pareto analysis](dashboards/defect_pareto.png)

### Quality Trends and Process Performance

![Simulated quality trends and process performance](dashboards/quality_trends_and_process_performance.png)

## Skills Demonstrated

- Python data generation and analysis with NumPy and pandas
- SQL analytics with SQLite
- Data validation and exploratory quality analysis
- First-pass yield, failure-rate, and rework-rate calculation
- Defect Pareto analysis
- Production-line, test-station, shift, and firmware comparisons
- Time-trend analysis and low-volume-day filtering
- Exploratory one-sided process-performance screening using \(C_{pu}\)
- CAPA-style
