use actix_web::{Either, post, Responder, Result, web};
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl, sql_query};
use diesel::associations::HasTable;
use diesel::sql_types::*;
use log::{debug, error, info};

use crate::{RB, schema};
use crate::common::result::BaseResponse;
use crate::model::{{module_name}}::{{table_info.table_name}}_model::*;
use crate::schema::{{table_info.table_name}}::*;
use crate::schema::{{table_info.table_name}}::dsl::{{table_info.table_name}};
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;

/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/add_{{table_info.table_name}}")]
pub async fn add_{{table_info.table_name}}(req: web::Json<Add{{table_info.class_name}}Req>) -> Result<impl Responder> {
    info!("add_{{table_info.table_name}} params: {:?}", &req);
    let item = req.0;

    let add_{{table_info.table_name}}_param = Add{{table_info.original_class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {%- elif column.rust_name is containing("create_time") %}, //{{column.column_comment}}
        {{column.rust_name}}: Default::default()
        {%- elif column.rust_name is containing("create_by") %}, //{{column.column_comment}}
        {{column.rust_name}}: Default::default()
        {%- elif column.rust_name is containing("update") %}, //{{column.column_comment}}
        {{column.rust_name}}: Default::default()
        {%- else %}
        {{column.rust_name}}: item.{{column.rust_name}}, //{{column.column_comment}}
        {%- endif %}
    {%- endfor %}
    };

    match &mut RB.clone().get() {
        Ok(conn) => {
           let result = diesel::insert_into({{table_info.table_name}}::table()).values(add_{{table_info.table_name}}_param).execute(conn);
           match result {
                Ok(_u) => BaseResponse::<String>::ok_result(),
                Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
           }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::<String>::err_result_msg(err.to_string())
        }
    }
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/delete_{{table_info.table_name}}")]
pub async fn delete_{{table_info.table_name}}(item: web::Json<Delete{{table_info.class_name}}Req>) -> Result<impl Responder> {
    info!("delete_{{table_info.table_name}} params: {:?}", &item);
    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = diesel::delete({{table_info.table_name}}.filter(id.eq_any(&item.ids))).execute(conn);
            match result {
                Ok(_u) => BaseResponse::<String>::ok_result(),
                Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
            }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::<String>::err_result_msg(err.to_string())
        }
    }
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update_{{table_info.table_name}}")]
pub async fn update_{{table_info.table_name}}(req: web::Json<Update{{table_info.class_name}}Req>) -> Result<impl Responder> {
    info!("update_{{table_info.table_name}} params: {:?}", &req);
    let item = req.0;

    let update_{{table_info.table_name}}_param = Update{{table_info.original_class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.rust_name is containing("create") %}
        {{column.rust_name}}: Default::default()
        {%- elif column.rust_name is containing("update") %}
        {{column.rust_name}}: Default::default()
        {%- else %}
        {{column.rust_name}}: item.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}

    };

    match &mut RB.clone().get() {
        Ok(conn) => {
           let result = diesel::update({{table_info.table_name}}).filter(id.eq(&item.id)).set(update_{{table_info.table_name}}_param).execute(conn);
           match result {
                Ok(_u) => BaseResponse::<String>::ok_result(),
                Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
           }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::<String>::err_result_msg(err.to_string())
        }
    }
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update_{{table_info.table_name}}_status")]
pub async fn update_{{table_info.table_name}}_status(item: web::Json<Update{{table_info.class_name}}StatusReq>) -> Result<impl Responder> {
    info!("update_{{table_info.table_name}}_status params: {:?}", &item);

    match &mut RB.clone().get() {
        Ok(conn) => {
           let result = diesel::update({{table_info.table_name}}).filter(id.eq_any(&item.ids)).set(status.eq(item.status)).execute(conn);
           match result {
                Ok(_u) => BaseResponse::<String>::ok_result(),
                Err(err) => BaseResponse::<String>::err_result_msg(err.to_string()),
           }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::<String>::err_result_msg(err.to_string())
        }
    }
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query_{{table_info.table_name}}_detail")]
pub async fn query_{{table_info.table_name}}_detail(item: web::Json<Query{{table_info.class_name}}DetailReq>) -> Result<impl Responder> {
    info!("query_{{table_info.table_name}}_detail params: {:?}", &item);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let {{table_info.table_name}}_sql = sql_query("SELECT * FROM {{table_info.table_name}} WHERE id = ?");
            let result = {{table_info.table_name}}_sql.bind::<Bigint, _>(&item.id).get_result(conn);
            if let Ok(x) = result {
              let data  =Query{{table_info.class_name}}DetailResp {
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

              BaseResponse::<Query{{table_info.class_name}}DetailResp>::ok_result_data(data)
            }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::<String>::err_result_msg(err.to_string())
        }
    }
}

/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query_{{table_info.table_name}}_list")]
pub async fn query_{{table_info.table_name}}_list(item: web::Json<Query{{table_info.class_name}}ListReq>) -> Result<impl Responder> {
    info!("query_{{table_info.table_name}}_list params: {:?}", &item);

    let mut query = {{table_info.table_name}}::table().into_boxed();

    //if let Some(i) = &item.status {
    //    query = query.filter(status_id.eq(i));
    //}

    debug!("SQL:{}", diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string());

    let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();
    match &mut RB.clone().get() {
        Ok(conn) => {
            if let Ok(list) = query.load::<{{table_info.original_class_name}}>(conn) {
                for x in list {
                    {{table_info.table_name}}_list_data.push({{table_info.class_name}}ListDataResp {
                    {%- for column in table_info.columns %}
                        {%- if column.column_key =="PRI"  %}
                        {{column.rust_name}}: x.{{column.rust_name}}
                        {%- elif column.is_nullable =="YES" %}
                        {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                        {%- elif column.rust_type =="DateTime" %}
                        {{column.rust_name}}: x.{{column.rust_name}}.to_string()
                        {%- else %}
                        {{column.rust_name}}: x.{{column.rust_name}}
                        {%- endif %}, //{{column.column_comment}}
                      {%- endfor %}
                    })
                }
            }
            let total = 0;
            BaseResponse::<Vec<{{table_info.class_name}}ListDataResp>>::ok_result_page({{table_info.table_name}}_list_data, total)
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::<Vec<{{table_info.class_name}}ListDataResp>>::err_result_page({{table_info.table_name}}_list_data, err.to_string()),
        }
    }
}
