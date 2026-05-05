
  create or replace   view bitcoin_dev.bitcoin_dev_schema_core.vw_whale_alert_top_10
  
  
  
  
  as (
    


with bitcoin_whale_alerts as 
(
    select * from bitcoin_dev.bitcoin_dev_schema_core.vw_whale_alert_v2 limit 10 
)
select * from bitcoin_whale_alerts
  );

