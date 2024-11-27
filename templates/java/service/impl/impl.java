package {{package_name}}.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import {{package_name}}.entity.*;
import {{package_name}}.util.ResultPage;
import {{package_name}}.vo.req.*;
import {{package_name}}.vo.resp.*;
import {{package_name}}.dao.{{table_info.class_name}}Dao;
import {{package_name}}.service.{{table_info.class_name}}Service;
import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;

/**
 * 描述：{{table_info.table_comment}}
 * 作者：{{author}}
 * 日期：{{create_time}}
 */
@Service
public class {{table_info.class_name}}ServiceImpl implements {{table_info.class_name}}Service {

    @Autowired
    private {{table_info.class_name}}Dao {{table_info.object_name}}Dao;

    /**
     * 添加{{table_info.table_comment}}
     *
     * @param {{table_info.object_name}} 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Override
	int insert{{table_info.class_name}}({{table_info.class_name}}Req {{table_info.object_name}}) {
        return {{table_info.object_name}}Dao.insert{{table_info.class_name}}({{table_info.class_name}}.builder().build());
	}

    /**
     * 删除{{table_info.table_comment}}
     *
     * @param ids 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Override
	int delete{{table_info.class_name}}(List<Integer> ids) {
        return {{table_info.object_name}}Dao.delete{{table_info.class_name}}(ids);
	}

    /**
     * 修改{{table_info.table_comment}}
     *
     * @param {{table_info.object_name}} 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Override
    int update{{table_info.class_name}}({{table_info.class_name}}Req {{table_info.object_name}}) {
      return {{table_info.object_name}}Dao.update{{table_info.class_name}}({{table_info.class_name}}.builder().build());
    }

    /**
     * 修改{{table_info.table_comment}}状态
     *
     * @param {{table_info.object_name}} 请求参数
     * @return int
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Override
    int update{{table_info.class_name}}Status({{table_info.class_name}}Req {{table_info.object_name}}) {
      return {{table_info.object_name}}Dao.update{{table_info.class_name}}Status({{table_info.class_name}}.builder().build());
    }

    /**
     * 查询{{table_info.table_comment}}详情
     *
     * @param {{table_info.object_name}} 请求参数
     * @return {{table_info.class_name}}Resp
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Override
    {{table_info.class_name}}Resp query{{table_info.class_name}}Detail({{table_info.class_name}}Req {{table_info.object_name}}) {
       {{table_info.class_name}} query = {{table_info.object_name}}Dao.query{{table_info.class_name}}Detail({{table_info.class_name}}.builder().build());

       return {{table_info.class_name}}Resp.builder().build();
    }

    /**
     * 查询{{table_info.table_comment}}列表
     *
     * @param {{table_info.object_name}} 请求参数
     * @return ResultPage
     * @author {{author}}
     * @date: {{create_time}}
     */
    @Override
    ResultPage<{{table_info.class_name}}Resp> query{{table_info.class_name}}List({{table_info.class_name}}Req {{table_info.object_name}}) {
       PageHelper.startPage({{table_info.object_name}}.getPageNum(), {{table_info.object_name}}.getPageSize());
	   List<{{table_info.class_name}}> query = {{table_info.object_name}}Dao.query{{table_info.class_name}}List({{table_info.class_name}}.builder().build());
       PageInfo<{{table_info.class_name}}> pageInfo = new PageInfo<>(query);

	   List<{{table_info.class_name}}Resp> list = pageInfo.getList().stream().map(x -> {
		   {{table_info.class_name}}Resp resp = new {{table_info.class_name}}Resp();
		   BeanUtils.copyProperties(x, resp);
		   return resp;
	   }).collect(Collectors.toList());

        return new ResultPage<>(list,pageInfo.getPageNum(),pageInfo.getPageSize(),pageInfo.getTotal());
    }

}