{{
    config(
        alias='tblbitcoin',
        materialized='incremental',
        unique_key='HASH_KEY'
        )       
    
}}


with bitcoin_stg as 
(
select  
 
Md5_HASHED,
HASH_KEY ,
BLOCK_HASH,
BLOCK_NUMBER,
BLOCK_TIMESTAMP,
Fee ,
INPUT_VALUE,
OUTPUT_VALUE,
FEE_PER_BYTE,
IS_COINBASE ,
OUTPUTS ,
created_at
from {{ ref('bitcoin_stg') }}
)
select 
stg.Md5_HASHED,
stg.HASH_KEY ,
stg.BLOCK_HASH,
stg.BLOCK_NUMBER,
stg.BLOCK_TIMESTAMP,
stg.Fee ,
stg.INPUT_VALUE,
stg.OUTPUT_VALUE,
stg.FEE_PER_BYTE,
stg.IS_COINBASE ,
stg.OUTPUTS::variant as OUTPUTS,
stg.created_at,

{% if not is_incremental() %}

        NULL::timestamp_ltz as updated_at
{% else %}
     case when  tgt.hash_key is null then NULL::timestamp_ltz 
          when  tgt.md5_hashed <> stg.md5_hashed then current_timestamp()::timestamp_ltz 
          else tgt.updated_at  
     end as updated_at

{% endif %}

from bitcoin_stg stg

{% if is_incremental() %}

    left join {{ this }} tgt on stg.hash_key = tgt.hash_key
    where tgt.hash_key is null 
    or stg.md5_hashed != tgt.md5_hashed
{% endif %}

