{{
    config(
        materialized = 'view',
        alias = 'vw_whale_alert'
    )
}}


with bitcoin_whales as (

select 
btd.f_address,
sum(btd.f_value) as total_sent,
count(*) as total_transactions 
from {{ ref("bitcoin_transactions_dim")}} as btd
where btd.f_value > 10
group by btd.f_address
order by total_sent desc
) 
select 
bw.f_address,
bw.total_sent,
bw.total_transactions,
{{ convert_usd('bw.total_sent') }} as total_sent_usd
from bitcoin_whales bw  
order by total_sent_usd desc 