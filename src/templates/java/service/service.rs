pub fn get_service() -> &'static str {
    "package {{package_name}}.service;

import java.util.List;

import {{package_name}}.vo.req.{{class_name}}Req;
import {{package_name}}.vo.resp.{{class_name}}Resp;

public interface {{class_name}}Service {

   {{class_name}}Resp query({{class_name}}Req record);

   List<{{class_name}}Resp> query{{class_name}}List({{class_name}}Req record);

   int insert({{class_name}}Req record);

   int delete(int id);

   int update({{class_name}}Req record);

}"
}