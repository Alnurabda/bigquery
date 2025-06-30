-- Script: manufacturing_summary.sql
-- Purpose: Summarize production data and calculate performance metrics

CREATE OR REPLACE TABLE `project_id.dataset.manufacturing_summary` AS
WITH base_data AS (
  SELECT
    ID,
    charge_id,
    plant_unit_id,
    production_date,
    dt_start,
    dt_end,
    shift_number,
    product_name,
    product_code,
    job_number,
    ref.nomenclature,
    ref.variation,
    ref.unit,
    ROUND(pkg.square_m2 / pkg.layers_per_pallet, 3) AS units_per_layer,
    val_0, val_1, val_2, val_3, val_4, val_5,
    (val_1 + val_2 + val_3) AS total_cycles,
    TIMESTAMP_DIFF(dt_end, dt_start, SECOND) AS duration_seconds,
    SAFE_DIVIDE(
      TIMESTAMP_DIFF(dt_end, dt_start, SECOND),
      NULLIF((val_1 + val_2 + val_3), 0)
    ) AS avg_cycle_time_sec
  FROM `project_id.dataset.raw_mfg_events` e
  LEFT JOIN `project_id.dataset.product_reference` ref
    ON e.job_number = ref.document_number
       AND EXTRACT(YEAR FROM e.production_date) = EXTRACT(YEAR FROM ref.document_date)
  LEFT JOIN `project_id.dataset.packaging_registry` pkg
    ON ref.nomenclature = pkg.nomenclature_name
    AND pkg.machine_type = "Line A"
)
SELECT * FROM base_data;
