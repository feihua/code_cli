pub mod model;
pub mod util;

use crate::model::db_info::DbInfo;
use crate::util::db_util::DbUtil;
use crate::util::generate_util::generate;
use rust_embed::Embed;
use tera::Tera;

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
    for x in table_info_list {
        generate(&mut tera, x);
    }

    Ok(())
}
