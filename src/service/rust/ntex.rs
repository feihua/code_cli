use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct Ntex {}

impl Ntex {
    pub fn generate_ntex_curd(
        mut tera: &mut Tera,
        table_info: TableInfo,
        orm_type: &str,
        mut ctx: Context,
    ) {
        let package_name = "sys";

        if orm_type == "sea" {
            Self::create_sea_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                package_name,
            )
        } else if orm_type == "diesel" {
            Self::create_diesel_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                package_name,
            )
        } else if orm_type == "rbatis" {
            Self::create_rbatis_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                package_name,
            )
        } else {
            Self::create_sea_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                package_name,
            );
            Self::create_diesel_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                package_name,
            );
            Self::create_rbatis_from_tpl(
                &mut tera,
                table_info.table_name.as_str(),
                &mut ctx,
                package_name,
            )
        }
    }

    fn create_sea_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("rust/ntex/sea/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}{}/vo/{}_vo.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }

    fn create_diesel_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("rust/ntex/diesel/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}{}/vo/{}_vo.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }

    fn create_rbatis_from_tpl(
        tera: &mut Tera,
        table_name: &str,
        mut context: &mut Context,
        package_name: &str,
    ) {
        let path = String::from("rust/ntex/rbatis/");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "vo.tpl").as_str(),
            format!("{}{}/vo/{}_vo.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "model.tpl").as_str(),
            format!("{}{}/model/{}_model.rs", path, package_name, table_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "handler.tpl").as_str(),
            format!("{}{}/handler/{}_handler.rs", path, package_name, table_name).as_str(),
        );
    }
}
