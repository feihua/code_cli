use log::info;
use ntex::web;
use ntex::web::types::Json;
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;
use rbs::to_value;

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::RB;
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};


/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/add{{.JavaName}}")]
pub async fn add_{{.RustName}}(item: Json<Add{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("add_{{.RustName}} params: {:?}", &item);

    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: None
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: None
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: None
        {{- else}}
        {{.RustName}}: req.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    let result = {{.JavaName}}::insert(&mut RB.clone(),&{{.RustName}}).await;

    Ok(web::HttpResponse::Ok().json(&handle_result(result)))
}


/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/delete{{.JavaName}}")]
pub async fn delete_{{.RustName}}(item: Json<Delete{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("delete_{{.RustName}} params: {:?}", &item);

    let result = {{.JavaName}}::delete_in_column(&mut RB.clone(), "id", &item.ids).await;

    Ok(web::HttpResponse::Ok().json(&handle_result(result)))
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/update{{.JavaName}}")]
pub async fn update_{{.RustName}}(item: Json<Update{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{.RustName}} params: {:?}", &item);

    let req = item.0;

    let {{.RustName}} = {{.JavaName}} {
    {{- range .TableColumn}}
        {{- if eq .ColumnKey `PRI`}}
        {{.RustName}}: Some(item.{{.RustName}})
        {{- else if isContain .JavaName "createTime"}}
        {{.RustName}}: None
        {{- else if isContain .JavaName "createBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateBy"}}
        {{.RustName}}: String::from("")
        {{- else if isContain .JavaName "updateTime"}}
        {{.RustName}}: None
        {{- else}}
        {{.RustName}}: req.{{.RustName}}
        {{- end}},//{{.ColumnComment}}
    {{- end}}
    };

    let result = {{.JavaName}}::update_by_column(&mut RB.clone(), &{{.RustName}}, "id").await;

    Ok(web::HttpResponse::Ok().json(&handle_result(result)))
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/update{{.JavaName}}Status")]
pub async fn update_{{.RustName}}_status(item: Json<Update{{.JavaName}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{.RustName}}_status params: {:?}", &item);
    let rb=&mut RB.clone();

    let req = item.0;

   let param = vec![to_value!(1), to_value!(1)];
   let result = rb.exec("update {{.OriginalName}} set status = ? where id in ?", param).await;

    Ok(web::HttpResponse::Ok().json(&handle_result(result)))
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/query{{.JavaName}}Detail")]
pub async fn query_{{.RustName}}_detail(item: Json<Query{{.JavaName}}DetailReq>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{.RustName}}_detail params: {:?}", &item);

   let result = {{.JavaName}}::select_by_id(&mut RB.clone(), &item.id).await;

    match result {
        Ok(d) => {
            let x = d.unwrap();

            let {{.RustName}} = Query{{.JavaName}}DetailResp {
            {{- range .TableColumn}}
            {{- if eq .ColumnKey `PRI`}}
                {{.RustName}}: x.{{.RustName}}.unwrap()
            {{- else if eq .IsNullable `YES` }}
                {{.RustName}}: x.{{.RustName}}.unwrap_or_default()
            {{- else if eq .RustType `DateTime`}}
                {{.RustName}}: x.{{.RustName}}.unwrap().0.to_string()
            {{- else}}
                {{.RustName}}: x.{{.RustName}}
            {{- end}},
            {{- end}}
            };

            Ok(web::HttpResponse::Ok().json(&ok_result_data({{.RustName}})))
        }
        Err(err) => {
            Ok(web::HttpResponse::Ok().json(&ok_result_code(1, err.to_string())))
        }
    }
}


/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/query{{.JavaName}}List")]
pub async fn query_{{.RustName}}_list(item: Json<Query{{.JavaName}}ListReq>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{.RustName}}_list params: {:?}", &item);


    let page=&PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let result = {{.JavaName}}::select_page(&mut RB.clone(), page).await;

    let mut {{.RustName}}_list_data: Vec<{{.JavaName}}ListDataResp> = Vec::new();
    match result {
        Ok(d) => {
            let total = d.total;

            for x in d.records {
                {{.RustName}}_list_data.push({{.JavaName}}ListDataResp {
                {{- range .TableColumn}}
                {{- if eq .ColumnKey `PRI`}}
                    {{.RustName}}: x.{{.RustName}}.unwrap()
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

            Ok(web::HttpResponse::Ok().json(&ok_result_page({{.RustName}}_list_data, total)))
        }
        Err(err) => {
            Ok(web::HttpResponse::Ok().json(&err_result_page({{.RustName}}_list_data, err.to_string())))
        }
    }
}