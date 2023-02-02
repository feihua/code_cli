pub fn get_controller() -> &'static str {
    "package {{package_name}}.controller;

import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import {{package_name}}.vo.req.{{class_name}}Req;
import {{package_name}}.vo.resp.{{class_name}}Resp;
import {{package_name}}.service.{{class_name}}Service;

@Api(tags = \"{{table_comment}}\")
@RestController
@RequestMapping(\"/{{table_name}}\")
public class {{class_name}}Controller {

   @Autowired
   private {{class_name}}Service recordService;

   @ApiOperation(\"查询{{table_comment}}\")
   @PostMapping(\"/query\")
   public {{class_name}}Resp query(@RequestBody @Valid {{class_name}}Req record){
       return recordService.query(record);
   }

   @ApiOperation(\"查询{{table_comment}}列表\")
   @PostMapping(\"/query{{class_name}}List\")
   public List<{{class_name}}Resp> query{{class_name}}List(@RequestBody @Valid {{class_name}}Req record){
        return recordService.query{{class_name}}List(record);
   }

   @ApiOperation(\"添加{{table_comment}}\")
   @PostMapping(\"/insert\")
   public int insert(@RequestBody @Valid {{class_name}}Req record){
        return recordService.insert(record);
   }

   @ApiOperation(\"删除{{table_comment}}\")
   @PostMapping(\"/delete\")
   public int delete(int id){
        return recordService.delete(id);
   }

   @ApiOperation(\"更新{{table_comment}}\")
   @PostMapping(\"/update\")
   public int update(@RequestBody @Valid {{class_name}}Req record){
        return recordService.update(record);
   }

}"
}
