package {{package_name}}.controller;

import io.swagger.v3.oas.annotations.Operation;
import io.swagger.v3.oas.annotations.tags.Tag;

import java.util.List;

import jakarta.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import {{package_name}}.util.*;
import {{package_name}}.vo.req.*;
import {{package_name}}.vo.resp.*;
import {{package_name}}.service.{{table_info.class_name}}Service;

/**
 * 描述：{{table_info.table_comment}}
 * 作者：{{author}}
 * 日期：{{create_time}}
 */
@Tag(name = "{{table_info.table_comment}}")
@RestController
@RequestMapping("/{{table_info.object_name}}")
public class {{table_info.class_name}}Controller {

    @Autowired
    private {{table_info.class_name}}Service {{table_info.object_name}}Service;

    /**
     * 添加{{table_info.table_comment}}
     *
     * @param {{table_info.object_name}}Req 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Operation(summary = "添加{{table_info.table_comment}}")
    @PostMapping("/insert{{table_info.class_name}}")
    public Result<Integer> insert{{table_info.class_name}}(@RequestBody @Valid {{table_info.class_name}}Req {{table_info.object_name}}Req){
        return Result.success({{table_info.object_name}}Service.insert{{table_info.class_name}}({{table_info.object_name}}Req));
    }

    /**
     * 删除{{table_info.table_comment}}
     *
     * @param ids 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Operation(summary = "删除{{table_info.table_comment}}")
    @PostMapping("/delete{{table_info.class_name}}")
    public Result<Integer> delete{{table_info.class_name}}(List<Integer> ids){
        return Result.success({{table_info.object_name}}Service.delete{{table_info.class_name}}(ids));
    }

    /**
     * 更新{{table_info.table_comment}}
     *
     * @param {{table_info.object_name}}Req 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Operation(summary = "更新{{table_info.table_comment}}")
    @PostMapping("/update{{table_info.class_name}}")
    public Result<Integer> update{{table_info.class_name}}(@RequestBody @Valid {{table_info.class_name}}Req {{table_info.object_name}}Req){
        return Result.success({{table_info.object_name}}Service.update{{table_info.class_name}}({{table_info.object_name}}Req));
    }

    /**
     * 更新{{table_info.table_comment}}状态
     *
     * @param {{table_info.object_name}}Req 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Operation(summary = "更新{{table_info.table_comment}}状态")
    @PostMapping("/update{{table_info.class_name}}Status")
    public Result<Integer> update{{table_info.class_name}}Status(@RequestBody @Valid {{table_info.class_name}}Req {{table_info.object_name}}Req){
        return Result.success({{table_info.object_name}}Service.update{{table_info.class_name}}Status({{table_info.object_name}}Req));
    }

    /**
     * 查询{{table_info.table_comment}}详情
     *
     * @param {{table_info.object_name}}Req 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Operation(summary = "查询{{table_info.table_comment}}详情")
    @PostMapping("/query{{table_info.class_name}}Detail")
    public Result<{{table_info.class_name}}Resp> query{{table_info.class_name}}Detail(@RequestBody @Valid {{table_info.class_name}}Req {{table_info.object_name}}Req){
        return Result.success({{table_info.object_name}}Service.query{{table_info.class_name}}Detail({{table_info.object_name}}Req));
    }

    /**
     * 查询{{table_info.table_comment}}列表
     *
     * @param {{table_info.object_name}}Req 请求参数
     * @param pageNum 当前页
     * @param pageSize 每页的数量
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Operation(summary = "查询{{table_info.table_comment}}列表")
    @PostMapping("/query{{table_info.class_name}}List")
    public ResultPage<{{table_info.class_name}}Resp> query{{table_info.class_name}}List(@RequestBody @Valid {{table_info.class_name}}Req {{table_info.object_name}}Req,
                                              @RequestParam(value = "pageNum", defaultValue = "1") Integer pageNum,
                                              @RequestParam(value = "pageSize", defaultValue = "10") Integer pageSize){
        return {{table_info.object_name}}Service.query{{table_info.class_name}}List({{table_info.object_name}}Req, pageNum, pageSize);
    }

}