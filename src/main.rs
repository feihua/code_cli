pub mod model;
pub mod util;

use crate::util::generate_util::generate;
use heck::ToUpperCamelCase;
use rust_embed::Embed;
use tera::Tera;

#[derive(Embed)]
#[folder = "templates/"]
struct Asset;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 待生成代码的表名
    let table_name_str = "sys_user,sys_role_user,sys_role,sys_menu_role,sys_menu";
    let t_prefix = "sys_";

    let table_names: Vec<&str> = table_name_str.split(",").collect();

    // 模板引擎
    let mut tera = Tera::default();

    tera.autoescape_on(vec![]);

    for table_name in table_names {
        generate(&mut tera, table_name, t_prefix);
    }

    Ok(())
}
