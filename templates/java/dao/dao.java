package {{package_name}}.dao;

import java.util.List;

import {{package_name}}.bean.{{class_name}};

public interface {{class_name}}Dao {

   {{class_name}} query({{class_name}} record);

   List<{{class_name}}> querySysRoleList({{class_name}} record);

   int insert({{class_name}} record);

   int delete(int id);

   int update({{class_name}} record);

}