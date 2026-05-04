

    select 
     *
    from bitcoin_dev.bitcoin_dev_schema_core.vw_whale_alert_v1
    where not (
        f_address like '1%' or
        f_address like '3%' or
        f_address like 'bc1%'
    )


