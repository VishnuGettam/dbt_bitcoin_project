
    
    

select
    hash_key as unique_field,
    count(*) as n_records

from bitcoin_dev.bitcoin_dev_schema_staging.tblbitcoin_stg
where hash_key is not null
group by hash_key
having count(*) > 1


