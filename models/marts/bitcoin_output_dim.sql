{{
    config(
        alias = 'tblbitcoin_outputs_dim',
        materialized = 'incremental',
        unique_key = 'hash_key'
        
    )
}}


with bitcoin_outputs_dim as 
(
    select 
    hash_key,
    block_number,
    block_timestamp,
    is_coinbase,
    outputs
    from  {{ ref('bitcoin')  }}
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
 {% if is_incremental() %}
where bitcoin_outputs_dim.block_timestamp > (select max(block_timestamp) from {{ this }})   
 {% endif %}