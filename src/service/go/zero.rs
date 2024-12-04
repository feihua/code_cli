use crate::model::table::TableInfo;
use crate::util::file_util::write_file;
use tera::{Context, Tera};

pub struct Gozero {}

impl Gozero {
    pub fn generate_go_zero_curd(mut tera: &mut Tera, table_info: TableInfo, mut ctx: Context) {
        Self::create_from_tpl(&mut tera, table_info.table_name.as_str(), &mut ctx);
    }

    //name := strings.Replace(t.GoName, "_", "", -1)
    // 			Generate(t, "template/go/zero/logic/add.tpl", path+"/api/logic/"+name, "add"+name+"logic.go")
    // 			Generate(t, "template/go/zero/logic/delete.tpl", path+"/api/logic/"+name, "delete"+name+"logic.go")
    // 			Generate(t, "template/go/zero/logic/update.tpl", path+"/api/logic/"+name, "update"+name+"logic.go")
    // 			Generate(t, "template/go/zero/logic/updatestatus.tpl", path+"/api/logic/"+name, "update"+name+"statuslogic.go")
    // 			Generate(t, "template/go/zero/logic/querydetail.tpl", path+"/api/logic/"+name, "query"+name+"detaillogic.go")
    // 			Generate(t, "template/go/zero/logic/querylist.tpl", path+"/api/logic/"+name, "query"+name+"listlogic.go")
    //
    // 			Generate(t, "template/go/zero/service/add.tpl", path+"/proto/service/"+name+"service", "add"+name+"logic.go")
    // 			Generate(t, "template/go/zero/service/delete.tpl", path+"/proto/service/"+name+"service", "delete"+name+"logic.go")
    // 			Generate(t, "template/go/zero/service/update.tpl", path+"/proto/service/"+name+"service", "update"+name+"logic.go")
    // 			Generate(t, "template/go/zero/service/updatestatus.tpl", path+"/proto/service/"+name+"service", "update"+name+"statuslogic.go")
    // 			Generate(t, "template/go/zero/service/querydetail.tpl", path+"/proto/service/"+name+"service", "query"+name+"detaillogic.go")
    // 			Generate(t, "template/go/zero/service/querylist.tpl", path+"/proto/service/"+name+"service", "query"+name+"listlogic.go")
    fn create_from_tpl(tera: &mut Tera, table_name: &str, mut context: &mut Context) {
        let path = String::from("go/zero/");

        let name = table_name.replace("_", "");
        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "api.tpl").as_str(),
            format!("{}/api/{}.api", path, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}logic/{}", path, "add.tpl").as_str(),
            format!("{}/api/logic/{}/add{}logic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}logic/{}", path, "delete.tpl").as_str(),
            format!("{}/api/logic/{}/delete{}logic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}logic/{}", path, "update.tpl").as_str(),
            format!("{}/api/logic/{}/update{}logic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}logic/{}", path, "updatestatus.tpl").as_str(),
            format!("{}/api/logic/{}/update{}statuslogic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}logic/{}", path, "querydetail.tpl").as_str(),
            format!("{}/api/logic/{}/query{}detaillogic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}logic/{}", path, "querylist.tpl").as_str(),
            format!("{}/api/logic/{}/query{}listlogic.go", path, name, name).as_str(),
        );


        write_file(
            tera.clone(),
            &mut context,
            format!("{}{}", path, "proto.tpl").as_str(),
            format!("{}/proto/{}.proto", path, table_name).as_str(),
        );

        write_file(
            tera.clone(),
            &mut context,
            format!("{}service/{}", path, "add.tpl").as_str(),
            format!("{}/proto/service/{}/add{}logic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}service/{}", path, "delete.tpl").as_str(),
            format!("{}/proto/service/{}/delete{}logic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}service/{}", path, "update.tpl").as_str(),
            format!("{}/proto/service/{}/update{}logic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}service/{}", path, "updatestatus.tpl").as_str(),
            format!("{}/proto/service/{}/update{}statuslogic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}service/{}", path, "querydetail.tpl").as_str(),
            format!("{}/proto/service/{}/query{}detaillogic.go", path, name, name).as_str(),
        );
        write_file(
            tera.clone(),
            &mut context,
            format!("{}service/{}", path, "querylist.tpl").as_str(),
            format!("{}/proto/service/{}/query{}listlogic.go", path, name, name).as_str(),
        );

    }
}
