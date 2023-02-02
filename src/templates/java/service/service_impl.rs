pub fn get_impl() -> &'static str {
    "package {{package_name}}.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{package_name}}.entity.{{class_name}};
import {{package_name}}.vo.req.{{class_name}}Req;
import {{package_name}}.vo.resp.{{class_name}}Resp;
import {{package_name}}.dao.{{class_name}}Dao;
import {{package_name}}.service.{{class_name}}Service;

@Service
public class {{class_name}}ServiceImpl implements {{class_name}}Service {

   @Autowired
   private {{class_name}}Dao recordDao;

   @Override
   public {{class_name}}Resp query({{class_name}}Req record){
       return recordDao.query(record);
   }

   @Override
   public List<{{class_name}}Resp> query{{class_name}}List({{class_name}}Req record){
        return recordDao.query{{class_name}}List(record);
   }

   @Override
   public int insert({{class_name}}Req record){
        return recordDao.insert(record);
   }

   @Override
   public int delete(int id){
        return recordDao.delete(id);
   }

   @Override
   public int update({{class_name}}Req record){
        return recordDao.update(record);
   }

}"
}