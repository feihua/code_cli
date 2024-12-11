// 数据库链接信息
pub struct DbInfo {
    pub host: String,           //ip
    pub port: i32,              //端口
    pub user_name: String,      //账号
    pub password: String,       //密码
    pub information_db: String, //元数据库
    pub table_db: String,       //业务数据库
    pub table_name_str: String, //待生成的表
    pub t_prefix: String,       //生成时，待去掉的表前缀
}

impl DbInfo {
    pub fn default() -> DbInfo {
        DbInfo {
            host: "127.0.0.1".to_string(),
            port: 3306,
            user_name: "root".to_string(),
            password: "123456".to_string(),
            information_db: "information_schema".to_string(),
            table_db: "".to_string(),
            table_name_str: "".to_string(),
            t_prefix: "".to_string(),
        }
    }

    pub fn get_url(&self) -> String {
        //let url = "mysql://root:123456@127.0.0.1:3306/information_schema";
        format!(
            "mysql://{}:{}@{}:{}/{}",
            self.user_name, self.password, self.host, self.port, self.information_db
        )
    }
}
