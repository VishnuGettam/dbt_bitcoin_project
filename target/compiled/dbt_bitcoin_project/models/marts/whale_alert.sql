


with  __dbt__cte__tblbitcoin_transactions_dim as (



with bitcoin_transactions_dim as (

select 
*
from 
bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin_outputs_dim
where is_coinbase = false
)
select * from bitcoin_transactions_dim
), bitcoin_whales as (

select 
btd.f_address,
sum(btd.f_value) as total_sent,
count(*) as total_transactions 
from __dbt__cte__tblbitcoin_transactions_dim as btd
where btd.f_value > 10
group by btd.f_address
order by total_sent desc
) 
select 
bw.f_address,
bw.total_sent,
bw.total_transactions,


(
    bw.total_sent * (
        select price 
        from bitcoin_dev.bitcoin_dev_schema_core.btc_usd_max
        where to_date(replace(snapped_at,' UTC','')) = current_date() - 35
    )
)

 as total_sent_usd
from bitcoin_whales bw  
order by total_sent_usd desc