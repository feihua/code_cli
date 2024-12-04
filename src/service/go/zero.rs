use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct Gozero {}

impl Gozero {
    pub fn generate_go_zero_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {
        Self::create_from_tpl(&mut tera, table_info.table_name.as_str(), &mut ctx);
    }

    fn create_from_tpl(tera: &mut Tera, table_name: &str, mut context: &mut Context) {
        let path = String::from("go/zero/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "proto.tpl").as_str(),
            format!("{}/proto/{}.proto", path, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "api.tpl").as_str(),
            format!("{}/api/{}.api", path, table_name).as_str(),
        );
    }
}
