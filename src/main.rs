pub mod model;

use crate::model::db::{get_all_columns, get_columns, get_java_columns, get_table_comment};
use tera::{Tera, Context};
use heck::ToUpperCamelCase;
use rust_embed::Embed;


#[derive(Embed)]
#[folder = "templates/"]
struct Asset;

fn main() -> Result<(), Box<dyn std::error::Error>> {

    // 待生成代码的表名
    let table_name_str = "sys_user,sys_role_user,sys_role,sys_menu_role,sys_menu";
    let t_prefix = "sys_";

    let table_names: Vec<&str> = table_name_str.split(",").collect();

    // 模板引擎
    let mut tera =  Tera::default();

    tera.autoescape_on(vec![]);

    for table_name in table_names {
        generate(&mut tera, table_name, t_prefix);
    }

    Ok(())
}

fn generate(mut tera: &mut Tera,original_table_name: &str, t_prefix: &str) {


    // 数据库地址
    let url = "mysql://root:oMbPi5munxCsBSsiLoPV@110.41.179.89:3306/information_schema";
    // 待生成代码的数据库
    let db_name = "better-pay";

    // 获取表字段
    let db_columns = get_columns(url, db_name, original_table_name);
    if db_columns.clone().len() == 0 {
        return;
    }
    // 把表字段转换成java字段
    let java_columns = get_java_columns(db_columns.clone());

    let all_columns = get_all_columns(db_columns);
    // 获取表注释
    let table_comment = get_table_comment(url, db_name, original_table_name);

    let table_name_string = original_table_name.replace(t_prefix, "");
    let table_name = table_name_string.as_str();

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


    create_from_tpl(&mut tera, class_name, &mut context);
//     create_vue_from_tpl(tera.clone(), table_name, &mut context);
//     create_react_from_tpl(tera.clone(), table_name, &mut context);
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

fn create_vue_from_tpl(mut tera: Tera, table_name: &str, mut context: &mut Context) {
    write_file(tera.clone(), &mut context, "java/vue/index.vue", format!("java/vue/{}/index.vue", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/vue/data.d.ts", format!("java/vue/{}/data.d.ts", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/vue/service.ts", format!("java/vue/{}/service.ts", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/vue/components/AddForm.vue", format!("java/vue/{}/components/AddForm.vue", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/vue/components/ListTable.vue", format!("java/vue/{}/components/ListTable.vue", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/vue/components/UpdateForm.vue", format!("java/vue/{}/components/UpdateForm.vue", table_name).as_str());
}

fn create_react_from_tpl(mut tera: Tera, table_name: &str, mut context: &mut Context) {
    write_file(tera.clone(), &mut context, "java/react/index.tsx", format!("java/react/{}/index.tsx", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/react/data.d.ts", format!("java/react/{}/data.d.ts", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/react/service.ts", format!("java/react/{}/service.ts", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/react/components/AddForm.tsx", format!("java/react/{}/components/AddForm.tsx", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/react/components/SearchForm.tsx", format!("java/react/{}/components/SearchForm.tsx", table_name).as_str());
    write_file(tera.clone(), &mut context, "java/react/components/UpdateForm.tsx", format!("java/react/{}/components/UpdateForm.tsx", table_name).as_str());
}


fn write_file(mut tera: Tera, context: &mut Context, template_file_name: &str, target_file_name: &str) {
    let template_file = Asset::get(template_file_name).unwrap();
    let template_file_str =std::str::from_utf8(template_file.data.as_ref());

    let result = tera.render_str(template_file_str.unwrap(), &context);
    let r = result.unwrap();
    println!("{}", r);

    let cwd = std::env::current_dir().unwrap();
    let folder = cwd.as_path().join("generate").join(target_file_name);
    let path = folder.parent().unwrap();
    std::fs::create_dir_all(path).unwrap();
    println!("create -------------->{:?}", folder);

    let mut file = std::fs::File::create(folder).unwrap();
    std::io::Write::write_all(&mut file, r.as_ref()).unwrap();
}

