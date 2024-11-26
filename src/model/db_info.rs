// 数据库链接信息
pub struct DbInfo {
    url: String,
    user_name: String,
    password: String,
}

impl DbInfo {
    pub fn new(url: String, user_name: String, password: String) -> DbInfo {
        DbInfo{
            url,
            user_name,
            password,
        }
    }
}
