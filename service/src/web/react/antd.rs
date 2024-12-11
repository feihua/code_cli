use model::table::TableInfo;
use util::file_util::write_file;
use tera::{Context, Tera};

pub struct ReactAntd {}

impl ReactAntd {
    pub fn generate_react_antd_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {
        Self::create_antd_tpl(&mut tera, table_info.class_name.as_str(), &mut ctx);
    }

    fn create_antd_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context) {
        let path = String::from("web/react/antd/");
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
            format!("{}{}", path, "Search.tpl").as_str(),
            format!("{}/{}/components/SearchForm.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "Add.tpl").as_str(),
            format!("{}/{}/components/AddModal.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "Update.tpl").as_str(),
            format!("{}/{}/components/UpdateModal.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "Detail.tpl").as_str(),
            format!("{}/{}/components/DetailModal.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "index.tpl").as_str(),
            format!("{}{}/index.tsx", path, class_name).as_str(),
        );
    }
}
