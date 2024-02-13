# Nested array performance BigQuery vs DuckDB
This dbt project is aimed to benchmark the performance of nested arrays in BigQuery and DuckDB.

# Structure
The project is structured as follows:
- `models` contains the dbt models
  - `bigquery` contains the models for BigQuery
  - `duckdb` contains the models for DuckDB

# Getting started

## Prerequisites

install the requirements:
`pip -r requirements.txt`

## Running the project

### BigQuery
To run the project in BigQuery, you need to leverage environment variables and adapt them to your environment:
```
DBT_PROFILES_DIR=./nested_array_perf PROJECT=my_project EXECUTION_PROJECT=my_project DATASET=my_dataset dbt -d run --target=dev_bigquery -s +bq_filtered_approach
```

### DuckDB
To run the project in DuckDB, you need to leverage environment variables and adapt them to your environment:
```
DBT_PROFILES_DIR=./nested_array_perf dbt -d run --target=dev_bigquery -s +filtered_approach
```
