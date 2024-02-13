{{
    config(
        materialized='ephemeral'
    )
}}
{% set rows_count = 10 ** var('exponent_scale') %}
  SELECT
    UNNEST(GENERATE_SERIES(1, {{ rows_count }}, 1)) AS id