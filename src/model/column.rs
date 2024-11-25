use serde::{Deserialize, Serialize};

// 列信息
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct ColumnInfo {
    pub table_name: String,             //表原始名称，sys_user
    pub column_name: String,            //表字段名称，user_name
    pub column_comment: Option<String>, //字段注释
    pub is_nullable: String,            //是否可以为空
    pub data_type: String,              //数据类型
    pub column_type: String,            //字段类型
    pub column_key: String,             //字段的key
    pub java_name: String,              //java的字段名称 userName
    pub java_type: String,              //java的字段类型 String
    pub jdbc_type: String,              //jdbc的类型 VARCHAR
    pub rust_name: String,              //rust字段名称 user_name
    pub rust_type: String,              //rust字段类型 String
    pub ts_name: String,                //ts字段名称 userName
    pub ts_type: String,                //ts字段类型 String
    pub go_name: String,                //go字段名称 UserName
    pub go_type: String,                //go字段类型 string
    pub proto_name: String,             //proto字段名称 user_name
    pub proto_type: String,             //proto字段类型 string
}
