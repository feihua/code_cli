use log::info;
use ntex::web;
use ntex::web::{Error, HttpResponse, Responder};
use ntex::web::types::{Json, State};
use crate::AppState;

use sea_orm::{ColumnTrait, DatabaseConnection, EntityTrait, NotSet, PaginatorTrait, QueryFilter, QueryTrait};
use sea_orm::ActiveValue::Set;
use crate::model::{{module_name}}::{ {{table_info.table_name}} };
use crate::common::result::BaseResponse;
use crate::model::{{module_name}}::prelude::{ {{table_info.original_class_name}} };
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;


/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/add{{table_info.class_name}}")]
pub async fn add_{{table_info.table_name}}(item: Json<Add{{table_info.class_name}}Req>, data: State<AppState>) -> Result<impl web::Responder, web::Error> {
    info!("add_{{table_info.table_name}} params: {:?}", &item);
    let conn = &data.conn;

    let req = item.0;

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
        {{column.rust_name}}: Set(req.{{column.rust_name}})
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.original_class_name}}::insert({{table_info.table_name}}).exec(conn).await;
    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}


/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/delete{{table_info.class_name}}")]
pub async fn delete_{{table_info.table_name}}(item: Json<Delete{{table_info.class_name}}Req>, data: State<AppState>) -> Result<impl web::Responder, web::Error> {
    info!("delete_{{table_info.table_name}} params: {:?}", &item);
    let conn = &data.conn;
    let req = item.0;

   let result = {{table_info.original_class_name}}::delete_many().filter({{table_info.original_class_name}}::Column::Id.is_in(req.ids)).exec(conn).await;

    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/update{{table_info.class_name}}")]
pub async fn update_{{table_info.table_name}}(item: Json<Update{{table_info.class_name}}Req>, data: State<AppState>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{table_info.table_name}} params: {:?}", &item);

    let conn = &data.conn;

    let req = item.0;

    if {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default().is_none() {
        return Ok(BaseResponse::<String>::err_result_msg("{{table_info.table_comment}}不存在,不能更新!".to_string()))
    }

    let {{table_info.table_name}} = {{table_info.table_name}}::ActiveModel {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: Set(req.{{column.rust_name}})
        {%- elif column.rust_name is containing("create") %}
        {{column.rust_name}}: NotSet
        {%- elif column.rust_name is containing("update_by") %}
        {{column.rust_name}}: Set(String::from(""))
        {%- elif column.rust_name is containing("update_time") %}
        {{column.rust_name}}: NotSet
        {%- else %}
        {{column.rust_name}}: Set(req.{{column.rust_name}})
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.original_class_name}}::update({{table_info.table_name}}).exec(conn).await;
    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/update{{table_info.class_name}}Status")]
pub async fn update_{{table_info.table_name}}_status(item: Json<Update{{table_info.class_name}}Req>, data: State<AppState>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{table_info.table_name}}_status params: {:?}", &item);
    let conn = &data.conn;

    let req = item.0;

    //{{table_info.original_class_name}}::update_many()
    //    .col_expr({{table_info.original_class_name}}::Column::Status, Expr::value(item.status))
    //    .filter({{table_info.original_class_name}}::Column::Id.is_in(item.ids))
    //    .exec(&conn)
    //    .await.unwrap();

     BaseResponse::<String>::ok_result_msg("更新{{table_info.table_comment}}状态成功!".to_string())
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/query{{table_info.class_name}}Detail")]
pub async fn query_{{table_info.table_name}}_detail(item: Json<Query{{table_info.class_name}}DetailReq>, data: State<AppState>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{table_info.table_name}}_detail params: {:?}", &item);
    let conn = &data.conn;

   let result = {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(conn).await;

   match result {
       Ok(d) => {
           let x = d.unwrap();

            let {{table_info.table_name}} = Query{{table_info.class_name}}DetailResp {
               {%- for column in table_info.columns %}
                {%- if column.is_nullable =="YES" %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                {%- elif column.rust_type =="DateTime" %}
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


/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/query{{table_info.class_name}}List")]
pub async fn query_{{table_info.table_name}}_list(item: Json<Query{{table_info.class_name}}ListReq>, data: State<AppState>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{table_info.table_name}}_list params: {:?}", &item);
    let conn = &data.conn;

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
            {%- if column.is_nullable =="YES" %}
            {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
            {%- elif column.rust_type =="DateTime" %}
            {{column.rust_name}}: x.{{column.rust_name}}.to_string()
            {%- else %}
            {{column.rust_name}}: x.{{column.rust_name}}
            {%- endif %}, //{{column.column_comment}}
          {%- endfor %}
        })
    }

    BaseResponse::<Vec<{{table_info.class_name}}ListDataResp>>::ok_result_page({{table_info.table_name}}_list_data, total)
}
