
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    

select
    hash_key as unique_field,
    count(*) as n_records

from bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin
where hash_key is not null
group by hash_key
having count(*) > 1



  
  
      
    ) dbt_internal_test