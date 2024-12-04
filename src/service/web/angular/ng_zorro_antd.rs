use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct NgZorroAntd {}

impl NgZorroAntd {
    pub fn generate_ng_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {
        Self::create_zorro_from_tpl(&mut tera, table_info.table_name.as_str(), &mut ctx);
    }

    fn create_zorro_from_tpl(tera: &mut Tera, table_name: &str, mut context: &mut Context) {
        let path = String::from("web/angular/ng-zorro-antd/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "component.css").as_str(),
            format!("{}{}/component.css", path, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "data.tpl").as_str(),
            format!("{}{}/data.d.ts", path, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "service.tpl").as_str(),
            format!("{}{}/service.ts", path, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "component.tpl").as_str(),
            format!("{}{}/component.ts", path, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "component.html").as_str(),
            format!("{}{}/component.html", path, table_name).as_str(),
        );
    }
}
