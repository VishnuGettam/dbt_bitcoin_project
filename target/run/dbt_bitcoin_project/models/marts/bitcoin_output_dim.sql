-- back compat for old kwarg name
  
  begin;
    
        
            
	    
	    
            
        
    

    

    merge into bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin_outputs_dim as DBT_INTERNAL_DEST
        using bitcoin_dev.bitcoin_dev_schema_core.tblbitcoin_outputs_dim__dbt_tmp as DBT_INTERNAL_SOURCE
        on ((DBT_INTERNAL_SOURCE.hash_key = DBT_INTERNAL_DEST.hash_key))

    
    when matched then update set
        "HASH_KEY" = DBT_INTERNAL_SOURCE."HASH_KEY","BLOCK_NUMBER" = DBT_INTERNAL_SOURCE."BLOCK_NUMBER","BLOCK_TIMESTAMP" = DBT_INTERNAL_SOURCE."BLOCK_TIMESTAMP","IS_COINBASE" = DBT_INTERNAL_SOURCE."IS_COINBASE","F_ADDRESS" = DBT_INTERNAL_SOURCE."F_ADDRESS","F_VALUE" = DBT_INTERNAL_SOURCE."F_VALUE"
    

    when not matched then insert
        ("HASH_KEY", "BLOCK_NUMBER", "BLOCK_TIMESTAMP", "IS_COINBASE", "F_ADDRESS", "F_VALUE")
    values
        ("HASH_KEY", "BLOCK_NUMBER", "BLOCK_TIMESTAMP", "IS_COINBASE", "F_ADDRESS", "F_VALUE")

;
    commit;