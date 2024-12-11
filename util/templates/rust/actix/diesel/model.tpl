use chrono::NaiveDateTime;
use diesel::prelude::*;
use serde::{Deserialize, Serialize};

#[derive(Insertable, Debug, PartialEq, Serialize, Deserialize)]
#[diesel(table_name = crate::schema::{{table_info.table_name}})]
#[diesel(check_for_backend(diesel::mysql::Mysql))]
pub struct Add{{table_info.original_class_name}} {
{%- for column in table_info.columns %}
    {%- if column.rust_type == "DateTime"  %}
    pub {{column.rust_name}}: NaiveDateTime, //{{column.column_comment}}
    {%- elif column.column_key =="PRI"  %}
    {%- elif column.is_nullable == "YES"  %}
    pub {{column.rust_name}}: Option<{{column.rust_type}}>, //{{column.column_comment}}
    {%- else %}
    pub {{column.rust_name}}: {{column.rust_type}}, //{{column.column_comment}}
    {%- endif %}
{%- endfor %}


}

#[derive(Debug, PartialEq, Serialize, Deserialize, AsChangeset)]
#[diesel(table_name = crate::schema::{{table_info.table_name}})]
#[diesel(check_for_backend(diesel::mysql::Mysql))]
pub struct Update{{table_info.original_class_name}} {
{%- for column in table_info.columns %}
    {%- if column.rust_type == "DateTime"  %}
    pub {{column.rust_name}}: NaiveDateTime, //{{column.column_comment}}
    {%- elif column.is_nullable == "YES"  %}
    pub {{column.rust_name}}: Option<{{column.rust_type}}>
    {%- else %}
    pub {{column.rust_name}}: {{column.rust_type}}
    {%- endif %}, //{{column.column_comment}}
{%- endfor %}

}

#[derive(Queryable, Selectable, Insertable, Debug, PartialEq, Serialize, Deserialize, QueryableByName, AsChangeset)]
#[diesel(table_name = crate::schema::{{table_info.table_name}})]
#[diesel(check_for_backend(diesel::mysql::Mysql))]
pub struct {{table_info.original_class_name}} {
{%- for column in table_info.columns %}
    {%- if column.is_nullable == "YES"  %}
    pub {{column.rust_name}}: Option<{{column.rust_type}}>
    {%- elif column.rust_type == "DateTime"  %}
    pub {{column.rust_name}}: NaiveDateTime
    {%- else %}
    pub {{column.rust_name}}: {{column.rust_type}}
    {%- endif %}, //{{column.column_comment}}
{%- endfor %}

}
