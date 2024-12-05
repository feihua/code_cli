use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct Hertz {}

impl Hertz {
    pub fn generate_hertz_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context, module_name: &str,) {
        Self::create_from_tpl(&mut tera, table_info.table_name.as_str(), &mut ctx, module_name);
    }

    fn create_from_tpl(tera: &mut Tera, table_name: &str, mut context: &mut Context, module_name: &str,) {
        let path = String::from("go/hertz/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "proto.tpl").as_str(),
            format!("{}/proto/{}/{}_vo.proto", path, module_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}/handler/{}/{}_handler.rs", path, module_name, table_name).as_str(),
        );
    }
}
