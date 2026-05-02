


with bitcoin_outputs_dim as 
(
    select 
    hash_key,
    block_number,
    block_timestamp,
    is_coinbase,
    outputs
    from  bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin
)
select 
hash_key,
block_number,
block_timestamp,
is_coinbase,
coalesce(cast(flatted_outputs.value:address as varchar),'') as f_address,
coalesce(cast(flatted_outputs.value:value as varchar),'') as f_value
from bitcoin_outputs_dim as bitcoin_outputs_dim,
lateral flatten(input => bitcoin_outputs_dim.outputs) as flatted_outputs
 
where bitcoin_outputs_dim.block_timestamp > (select max(block_timestamp) from bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin_outputs_dim)   
 