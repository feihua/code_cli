package {{table_info.table_name}}_service

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{table_info.class_name}}DetailLogic 查询{{table_info.table_comment}}详情
/*
Author: {{author}}
Date: {{create_time}}
*/
type Query{{table_info.class_name}}DetailLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewQuery{{table_info.class_name}}DetailLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{table_info.class_name}}DetailLogic {
	return &Query{{table_info.class_name}}DetailLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Query{{table_info.class_name}}Detail 查询{{table_info.table_comment}}详情
func (l *Query{{table_info.class_name}}DetailLogic) Query{{table_info.class_name}}Detail(in *{{rpc_client}}.Query{{table_info.class_name}}DetailReq) (*{{rpc_client}}.Query{{table_info.class_name}}DetailResp, error) {
	item, err := query.{{table_info.original_class_name}}.WithContext(l.ctx).Where(query.{{table_info.original_class_name}}.ID.Eq(in.Id)).First()

	if err != nil {
		logc.Errorf(l.ctx, "查询{{table_info.table_comment}}详情失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("查询{{table_info.table_comment}}详情失败")
	}

	data := &{{rpc_client}}.Query{{table_info.class_name}}DetailResp{
    {%- for column in table_info.columns %}
      {%- if column.go_name is containing("Time") %}
        {{column.go_name}}: item.{{column.go_name}}.Format("2006-01-02 15:04:05"), //{{column.column_comment}}
      {%- else %}
        {{column.go_name}}: item.{{column.go_name}}, //{{column.column_comment}}
      {%- endif %}

    {%- endfor %}

	}

    logc.Infof(l.ctx, "查询{{table_info.table_comment}}详情,参数：%+v,响应：%+v", in, data)
	return data, nil
}
