use crate::model::column::ColumnInfo;
use crate::model::db_info::DbInfo;
use crate::model::table::TableInfo;
use crate::model::type_mapping::TypeMapping;
use heck::{ToLowerCamelCase, ToUpperCamelCase};
use mysql::prelude::*;
use mysql::*;
use serde::{Deserialize, Serialize};

#[derive(Clone, Debug, Serialize, Deserialize, PartialEq)]
pub struct TableEntity {
    pub table_name: String,    //表原始名称，sys_user
    pub table_comment: String, //表注释
}

// 数据库相关操作
pub struct DbUtil {}

impl DbUtil {
    // 获取所有表信息
    pub fn get_tables(db_info: DbInfo) -> Vec<TableInfo> {
        let binding = db_info.get_url().clone();
        let url = binding.as_str();

        let db_name = db_info.table_db.as_str();
        let table_name_str = db_info.table_name_str.as_str();
        let t_prefix = db_info.t_prefix.as_str();

        let req_tables: Vec<&str> = table_name_str.split(",").collect();

        let mut table_list = vec![];

        for t_name in req_tables {
            let query_sql = "select TABLE_NAME as table_name, TABLE_COMMENT as table_comment from TABLES where TABLE_SCHEMA =:db_name and TABLE_NAME like:tb_name";
            let result: Vec<TableEntity> = Pool::new(url)
                .unwrap()
                .get_conn()
                .unwrap()
                .exec_map(
                    query_sql,
                    params! {"tb_name"=>format!("{}%",t_name),"db_name"=>db_name},
                    |(table_name, table_comment): (String, String)| TableEntity {
                        table_name: table_name.to_string(),
                        table_comment: table_comment.to_string(),
                    },
                )
                .unwrap();
            for table_name in result {
                if table_list.contains(&table_name) {
                    continue;
                }
                table_list.push(table_name);
            }
        }

        // println!("table_list: {:?}", table_list);

        let mut tables = vec![];

        for x in table_list {
            let name = x.table_name.replace(t_prefix, "").clone();
            let class_name = ToUpperCamelCase::to_upper_camel_case(name.as_str());
            let object_name = ToLowerCamelCase::to_lower_camel_case(name.as_str());
            let original_class_name = ToUpperCamelCase::to_upper_camel_case(x.table_name.as_str());
            let mut info = TableInfo {
                table_name: x.table_name.clone(),
                table_comment: x.table_comment,
                class_name,
                object_name,
                original_class_name,
                columns: vec![],
                all_column_str: "".to_string(),
            };
            let res = Self::get_table_columns(url, db_name, x.table_name.as_str());
            info.columns = res;
            info.all_column_str = info.get_all_column();
            tables.push(info);

            // println!("tables: {:?}", tables);
        }

        tables
    }

    // 获取表的列信息
    pub fn get_table_columns(url: &str, db_name: &str, tb_name: &str) -> Vec<ColumnInfo> {
        let query_sql = format!("select TABLE_NAME as table_name, COLUMN_NAME as column_name, DATA_TYPE as data_type,\
    COLUMN_KEY as column_key,IS_NULLABLE as is_nullable,COLUMN_TYPE as column_type,COLUMN_COMMENT as column_comment \
    from COLUMNS where TABLE_SCHEMA = '{db_name}' and TABLE_NAME = '{tb_name}'", db_name = db_name, tb_name = tb_name);

        Pool::new(url)
            .unwrap()
            .get_conn()
            .unwrap()
            .query_map(
                query_sql,
                |(
                    table_name,
                    column_name,
                    data_type,
                    column_key,
                    is_nullable,
                    column_type,
                    column_comment,
                )| {
                    let column_name_str: String = column_name;
                    let b = &column_name_str;
                    let c = b.as_str();

                    let data_type_str: String = data_type;
                    let d = &data_type_str;
                    let f = d.as_str();
                    ColumnInfo {
                        table_name,
                        column_name: c.to_string(),
                        column_comment,
                        is_nullable,
                        data_type: f.to_string(),
                        column_type,
                        column_key,
                        java_name: ToLowerCamelCase::to_lower_camel_case(c),
                        java_type: TypeMapping::java_type(f),
                        jdbc_type: TypeMapping::jdbc_type(f),
                        rust_name: c.to_string(),
                        rust_type: TypeMapping::rust_type(f),
                        ts_name: ToLowerCamelCase::to_lower_camel_case(c),
                        ts_type: TypeMapping::ts_type(f),
                        go_name: ToUpperCamelCase::to_upper_camel_case(c),
                        go_type: TypeMapping::go_type(f),
                        proto_name: c.to_string(),
                        proto_type: TypeMapping::proto_type(f),
                    }
                },
            )
            .unwrap()
    }
}
