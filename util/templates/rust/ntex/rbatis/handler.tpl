use log::info;
use ntex::web;
use ntex::web::types::Json;
use rbatis::rbdc::datetime::DateTime;
use rbatis::plugin::page::PageRequest;
use rbs::to_value;

use crate::common::result::BaseResponse;
use crate::model::{{module_name}}::{{table_info.table_name}}_model::{ {{table_info.class_name}} };
use crate::RB;
use crate::vo::{{module_name}}::*;
use crate::vo::{{module_name}}::{{table_info.table_name}}_vo::*;


/**
 *添加{{table_info.table_comment}}
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/add{{table_info.class_name}}")]
pub async fn add_{{table_info.table_name}}(item: Json<Add{{table_info.class_name}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("add_{{table_info.table_name}} params: {:?}", &item);

    let req = item.0;

    let {{table_info.table_name}} = {{table_info.class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: String::from("")
        {%- elif column.rust_name is containing("update_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("update_by") %}
        {{column.rust_name}}: String::from("")
        {%- else %}
        {{column.rust_name}}: req.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.class_name}}::insert(&mut RB.clone(),&{{table_info.table_name}}).await;

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
pub async fn delete_{{table_info.table_name}}(item: Json<Delete{{table_info.class_name}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("delete_{{table_info.table_name}} params: {:?}", &item);

    let result = {{table_info.class_name}}::delete_in_column(&mut RB.clone(), "id", &item.ids).await;

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
pub async fn update_{{table_info.table_name}}(item: Json<Update{{table_info.class_name}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{table_info.table_name}} params: {:?}", &item);

    let req = item.0;

    let {{table_info.table_name}} = {{table_info.class_name}} {
    {%- for column in table_info.columns %}
        {%- if column.column_key =="PRI"  %}
        {{column.rust_name}}: Some(req.{{column.rust_name}})
        {%- elif column.rust_name is containing("create_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("create_by") %}
        {{column.rust_name}}: String::from("")
        {%- elif column.rust_name is containing("update_time") %}
        {{column.rust_name}}: None
        {%- elif column.rust_name is containing("update_by") %}
        {{column.rust_name}}: String::from("")
        {%- else %}
        {{column.rust_name}}: req.{{column.rust_name}}
        {%- endif %}, //{{column.column_comment}}
    {%- endfor %}
    };

    let result = {{table_info.class_name}}::update_by_column(&mut RB.clone(), &{{table_info.table_name}}, "id").await;

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
pub async fn update_{{table_info.table_name}}_status(item: Json<Update{{table_info.class_name}}Req>) -> Result<impl web::Responder, web::Error> {
    info!("update_{{table_info.table_name}}_status params: {:?}", &item);
    let rb=&mut RB.clone();

    let req = item.0;

   let param = vec![to_value!(1), to_value!(1)];
   let result = rb.exec("update {{table_info.table_name}} set status = ? where id in ?", param).await;

    match result {
        Ok(_u) => Ok(BaseResponse::<String>::ok_result()),
        Err(err) => Ok(BaseResponse::<String>::err_result_msg(err.to_string())),
    }
}

/**
 *查询{{table_info.table_comment}}详情
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/query{{table_info.class_name}}Detail")]
pub async fn query_{{table_info.table_name}}_detail(item: Json<Query{{table_info.class_name}}DetailReq>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{table_info.table_name}}_detail params: {:?}", &item);

   let result = {{table_info.class_name}}::select_by_id(&mut RB.clone(), &item.id).await;

    match result {
        Ok(d) => {
            let x = d.unwrap();

            let {{table_info.table_name}} = Query{{table_info.class_name}}DetailResp {
            {%- for column in table_info.columns %}
                {%- if column.column_key =="PRI"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
                {%- elif column.is_nullable == "YES"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                {%- elif column.rust_type == "DateTime"  %}
                {{column.rust_name}}: x.{{column.rust_name}}.to_string()
                {%- else %}
                {{column.rust_name}}: x.{{column.rust_name}}
                {%- endif %}, //{{column.column_comment}}
            {%- endfor %}

            };

           Ok(BaseResponse::<Query{{table_info.class_name}}DetailResp>::ok_result_data({{table_info.table_name}}))
        }
        Err(err) => {
            Ok(BaseResponse::<String>::ok_result_code(1, err.to_string()))
        }
    }
}


/**
 *查询{{table_info.table_comment}}列表
 *author：{{author}}
 *date：{{create_time}}
 */
#[web::post("/query{{table_info.class_name}}List")]
pub async fn query_{{table_info.table_name}}_list(item: Json<Query{{table_info.class_name}}ListReq>) -> Result<impl web::Responder, web::Error> {
    info!("query_{{table_info.table_name}}_list params: {:?}", &item);


    let page=&PageRequest::new(item.page_no.clone(), item.page_size.clone());
    let result = {{table_info.class_name}}::select_page(&mut RB.clone(), page).await;

    let mut {{table_info.table_name}}_list_data: Vec<{{table_info.class_name}}ListDataResp> = Vec::new();
    match result {
        Ok(d) => {
            let total = d.total;

            for x in d.records {
                {{table_info.table_name}}_list_data.push({{table_info.class_name}}ListDataResp {
                {%- for column in table_info.columns %}
                    {%- if column.column_key =="PRI"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap()
                    {%- elif column.is_nullable == "YES"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.unwrap_or_default()
                    {%- elif column.rust_type == "DateTime"  %}
                    {{column.rust_name}}: x.{{column.rust_name}}.to_string()
                    {%- else %}
                    {{column.rust_name}}: x.{{column.rust_name}}
                    {%- endif %}, //{{column.column_comment}}
                {%- endfor %}
                })
            }

            Ok(BaseResponse::<Vec<{{table_info.class_name}}ListDataResp>>::ok_result_page({{table_info.table_name}}_list_data, total))
        }
        Err(err) => {
            Ok(BaseResponse::<Vec<{{table_info.class_name}}ListDataResp>>::err_result_page({{table_info.table_name}}_list_data, err.to_string()))
        }
    }
}
