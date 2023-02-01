pub mod model;

use crate::model::db::{get_columns, get_java_columns, get_table_comment};
use tera::{Tera, Context};
use heck::ToUpperCamelCase;

fn main() -> Result<(), Box<dyn std::error::Error>> {
    // 模板引擎
    let tera = match Tera::new("templates/**/*.*") {
        Ok(t) => t,
        Err(e) => {
            println!("Parsing error(s): {}", e);
            ::std::process::exit(1);
        }
    };

    // 数据库地址
    let url = "mysql://root:123456@127.0.0.1:3306/information_schema";
    // 待生成代码的数据库
    let db_name = "rustdb";
    // 待生成代码的表名
    let table_name = "sys_role";

    // 获取表字段
    let db_columns = get_columns(url, db_name, table_name);
    // 把表字段转换成java字段
    let java_columns = get_java_columns(db_columns);
    // 获取表注释
    let table_comment = get_table_comment(url, db_name, table_name);

    let binding = ToUpperCamelCase::to_upper_camel_case(table_name);
    // 类名
    let class_name = binding.as_str();
    // 包名
    let package_name = "com.liu";

    let mut context = Context::new();
    context.insert("table_name", table_name);
    context.insert("table_comment", table_comment.as_str());
    context.insert("package_name", package_name);
    context.insert("class_name", class_name);
    context.insert("java_columns", &java_columns);

    // write_file(tera.clone(), &mut context, "java/index.html");
    // write_file(tera.clone(), &mut context, "go/index.html");
    // write_file(tera.clone(), &mut context, "rust/index.html");
    write_file(tera.clone(), &mut context, "java/entity/entity.java", format!("java/entity/{}Bean.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/controller/controller.java", format!("java/controller/{}Controller.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/dao/dao.java", format!("java/dao/{}Dao.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/mapper/mapper.xml", format!("java/mapper/{}Mapper.xml", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/service/service.java", format!("java/service/{}Service.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/service/impl/impl.java", format!("java/service/impl/{}ServiceImpl.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/vo/req.java", format!("java/vo/req/{}Req.java", class_name).as_str());
    write_file(tera.clone(), &mut context, "java/vo/resp.java", format!("java/vo/resp/{}Resp.java", class_name).as_str());

    Ok(())
}

fn write_file(tera: Tera, context: &mut Context, template_file_name: &str, target_file_name: &str) {
    let result = tera.render(template_file_name, &context);

    let cwd = std::env::current_dir().unwrap();
    let folder = cwd.as_path().join("generate").join(target_file_name);
    let r = result.unwrap();
    println!("{}", r);
    println!("create -------------->{:?}", folder);
    let path = folder.parent().unwrap();
    std::fs::create_dir_all(path).unwrap();
    let mut file = std::fs::File::create(folder).unwrap();
    std::io::Write::write_all(&mut file, r.as_ref()).unwrap();
}

