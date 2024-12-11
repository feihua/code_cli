package {{table_info.table_name}}_service

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{table_info.class_name}}ListLogic 查询{{table_info.table_comment}}列表
/*
Author: {{author}}
Date: {{create_time}}
*/
type Query{{table_info.class_name}}ListLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewQuery{{table_info.class_name}}ListLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{table_info.class_name}}ListLogic {
	return &Query{{table_info.class_name}}ListLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Query{{table_info.class_name}}List 查询{{table_info.table_comment}}列表
func (l *Query{{table_info.class_name}}ListLogic) Query{{table_info.class_name}}List(in *{{rpc_client}}.Query{{table_info.class_name}}ListReq) (*{{rpc_client}}.Query{{table_info.class_name}}ListResp, error) {
    {{table_info.object_name}} := query.{{table_info.original_class_name}}
    q := {{table_info.object_name}}.WithContext(l.ctx)

    {%- for column in table_info.columns %}
      {%- if column.column_key =="PRI"  %}
      {%- elif column.go_name is containing("Create") %}
      {%- elif column.go_name is containing("Update") %}
      {%- elif column.go_name is containing("Sort") %}
      {%- elif column.go_name is containing("Remark") %}
      {%- else %}
        {%- if column.go_type == "string"  %}
        if len(in.{{column.go_name}}) > 0 {
            q = q.Where({{table_info.object_name}}.{{column.go_name}}.Like("%" + in.{{column.go_name}} + "%"))
        }
        {%- else %}
        if in.{{column.go_name}} != 2 {
            q = q.Where({{table_info.object_name}}.{{column.go_name}}.Eq(in.{{column.go_name}}))
        }
        {%- endif %}
        {{column.go_name}}: req.{{column.go_name}}, //{{column.column_comment}}
      {%- endif %}
    {%- endfor %}



	result, count, err := q.FindByPage(int((in.PageNum-1)*in.PageSize), int(in.PageSize))

	if err != nil {
		logc.Errorf(l.ctx, "查询{{table_info.table_comment}}列表失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("查询{{table_info.table_comment}}列表失败")
	}

	var list []*{{rpc_client}}.{{table_info.class_name}}ListData

	for _, item := range result {
		list = append(list, &{{rpc_client}}.{{table_info.class_name}}ListData{
        {%- for column in table_info.columns %}
          {%- if column.go_name is containing("Time") %}
            {{column.go_name}}: item.{{column.go_name}}.Format("2006-01-02 15:04:05"), //{{column.column_comment}}
          {%- else %}
            {{column.go_name}}: item.{{column.go_name}}, //{{column.column_comment}}
          {%- endif %}

        {%- endfor %}
		})
	}

	logc.Infof(l.ctx, "查询{{table_info.table_comment}}列表信息,参数：%+v,响应：%+v", in, list)

	return &{{rpc_client}}.Query{{table_info.class_name}}ListResp{
	    Total: count,
    	List:  list,
	}, nil
}
