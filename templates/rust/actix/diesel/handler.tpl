use actix_web::{Either, post, Responder, Result, web};
use diesel::{ExpressionMethods, QueryDsl, RunQueryDsl, sql_query};
use diesel::associations::HasTable;
use diesel::sql_types::*;
use log::{debug, error, info};

use crate::{RB, schema};
use crate::model::{{.RustName}}::{{.UpperOriginalName}};
use crate::schema::{{.OriginalName}}::*;
use crate::schema::{{.OriginalName}}::dsl::{{.OriginalName}};
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};

/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/add_{{.RustName}}")]
pub async fn add_{{.RustName}}(req: web::Json<Add{{.JavaName}}Req>) -> Result<impl Responder> {
    info!("add_{{.RustName}} params: {:?}", &req);
    let item = req.0;

    let add_{{.OriginalName}} = {{.UpperOriginalName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: 0
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: Default::default()
        {{- else}}
        {{.RustName}}: item.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::insert_into({{.OriginalName}}::table()).values(add_{{.OriginalName}}).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    Ok(web::Json(resp))
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/delete_{{.RustName}}")]
pub async fn delete_{{.RustName}}(item: web::Json<Delete{{.JavaName}}Req>) -> Result<impl Responder> {
    info!("delete_{{.RustName}} params: {:?}", &item);
    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
            handle_result(diesel::delete({{.OriginalName}}.filter(id.eq_any(&item.ids))).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    Ok(web::Json(resp))
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update_{{.RustName}}")]
pub async fn update_{{.RustName}}(req: web::Json<Update{{.JavaName}}Req>) -> Result<impl Responder> {
    info!("update_{{.RustName}} params: {:?}", &req);
    let item = req.0;

    let update_{{.OriginalName}} = {{.UpperOriginalName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: 0
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: Default::default()
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: Default::default()
        {{- else}}
        {{.RustName}}: item.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
           handle_result(diesel::update({{.OriginalName}}).filter(id.eq(&item.id)).set(update_{{.OriginalName}}).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    return Ok(web::Json(resp));
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update_{{.RustName}}_status")]
pub async fn update_{{.RustName}}_status(item: web::Json<Update{{.JavaName}}StatusReq>) -> Result<impl Responder> {
    info!("update_{{.RustName}}_status params: {:?}", &item);

    let resp = match &mut RB.clone().get() {
        Ok(conn) => {
           handle_result(diesel::update({{.OriginalName}}).filter(id.eq_any(&item.ids)).set(status.eq(item.status)).execute(conn))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            err_result_msg(err.to_string())
        }
    };

    return Ok(web::Json(resp));
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query_{{.RustName}}_detail")]
pub async fn query_{{.RustName}}_detail(item: web::Json<Query{{.JavaName}}DetailReq>) -> Result<impl Responder> {
    info!("query_{{.RustName}}_detail params: {:?}", &item);

    match &mut RB.clone().get() {
        Ok(conn) => {
            let {{.OriginalName}}_sql = sql_query("SELECT * FROM {{.OriginalName}} WHERE id = ?");
            let result = {{.OriginalName}}_sql.bind::<Bigint, _>(&item.id).get_result(conn);
            if let Ok(x) = result {
              let data  =Query{{.JavaName}}DetailResp {
                    {{- range .TableColumn}}
                    {{- if eq .ColumnKey `PRI`}}
                        {{.RustName}}: x.{{.RustName}}
                    {{- else if eq .IsNullable `YES` }}
                        {{.RustName}}: x.{{.RustName}}.unwrap_or_default()
                    {{- else if eq .RustType `DateTime`}}
                        {{.RustName}}: x.{{.RustName}}.unwrap().0.to_string()
                    {{- else}}
                        {{.RustName}}: x.{{.RustName}}
                    {{- end}},
                    {{- end}}
                };

                Ok(web::Json(ok_result_data(data)))
            }
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Ok(web::Json(err_result_msg(err.to_string())))
        }
    }
}

/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query_{{.RustName}}_list")]
pub async fn query_{{.RustName}}_list(item: web::Json<Query{{.JavaName}}ListReq>) -> Result<impl Responder> {
    info!("query_{{.RustName}}_list params: {:?}", &item);

    let mut query = {{.OriginalName}}::table().into_boxed();

    //if let Some(i) = &item.status {
    //    query = query.filter(status_id.eq(i));
    //}

    debug!("SQL:{}", diesel::debug_query::<diesel::mysql::Mysql, _>(&query).to_string());

    let mut {{.RustName}}_list_data: Vec<Query{{.JavaName}}ListDataResp> = Vec::new();
    match &mut RB.clone().get() {
        Ok(conn) => {
            if let Ok(list) = query.load::<{{.UpperOriginalName}}>(conn) {
                for x in list {
                    {{.RustName}}_list_data.push(Query{{.JavaName}}ListDataResp {
                    {{- range .TableColumn}}
                    {{- if eq .ColumnKey `PRI`}}
                        {{.RustName}}: x.{{.RustName}}
                    {{- else if eq .IsNullable `YES` }}
                        {{.RustName}}: x.{{.RustName}}.unwrap_or_default()
                    {{- else if eq .RustType `DateTime`}}
                        {{.RustName}}: x.{{.RustName}}.unwrap().0.to_string()
                    {{- else}}
                        {{.RustName}}: x.{{.RustName}}
                    {{- end}},
                    {{- end}}
                    })
                }
            }
            Ok(web::Json(ok_result_page({{.RustName}}_list_data, 10)))
        }
        Err(err) => {
            error!("err:{}", err.to_string());
            Ok(web::Json(err_result_page({{.RustName}}_list_data, err.to_string())))
        }
    }
}
