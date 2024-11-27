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

impl TableInfo {
    // 把表字段拼接在一起
    pub fn get_all_column(&self) -> String {
        let mut all_columns = String::from("");

        for x in self.columns.iter() {
            all_columns.push_str(x.column_name.as_str());
            all_columns.push_str(", ");
        }

        let size = all_columns.len() - 2;
        let new_all_columns = &all_columns[0..size];
        new_all_columns.to_string()
    }
}
