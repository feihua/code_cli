use mysql::Column;
use serde::{Deserialize, Serialize};

// 列信息
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ColumnInfo {
    pub table_name: String,     //表原始名称，sys_user
    pub column_name: String,    //表字段名称，user_name
    pub column_comment: String, //字段注释
    pub is_nullable: String,    //是否可以为空
    pub data_type: String,      //数据类型
    pub column_type: String,    //字段类型
    pub column_key: String,     //字段的key
    pub java_name: String,      //java的字段名称 userName
    pub java_type: String,      //java的字段类型 String
    pub jdbc_type: String,      //jdbc的类型 VARCHAR
    pub rust_name: String,      //rust字段名称 user_name
    pub rust_type: String,      //rust字段类型 String
    pub ts_name: String,        //ts字段名称 userName
    pub ts_type: String,        //ts字段类型 String
    pub go_name: String,        //go字段名称 UserName
    pub go_type: String,        //go字段类型 string
    pub proto_name: String,     //proto字段名称 user_name
    pub proto_type: String,     //proto字段类型 string
}

impl ColumnInfo {
    pub fn new(
        table_name: String,
        column_name: String,
        data_type: String,
        column_key: String,
        is_nullable: String,
        column_type: String,
        column_comment: String,
    ) -> ColumnInfo {
        ColumnInfo {
            table_name,
            column_name,
            data_type,
            column_key,
            java_name: "".to_string(),
            java_type: "".to_string(),
            jdbc_type: "".to_string(),
            rust_name: "".to_string(),
            rust_type: "".to_string(),
            ts_name: "".to_string(),
            ts_type: "".to_string(),
            go_name: "".to_string(),
            go_type: "".to_string(),
            proto_name: "".to_string(),
            is_nullable,
            column_type,
            column_comment,
            proto_type: "".to_string(),
        }
    }
}
