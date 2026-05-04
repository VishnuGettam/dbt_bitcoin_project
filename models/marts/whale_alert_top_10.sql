{{
    config(
        alias = 'vw_whale_alert_top_10',
        materialized = 'view'
    )
}}


with bitcoin_whale_alerts as 
(
    select * from {{ ref('whale_alert',v=2) }} limit 10 
)
select * from bitcoin_whale_alerts