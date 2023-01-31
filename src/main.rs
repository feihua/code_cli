pub mod model;

use crate::model::db::{get_columns, get_java_columns};


fn main() -> Result<(), Box<dyn std::error::Error>> {
    let url = "mysql://root:123456@127.0.0.1:3306/information_schema";

    let columns = get_columns(url, "rustdb", "sys_user");
    println!("columns!{:?}", columns);

    let java_columns = get_java_columns(columns);

    println!("java_columns{:?}", java_columns);

    Ok(())
}

