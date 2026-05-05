


with bitcoin_transactions_dim as (

select 
*
from 
bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin_outputs_dim
where is_coinbase = false
)
select * from bitcoin_transactions_dim