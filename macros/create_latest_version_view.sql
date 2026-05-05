{% macro create_latest_version_view(results) %}

    {% if execute %}

        {% for result in results %}

             
            {% if result.status == 'success' 
               and result.node.config.materialized in ('incremental', 'table') %}

                {% set current_relation = result.node.relation_name %}
                {% set identifier = result.node.alias %}

                 
                {% if '_v1' in identifier or '_v2' in identifier %}

                     
                    {% set clean_name = identifier
                        | replace('_v1', '')
                        | replace('_v2', '')
                    %}

                     
                    {% set latest_view_relation = api.Relation.create(
                        database   = result.node.database,
                        schema     = result.node.schema,
                        identifier = clean_name,
                        type       = 'view'
                    ) %}

                    {% set create_view_sql %}
                        CREATE OR REPLACE VIEW {{ latest_view_relation }}
                        AS SELECT * FROM {{ current_relation }}
                    {% endset %}

                    {% do log(
                        "Creating latest view: " ~ latest_view_relation ~ 
                        " → pointing to: " ~ current_relation,
                        info = true
                    ) %}

                    {% do adapter.execute(create_view_sql, auto_begin=false, fetch=false) %}

                {% endif %}

            {% endif %}

        {% endfor %}

    {% endif %}

{% endmacro %}