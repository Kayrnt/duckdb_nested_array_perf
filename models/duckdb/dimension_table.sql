{{
    config(
        materialized='table',
    )
}}

SELECT
    CONCAT('col15 ', GENERATE_SERIES) AS name,
    GENERATE_SERIES AS id,
    MOD(GENERATE_SERIES, 2) AS bar
FROM GENERATE_SERIES(1, 1000, 1)