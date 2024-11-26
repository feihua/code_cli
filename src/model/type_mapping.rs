use std::collections::HashMap;

// 类型映射
pub struct TypeMapping {

}

impl TypeMapping {

    pub fn java_type(db_type: &str) -> String {
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

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }

    pub fn jdbc_type(db_type: &str) -> String {
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

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }

    pub fn rust_type(db_type: &str) -> String {
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

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }

    pub fn go_type(db_type: &str) -> String {
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

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }
    pub fn ts_type(db_type: &str) -> String {
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

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }

    pub fn proto_type(db_type: &str) -> String {
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

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }
}