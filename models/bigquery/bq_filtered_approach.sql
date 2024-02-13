{{
    config(
        materialized='table',
    )
}}
WITH fact_table_col15_name_values AS (
SELECT distinct st.name
from {{ ref('bq_fact_table') }}, UNNEST(col15) st
),
dimension_table_filtered AS (
SELECT st.*
FROM {{ ref('bq_dimension_table') }} st
JOIN fact_table_col15_name_values v ON st.name = v.name
)
select
*,
ARRAY(
SELECT as struct st.id, st.bar
FROM UNNEST(col15) c
JOIN dimension_table_filtered st ON c.name = st.name
GROUP BY st.id, st.bar
) joined
FROM {{ ref('bq_fact_table') }} bt