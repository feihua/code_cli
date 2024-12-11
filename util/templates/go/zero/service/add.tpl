package {{table_info.table_name}}_service

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Add{{table_info.class_name}}Logic 添加{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Add{{table_info.class_name}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewAdd{{table_info.class_name}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Add{{table_info.class_name}}Logic {
	return &Add{{table_info.class_name}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Add{{table_info.class_name}} 添加{{table_info.table_comment}}
func (l *Add{{table_info.class_name}}Logic) Add{{table_info.class_name}}(in *{{rpc_client}}.Add{{table_info.class_name}}Req) (*{{rpc_client}}.Add{{table_info.class_name}}Resp, error) {
    q := query.{{table_info.original_class_name}}
    
    item := &model.{{table_info.original_class_name}}{
    {%- for column in table_info.columns %}
      {%- if column.column_key =="PRI"  %}
      {%- elif column.go_name is containing("CreateTime") %}
      {%- elif column.go_name is containing("Update") %}
      {%- else %}
        {{column.go_name}}: in.{{column.go_name}}, //{{column.column_comment}}
      {%- endif %}
    {%- endfor %}

	}

	err := q.WithContext(l.ctx).Create(item)
	if err != nil {
		logc.Errorf(l.ctx, "添加{{table_info.table_comment}}失败,参数:%+v,异常:%s", item, err.Error())
		return nil, errors.New("添加{{table_info.table_comment}}失败")
	}

    logc.Infof(l.ctx, "添加{{table_info.table_comment}}成功,参数：%+v", in)
	return &{{rpc_client}}.Add{{table_info.class_name}}Resp{}, nil
}
