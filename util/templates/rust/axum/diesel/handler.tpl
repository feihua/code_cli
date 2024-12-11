 use axum::Json;
use axum::response::IntoResponse;
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl, sql_query};
use diesel::associations::HasTable;
use diesel::sql_types::*;
use log::{debug, error};

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
pub async fn add_{{table_info.table_name}}(Json(req): Json<Add{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("add_{{table_info.table_name}} params: {:?}", &req);

    let add_{{table_info.table_name}}_param = Add{{table_info.original_class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
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
pub async fn delete_{{table_info.table_name}}(Json(req): Json<Delete{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("delete_{{table_info.table_name}} params: {:?}", &req);
    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = diesel::delete({{table_info.table_name}}).filter(id.eq_any(&req.ids)).execute(conn);
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
pub async fn update_{{table_info.table_name}}(Json(req): Json<Update{{table_info.class_name}}Req>) -> impl IntoResponse {
    log::info!("update_{{table_info.table_name}} params: {:?}", &req);

    let update_{{table_info.table_name}}_param = Update{{table_info.original_class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.rust_name is containing("create") %}
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
            let result = diesel::update({{table_info.table_name}}).filter(id.eq(&req.id)).set(update_{{table_info.table_name}}_param).execute(conn);
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
pub async fn update_{{table_info.table_name}}_status(Json(req): Json<Update{{table_info.class_name}}StatusReq>) -> impl IntoResponse {
    log::info!("update_{{table_info.table_name}}_status params: {:?}", &req);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = diesel::update({{table_info.table_name}}).filter(id.eq_any(&req.ids)).set(status.eq(req.status)).execute(conn);
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
pub async fn query_{{table_info.table_name}}_detail(Json(req): Json<Query{{table_info.class_name}}DetailReq>) -> Result<impl IntoResponse, impl IntoResponse> {
    log::info!("query_{{table_info.table_name}}_detail params: {:?}", &req);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let {{table_info.table_name}}_sql = sql_query("SELECT * FROM {{table_info.table_name}} WHERE id = ?");
            let result = {{table_info.table_name}}_sql.bind::<Bigint, _>(&req.id).get_result::<{{table_info.original_class_name}}>(conn);
            match result {
                Ok(x) => {
                let data  =Query{{table_info.class_name}}DetailResp {
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

                 Ok(BaseResponse::<Query{{table_info.class_name}}DetailResp>::ok_result_data(data))
                 },
                Err(err) => Err(BaseResponse::<String>::err_result_msg(err.to_string())),
            }


        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Err(BaseResponse::<String>::err_result_msg(err.to_string()))
        }
    }
}

/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
pub async fn query_{{table_info.table_name}}_list(Json(req): Json<Query{{table_info.class_name}}ListReq>) -> impl IntoResponse {
    log::info!("query_{{table_info.table_name}}_list params: {:?}", &req);
    let mut query = {{table_info.table_name}}::table().into_boxed();

    //if let Some(i) = &req.status {
    //    query = query.filter(status_id.eq(i));
    //}

    debug!("SQL:{}", diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string());

    let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();
    match &mut RB.clone().get() {
        Ok(conn) => {
            let result = query.load::<{{table_info.original_class_name}}>(conn);

            if let Ok(role_list) = result {
                for x in role_list {
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
            }

            BaseResponse::ok_result_page({{table_info.table_name}}_list_data, 0)
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            BaseResponse::err_result_page({{table_info.table_name}}_list_data, err.to_string())
        }
    }
}

