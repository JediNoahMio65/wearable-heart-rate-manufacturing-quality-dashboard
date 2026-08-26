# Model Card: Simulated Manufacturing Failure-Risk Classifier

> **Simulation notice:** This model was trained on fictional manufacturing data created for educational portfolio purposes only. It does not predict real product quality and must not be used for any manufacturing, clinical, or regulatory decision.

## 1. Model Details

| Field | Value |
|---|---|
| Model name | Simulated wearable manufacturing failure-risk classifier |
| Version | 1.0 |
| Date | August 2026 |
| Model type | Random Forest classifier (300 trees, minimum 15 samples per leaf) |
| Comparison model | Logistic regression with balanced class weights |
| Framework | scikit-learn |
| Preprocessing | One-hot encoding of categorical features within a fitted pipeline |
| Random seed | 42 |
| Source notebook | `notebooks/05_failure_risk_model.ipynb` |
| Training data | `data/synthetic_manufacturing_data.csv` |

## 2. Intended Use

### Primary purpose

Demonstrate a complete, honestly evaluated binary classification workflow on simulated manufacturing data: framing a non-leaky prediction problem, handling class imbalance, selecting appropriate metrics, and interpreting feature contributions.

### Intended question

Given only attributes known **before** functional test, can the risk of a simulated test failure be estimated well enough to prioritize screening attention?

### Out-of-scope uses

- Any decision about a real device, unit, lot, or production process
- Release, disposition, or acceptance of manufactured product
- Clinical, diagnostic, or patient-facing use
- Regulatory submission or quality-system evidence
- Transfer to any dataset other than the synthetic file in this repository

## 3. Features

### Features used

| Feature | Type | Description |
|---|---|---|
| `production_line` | Categorical | Simulated production line: Line A, Line B, or Line C |
| `shift` | Categorical | Simulated shift: Day or Evening |
| `test_station` | Categorical | Simulated functional-test station: TS-01, TS-02, or TS-03 |
| `firmware_version` | Categorical | Simulated firmware configuration |
| `build_weekday` | Categorical | Day of week derived from build date |
| `build_day_index` | Numeric | Days elapsed since the first build date |

### Features deliberately excluded

The following columns were excluded to prevent target leakage:

| Excluded column | Reason |
|---|---|
| `test_status` | This is the prediction target |
| `heart_rate_error_bpm` | The pass/fail label was derived by thresholding this value |
| `response_time_seconds` | The pass/fail label was derived by thresholding this value |
| `signal_quality_score` | The pass/fail label was derived by thresholding this value |
| `defect_category` | Assigned only after a failure occurs; unavailable before test |
| `rework_required` | A downstream consequence of the test outcome |
| `unit_id` | Unique identifier carrying no generalizable signal |

Including any measured test value would have produced near-perfect scores for a trivial reason: the label was constructed from those measurements. Such a model would encode the answer rather than learn a relationship, and its performance would not transfer to any prediction made before test.

## 4. Target and Class Balance

| Field | Value |
|---|---:|
| Target | `failed` (1 = simulated test failure, 0 = simulated pass) |
| Total records | 2,400 |
| Overall failure rate | 20.6% |
| Training records | 1,800 |
| Test records | 600 |
| Test-set failure rate | 20.5% |
| Split method | Stratified 75/25 split |

Because failures are the minority class, both models were fitted with balanced class weights so the minority class was not ignored.

## 5. Evaluation

### Cross-validation on training data

Five-fold stratified cross-validation, scored on macro F1:

| Model | Mean macro F1 | Standard deviation |
|---|---:|---:|
| Logistic regression | 0.512 | 0.015 |
| Random Forest | 0.518 | 0.015 |

### Held-out test performance

| Model | Accuracy | Macro F1 | ROC AUC |
|---|---:|---:|---:|
| Logistic regression | 0.595 | 0.538 | 0.614 |
| Random Forest | 0.618 | 0.543 | 0.609 |

### Selected model, per-class results

| Class | Precision | Recall | F1 | Support |
|---|---:|---:|---:|---:|
| Pass | 0.839 | 0.644 | 0.728 | 477 |
| Fail | 0.274 | 0.520 | 0.359 | 123 |

### Confusion matrix

| | Predicted Pass | Predicted Fail |
|---|---:|---:|
| **Actual Pass** | 307 | 170 |
| **Actual Fail** | 59 | 64 |

## 6. Metric Rationale

**Accuracy alone is misleading here.** A model that always predicted "Pass" would score 79.5% accuracy while detecting zero failures. The selected model's 61.8% accuracy is *lower* than that baseline, yet far more useful, because it identifies 64 of 123 actual failures.

This is a deliberate tradeoff created by the balanced class weighting: the model accepts 170 false alarms in exchange for 52.0% failure recall. In a screening context, a false alarm costs an unnecessary review, while a missed failure passes a defective unit forward — an asymmetry that justifies favoring recall.

**Macro F1** was used for model selection because it averages each class's F1 equally, so minority-class performance is not absorbed by the majority class.

**ROC AUC of 0.609** is the clearest statement of the model's real signal: modestly better than the 0.50 expected from random ranking, indicating that build-time process attributes carry weak but genuine predictive information.

## 7. Feature Importance

Permutation importance was computed on the held-out test set with 20 repeats, scored on macro F1:

| Feature | Mean macro-F1 decrease | Standard deviation |
|---|---:|---:|
| `test_station` | 0.0180 | 0.0083 |
| `production_line` | 0.0118 | 0.0104 |
| `firmware_version` | 0.0019 | 0.0098 |
| `shift` | 0.0018 | 0.0036 |
| `build_weekday` | -0.0106 | 0.0094 |
| `build_day_index` | -0.0177 | 0.0109 |

### Interpretation and caveats

`test_station` and `production_line` showed the largest contributions, consistent with the station-related signal-quality variation and line-related heart-rate-error offset built into the synthetic data generator.

**`firmware_version` appears unimportant, but this is a measurement artifact, not evidence that firmware does not matter.** In the synthetic generator, firmware version was assigned entirely by build date, making `firmware_version` and `build_day_index` nearly collinear. Permutation importance shuffles one feature at a time, so when two features carry the same information, the model compensates using the other and neither appears important. The separate firmware analysis in `notebooks/03_quality_trends_and_process_performance.ipynb` shows a clear firmware effect: 84.1% first-pass yield for FW-SIM-0.3 versus 75.1% for FW-SIM-0.2.

The two negative values indicate that shuffling `build_weekday` and `build_day_index` slightly *improved* the score, meaning those features contributed noise rather than signal in this model.

## 8. Limitations

- All data is synthetic and generated from explicit statistical rules, so measured performance reflects those rules rather than real manufacturing behavior.
- Predictive performance is weak in absolute terms; the model is not fit for operational use even within the simulation.
- Only 2,400 records across a 28-day window were available, limiting the detection of seasonal or long-term drift.
- No hyperparameter search was performed; default-adjacent settings were used deliberately to keep the evaluation honest and reproducible.
- The decision threshold was left at the default 0.5 and was not tuned to a cost model.
- Feature collinearity between firmware version and build date limits the interpretability of the importance ranking.
- No fairness, drift, or measurement-system analysis was performed.

## 9. Ethical and Practical Considerations

A weak model presented as strong is the primary risk in this kind of work. This card therefore reports the majority-class baseline alongside accuracy, states the ROC AUC plainly, and documents every excluded feature and the reason for its exclusion.

In a real manufacturing setting, a screening model of this quality should not gate product disposition. It could at most direct additional review attention, and only after process stability, measurement-system validity, and representative sampling had been established.

## 10. Reproduction

1. Open `notebooks/05_failure_risk_model.ipynb` in Google Colab.
2. Run all cells in order. The notebook reads the dataset directly from this repository.
3. With random seed 42, the reported metrics reproduce exactly.

## 11. Related Artifacts

- Dataset: `data/synthetic_manufacturing_data.csv`
- Model notebook: `notebooks/05_failure_risk_model.ipynb`
- Evaluation figure: `dashboards/failure_risk_model_evaluation.png`
- Quality trend analysis: `notebooks/03_quality_trends_and_process_performance.ipynb`
- CAPA investigation: `docs/01_simulated_capa_quality_investigation.md`
