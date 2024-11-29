use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

pub struct Gozero {

}

impl Gozero {

    pub fn generate(mut tera: &mut Tera, table_info: TableInfo) {
        let package_name = "test";
        let author = "刘飞华";
        let fmt = "%Y/%m/%d %H:%M:%S";
        let create_time = Local::now().format(fmt).to_string();

        let mut context = Context::new();
        context.insert("table_info", &table_info);
        context.insert("author", author);
        context.insert("create_time", create_time.as_str());
        context.insert("package_name", package_name);

        Self::create_from_tpl(&mut tera, table_info.table_name.as_str(), &mut context, package_name);

    }

    fn create_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("go/zero/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "proto.tpl").as_str(),
            format!("{}{}/proto/{}.proto", path, package_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "api.tpl").as_str(),
            format!("{}{}/api/{}.api", path, package_name, table_name).as_str(),
        );
    }

}


