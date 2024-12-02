
export interface {{table_info.class_name}}ListParam {
  current: number;
  pageSize?: number;
{%- for column in table_info.columns %}
  {% if column.column_key =="PRI"  %}
  {% elif column.ts_name is containing("create") %}
  {% elif column.ts_name is containing("update") %}
  {% elif column.ts_name is containing("sort") %}
  {% elif column.ts_name is containing("Sort") %}
  {% elif column.ts_name is containing("remark") %}
  {% else %}
  {{column.ts_name}}?: {{column.ts_type}}; //{{column.column_comment}}
  {% endif %}
{%- endfor %}

}

export interface {{table_info.class_name}}Vo {
{%- for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
{%- endfor %}

}
