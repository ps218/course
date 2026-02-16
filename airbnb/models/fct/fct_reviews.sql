{{
config(
    materialized ='incremental', 
    on_schema_change = 'fail'   
)
}}
/*
-- override default materialization?
-- with schema change: when source structure change, select * from src_reviews return different data structur
*/
with
src_reviews
as (
select * from {{ ref('src_reviews') }}
)
select * from src_reviews 
where review_text is not null
{% if is_incremental() %}         
-- if is incremental then append below sql part
and review_date > (select max(review_date)from {{this}}) 
--selecting only dates bigger then already existing in the model before its remateerialization
--
/*  {% if var("start_date", False) and var("end_date", False) %}
    {{ log('Loading ' ~ this ~ ' incrementally (start_date: ' ~ var("start_date") ~ ', end_date: ' ~ var("end_date") ~ ')', info=True) }}
    AND review_date >= '{{ var("start_date") }}'
    AND review_date < '{{ var("end_date") }}'
  {% else %}
    AND review_date > (select max(review_date) from {{ this }})
    {{ log('Loading ' ~ this ~ ' incrementally (all missing dates)', info=True)}}
  {% endif %}
 */ --
{% endif %}