use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

pub struct Angular{

}

impl Angular {

    pub fn generate(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {


        // Self::create_zorro_from_tpl(&mut tera, table_info.object_name.as_str(), &mut ctx);

    }

    // fn create_zorro_from_tpl(tera: &mut Tera, object_name: &str, mut context: &mut Context) {
    //     let path = String::from("web/angular/ng-zorro-antd/");
    //     write_file(tera.clone(), &mut context, format!("{}{}", path, "component.css").as_str(), format!("{}{}/component.css",path, object_name).as_str());
    //     write_file(tera.clone(), &mut context, format!("{}{}", path, "data.d.ts").as_str(), format!("{}{}/data.d.ts",path, object_name).as_str());
    //     write_file(tera.clone(), &mut context, format!("{}{}", path, "service.ts").as_str(), format!("{}{}/service.ts",path, object_name).as_str());
    //     write_file(tera.clone(), &mut context, format!("{}{}", path, "component.ts").as_str(), format!("{}{}/component.ts",path, object_name).as_str());
    //     write_file(tera.clone(), &mut context, format!("{}{}", path, "component.html").as_str(), format!("{}{}/component.html",path, object_name).as_str());
    // }

}


