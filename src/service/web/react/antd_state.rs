use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct ReactAntdState {}

impl ReactAntdState {
    pub fn generate_react_antd_state_curd(
        mut tera: &mut Tera,
        table_info: TableInfo,
        mut ctx: Context,
    ) {
        Self::create_antd_state_tpl(&mut tera, table_info.class_name.as_str(), &mut ctx);
    }

    fn create_antd_state_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context) {
        let path = String::from("web/react/antd-state/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "data.d.tpl").as_str(),
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
            format!("{}{}", path, "SearchForm.tpl").as_str(),
            format!("{}/{}/components/SearchForm.tsx", path, class_name).as_str(),
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
            format!("{}{}", path, "DetailModal.tpl").as_str(),
            format!("{}/{}/components/DetailModal.tsx", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "store.tpl").as_str(),
            format!("{}/{}/store/{}Store.ts", path, class_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "index.tpl").as_str(),
            format!("{}{}/index.tsx", path, class_name).as_str(),
        );
    }
}
