{{
    config(
        materialized='table',
    )
}}
SELECT
CONCAT("col15 ", x) AS name,
x AS id,
MOD(x, 2) AS bar
FROM UNNEST(GENERATE_ARRAY(1, 1000, 1)) x