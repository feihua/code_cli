use std::sync::Arc;
use axum::extract::State;
use axum::Json;
use axum::response::IntoResponse;
use sea_orm::{ColumnTrait, EntityTrait, NotSet, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm::ActiveValue::Set;
use crate::{AppState};

use crate::model::{ {{table_info.table_name}} };
use crate::model::prelude::{ {{table_info.original_class_name}} };
use crate::vo::*;
use crate::vo::{{table_info.table_name}}_vo::*;
use crate::vo::{err_result_msg, ok_result_msg, ok_result_page};

/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn add_{{table_info.table_name}}(State(state): State<Arc<AppState>>, Json(item): Json<Add{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("add_{{table_info.table_name}} params: {:?}", &item);
    let conn = &state.conn;

    let {{table_info.table_name}} = {{table_info.table_name}}::ActiveModel {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: NotSet
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: NotSet
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: Set(String::from(""))
        {%- elif column.rust_name is containing("update") %}
        {{column.rust_name}}: NotSet
        {%- else %}
        {{column.rust_name}}: Set(item.{{column.rust_name}})
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    {{table_info.original_class_name}}::insert({{table_info.table_name}}).exec(conn).await.unwrap();

    Json(ok_result_msg("添加{{table_info.table_comment}}成功!"))
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn delete_{{table_info.table_name}}(State(state): State<Arc<AppState>>, Json(item): Json<Delete{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("delete_{{table_info.table_name}} params: {:?}", &item);
    let conn = &state.conn;

   {{table_info.original_class_name}}::delete_many().filter({{table_info.original_class_name}}::Column::Id.is_in(item.ids)).exec(conn).await.unwrap();

    Json(ok_result_msg("删除{{table_info.table_comment}}成功!"))
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn update_{{table_info.table_name}}(State(state): State<Arc<AppState>>, Json(item): Json<Update{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("update_{{table_info.table_name}} params: {:?}", &item);
    let conn = &state.conn;

    if {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default().is_none() {
        return Json(err_result_msg("{{table_info.table_comment}}不存在,不能更新!"))
    }

    let {{table_info.table_name}} = {{table_info.table_name}}::ActiveModel {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: Set(item.{{column.rust_name}})
        {%- elif column.rust_name is containing("create") %}
        {{column.rust_name}}: NotSet
        {%- elif column.rust_name is containing("update_by") %}
        {{column.rust_name}}: Set(String::from(""))
        {%- elif column.rust_name is containing("update_time") %}
        {{column.rust_name}}: NotSet
        {%- else %}
        {{column.rust_name}}: Set(item.{{column.rust_name}})
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    {{table_info.original_class_name}}::update({{table_info.table_name}}).exec(conn).await.unwrap();
    Json(ok_result_msg("更新{{table_info.table_comment}}成功!"))
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn update_{{table_info.table_name}}_status(State(state): State<Arc<AppState>>, Json(item): Json<Update{{table_info.class_name}}StatusReq>) -> impl IntoResponse {
    log::info!("update_{{table_info.table_name}}_status params: {:?}", &item);
    //let conn = &state.conn;

    //{{table_info.original_class_name}}::update_many()
    //    .col_expr({{table_info.original_class_name}}::Column::Status, Expr::value(item.status))
    //    .filter({{table_info.original_class_name}}::Column::Id.is_in(item.ids))
    //    .exec(&conn)
    //    .await.unwrap();
    Json(ok_result_msg("更新{{table_info.table_comment}}状态成功!"))
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_detail(State(state): State<Arc<AppState>>, Json(item): Json<Query{{table_info.class_name}}DetailReq>) -> impl IntoResponse {
    log::info!("query_{{table_info.table_name}}_detail params: {:?}", &item);
    let conn = &state.conn;

    let result = {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default();

    match result {
        Ok(d) => {
            let x = d.unwrap();

            let {{table_info.table_name}} = Query{{table_info.class_name}}DetailResp {
               {%- for column in table_info.columns %}
                {%- if column.column_key =="PRI"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
                {%- elif column.is_nullable =="YES" %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                {%- elif column.rust_type =="DateTime" %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap().0.to_string()
                {%- else %}
                {{column.rust_name}}: x.{{column.rust_name}}
                {%- endif %}, //{{column.column_comment}}
              {%- endfor %}
            };

            Json(ok_result_data({{table_info.table_name}}))
        }
        Err(err) => {
            Json(err_result_msg(err.to_string()))
        }
    }

}


/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_list(State(state): State<Arc<AppState>>, Json(item): Json<Query{{table_info.class_name}}ListReq>) -> impl IntoResponse {
    log::info!("query_{{table_info.table_name}}_list params: {:?}", &item);
    let conn = &state.conn;

    let paginator = {{table_info.original_class_name}}::find()
        {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {%- elif column.rust_name is containing("create") %}
        {%- elif column.rust_name is containing("update") %}
        {%- elif column.rust_name is containing("remark") %}
        {%- elif column.rust_name is containing("sort") %}
        {%- else %}
        //.apply_if(item.{{column.rust_name}}.clone(), |query, v| { query.filter( {{table_info.class_name}}::Column::{{column.rust_name}}.eq(v))})
        {%- endif %}
      {%- endfor %}
        .paginate(conn, item.page_size.clone());

    let total = paginator.num_items().await.unwrap_or_default();

    let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();

    for x in paginator.fetch_page(item.page_no.clone() - 1).await.unwrap_or_default() {
        {{table_info.table_name}}_list_data.push({{table_info.class_name}}ListDataResp {
            {%- for column in table_info.columns %}
            {%- if column.column_key =="PRI"  %}
            {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
            {%- elif column.is_nullable =="YES" %}
            {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
            {%- elif column.rust_type =="DateTime" %}
            {{column.rust_name}}: x.{{column.rust_name}}.unwrap().0.to_string()
            {%- else %}
            {{column.rust_name}}: x.{{column.rust_name}}
            {%- endif %}, //{{column.column_comment}}
          {%- endfor %}
        })
    }

    Json(ok_result_page({{table_info.table_name}}_list_data, total))

}

