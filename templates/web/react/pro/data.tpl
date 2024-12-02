export interface {{.JavaName}}ListItem {
{%- for column in table_info.columns %}
  {{column.ts_name}}: {{column.ts_type}}; //{{column.column_comment}}

{%- endfor %}

}

export interface {{.JavaName}}ListPagination {
  total: number;
  pageSize: number;
  current: number;
}

export interface {{.JavaName}}ListData {
  list: {{.JavaName}}ListItem[];
  pagination: Partial<{{.JavaName}}ListPagination>;
}

export interface {{.JavaName}}ListParams {
  pageSize?: number;
  current?: number;
  filter?: { [key: string]: any[] };
  sorter?: { [key: string]: any };
{%- for column in table_info.columns %}
  {{column.ts_name}}?: {{column.ts_type}}; //{{column.column_comment}}

{%- endfor %}
}
