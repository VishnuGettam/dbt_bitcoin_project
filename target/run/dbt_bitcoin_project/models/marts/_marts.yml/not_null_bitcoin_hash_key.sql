
    
    select
      count(*) as failures,
      count(*) != 0 as should_warn,
      count(*) != 0 as should_error
    from (
      
    
  
    
    



select hash_key
from bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin
where hash_key is null



  
  
      
    ) dbt_internal_test