export interface Add{{table_info.class_name}}Param {
{%- for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
{%- endfor %}
}

export interface Delete{{table_info.class_name}}Param {
  ids: number[]; //编号
}

export interface Update{{table_info.class_name}}Param {
  {%- for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
  {%- endfor %}

}

export interface Update{{table_info.class_name}}StatusParam {
  ids: number[]; //编号
  status?: number; //状态(0：禁用，1：启用)
}

export interface QueryList{{table_info.class_name}}Param {
  pageNum?: number;
  pageSize?: number;
  {% for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
  {%- endfor %}
}


export interface {{table_info.class_name}}RecordRes {
  {%- for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}
  {%- endfor %}

}
