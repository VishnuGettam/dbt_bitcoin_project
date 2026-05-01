{{
    config(
        alias='tblbitcoin_stg',
        materialization='table',
        transient='true',
        unique_key='HASH_KEY',
        )
}}


with bitcoin_stg as (

select  

        MD5(concat_ws(
                '~',
                COALESCE(CAST(HASH_KEY as  varchar),'')  ,                
                COALESCE(CAST(BLOCK_HASH as  varchar),'')  ,
                COALESCE(CAST(BLOCK_NUMBER as  varchar),'') ,
                COALESCE(CAST(BLOCK_TIMESTAMP as  varchar),'')   ,
                COALESCE(CAST(FEE as varchar),'')   ,
                COALESCE(CAST(INPUT_VALUE as varchar),'')  ,
                COALESCE(CAST(OUTPUT_VALUE as varchar),'')  ,
                COALESCE(CAST(FEE_PER_BYTE as varchar),'')  ,
                COALESCE(CAST(IS_COINBASE as varchar),'')  ,
                COALESCE(CAST(OUTPUTS as varchar),'') 
                )) as Md5_HASHED,
        COALESCE(CAST(HASH_KEY as  varchar),'') as HASH_KEY,
        COALESCE(CAST(BLOCK_HASH as  varchar),'') as BLOCK_HASH,
        COALESCE(CAST(BLOCK_NUMBER as  varchar),'') as BLOCK_NUMBER,
        COALESCE(CAST(BLOCK_TIMESTAMP as  varchar),'') as BLOCK_TIMESTAMP,
        COALESCE(CAST(FEE as varchar),'') as Fee ,
        COALESCE(CAST(INPUT_VALUE as varchar),'') as INPUT_VALUE,
        COALESCE(CAST(OUTPUT_VALUE as varchar),'') as OUTPUT_VALUE,
        COALESCE(CAST(FEE_PER_BYTE as varchar),'') as FEE_PER_BYTE,
        COALESCE(CAST(IS_COINBASE as varchar),'') as IS_COINBASE ,
        OUTPUTS  as OUTPUTS ,
        to_timestamp_ltz(current_timestamp()) as  created_at
from {{ source('bitcoin_stg','tblbitcoin_stg_raw') }}  

)
select * from bitcoin_stg