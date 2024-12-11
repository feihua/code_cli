use util::file_util::write_file;
use tera::{Context, Tera};
use model::table::TableInfo;

pub struct Mybatis {}

impl Mybatis {
    // 生成文件相关操作
    pub fn generate_mybatis_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context, module_name: &str,) {
        Self::create_from_tpl(&mut tera, table_info.class_name.as_str(), &mut ctx, module_name);
    }

    fn create_from_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context, module_name: &str,) {
        write_file(
            tera.clone(),
            &mut context,
            "java/util/Result.java",
            "java/util/Result.java",
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/util/ResultPage.java",
            "java/util/ResultPage.java",
        );

        write_file(
            tera.clone(),
            &mut context,
            "java/entity/entity.java",
            format!("java/entity/{}/{}.java", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/dao/dao.java",
            format!("java/dao/{}/{}Dao.java", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/service/service.java",
            format!("java/service/{}/{}Service.java", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/service/impl/impl.java",
            format!("java/service/{}/impl/{}ServiceImpl.java", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/controller/controller.java",
            format!("java/controller/{}/{}Controller.java", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/mapper/mapper.xml",
            format!("java/mapper/{}/{}Mapper.xml", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/vo/req.java",
            format!("java/vo/req/{}/{}Req.java", module_name, class_name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            "java/vo/resp.java",
            format!("java/vo/resp/{}/{}Resp.java", module_name, class_name).as_str(),
        );
    }
}
