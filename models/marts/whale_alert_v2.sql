{{
    config(               
        alias = 'vw_whale_alert_v2',
        materialized = 'view'
        
    )
}}

with bitcoin_whales as (
    select 
        btd.f_address,
        sum(btd.f_value)  as total_sent,
        count(*)          as total_transactions 
    from {{ ref("bitcoin_transactions_dim") }} as btd
    where btd.f_value > 10
    group by btd.f_address
   
) 
select 
    bw.f_address,
    bw.total_sent,
    bw.total_transactions 
from bitcoin_whales bw  