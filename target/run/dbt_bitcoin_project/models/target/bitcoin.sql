
  
    

create or replace table bitcoin_dev.bitcoin_dev_schema.tblbitcoin
    
    
    
    as (


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
from bitcoin_dev.bitcoin_dev_stg_schema.tblbitcoin_stg
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
stg.OUTPUTS ,
stg.created_at,



        NULL::timestamp_ltz as updated_at


from bitcoin_stg stg


    )
;


  