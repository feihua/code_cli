pub mod model;
pub mod util;

use crate::util::generate_util::generate;
use crate::util::db_util::DbUtil;
use heck::ToUpperCamelCase;
use rust_embed::Embed;
use tera::Tera;

#[derive(Embed)]
#[folder = "templates/"]
struct Asset;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 待生成代码的表名
    // let table_name_str = "sys_user,sys_role_user,sys_role,sys_menu_role,sys_menu";
    // let t_prefix = "sys_";
    //
    // let table_names: Vec<&str> = table_name_str.split(",").collect();
    //
    // // 模板引擎
    // let mut tera = Tera::default();
    //
    // tera.autoescape_on(vec![]);
    //
    // for table_name in table_names {
    //     generate(&mut tera, table_name, t_prefix);
    // }

    // 数据库地址
    let url = "mysql://root:oMbPi5munxCsBSsiLoPV@110.41.179.89:3306/information_schema";
    // 待生成代码的数据库
    let db_name = "better-pay";
    let table_name_str = "sys_user,sys_role_menu";
    DbUtil::get_tables(url, db_name, table_name_str, "sys_");
    Ok(())
}
