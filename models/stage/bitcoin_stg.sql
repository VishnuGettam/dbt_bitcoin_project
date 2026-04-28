{{
    config(alias='tblbitcoin_stg')
}}


with bitcoin_stg as (


select  
"hash"::varchar as hashkey,
"block_hash"::varchar as block_hash,
"block_number"::int as block_number,
"block_timestamp"::timestamp as block_timestamp,
"fee"::float as fee,
"input_value"::float as input_value,
"output_value"::float as output_btc,
round("fee"/"size")::float as fee_per_byte,
"is_coinbase"::boolean as is_coinbase,
"outputs"::variant as outputs
from {{ source('bitcoin_stg','tblbitcoin_stg') }}  

 

)
select * from bitcoin_stg