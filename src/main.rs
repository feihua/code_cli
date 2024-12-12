use chrono::Local;
use ::model::db_info::DbInfo;
use ::service::rust::rocket::Rocket;
use tera::{Context, Tera};
use ::util::db_util::DbUtil;
use service::go::gf::Gf;
use service::go::hertz::Hertz;
use service::go::zero::Gozero;
use service::java::mybatis::Mybatis;
use service::rust::actix::Actix;
use service::rust::axum::Axum;
use service::rust::ntex::Ntex;
use service::rust::salvo::Salvo;
use service::web::angular::ng_zorro_antd::NgZorroAntd;
use service::web::react::antd::ReactAntd;
use service::web::react::antd_state::ReactAntdState;
use service::web::react::pro::ReactAntdPro;
use service::web::vue::antd::VueAntd;
use service::web::vue::element_plus::ElementPlus;
use service::web::vue::element_plus_state::ElementPlusState;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 模板引擎
    let mut tera = Tera::default();
    tera.autoescape_on(vec![]);

    // 模板参数
    let package_name = "com.example.springboottpl";
    let author = "刘飞华";
    let fmt = "%Y/%m/%d %H:%M:%S";
    let create_time = Local::now().format(fmt).to_string();

    let mut context = Context::new();
    context.insert("author", author);
    context.insert("create_time", create_time.as_str());
    context.insert("package_name", package_name);

    //go
    let project_name = "github.com/demo/test";
    context.insert("project_name", project_name);
    context.insert("rpc_client", "system");

    // 数据库链接信息
    let mut info = DbInfo::default();
    info.host = String::from("110.41.179.89"); //数据库ip
    info.port = 3306; //数据库端口
    info.user_name = String::from("root"); //数据库账号
    info.password = String::from("oMbPi5munxCsBSsiLoPV"); //数据库密码
    info.table_db = String::from("better-pay"); //业务数据库
    info.table_name_str = String::from("sys_"); //待生成的表
    info.t_prefix = String::from("sys_"); //生成时，待去掉的表前缀

    // 待生成代码的表
    let table_info_list = DbUtil::get_tables(info);
    let orm_type = "";
    let module_name = "system";
    for x in table_info_list {
        context.insert("table_info", &x);
        context.insert("module_name", module_name);
        Mybatis::generate_mybatis_curd(&mut tera, x.clone(), context.clone(), module_name);
        NgZorroAntd::generate_ng_curd(&mut tera, x.clone(), context.clone());
        Salvo::generate_salvo_curd(&mut tera, x.clone(), orm_type, context.clone(), module_name);
        Rocket::generate_rocket_curd(&mut tera, x.clone(), orm_type, context.clone(), module_name);
        Ntex::generate_ntex_curd(&mut tera, x.clone(), orm_type, context.clone(), module_name);
        Axum::generate_axum_curd(&mut tera, x.clone(), orm_type, context.clone(), module_name);
        Actix::generate_actix_curd(&mut tera, x.clone(), orm_type, context.clone(), module_name);
        Hertz::generate_hertz_curd(&mut tera, x.clone(), context.clone(), module_name);
        Gozero::generate_go_zero_curd(&mut tera, x.clone(), context.clone());
        Gf::generate_gf_curd(&mut tera, x.clone(), context.clone(), module_name);
        ElementPlus::generate_vue_element_curd(&mut tera, x.clone(), context.clone());
        ElementPlusState::generate_vue_element_state_curd(&mut tera, x.clone(), context.clone());
        VueAntd::generate_vue_antd_curd(&mut tera, x.clone(), context.clone());
        ReactAntd::generate_react_antd_curd(&mut tera, x.clone(), context.clone());
        ReactAntdState::generate_react_antd_state_curd(&mut tera, x.clone(), context.clone());
        ReactAntdPro::generate_react_antd_pro(&mut tera, x, context.clone());
    }

    Ok(())
}
