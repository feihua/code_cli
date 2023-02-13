pub fn get_impl() -> &'static str {
    "package {{package_name}}.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{package_name}}.entity.{{class_name}};
import {{package_name}}.vo.req.{{class_name}}Req;
import {{package_name}}.vo.resp.{{class_name}}Resp;
import {{package_name}}.dao.{{class_name}}Dao;
import {{package_name}}.service.{{class_name}}Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

@Service
public class {{class_name}}ServiceImpl implements {{class_name}}Service {

   @Autowired
   private {{class_name}}Dao recordDao;

   @Override
   public {{class_name}}Resp query({{class_name}}Req record){

       {{class_name}} query = recordDao.query({{class_name}}.builder().build());

       return {{class_name}}Resp.builder().build();
   }

   @Override
   public List<{{class_name}}Resp> query{{class_name}}List({{class_name}}Req record){
       PageHelper.startPage(1, 10);
	   List<{{class_name}}> query = recordDao.query{{class_name}}List({{class_name}}.builder().build());
       PageInfo<{{class_name}}> pageInfo = new PageInfo<>(query);

	   return pageInfo.getList().stream().map(x -> {
		   {{class_name}}Resp resp = new {{class_name}}Resp();
		   BeanUtils.copyProperties(x, resp);
		   return resp;
	   }).collect(Collectors.toList());
   }

   @Override
   public int insert({{class_name}}Req record){

        return recordDao.insert({{class_name}}.builder().build());
   }

   @Override
   public int delete(int id){
        return recordDao.delete(id);
   }

   @Override
   public int update({{class_name}}Req record){

        return recordDao.update({{class_name}}.builder().build());
   }

}"
}