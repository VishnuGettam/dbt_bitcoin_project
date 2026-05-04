with __dbt__cte__tblbitcoin_transactions_dim as (



with bitcoin_transactions_dim as (

select 
*
from 
bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin_outputs_dim
where is_coinbase = false
)
select * from bitcoin_transactions_dim 
)
--EPHEMERAL-SELECT-WRAPPER-START
select * from (


with bitcoin_whales as (
    select 
        btd.f_address,
        sum(btd.f_value)  as total_sent,
        count(*)          as total_transactions 
    from __dbt__cte__tblbitcoin_transactions_dim as btd
    where btd.f_value > 10
    group by btd.f_address
   
) 
select 
    bw.f_address,
    bw.total_sent,
    bw.total_transactions 
from bitcoin_whales bw  
--EPHEMERAL-SELECT-WRAPPER-END
)