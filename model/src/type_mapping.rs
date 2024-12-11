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

        map.insert("char", String::from("String"));
        map.insert("varchar", String::from("String"));
        map.insert("text", String::from("String"));
        map.insert("tinyint", String::from("i8"));
        map.insert("tinyint unsigned", String::from("u8"));
        map.insert("smallint", String::from("i16"));
        map.insert("smallint unsigned", String::from("u16"));
        map.insert("int", String::from("i32"));
        map.insert("int unsigned", String::from("u32"));
        map.insert("bigint", String::from("i64"));
        map.insert("bigint unsigned", String::from("u64"));
        map.insert("datetime", String::from("DateTime"));
        map.insert("timestamp", String::from("DateTime"));
        map.insert("float", String::from("f32"));
        map.insert("double", String::from("f64"));
        map.insert("decimal", String::from("Decimal"));
        map.insert("boolean", String::from("bool"));

        match map.get(db_type) {
            Some(v) => { v.to_string() }
            None => {
                String::from("String")
            }
        }
    }

    pub fn go_type(db_type: &str) -> String {
        let mut map = HashMap::new();
        map.insert("int", String::from("int32"));
        map.insert("tinyint", String::from("int32"));
        map.insert("smallint", String::from("int32"));
        map.insert("mediumint", String::from("int64"));
        map.insert("bigint", String::from("int64"));
        map.insert("bool", String::from("bool"));
        map.insert("enum", String::from("string"));
        map.insert("set", String::from("string"));
        map.insert("varchar", String::from("string"));
        map.insert("char", String::from("string"));
        map.insert("text", String::from("string"));
        map.insert("date", String::from("time.Time"));
        map.insert("datetime", String::from("time.Time"));
        map.insert("timestamp", String::from("time.Time"));
        map.insert("time", String::from("time.Time"));
        map.insert("decimal", String::from("float64"));

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