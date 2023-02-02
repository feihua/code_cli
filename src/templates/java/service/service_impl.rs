pub fn get_impl() -> &'static str {
    "package {{package_name}}.service.impl;

import java.util.List;

import {{package_name}}.bean.{{class_name}};
import {{package_name}}.dao.{{class_name}}Dao;

@Service
public class {{class_name}}ServiceImpl implements {{class_name}}Service {

   @Autowired
   private {{class_name}}Dao recordDao

   @Override
   public {{class_name}} query({{class_name}} record){
       return recordDao.query(record);
   }

   @Override
   public List<{{class_name}}> query{{class_name}}List({{class_name}} record){
        return recordDao.query(record);
   }

   @Override
   public int insert({{class_name}} record){
        return recordDao.insert(record);
   }

   @Override
   public int delete(int id){
        return recordDao.delete(id);
   }

   @Override
   public int update({{class_name}} record){
        return recordDao.update(record);
   }

}"
}