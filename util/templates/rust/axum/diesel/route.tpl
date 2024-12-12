use std::sync::Arc;
use axum::Router;
use axum::routing::post;
use crate::AppState;

/*
 *构建{{table_info.table_comment}}路由
 *author：{{author}}
 *date：{{create_time}}
 */
pub fn build_{{table_info.table_name}}_route() -> Router<Arc<AppState>> {
    Router::new()
        .route("/add_{{table_info.table_name}}", post({{table_info.table_name}}_handler::add_{{table_info.table_name}}))
        .route("/delete_{{table_info.table_name}}", post({{table_info.table_name}}_handler::delete_{{table_info.table_name}}))
        .route("/update_{{table_info.table_name}}", post({{table_info.table_name}}_handler::update_{{table_info.table_name}}))
        .route("/update_{{table_info.table_name}}_status", post({{table_info.table_name}}_handler::update_{{table_info.table_name}}_status))
        .route("/query_{{table_info.table_name}}_detail", post({{table_info.table_name}}_handler::query_{{table_info.table_name}}_detail))
        .route("/query_{{table_info.table_name}}_list", post({{table_info.table_name}}_handler::query_{{table_info.table_name}}_list))
        //记得在main.rs中添加路由build_{{table_info.table_name}}_route()
}
