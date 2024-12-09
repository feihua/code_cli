use std::sync::Arc;
use axum::extract::State;
use axum::Json;
use axum::response::IntoResponse;
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;
use rbs::to_value;
use crate::{AppState};

use crate::common::result::BaseResponse;
use crate::model::{{module_name}}::{{table_info.table_name}}_model::{ {{table_info.class_name}} };
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;

/*
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn add_{{table_info.table_name}}(State(state): State<Arc<AppState>>, Json(item): Json<Add{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("add {{table_info.table_name}} params: {:?}", &item);
    let rb = &state.batis;

    let {{table_info.table_name}} = {{table_info.class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: String::from("")
        {%- elif column.rust_name is containing("update time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("update by") %}
        {{column.rust_name}}: String::from("")
        {%- else %}
        {{column.rust_name}}: item.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.class_name}}::insert(rb, &{{table_info.table_name}}).await;

    match result {
        Ok(_u) => BaseResponse::<String>::ok_result(),
        Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
    }
}

/*
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn delete_{{table_info.table_name}}(State(state): State<Arc<AppState>>, Json(item): Json<Delete{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("delete {{table_info.table_name}} params: {:?}", &item);
    let rb = &state.batis;

    let result = {{table_info.class_name}}::delete_in_column(rb, "id", &item.ids).await;

    match result {
        Ok(_u) => BaseResponse::<String>::ok_result(),
        Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
    }
}

/*
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn update_{{table_info.table_name}}(State(state): State<Arc<AppState>>, Json(item): Json<Update{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("update {{table_info.table_name}} params: {:?}", &item);
    let rb = &state.batis;

    let {{table_info.table_name}} = {{table_info.class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: Some(item.{{column.rust_name}})
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: String::from("")
        {%- elif column.rust_name is containing("update time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("update by") %}
        {{column.rust_name}}: String::from("")
        {%- else %}
        {{column.rust_name}}: item.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.class_name}}::update_by_column(rb, &{{table_info.table_name}}, "id").await;

    match result {
        Ok(_u) => BaseResponse::<String>::ok_result(),
        Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
    }
}

/*
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn update_{{table_info.table_name}}_status(State(state): State<Arc<AppState>>, Json(item): Json<Update{{table_info.class_name}}StatusReq>) -> impl IntoResponse {
    log::info!("update {{table_info.table_name}}_status params: {:?}", &item);
    let rb = &state.batis;

   let param = vec![to_value!(1), to_value!(1)];
   let result = rb.exec("update {{table_info.table_name}} set status = ? where id in ?", param).await;

    match result {
        Ok(_u) => BaseResponse::<String>::ok_result(),
        Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
    }
}

/*
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_detail(State(state): State<Arc<AppState>>, Json(item): Json<Query{{table_info.class_name}}DetailReq>) -> impl IntoResponse {
    log::info!("query {{table_info.table_name}}_detail params: {:?}", &item);
    let rb = &state.batis;

     let result = {{table_info.class_name}}::select_by_id(rb, &item.id).await;

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
                {{column.rust_name}}: x.{{column.rust_name}}.to_string()
                {%- else %}
                {{column.rust_name}}: x.{{column.rust_name}}
                {%- endif %}, //{{column.column_comment}}
            {%- endfor %}
            };

            BaseResponse::<Query{{table_info.class_name}}DetailResp>::ok_result_data({{table_info.table_name}})
        }
        Err(err) => {
            BaseResponse::<String>::err_result_msg(err.to_string())
        }
    }

}


/*
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_list(State(state): State<Arc<AppState>>, Json(item): Json<Query{{table_info.class_name}}ListReq>) -> impl IntoResponse {
    log::info!("query {{table_info.table_name}}_list params: {:?}", &item);
    let rb = &state.batis;

    let page=&PageRequest::new(item.page_no, item.page_size);
    let result = {{table_info.class_name}}::select_page(rb, page).await;

    let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();
    match result {
        Ok(d) => {
            let total = d.total;

            for x in d.records {
                {{table_info.table_name}}_list_data.push({{table_info.class_name}}ListDataResp {
                {%- for column in table_info.columns %}
                    {%- if column.column_key =="PRI"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
                    {%- elif column.is_nullable == "YES"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                    {%- elif column.rust_type == "DateTime"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap().0.to_string()
                    {%- else %}
                    {{column.rust_name}}: x.{{column.rust_name}}
                    {%- endif %}, //{{column.column_comment}}
                {%- endfor %}
                })
            }

            BaseResponse::ok_result_page({{table_info.table_name}}_list_data, total)
        }
        Err(err) => {
            BaseResponse::err_result_page({{table_info.table_name}}_list_data, err.to_string())
        }
    }

}

