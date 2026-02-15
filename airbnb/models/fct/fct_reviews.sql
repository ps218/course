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
{% endif %}