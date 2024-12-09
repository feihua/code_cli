use actix_web::{post, Responder, Result, web};
use sea_orm::{ColumnTrait, EntityTrait, NotSet, PaginatorTrait, QueryFilter, QueryOrder};
use sea_orm::ActiveValue::Set;
use crate::AppState;

use crate::common::result::BaseResponse;
use crate::model::{{module_name}}::{ {{table_info.table_name}} };
use crate::model::{{module_name}}::prelude::{ {{table_info.original_class_name}} };
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;
use crate::vo::{{module_name}}::{err_result_msg, ok_result_msg, ok_result_page};
/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/add{{table_info.class_name}}")]
pub async fn add_{{table_info.table_name}}(item: web::Json<Add{{table_info.class_name}}Req>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("add_{{table_info.table_name}} params: {:?}", &item);
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


    {{table_info.original_class_name}}::insert({{table_info.table_name}}).exec(conn).await.unwrap();
    Ok(web::Json(ok_result_msg("添加{{table_info.table_comment}}成功!")))
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/delete{{table_info.class_name}}")]
pub async fn delete_{{table_info.table_name}}(item: web::Json<Delete{{table_info.class_name}}Req>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("delete_{{table_info.table_name}} params: {:?}", &item);
    let conn = &data.conn;
    let req = item.0;

    {{table_info.original_class_name}}::delete_many().filter({{table_info.original_class_name}}::Column::Id.is_in(req.ids)).exec(conn).await.unwrap();

    Ok(web::Json(ok_result_msg("删除{{table_info.table_comment}}成功!")))
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{table_info.class_name}}")]
pub async fn update_{{table_info.table_name}}(item: web::Json<Update{{table_info.class_name}}Req>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("update_{{table_info.table_name}} params: {:?}", &item);
    let conn = &data.conn;
    let req = item.0;

    if {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(conn).await.unwrap_or_default().is_none() {
        return Ok(web::Json(err_result_msg("{{table_info.table_comment}}不存在,不能更新!")))
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
    Ok(web::Json(ok_result_msg("更新{{table_info.table_comment}}成功!")))
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{table_info.class_name}}Status")]
pub async fn update_{{table_info.table_name}}_status(item: web::Json<Update{{table_info.class_name}}StatusReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("update_{{table_info.table_name}}_status params: {:?}", &item);
    let conn = &data.conn;
    //let req = item.0;

    //{{table_info.original_class_name}}::update_many()
    //    .col_expr({{table_info.original_class_name}}::Column::Status, Expr::value(item.status))
    //    .filter({{table_info.original_class_name}}::Column::Id.is_in(item.ids))
    //    .exec(&conn)
    //    .await.unwrap();

    Ok(web::Json(ok_result_msg("更新{{table_info.table_comment}}状态成功!")))
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{table_info.class_name}}Detail")]
pub async fn query_{{table_info.table_name}}_detail(item: web::Json<Query{{table_info.class_name}}DetailReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("query_{{table_info.table_name}}_detail params: {:?}", &item);
    let conn = &data.conn;

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


            Ok(web::Json(ok_result_data({{table_info.table_name}})))
        }
        Err(err) => {
            Ok(web::Json(err_result_msg(err.to_string())))
        }
    }

}

/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{table_info.class_name}}List")]
pub async fn query_{{table_info.table_name}}_list(item: web::Json<Query{{table_info.class_name}}ListReq>, data: web::Data<AppState>) -> Result<impl Responder> {
    log::info!("query_{{table_info.table_name}}_list params: {:?}", &item);
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


    Ok(web::Json(ok_result_page({{table_info.table_name}}_list_data, total)))

}
