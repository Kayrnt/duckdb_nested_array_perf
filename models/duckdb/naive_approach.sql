{{
    config(
        materialized='table',
    )
}}

{% call set_sql_header(config) %}
-- PRAGMA enable_profiling;
-- SET enable_profiling = 'json';
-- SET enable_profiling = 'query_tree_optimizer';
PRAGMA temp_directory='/tmp/tmp.tmp';
{% endcall %}

SELECT
  * exclude(col15),
  ARRAY(
    SELECT
      {'id': st.id, 'bar': st.bar}
    FROM UNNEST(col15) AS c
    JOIN {{ ref('dimension_table') }} AS st
      ON c.col15.name = st.name
    GROUP BY
      st.id,
      st.bar
  ) AS joined
FROM {{ ref('fact_table') }} AS bt