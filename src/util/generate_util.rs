use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use chrono::Local;
use tera::{Context, Tera};

// 生成文件相关操作
pub fn generate(mut tera: &mut Tera, table_info: TableInfo) {
    // 包名
    let package_name = "com.example.springboottpl";
    let author = "刘飞华";
    let fmt = "%Y/%m/%d %H:%M:%S";
    let create_time = Local::now().format(fmt).to_string();

    let mut context = Context::new();
    context.insert("table_info", &table_info);
    context.insert("author", author);
    context.insert("create_time", create_time.as_str());
    context.insert("package_name", package_name);
    // context.insert("table_name", table_info.table_name.as_str());
    // context.insert("table_comment", table_info.table_comment.as_str());
    // context.insert("package_name", package_name);
    // context.insert("class_name", table_info.class_name.as_str());
    // context.insert("java_columns", &table_info.columns);
    // context.insert("all_columns", "all_columns.as_str()");

    create_from_tpl(&mut tera, table_info.class_name.as_str(), &mut context);
    //     create_vue_from_tpl(tera.clone(), table_name, &mut context);
    //     create_react_from_tpl(tera.clone(), table_name, &mut context);
}

fn create_from_tpl(tera: &mut Tera, class_name: &str, mut context: &mut Context) {
    write_file(
        tera.clone(),
        &mut context,
        "java/entity/entity.java",
        format!("java/entity/{}Bean.java", class_name).as_str(),
    );
    write_file(
        tera.clone(),
        &mut context,
        "java/dao/dao.java",
        format!("java/dao/{}Dao.java", class_name).as_str(),
    );
    // write_file(
    //     tera.clone(),
    //     &mut context,
    //     "java/controller/controller.java",
    //     format!("java/controller/{}Controller.java", class_name).as_str(),
    // );

    // write_file(
    //     tera.clone(),
    //     &mut context,
    //     "java/mapper/mapper.xml",
    //     format!("java/mapper/{}Mapper.xml", class_name).as_str(),
    // );
    // write_file(
    //     tera.clone(),
    //     &mut context,
    //     "java/service/service.java",
    //     format!("java/service/{}Service.java", class_name).as_str(),
    // );
    // write_file(
    //     tera.clone(),
    //     &mut context,
    //     "java/service/impl/impl.java",
    //     format!("java/service/impl/{}ServiceImpl.java", class_name).as_str(),
    // );
    // write_file(
    //     tera.clone(),
    //     &mut context,
    //     "java/vo/req.java",
    //     format!("java/vo/req/{}Req.java", class_name).as_str(),
    // );
    // write_file(
    //     tera.clone(),
    //     &mut context,
    //     "java/vo/resp.java",
    //     format!("java/vo/resp/{}Resp.java", class_name).as_str(),
    // );
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
