{{
    config(
        materialized='table',
    )
}}
SELECT *,
ARRAY(
SELECT as struct st.id, st.bar
FROM UNNEST(col15) c
JOIN {{ ref('bq_dimension_table') }} st ON c.name = st.name
GROUP BY st.id, st.bar
) joined
FROM {{ ref('bq_fact_table') }} bt