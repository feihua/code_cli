export interface Add{{.JavaName}}Param {
{%- for column in table_info.columns %}
  {% if column.column_key =="PRI"  %}
  {% elif column.ts_name is containing("create") %}
  {% elif column.ts_name is containing("update") %}
  {% else %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
  {% endif %}
{%- endfor %}

}

export interface Update{{.JavaName}}Param {
{%- for column in table_info.columns %}
  {% if column.ts_name is containing("create") %}
  {% elif column.ts_name is containing("update") %}
  {% else %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
  {% endif %}
{%- endfor %}
}

export interface Search{{.JavaName}}Param {
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

export interface List{{.JavaName}}Param {
   current?: number;
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

export interface {{.JavaName}}RecordVo {
{%- for column in table_info.columns %}
  {{column.ts_name}}?: {{column.ts_type}}; //{{column.column_comment}}
{%- endfor %}

{{range .TableColumn}}    {{.JavaName}}: {{.TsType}}; //{{.ColumnComment}}
{{end}}
}