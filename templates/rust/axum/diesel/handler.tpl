use axum::Json;
use axum::response::IntoResponse;
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl, sql_query};
use diesel::associations::HasTable;
use diesel::sql_types::*;
use log::{debug, error};

use crate::{RB, schema};

use crate::model::{{module_name}}::{{table_info.table_name}}::{{table_info.original_class_name}};
use crate::schema::{{table_info.table_name}}::*;
use crate::schema::{{table_info.table_name}}::dsl::{{table_info.table_name}};
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;


/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn add_{{table_info.table_name}}(Json(req): Json<Add{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("add_{{table_info.table_name}} params: {:?}", &req);

    let add_{{table_info.table_name}}_param = {{table_info.original_class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: 0
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: Default::default()
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: Default::default()
        {%- elif column.rust_name is containing("update") %}
        {{column.rust_name}}: Default::default()
        {%- else %}
        {{column.rust_name}}: req.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}


    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::insert_into({{table_info.table_name}}::table()).values(add_{{table_info.table_name}}_param).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn delete_{{table_info.table_name}}(Json(req): Json<Delete{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("delete_{{table_info.table_name}} params: {:?}", &req);
    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::delete({{table_info.table_name}}}.filter(id.eq_any(&req.ids))).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn update_{{table_info.table_name}}(Json(req): Json<Update{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("update_{{table_info.table_name}} params: {:?}", &req);

    let update_{{table_info.table_name}}_param = {{table_info.original_class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: 0
        {%- elif column.rust_name is containing("create") %}
        {{column.rust_name}}: Default::default()
        {%- elif column.rust_name is containing("update") %}
        {{column.rust_name}}: Default::default()
        {%- else %}
        {{column.rust_name}}: req.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}

    };

    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::update({{table_info.table_name}}).filter(id.eq(&req.id)).set(update_{{table_info.table_name}}_param).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn update_{{table_info.table_name}}_status(Json(req): Json<Update{{table_info.class_name}}StatusReq>) -> impl IntoResponse {
    log::info!("update_{{table_info.table_name}}_status params: {:?}", &req);

    match &mut RB.clone().get() {
        Ok(conn) => {
            Json(handle_result(diesel::update({{table_info.table_name}}).filter(id.eq_any(&req.ids)).set(status.eq(req.status)).execute(conn)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Json(err_result_msg(err.to_string()))
        }
    }
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_detail(Json(req): Json<Query{{table_info.class_name}}DetailReq>) -> Result<impl IntoResponse, impl IntoResponse> {
    log::info!("query_{{table_info.table_name}}_detail params: {:?}", &req);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let {{table_info.table_name}}_sql = sql_query("SELECT * FROM {{table_info.table_name}} WHERE id = ?");
            let result = {{table_info.table_name}}_sql.bind::<Bigint, _>(&req.id).get_result(conn);
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

             Ok(Json(ok_result_data(data)))
            }

        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Err(Json(err_result_msg(err.to_string())))
        }
    }
}

/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_list(Json(req): Json<Query{{table_info.class_name}}ListReq>) -> Result<impl IntoResponse, impl IntoResponse> {
    log::info!("query_{{table_info.table_name}}_list params: {:?}", &req);
    let mut query = {{table_info.table_name}}::table().into_boxed();

    //if let Some(i) = &req.status {
    //    query = query.filter(status_id.eq(i));
    //}

    debug!("SQL:{}", diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string());

    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = query.load::<SysRole>(conn);
            let mut {{table_info.table_name}}_list_data: Vec<Query{{table_info.class_name}}ListDataResp> = Vec::new();
            if let Ok(role_list) = result {
                for x in role_list {
                    {{table_info.table_name}}_list_data.push(Query{{table_info.class_name}}ListDataResp {
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
            }

            Ok(Json(ok_result_page({{table_info.table_name}}_list_data, 10)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Err(Json(err_result_msg(err.to_string())))
        }
    }
}

