
with  
r as (select distinct listing_id as l1,review_date from {{ref('fct_reviews')}}),
l as (select distinct listing_id as l2,created_at from {{ref('dim_listings_cleansed')}})
select * from 
r left join l on r.l1 = l.l2
where r.review_date < l.created_at