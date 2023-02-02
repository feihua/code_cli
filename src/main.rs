pub mod model;
pub mod templates;

use crate::model::db::{get_all_columns, get_columns, get_java_columns, get_table_comment};
use tera::{Tera, Context};
use heck::ToUpperCamelCase;
use crate::templates::java::controller::controller::get_controller;
use crate::templates::java::dao::dao::get_dao;
use crate::templates::java::entity::entity::get_entity;
use crate::templates::java::mapper::mapper::get_mapper;
use crate::templates::java::service::service::get_service;
use crate::templates::java::service::service_impl::get_impl;
use crate::templates::java::vo::req::get_req;
use crate::templates::java::vo::resp::get_resp;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 模板引擎
    let mut tera = match Tera::new("templates/**/*.*") {
        Ok(t) => t,
        Err(e) => {
            println!("Parsing error(s): {}", e);
            ::std::process::exit(1);
        }
    };

    // 数据库地址
    let url = "mysql://root:r-wz9wop62956dh5k9ed@rm-wz9a2yv489d123yqkdo.mysql.rds.aliyuncs.com:3306/information_schema";
    // 待生成代码的数据库
    let db_name = "rustdb";
    // 待生成代码的表名
    let table_name = "sys_role";

    // 获取表字段
    let db_columns = get_columns(url, db_name, table_name);
    // 把表字段转换成java字段
    let java_columns = get_java_columns(db_columns.clone());

    let all_columns = get_all_columns(db_columns);
    // 获取表注释
    let table_comment = get_table_comment(url, db_name, table_name);

    let binding = ToUpperCamelCase::to_upper_camel_case(table_name);
    // 类名
    let class_name = binding.as_str();
    // 包名
    let package_name = "com.example.springboottpl";

    let mut context = Context::new();
    context.insert("table_name", table_name);
    context.insert("table_comment", table_comment.as_str());
    context.insert("package_name", package_name);
    context.insert("class_name", class_name);
    context.insert("java_columns", &java_columns);
    context.insert("all_columns", all_columns.as_str());

    // create_from_tpl(&mut tera, class_name, &mut context);

    create_from_str(tera, class_name, &mut context);

    Ok(())
}

fn create_from_str(mut tera: Tera, class_name: &str, mut context: &mut Context) {
    write_str_file(tera.clone(), &mut context, get_entity(), format!("java/entity/{}.java", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_controller(), format!("java/controller/{}Controller.java", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_dao(), format!("java/dao/{}Dao.java", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_mapper(), format!("java/mapper/{}Mapper.xml", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_service(), format!("java/service/{}Service.java", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_impl(), format!("java/service/impl/{}ServiceImpl.java", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_req(), format!("java/vo/req/{}Req.java", class_name).as_str());
    write_str_file(tera.clone(), &mut context, get_resp(), format!("java/vo/resp/{}Resp.java", class_name).as_str());
}

fn create_from_tpl(mut tera: &mut Tera, class_name: &str, mut context: &mut Context) {
    write_file(tera.clone(), &mut context, "java/entity/entity.java", format!("java/entity/{}Bean.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/controller/controller.java", format!("java/controller/{}Controller.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/dao/dao.java", format!("java/dao/{}Dao.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/mapper/mapper.xml", format!("java/mapper/{}Mapper.xml", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/service/service.java", format!("java/service/{}Service.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/service/impl/impl.java", format!("java/service/impl/{}ServiceImpl.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/vo/req.java", format!("java/vo/req/{}Req.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/vo/resp.java", format!("java/vo/resp/{}Resp.java", class_name).as_str());
}

fn write_file(tera: Tera, context: &mut Context, template_file_name: &str, target_file_name: &str) {
    let result = tera.render(template_file_name, &context);

    let cwd = std::env::current_dir().unwrap();
    let folder = cwd.as_path().join("generate-from-tpl").join(target_file_name);
    let r = result.unwrap();
    println!("{}", r);
    println!("create -------------->{:?}", folder);
    let path = folder.parent().unwrap();
    std::fs::create_dir_all(path).unwrap();
    let mut file = std::fs::File::create(folder).unwrap();
    std::io::Write::write_all(&mut file, r.as_ref()).unwrap();
}

fn write_str_file(mut tera: Tera, context: &mut Context, template_file_str: &str, target_file_name: &str) {
    let result = tera.render_str(template_file_str, &context);

    let cwd = std::env::current_dir().unwrap();
    let folder = cwd.as_path().join("generate").join(target_file_name);
    let r = result.unwrap();
    println!("create -------------->{:?}", folder);
    let path = folder.parent().unwrap();
    std::fs::create_dir_all(path).unwrap();
    let mut file = std::fs::File::create(folder).unwrap();
    std::io::Write::write_all(&mut file, r.as_ref()).unwrap();
}

