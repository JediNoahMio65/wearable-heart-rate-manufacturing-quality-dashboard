-- ============================================================
-- Simulated Wearable Manufacturing Quality SQL Analysis
-- Source: synthetic_manufacturing_data.csv
-- Educational portfolio project. Fictional data only.
-- ============================================================

-- Query 1: Overall manufacturing-quality KPIs
SELECT
    COUNT(*) AS total_units_tested,
    SUM(CASE WHEN test_status = 'Pass' THEN 1 ELSE 0 END) AS units_passed,
    SUM(CASE WHEN test_status = 'Fail' THEN 1 ELSE 0 END) AS units_failed,
    ROUND(
        100.0 * SUM(CASE WHEN test_status = 'Pass' THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS first_pass_yield_pct,
    ROUND(
        100.0 * SUM(CASE WHEN test_status = 'Fail' THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS failure_rate_pct,
    ROUND(
        100.0 * SUM(CASE WHEN rework_required = 'Yes' THEN 1 ELSE 0 END)
        / COUNT(*),
        1
    ) AS rework_rate_pct
FROM manufacturing_quality;

-- Query 2: First-pass yield by production line
SELECT
    production_line,
    COUNT(*) AS units_tested,
    SUM(CASE WHEN test_status = 'Pass' THEN 1 ELSE 0 END) AS units_passed,
    ROUND(
        100.0 * AVG(CASE WHEN test_status = 'Pass' THEN 1.0 ELSE 0.0 END),
        1
    ) AS first_pass_yield_pct,
    ROUND(AVG(heart_rate_error_bpm), 2) AS mean_heart_rate_error_bpm,
    ROUND(AVG(response_time_seconds), 2) AS mean_response_time_seconds,
    ROUND(AVG(signal_quality_score), 1) AS mean_signal_quality_score
FROM manufacturing_quality
GROUP BY production_line
ORDER BY first_pass_yield_pct ASC;

-- Query 3: First-pass yield by test station
SELECT
    test_station,
    COUNT(*) AS units_tested,
    ROUND(
        100.0 * AVG(CASE WHEN test_status = 'Pass' THEN 1.0 ELSE 0.0 END),
        1
    ) AS first_pass_yield_pct,
    ROUND(AVG(signal_quality_score), 1) AS mean_signal_quality_score,
    SUM(CASE WHEN defect_category = 'Low signal quality' THEN 1 ELSE 0 END)
        AS low_signal_quality_failures
FROM manufacturing_quality
GROUP BY test_station
ORDER BY first_pass_yield_pct ASC;

-- Query 4: Firmware comparison
SELECT
    firmware_version,
    COUNT(*) AS units_tested,
    ROUND(
        100.0 * AVG(CASE WHEN test_status = 'Pass' THEN 1.0 ELSE 0.0 END),
        1
    ) AS first_pass_yield_pct,
    ROUND(AVG(response_time_seconds), 2) AS mean_response_time_seconds,
    ROUND(AVG(heart_rate_error_bpm), 2) AS mean_heart_rate_error_bpm
FROM manufacturing_quality
GROUP BY firmware_version
ORDER BY firmware_version;

-- Query 5: Defect Pareto analysis with cumulative percentage
WITH defect_counts AS (
    SELECT
        defect_category,
        COUNT(*) AS defect_count
    FROM manufacturing_quality
    WHERE defect_category <> 'None'
    GROUP BY defect_category
),
ranked_defects AS (
    SELECT
        defect_category,
        defect_count,
        ROUND(
            100.0 * defect_count / SUM(defect_count) OVER (),
            1
        ) AS percent_of_defects,
        ROUND(
            100.0 * SUM(defect_count) OVER (
                ORDER BY defect_count DESC, defect_category
                ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
            ) / SUM(defect_count) OVER (),
            1
        ) AS cumulative_percent
    FROM defect_counts
)
SELECT
    defect_category,
    defect_count,
    percent_of_defects,
    cumulative_percent
FROM ranked_defects
ORDER BY defect_count DESC, defect_category;

-- Query 6: Daily yield trend, excluding low-volume days
SELECT
    build_date,
    COUNT(*) AS units_tested,
    ROUND(
        100.0 * AVG(CASE WHEN test_status = 'Pass' THEN 1.0 ELSE 0.0 END),
        1
    ) AS first_pass_yield_pct
FROM manufacturing_quality
GROUP BY build_date
HAVING COUNT(*) >= 20
ORDER BY build_date;
