use rocket::serde::json::serde_json::json;
use rocket::serde::json::{Json, Value};
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;

use crate::RB;
use crate::utils::auth::Token;
use rbs::to_value;
use crate::model::{{module_name}}::{{table_info.table_name}}::{ {{table_info.class_name}} };
use crate::RB;
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;

/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/add{{table_info.class_name}}", data = "<item>")]
pub async fn add_{{table_info.table_name}}(item: Json<Add{{table_info.class_name}}Req>, _auth: Token) -> Value {
    log::info!("add_{{table_info.table_name}} params: {:?}", &item);
    let mut rb = RB.to_owned();

    let req = item.0;

    let {{table_info.table_name}} = {{table_info.class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: String::from("")
        {%- elif column.rust_name is containing("update_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("update_by") %}
        {{column.rust_name}}: String::from("")
        {%- else %}
        {{column.rust_name}}: req.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.class_name}}::insert(&mut rb, &{{table_info.table_name}}).await;

    json!(&handle_result(result))
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/delete{{table_info.class_name}}", data = "<item>")]
pub async fn delete_{{table_info.table_name}}(item: Json<Delete{{table_info.class_name}}Req>, _auth: Token) -> Value {
    log::info!("delete_{{table_info.table_name}} params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{table_info.class_name}}::delete_in_column(&mut rb, "id", &item.ids).await;

    json!(&handle_result(result))
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{table_info.class_name}}", data = "<item>")]
pub async fn update_{{table_info.table_name}}(item: Json<Update{{table_info.class_name}}Req>, _auth: Token) -> Value {
    log::info!("update_{{table_info.table_name}} params: {:?}", &item);
    let mut rb = RB.to_owned();
    let req = item.0;

    let {{table_info.table_name}} = {{table_info.class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: Some(item.{{column.rust_name}})
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: String::from("")
        {%- elif column.rust_name is containing("update_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("update_by") %}
        {{column.rust_name}}: String::from("")
        {%- else %}
        {{column.rust_name}}: req.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.class_name}}::update_by_column(&mut rb, &{{table_info.table_name}}, "id").await;

    json!(&handle_result(result))
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{table_info.class_name}}Status", data = "<item>")]
pub async fn update_{{table_info.table_name}}_status(item: Json<Update{{table_info.class_name}}StatusReq>, _auth: Token) -> Value {
    log::info!("update_{{table_info.table_name}}_status params: {:?}", &item);
    let mut rb = RB.to_owned();
    let req = item.0;

    let param = vec![to_value!(1), to_value!(1)];
    let result = rb.exec("update {{table_info.table_name}} set status = ? where id in ?", param).await;

    json!(&handle_result(result))
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{table_info.class_name}}Detail", data = "<item>")]
pub async fn query_{{table_info.table_name}}_detail(item: Json<Query{{table_info.class_name}}DetailReq>, _auth: Token) -> Value {
    log::info!("query_{{table_info.table_name}}_detail params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{table_info.class_name}}::select_by_id(&mut rb, &item.id).await;

    match result {
        Ok(d) => {
            let x = d.unwrap();

            let {{table_info.table_name}} = Query{{table_info.class_name}}DetailResp {
            {%- for column in table_info.columns %}
                {%- if column.column_key =="PRI"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
                {%- elif column.is_nullable == "YES"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                {%- elif column.rust_type == "DateTime"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.0.to_string()
                {%- else %}
                {{column.rust_name}}: {{column.rust_name}}
                {%- endif %}, //{{column.column_comment}}
            {%- endfor %}
            };

            json!(ok_result_data({{table_info.table_name}}))
        }
        Err(err) => {
            json!(ok_result_code(1, err.to_string()))
        }
    }
}


/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{table_info.class_name}}List", data = "<item>")]
pub async fn query_{{table_info.table_name}}_list(item: Json<Query{{table_info.class_name}}ListReq>, _auth: Token) -> Value {
    log::info!("query_{{table_info.table_name}}_list params: {:?}", &item);
    let mut rb = RB.to_owned();

    let page = &PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let result = {{table_info.class_name}}::select_page(&mut rb, page).await;

    match result {
        Ok(d) => {
            let total = d.total;

            let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();

            for x in d.records {
                let {{table_info.table_name}} = Query{{table_info.class_name}}ListDataResp {
                {%- for column in table_info.columns %}
                    {%- if column.column_key =="PRI"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
                    {%- elif column.is_nullable == "YES"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                    {%- elif column.rust_type == "DateTime"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.0.to_string()
                    {%- else %}
                    {{column.rust_name}}: {{column.rust_name}}
                    {%- endif %}, //{{column.column_comment}}
                {%- endfor %}
                })
            }

            json!(ok_result_page({{table_info.table_name}}_list_data, total))
        }
        Err(err) => {
            json!(err_result_page(err.to_string()))
        }
    }
}

