"""
Script: bigquery_loader.py
Purpose: Load processed data into Google BigQuery.
"""

from google.cloud import bigquery

def load_to_bigquery(project_id, dataset_id, table_name, rows_to_insert):
    client = bigquery.Client(project=project_id)
    table_ref = client.dataset(dataset_id).table(table_name)
    errors = client.insert_rows_json(table_ref, rows_to_insert)
    if errors:
        print("Errors occurred while inserting rows:", errors)
    else:
        print("Data successfully loaded to BigQuery.")
