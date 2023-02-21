use std::collections::HashMap;
use serde::{Deserialize, Serialize};
use mysql::*;
use mysql::prelude::*;
use heck::ToLowerCamelCase;

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct Columns {
    pub table_name: String,
    pub column_name: String,
    pub is_nullable: String,
    pub data_type: String,
    pub column_type: String,
    pub column_key: String,
    pub column_comment: Option<String>,
}

#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct JavaColumns {
    pub db_name: String,
    pub java_name: String,
    pub db_type: String,
    pub java_type: String,
    pub jdbc_type: String,
    pub ts_type: String,
    pub column_comment: String,
}

pub fn get_columns(url: &str, db_name: &str, tb_name: &str) -> Vec<Columns> {
    let raw_sql = format!("select TABLE_NAME as table_name, COLUMN_NAME as column_name, DATA_TYPE as data_type,\
    COLUMN_KEY as column_key,IS_NULLABLE as is_nullable,COLUMN_TYPE as column_type,COLUMN_COMMENT as column_comment \
    from COLUMNS where TABLE_SCHEMA = '{db_name}' and TABLE_NAME = '{tb_name}'", db_name = db_name, tb_name = tb_name);

    Pool::new(url).unwrap().get_conn().unwrap().query_map(
        raw_sql,
        |(table_name, column_name, data_type, column_key, is_nullable, column_type, column_comment)| {
            Columns { table_name, column_name, data_type, column_key, is_nullable, column_type, column_comment }
        },
    ).unwrap()
}

pub fn get_table_comment(url: &str, db_name: &str, tb_name: &str) -> String {
    Pool::new(url).unwrap().get_conn().unwrap().exec_first("select TABLE_COMMENT as table_comment \
    from TABLES where TABLE_SCHEMA =:db_name and TABLE_NAME =:tb_name", params! {"tb_name"=>tb_name,"db_name"=>db_name}).unwrap().unwrap()
}

fn get_java_type(db_type: &str) -> String {
    let mut map = HashMap::new();

    map.insert("int", String::from("int"));
    map.insert("tinyint", String::from("short"));
    map.insert("smallint", String::from("short"));
    map.insert("mediumint", String::from("int"));
    map.insert("bigint", String::from("long"));
    map.insert("bool", String::from("bool"));
    map.insert("enum", String::from("String"));
    map.insert("set", String::from("String"));
    map.insert("varchar", String::from("String"));
    map.insert("char", String::from("String"));
    map.insert("datetime", String::from("Date"));

    return match map.get(db_type) {
        Some(v) => { v.to_string() }
        None => {
            String::from("String")
        }
    };
}

fn get_jdbc_type(db_type: &str) -> String {
    let mut map = HashMap::new();

    map.insert("int", String::from("INTEGER"));
    map.insert("tinyint", String::from("TINYINT"));
    map.insert("smallint", String::from("SMALLINT"));
    map.insert("integer", String::from("INTEGER"));
    map.insert("double", String::from("DOUBLE"));
    map.insert("decimal", String::from("DECIMAL"));
    map.insert("bigint", String::from("BIGINT"));
    map.insert("varchar", String::from("VARCHAR"));
    map.insert("char", String::from("CHAR"));
    map.insert("date", String::from("DATE"));
    map.insert("datetime", String::from("TIMESTAMP"));
    map.insert("timestamp", String::from("TIMESTAMP"));
    map.insert("time", String::from("TIME"));

    return match map.get(db_type) {
        Some(v) => { v.to_string() }
        None => {
            String::from("String")
        }
    };
}

fn get_ts_type(db_type: &str) -> String {
    let mut map = HashMap::new();

    map.insert("int", String::from("number"));
    map.insert("tinyint", String::from("number"));
    map.insert("smallint", String::from("number"));
    map.insert("integer", String::from("number"));
    map.insert("double", String::from("number"));
    map.insert("boolean", String::from("boolean"));
    map.insert("decimal", String::from("number"));
    map.insert("bigint", String::from("number"));
    map.insert("varchar", String::from("string"));
    map.insert("char", String::from("string"));
    map.insert("date", String::from("string"));
    map.insert("datetime", String::from("string"));
    map.insert("timestamp", String::from("string"));
    map.insert("time", String::from("string"));

    return match map.get(db_type) {
        Some(v) => { v.to_string() }
        None => {
            String::from("String")
        }
    };
}

// 把表字段转换成java字段
pub fn get_java_columns(columns: Vec<Columns>) -> Vec<JavaColumns> {
    let mut java_columns = Vec::new();

    for x in columns {
        java_columns.push(JavaColumns {
            db_name: x.column_name.clone(),
            java_name: ToLowerCamelCase::to_lower_camel_case(x.column_name.as_str()),
            db_type: x.data_type.clone(),
            java_type: get_java_type(x.data_type.as_str()).to_string(),
            jdbc_type: get_jdbc_type(x.data_type.as_str()).to_string(),
            ts_type: get_ts_type(x.data_type.as_str()).to_string(),
            column_comment: x.column_comment.unwrap_or_default(),
        })
    }
    java_columns
}

// 把表字段拼接在一起
pub fn get_all_columns(columns: Vec<Columns>) -> String {
    let mut all_columns = String::from("");

    for x in columns {
        all_columns.push_str(x.column_name.as_str());
        all_columns.push_str(", ");
    }

    let size = all_columns.len() - 2;
    let new_all_columns = &all_columns[0..size];
    new_all_columns.to_string()
}