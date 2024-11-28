pub mod model;
pub mod util;
mod service;

use crate::model::db_info::DbInfo;
use crate::util::db_util::DbUtil;
use crate::util::generate_util::{generate, generate_common};
use rust_embed::Embed;
use tera::Tera;
use crate::service::rust::actix::Actix;
use crate::service::rust::axum::Axum;
use crate::service::rust::ntex::Ntex;
use crate::service::rust::rocket::Rocket;
use crate::service::rust::salvo::Salvo;
use crate::service::web::angular::ng_zorro_antd::NgZorroAntd;

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

    generate_common(&mut tera);

    let table_info_list = DbUtil::get_tables(info);
    for x in table_info_list {
        //generate(&mut tera, x);
        // NgZorroAntd::generate(&mut tera, x)
        // Salvo::generate(&mut tera, x);
        // Rocket::generate(&mut tera, x);
        // Ntex::generate(&mut tera, x);
        // Axum::generate(&mut tera, x);
        Actix::generate(&mut tera, x);
    }

    Ok(())
}
