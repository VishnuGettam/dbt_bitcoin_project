


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
from bitcoin_dev.bitcoin_dev_schema_staging.tblbitcoin_stg
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


     case when  tgt.hash_key is null then NULL::timestamp_ltz 
          when  tgt.md5_hashed <> stg.md5_hashed then current_timestamp()::timestamp_ltz 
          else tgt.updated_at  
     end as updated_at



from bitcoin_stg stg



    left join bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin tgt on stg.hash_key = tgt.hash_key
    where tgt.hash_key is null 
    or stg.md5_hashed != tgt.md5_hashed
