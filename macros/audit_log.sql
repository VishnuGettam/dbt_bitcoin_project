-- macros/log_audit.sql
{% macro log_audit(this, target, model) %}

    {% set audit_schema = generate_schema_name('core', model) %}

    INSERT INTO {{ target.database }}.{{ audit_schema }}.tblaudit_log 
        (TABLE_NAME, TABLE_COUNT, INSERTED_AT)
    VALUES (
        '{{ this.schema }}.{{ this.name }}',
        (SELECT COUNT(*) FROM {{ this }}),
        CURRENT_TIMESTAMP()
    )

{% endmacro %}