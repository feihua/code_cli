export interface {{table_info.class_name}}ListItem {
{%- for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}

{%- endfor %}

}

export interface {{table_info.class_name}}ListPagination {
  total: number;
  pageSize: number;
  current: number;
}

export interface {{table_info.class_name}}ListData {
  list: {{table_info.class_name}}ListItem[];
  pagination: Partial<{{table_info.class_name}}ListPagination>;
}

export interface {{table_info.class_name}}ListParams {
  pageSize?: number;
  current?: number;
  filter?: { [key: string]: any[] };
  sorter?: { [key: string]: any };
{%- for column in table_info.columns %}
  {{column.ts_name}}?: {{column.ts_type}}; //{{column.column_comment}}

{%- endfor %}
}
