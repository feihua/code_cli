use rocket::serde::json::serde_json::json;
use rocket::serde::json::{Json, Value};
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;

use crate::model::{{.RustName}}::{ {{.JavaName}} };
use crate::RB;
use crate::utils::auth::Token;
use rbs::to_value;
use crate::vo::*;
use crate::vo::{{.RustName}}_vo::{*};

/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/add{{.JavaName}}", data = "<item>")]
pub async fn add_{{.RustName}}(item: Json<Add{{.JavaName}}Req>, _auth: Token) -> Value {
    log::info!("add_{{.RustName}} params: {:?}", &item);
    let mut rb = RB.to_owned();

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

    let result = {{.JavaName}}::insert(&mut rb, &{{.RustName}}).await;

    json!(&handle_result(result))
}

/**
 *删除{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/delete{{.JavaName}}", data = "<item>")]
pub async fn delete_{{.RustName}}(item: Json<Delete{{.JavaName}}Req>, _auth: Token) -> Value {
    log::info!("delete_{{.RustName}} params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{.JavaName}}::delete_in_column(&mut rb, "id", &item.ids).await;

    json!(&handle_result(result))
}

/**
 *更新{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{.JavaName}}", data = "<item>")]
pub async fn update_{{.RustName}}(item: Json<Update{{.JavaName}}Req>, _auth: Token) -> Value {
    log::info!("update_{{.RustName}} params: {:?}", &item);
    let mut rb = RB.to_owned();
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

    let result = {{.JavaName}}::update_by_column(&mut rb, &{{.RustName}}, "id").await;

    json!(&handle_result(result))
}

/**
 *更新{{table_info.table_comment}}状态
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/update{{.JavaName}}Status", data = "<item>")]
pub async fn update_{{.RustName}}_status(item: Json<Update{{.JavaName}}StatusReq>, _auth: Token) -> Value {
    log::info!("update_{{.RustName}}_status params: {:?}", &item);
    let mut rb = RB.to_owned();
    let req = item.0;

    let param = vec![to_value!(1), to_value!(1)];
    let result = rb.exec("update {{.OriginalName}} set status = ? where id in ?", param).await;

    json!(&handle_result(result))
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{.JavaName}}Detail", data = "<item>")]
pub async fn query_{{.RustName}}_detail(item: Json<Query{{.JavaName}}DetailReq>, _auth: Token) -> Value {
    log::info!("query_{{.RustName}}_detail params: {:?}", &item);
    let mut rb = RB.to_owned();

    let result = {{.JavaName}}::select_by_id(&mut rb, &item.id).await;

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

            json!(ok_result_data({{.RustName}}))
        }
        Err(err) => {
            json!(ok_result_code(1, err.to_string()))
        }
    }
}


/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[post("/query{{.JavaName}}List", data = "<item>")]
pub async fn query_{{.RustName}}_list(item: Json<Query{{.JavaName}}ListReq>, _auth: Token) -> Value {
    log::info!("query_{{.RustName}}_list params: {:?}", &item);
    let mut rb = RB.to_owned();

    let page = &PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let result = {{.JavaName}}::select_page(&mut rb, page).await;

    match result {
        Ok(d) => {
            let total = d.total;

            let mut {{.RustName}}_list_data: Vec<{{.JavaName}}ListDataResp> = Vec::new();

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

            json!(ok_result_page({{.RustName}}_list_data, total))
        }
        Err(err) => {
            json!(err_result_page(err.to_string()))
        }
    }
}

