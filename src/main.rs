pub mod model;
mod service;
pub mod util;

use crate::model::db_info::DbInfo;
use crate::service::go::hertz::Hertz;
use crate::service::go::zero::Gozero;
use crate::service::rust::actix::Actix;
use crate::service::rust::axum::Axum;
use crate::service::rust::ntex::Ntex;
use crate::service::rust::rocket::Rocket;
use crate::service::rust::salvo::Salvo;
use crate::service::web::angular::ng_zorro_antd::NgZorroAntd;
use crate::util::db_util::DbUtil;
use rust_embed::Embed;
use tera::Tera;
use crate::service::java::mybatis::Mybatis;
use crate::service::web::react::antd::ReactAntd;
use crate::service::web::react::antd_state::ReactAntdState;
use crate::service::web::react::pro::ReactAntdPro;
use crate::service::web::vue::antd::VueAntd;
use crate::service::web::vue::element_plus::ElementPlus;
use crate::service::web::vue::element_plus_state::ElementPlusState;

#[derive(Embed)]
#[folder = "templates/"]
struct Asset;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 模板引擎
    let mut tera = Tera::default();
    tera.autoescape_on(vec![]);

    let mut info = DbInfo::default();
    info.host = String::from("110.41.179.89"); //数据库ip
    info.port = 3306; //数据库端口
    info.user_name = String::from("root"); //数据库账号
    info.password = String::from("123456"); //数据库密码
    info.table_db = String::from("better-pay"); //业务数据库
    info.table_name_str = String::from("sys_user,sys_role_menu"); //待生成的表
    info.t_prefix = String::from("sys_"); //生成时，待去掉的表前缀


    let table_info_list = DbUtil::get_tables(info);
    let orm_type = "";
    for x in table_info_list {
        Mybatis::generate_mybatis_curd(&mut tera, x.clone());
        NgZorroAntd::generate_ng_curd(&mut tera, x.clone());
        Salvo::generate_salvo_curd(&mut tera, x.clone(), orm_type);
        Rocket::generate_rocket_curd(&mut tera, x.clone(), orm_type);
        Ntex::generate_ntex_curd(&mut tera, x.clone(), orm_type);
        Axum::generate_axum_curd(&mut tera, x.clone(), orm_type);
        Actix::generate_actix_curd(&mut tera, x.clone(), orm_type);
        Hertz::generate_hertz_curd(&mut tera, x.clone());
        Gozero::generate_go_zero_curd(&mut tera, x.clone());
        ElementPlus::generate_vue_element_curd(&mut tera, x.clone());
        ElementPlusState::generate_vue_element_state_curd(&mut tera, x.clone());
        VueAntd::generate_vue_antd_curd(&mut tera, x.clone());
        ReactAntd::generate_react_antd_curd(&mut tera, x.clone());
        ReactAntdState::generate_react_antd_state_curd(&mut tera, x.clone());
        ReactAntdPro::generate_react_antd_pro(&mut tera, x);
    }

    Ok(())
}
