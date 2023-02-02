package {{package_name}}.service;

import java.util.List;

import {{package_name}}.bean.{{class_name}};

public interface {{class_name}}Service {

   {{class_name}} query({{class_name}} record);

   List<{{class_name}}> query{{class_name}}List({{class_name}} record);

   int insert({{class_name}} record);

   int delete(int id);

   int update({{class_name}} record);

}