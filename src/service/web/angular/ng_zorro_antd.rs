use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

pub struct NgZorroAntd {

}

impl NgZorroAntd {

    pub fn generate(mut tera: &mut Tera, table_info: TableInfo) {
        let package_name = "com.example.springboottpl";
        let author = "刘飞华";
        let fmt = "%Y/%m/%d %H:%M:%S";
        let create_time = Local::now().format(fmt).to_string();

        let mut context = Context::new();
        context.insert("table_info", &table_info);
        context.insert("author", author);
        context.insert("create_time", create_time.as_str());
        context.insert("package_name", package_name);

        Self::create_zorro_from_tpl(&mut tera, table_info.table_name.as_str(), &mut context);

    }

    fn create_zorro_from_tpl(tera: &mut Tera, table_name: &str, mut context: &mut Context) {
        let path = String::from("web/angular/ng-zorro-antd/"); //数据库密码
        write_file(tera.clone(), &mut context, format!("{}{}", path, "component.css").as_str(), format!("{}{}/component.css",path, table_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "data.d.ts").as_str(), format!("{}{}/data.d.ts",path, table_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "service.ts").as_str(), format!("{}{}/service.ts",path, table_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "component.ts").as_str(), format!("{}{}/component.ts",path, table_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "component.html").as_str(), format!("{}{}/component.html",path, table_name).as_str());
    }

}


