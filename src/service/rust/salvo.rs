use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

pub struct Salvo {}

impl Salvo {
    pub fn generate(mut tera: &mut Tera, table_info: TableInfo) {
        let package_name = "sys";
        let author = "刘飞华";
        let fmt = "%Y/%m/%d %H:%M:%S";
        let create_time = Local::now().format(fmt).to_string();

        let mut context = Context::new();
        context.insert("table_info", &table_info);
        context.insert("author", author);
        context.insert("create_time", create_time.as_str());
        context.insert("package_name", package_name);

        // Self::create_sea_from_tpl(
        //     &mut tera,
        //     table_info.table_name.as_str(),
        //     &mut context,
        //     package_name,
        // );

        // Self::create_rbatis_from_tpl(
        //     &mut tera,
        //     table_info.table_name.as_str(),
        //     &mut context,
        //     package_name,
        // );

        Self::create_rbatis_from_tpl(
            &mut tera,
            table_info.table_name.as_str(),
            &mut context,
            package_name,
        );
    }

    fn create_sea_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("rust/salvo/sea/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}{}/vo/{}_vo.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }

    fn create_diesel_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("rust/salvo/diesel/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}{}/vo/{}_vo.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }

    fn create_rbatis_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("rust/salvo/rbatis/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}{}/vo/{}_vo.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "model.tpl").as_str(),
            format!("{}{}/model/{}_model.rs", path, package_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }
}
