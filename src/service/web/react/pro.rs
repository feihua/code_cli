use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct ReactAntdPro {}

impl ReactAntdPro {
    pub fn generate_react_antd_pro(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {
        Self::create_antd_pro_tpl(&mut tera, table_info.class_name.as_str(), &mut ctx);
    }

    fn create_antd_pro_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context) {
        let path = String::from("web/react/pro/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "data.tpl").as_str(),
            format!("{}{}/data.d.ts", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "service.tpl").as_str(),
            format!("{}{}/service.ts", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "AddModal.tpl").as_str(),
            format!("{}/{}/components/AddModal.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "UpdateModal.tpl").as_str(),
            format!("{}/{}/components/UpdateModal.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "index.tpl").as_str(),
            format!("{}{}/index.tsx", path, class_name).as_str(),
        );
    }
}
