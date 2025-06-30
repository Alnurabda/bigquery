-- Script: quality_classification.sql
-- Purpose: Classify product quality based on sensor data

SELECT
  product_id,
  production_date,
  CASE
    WHEN height BETWEEN 9.5 AND 10.5 AND weight BETWEEN 95 AND 105 THEN 'High Quality'
    WHEN height BETWEEN 8.0 AND 11.0 AND weight BETWEEN 90 AND 110 THEN 'Medium Quality'
    ELSE 'Defective'
  END AS quality_category
FROM `project_id.dataset.stone_measurements`;
