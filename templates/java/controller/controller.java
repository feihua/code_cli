package {{package_name}}.controller;

import java.util.List;

import {{package_name}}.bean.{{class_name}};
import {{package_name}}.dao.{{class_name}}Service;

@Api(tags = "{{table_comment}}")
@RestController
@RequestMapping("/{{table_name}}")
public class {{class_name}}ServiceImpl {

   @Autowired
   private {{class_name}}Service recordService

   @ApiOperation("查询{{table_comment}}")
   @PostMapping("/query")
   public {{class_name}} query({{class_name}} record){
       return recordDao.query(record);
   }

   @ApiOperation("查询{{table_comment}}列表")
   @PostMapping("/query{{class_name}}List")
   public List<{{class_name}}> query{{class_name}}List({{class_name}} record){
        return recordDao.query(record);
   }

   @ApiOperation("添加{{table_comment}}")
   @PostMapping("/insert")
   public int insert({{class_name}} record){
        return recordDao.insert(record);
   }

   @ApiOperation("删除{{table_comment}}")
   @PostMapping("/delete")
   public int delete(int id){
        return recordDao.delete(id);
   }

   @ApiOperation("更新{{table_comment}}")
   @PostMapping("/update")
   public int update({{class_name}} record){
        return recordDao.update(record);
   }

}