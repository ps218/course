{{
config(
    materialized ='view'
)
}}
with
src_hosts
as 
(
select * from {{ ref('src_hosts') }}
)
select  
    host_id,
    --iff(host_name is null,'Anonymous',host_name) as host_name,
    nvl(host_name,'Anonymous') as host_name,
    is_superhost,
    --iff(is_superhost = 't',true,false) as is_superhost,
    created_at,
    updated_at 
from src_hosts