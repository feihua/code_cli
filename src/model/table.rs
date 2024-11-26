use crate::model::column::ColumnInfo;
use serde::{Deserialize, Serialize};

// 表信息元数据
#[derive(Clone, Debug, Serialize, Deserialize)]
pub struct TableInfo {
    pub table_name: String,       //表原始名称，sys_user
    pub table_comment: String,    //表注释
    pub class_name: String,       //java类名，SysUser
    pub object_name: String,      //java类的对象名称，sysUser
    pub columns: Vec<ColumnInfo>, //列的元数据
    pub all_column_str: String,   //所有列
}
