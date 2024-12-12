use salvo::Router;

/*
 *构建{{table_info.table_comment}}路由
 *author：{{author}}
 *date：{{create_time}}
 */
pub fn build_{{table_info.table_name}}_route() -> Router {
    Router::new()
        .push(Router::new().path("add {{table_info.table_name}}").post(add_{{table_info.table_name}}))
        .push(Router::new().path("delete {{table_info.table_name}}").post(delete_{{table_info.table_name}}))
        .push(Router::new().path("update {{table_info.table_name}}").post(update_{{table_info.table_name}}))
        .push(Router::new().path("update {{table_info.table_name}}_status").post(update_{{table_info.table_name}}_status))
        .push(Router::new().path("query {{table_info.table_name}}_detail").post(query_{{table_info.table_name}}_detail))
        .push(Router::new().path("query {{table_info.table_name}}_list").post(query_{{table_info.table_name}}_list))
        //记得在main.rs中的route()函数中添加构建{{table_info.table_comment}}路由build_{{table_info.table_name}}_route()
}
