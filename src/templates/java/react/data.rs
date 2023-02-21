pub fn get_react_data() -> &'static str {
    "
    export interface {{class_name}}ListParam {
    current: number;
    pageSize?: number;
    {% for column in java_columns %}
    {{column.db_name}}?: {{column.ts_type}}; // {{column.column_comment}}{% endfor %}
}

export interface {{class_name}}Vo {
    {% for column in java_columns %}
    {{column.db_name}}: {{column.ts_type}}; // {{column.column_comment}}{% endfor %}
}
"
}