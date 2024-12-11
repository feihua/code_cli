use model::table::TableInfo;
use util::file_util::write_file;
use tera::{Context, Tera};

pub struct VueAntd {}

impl VueAntd {
    pub fn generate_vue_antd_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {
        Self::create_vue_antd_tpl(&mut tera, table_info.class_name.as_str(), &mut ctx);
    }

    fn create_vue_antd_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context) {
        let path = String::from("web/vue/antd/");
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
            format!("{}{}", path, "SearchForm.tpl").as_str(),
            format!("{}/{}/components/SearchForm.vue", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "AddModal.tpl").as_str(),
            format!("{}/{}/components/AddModal.vue", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "UpdateModal.tpl").as_str(),
            format!("{}/{}/components/UpdateModal.vue", path, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "DetailModal.tpl").as_str(),
            format!("{}/{}/components/DetailModal.vue", path, class_name).as_str(),
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
            format!("{}{}/index.vue", path, class_name).as_str(),
        );
    }
}
