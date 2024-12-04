use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

pub struct ElementPlus {

}

impl ElementPlus {

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

        Self::create_element_plus_tpl(&mut tera, table_info.class_name.as_str(), &mut context);

    }

    fn create_element_plus_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context) {
        let path = String::from("web/vue/element-plus/");
        write_file(tera.clone(), &mut context, format!("{}{}", path, "data.tpl").as_str(), format!("{}{}/data.d.ts",path, class_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "service.tpl").as_str(), format!("{}{}/service.ts",path, class_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "AddForm.tpl").as_str(), format!("{}/{}/components/AddModal.vue",path, class_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "UpdateForm.tpl").as_str(), format!("{}/{}/components/UpdateModal.vue",path, class_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "DetailModal.tpl").as_str(), format!("{}/{}/components/DetailModal.vue",path, class_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "ListTable.tpl").as_str(), format!("{}/{}/components/ListTable.vue",path, class_name).as_str());
        write_file(tera.clone(), &mut context, format!("{}{}", path, "index.tpl").as_str(), format!("{}{}/index.vue",path, class_name).as_str());
    }

}


