use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

pub struct Hertz {

}

impl Hertz {

    pub fn generate(mut tera: &mut Tera, table_info: TableInfo) {
        let project_name = "github.com/feihua/hertz-admin";
        let package_name = "test";
        let author = "刘飞华";
        let fmt = "%Y/%m/%d %H:%M:%S";
        let create_time = Local::now().format(fmt).to_string();

        let mut context = Context::new();
        context.insert("table_info", &table_info);
        context.insert("author", author);
        context.insert("create_time", create_time.as_str());
        context.insert("package_name", package_name);
        context.insert("project_name", project_name);

        Self::create_from_tpl(&mut tera, table_info.table_name.as_str(), &mut context, package_name);

    }

    fn create_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("go/hertz/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "proto.tpl").as_str(),
            format!("{}{}/proto/{}_vo.proto", path, package_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }
}


