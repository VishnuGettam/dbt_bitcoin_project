{% macro generate_schema_name(custom_schema, node) %}

    {%- set default_schema = target.schema -%}

    {%- if custom_schema is none -%}
        {{ default_schema }}

    {%- elif target.name == 'prod' -%}
        {# Prod: use clean schema name directly #}
        {{ default_schema }}_{{ custom_schema | trim }}

    {%- else -%}
        {# Dev: prefix with dev schema to keep dev/prod isolated #}
        {{ default_schema }}_{{ custom_schema | trim }}

    {%- endif -%}

{% endmacro %}