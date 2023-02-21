pub fn get_vue_data() -> &'static str {
    "export interface {{class_name}}ListParam {
    current?: number;
    pageSize?: number;
    {% for column in java_columns %}
    {{column.db_name}}?: {{column.ts_type}};  // {{column.column_comment}}{% endfor %}
}

export interface Search{{class_name}}Param {
    {% for column in java_columns %}
    {{column.db_name}}?: {{column.ts_type}};  // {{column.column_comment}}{% endfor %}
}

export interface Add{{class_name}}Param {
    {% for column in java_columns %}
    {{column.db_name}}?: {{column.ts_type}};  // {{column.column_comment}}{% endfor %}
}

export interface Update{{class_name}}Param {
    {% for column in java_columns %}
    {{column.db_name}}?: {{column.ts_type}};  // {{column.column_comment}}{% endfor %}
}

export interface {{class_name}}Vo {
    {% for column in java_columns %}
    {{column.db_name}}: {{column.ts_type}};  // {{column.column_comment}} {% endfor %}
}
"
}