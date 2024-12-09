use model::table::TableInfo;
use util::file_util::write_file;
use tera::{Context, Tera};

pub struct Axum {}

impl Axum {
    pub fn generate_axum_curd(
        mut tera: &mut Tera,
        table_info: TableInfo,
        orm_type: &str,
        mut ctx: Context,
        module_name: &str,
    ) {


        if orm_type == "sea" {
            Self::create_sea_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                module_name,
            )
        } else if orm_type == "diesel" {
            Self::create_diesel_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                module_name,
            )
        } else if orm_type == "rbatis" {
            Self::create_rbatis_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                module_name,
            )
        } else {
            Self::create_sea_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                module_name,
            );
            Self::create_diesel_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                module_name,
            );
            Self::create_rbatis_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                module_name,
            )
        }
    }

    fn create_sea_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        module_name: &str,
    ) {
        let path = String::from("rust/axum/sea/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "route.tpl").as_str(),
            format!("{}/routes/{}/{}_route.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}/vo/{}/{}_vo.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}/handler/{}/{}_handler.rs", path, module_name, table_name).as_str(),
        );
    }

    fn create_diesel_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        module_name: &str,
    ) {
        let path = String::from("rust/axum/diesel/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "route.tpl").as_str(),
            format!("{}/routes/{}/{}_route.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}/vo/{}/{}_vo.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "model.tpl").as_str(),
            format!("{}/model/{}/{}_model.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}/handler/{}/{}_handler.rs", path, module_name, table_name).as_str(),
        );
    }

    fn create_rbatis_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        module_name: &str,
    ) {
        let path = String::from("rust/axum/rbatis/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "route.tpl").as_str(),
            format!("{}/routes/{}/{}_route.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}/vo/{}/{}_vo.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "model.tpl").as_str(),
            format!("{}/model/{}/{}_model.rs", path, module_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}/handler/{}/{}_handler.rs", path, module_name, table_name).as_str(),
        );
    }
}
