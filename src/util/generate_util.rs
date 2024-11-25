use heck::ToUpperCamelCase;
use tera::{Context, Tera};
use crate::util::file_util::write_file;
use crate::model::db::{get_all_columns, get_columns, get_java_columns, get_table_comment};

// 生成文件相关操作
pub fn generate(mut tera: &mut Tera, original_table_name: &str, t_prefix: &str) {


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

// fn create_vue_from_tpl(mut tera: Tera, table_name: &str, mut context: &mut Context) {
//     write_file(tera.clone(), &mut context, "java/vue/index.vue", format!("java/vue/{}/index.vue", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/vue/data.d.ts", format!("java/vue/{}/data.d.ts", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/vue/service.ts", format!("java/vue/{}/service.ts", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/vue/components/AddForm.vue", format!("java/vue/{}/components/AddForm.vue", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/vue/components/ListTable.vue", format!("java/vue/{}/components/ListTable.vue", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/vue/components/UpdateForm.vue", format!("java/vue/{}/components/UpdateForm.vue", table_name).as_str());
// }
//
// fn create_react_from_tpl(mut tera: Tera, table_name: &str, mut context: &mut Context) {
//     write_file(tera.clone(), &mut context, "java/react/index.tsx", format!("java/react/{}/index.tsx", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/react/data.d.ts", format!("java/react/{}/data.d.ts", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/react/service.ts", format!("java/react/{}/service.ts", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/react/components/AddForm.tsx", format!("java/react/{}/components/AddForm.tsx", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/react/components/SearchForm.tsx", format!("java/react/{}/components/SearchForm.tsx", table_name).as_str());
//     write_file(tera.clone(), &mut context, "java/react/components/UpdateForm.tsx", format!("java/react/{}/components/UpdateForm.tsx", table_name).as_str());
// }


