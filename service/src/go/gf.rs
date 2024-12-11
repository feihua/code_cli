use tera::{Context, Tera};
use model::table::TableInfo;
use util::file_util::write_file;

pub struct Gf {}

impl Gf {
    pub fn generate_gf_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context, module_name: &str,) {
        Self::create_gf_from_tpl(&mut tera, table_info.table_name.as_str(), &mut ctx, module_name);
    }

    fn create_gf_from_tpl(tera: &mut Tera, table_name: &str, mut context: &mut Context, module_name: &str,) {
        let path = String::from("go/gf/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "api.tpl").as_str(),
            format!("{}/api/{}/{}.go", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "logic.tpl").as_str(),
            format!("{}/logic/{}/{}.go", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "model.tpl").as_str(),
            format!("{}/model/{}/{}.go", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "ctrl_add.tpl").as_str(),
            format!("{}/controller/{}/{}/add_{}.go", path, module_name, table_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "ctrl_delete.tpl").as_str(),
            format!("{}/controller/{}/{}/delete_{}.go", path, module_name, table_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "ctrl_update.tpl").as_str(),
            format!("{}/controller/{}/{}/update_{}.go", path, module_name, table_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "ctrl_update_status.tpl").as_str(),
            format!("{}/controller/{}/{}/update_{}_status.go", path, module_name, table_name, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "ctrl_detail.tpl").as_str(),
            format!("{}/controller/{}/{}/query_{}_detail.go", path, module_name, table_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "ctrl_list.tpl").as_str(),
            format!("{}/controller/{}/{}/query_{}_list.go", path, module_name, table_name, table_name).as_str(),
        );

    }
}
