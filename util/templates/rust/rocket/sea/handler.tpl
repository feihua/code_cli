// Code generated by https://github.com/feihua/code_cli
// author：{{author}}
// date：{{create_time}}

use sea_orm::{ColumnTrait, DatabaseConnection, EntityTrait, NotSet, PaginatorTrait, QueryFilter, QueryTrait};
use rocket::State;
use sea_orm::ActiveValue::Set;

use rocket::serde::json::serde_json::json;
use rocket::serde::json::{Json, Value};
use crate::common::error_handler::ErrorResponder;
use crate::middleware::auth::Token;
use crate::common::result::BaseResponse;
use crate::model::{{module_name}}::{ {{table_info.table_name}} };
use crate::model::{{module_name}}::prelude::{ {{table_info.original_class_name}} };
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;

/*
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/add{{table_info.class_name}}", data = "<item>")]
pub async fn add_{{table_info.table_name}}(db: &State<DatabaseConnection>, item: Json<Add{{table_info.class_name}}Req>, _auth: Token) -> Result<Value, ErrorResponder> {
    log::info!("add {{table_info.table_name}} params: {:?}", &item);
    let db = db as &DatabaseConnection;

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

    let result = {{table_info.original_class_name}}::insert({{table_info.table_name}}).exec(db).await;

    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}

/*
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/delete{{table_info.class_name}}", data = "<item>")]
pub async fn delete_{{table_info.table_name}}(db: &State<DatabaseConnection>, item: Json<Delete{{table_info.class_name}}Req>, _auth: Token) -> Result<Value, ErrorResponder> {
    log::info!("delete {{table_info.table_name}} params: {:?}", &item);
    let db = db as &DatabaseConnection;
    let req = item.0;

    let result = {{table_info.original_class_name}}::delete_many().filter({{table_info.original_class_name}}::Column::Id.is_in(req.ids)).exec(db).await;

    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}

/*
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{table_info.class_name}}", data = "<item>")]
pub async fn update_{{table_info.table_name}}(db: &State<DatabaseConnection>, item: Json<Update{{table_info.class_name}}Req>, _auth: Token) -> Result<Value, ErrorResponder> {
    log::info!("update {{table_info.table_name}} params: {:?}", &item);
    let db = db as &DatabaseConnection;
    let req = item.0;

    if {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(db).await?.is_none() {
        return Ok(BaseResponse::<String>::err_result_msg("{{table_info.table_comment}}不存在,不能更新!".to_string()));
    }

    let {{table_info.table_name}} = {{table_info.table_name}}::ActiveModel {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: Set(req.{{column.rust_name}})
        {%- elif column.rust_name is containing("create") %}
        {{column.rust_name}}: NotSet
        {%- elif column.rust_name is containing("update by") %}
        {{column.rust_name}}: Set(String::from(""))
        {%- elif column.rust_name is containing("update time") %}
        {{column.rust_name}}: NotSet
        {%- else %}
        {{column.rust_name}}: Set(req.{{column.rust_name}})
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.original_class_name}}::update({{table_info.table_name}}).exec(db).await;
    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}

/*
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{table_info.class_name}}Status", data = "<item>")]
pub async fn update_{{table_info.table_name}}_status(db: &State<DatabaseConnection>, item: Json<Update{{table_info.class_name}}StatusReq>, _auth: Token) -> Result<Value, ErrorResponder> {
    log::info!("update {{table_info.table_name}}_status params: {:?}", &item);
    //let db = db as &DatabaseConnection;
    //let req = item.0;

    //{{table_info.original_class_name}}::update_many()
    //    .col_expr({{table_info.original_class_name}}::Column::Status, Expr::value(item.status))
    //    .filter({{table_info.original_class_name}}::Column::Id.is_in(item.ids))
    //    .exec(db)
    //    .await;

     Ok(BaseResponse::<String>::ok_result_msg("更新{{table_info.table_comment}}状态成功!".to_string()))
}

/*
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{table_info.class_name}}Detail", data = "<item>")]
pub async fn query_{{table_info.table_name}}_detail(db: &State<DatabaseConnection>, item: Json<Query{{table_info.class_name}}DetailReq>, _auth: Token) -> Result<Value, ErrorResponder> {
    log::info!("query {{table_info.table_name}}_detail params: {:?}", &item);
    let db = db as &DatabaseConnection;

    let result = {{table_info.original_class_name}}::find_by_id(item.id.clone()).one(db).await;

        match result {
            Ok(d) => {
                let x = d.unwrap();

                let {{table_info.table_name}} = Query{{table_info.class_name}}DetailResp {
                   {%- for column in table_info.columns %}
                    {%- if column.is_nullable =="YES" %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default(), //{{column.column_comment}}
                    {%- elif column.rust_type =="DateTime" %}
                    {{column.rust_name}}: x.{{column.rust_name}}.to_string(), //{{column.column_comment}}
                    {%- else %}
                    {{column.rust_name}}: x.{{column.rust_name}}, //{{column.column_comment}}
                    {%- endif %}
                  {%- endfor %}
                };

                Ok(BaseResponse::<Query{{table_info.class_name}}DetailResp>::ok_result_data({{table_info.table_name}}))
            }
            Err(err) => {
                Ok(BaseResponse::<String>::err_result_msg(err.to_string()))
            }
        }

}


/*
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{table_info.class_name}}List", data = "<item>")]
pub async fn query_{{table_info.table_name}}_list(db: &State<DatabaseConnection>, item: Json<Query{{table_info.class_name}}ListReq>, _auth: Token) -> Result<Value, ErrorResponder> {
    log::info!("query {{table_info.table_name}}_list params: {:?}", &item);
    let db = db as &DatabaseConnection;

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
        .paginate(db, item.page_size.clone());

    let total = paginator.num_items().await.unwrap_or_default();

    let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();

    for x in paginator.fetch_page(item.page_no.clone() - 1).await {
        {{table_info.table_name}}_list_data.push({{table_info.class_name}}ListDataResp {
            {%- for column in table_info.columns %}
            {%- if column.is_nullable =="YES" %}
            {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default(), //{{column.column_comment}}
            {%- elif column.rust_type =="DateTime" %}
            {{column.rust_name}}: x.{{column.rust_name}}.to_string(), //{{column.column_comment}}
            {%- else %}
            {{column.rust_name}}: x.{{column.rust_name}}, //{{column.column_comment}}
            {%- endif %}
          {%- endfor %}
        })
    }

     BaseResponse::<Vec<{{table_info.class_name}}ListDataResp>>::ok_result_page({{table_info.table_name}}_list_data, total)
}

