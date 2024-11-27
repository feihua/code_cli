package {{package_name}}.service;

import java.util.List;

import {{package_name}}.util.*;
import {{package_name}}.vo.req.*;
import {{package_name}}.vo.resp.*;

/**
 * 描述：{{table_info.table_comment}}
 * 作者：{{author}}
 * 日期：{{create_time}}
 */
public interface {{table_info.class_name}}Service {

    /**
     * 添加{{table_info.table_comment}}
     *
     * @param {{table_info.object_name}} 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
	int insert{{table_info.class_name}}({{table_info.class_name}}Req {{table_info.object_name}});

    /**
     * 删除{{table_info.table_comment}}
     *
     * @param ids 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
	int delete{{table_info.class_name}}(List<Integer> ids);

    /**
     * 修改{{table_info.table_comment}}
     *
     * @param {{table_info.object_name}} 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    int update{{table_info.class_name}}({{table_info.class_name}}Req {{table_info.object_name}});

    /**
     * 修改{{table_info.table_comment}}状态
     *
     * @param {{table_info.object_name}} 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    int update{{table_info.class_name}}Status({{table_info.class_name}}Req {{table_info.object_name}});

    /**
     * 查询{{table_info.table_comment}}详情
     *
     * @param {{table_info.object_name}} 请求参数
     * @return {{table_info.class_name}}Resp
     * @author {{author}}
     * @date: {{create_time}}
     */
    {{table_info.class_name}}Resp query{{table_info.class_name}}Detail({{table_info.class_name}}Req {{table_info.object_name}});

    /**
     * 查询{{table_info.table_comment}}列表
     *
     * @param {{table_info.object_name}} 请求参数
     * @param pageNum 当前页
     * @param pageSize 每页的数量
     * @return ResultPage
     * @author {{author}}
     * @date: {{create_time}}
     */
    ResultPage<{{table_info.class_name}}Resp> query{{table_info.class_name}}List({{table_info.class_name}}Req {{table_info.object_name}}, Integer pageNum, Integer pageSize);

}