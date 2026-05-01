{{
    config(
        alias = 'tblbitcoin_transactions_dim',
        materialized = 'ephemeral'
    )
}}


with bitcoin_transactions_dim as (

select 
*
from 
{{ ref('bitcoin_output_dim')  }}
where is_coinbase = false
)
select * from bitcoin_transactions_dim 