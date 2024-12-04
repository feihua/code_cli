package {{table_info.table_name}}_service

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{table_info.class_name}}Logic 更新{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Update{{table_info.class_name}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewUpdate{{table_info.class_name}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{table_info.class_name}}Logic {
	return &Update{{table_info.class_name}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Update{{table_info.class_name}} 更新{{table_info.table_comment}}
func (l *Update{{table_info.class_name}}Logic) Update{{table_info.class_name}}(in *{{rpc_client}}.Update{{table_info.class_name}}Req) (*{{rpc_client}}.Update{{table_info.class_name}}Resp, error) {
    q := query.{{table_info.original_class_name}}.WithContext(l.ctx)

    // 1.根据{{table_info.table_comment}}id查询{{table_info.table_comment}}是否已存在
	_, err := q.Where(query.{{table_info.original_class_name}}.ID.Eq(in.Id)).First()

	if err != nil {
		logc.Errorf(l.ctx, "根据{{table_info.table_comment}}id：%d,查询{{table_info.table_comment}}失败,异常:%s", in.Id, err.Error())
		return nil, errors.New(fmt.Sprintf("查询{{table_info.table_comment}}失败"))
	}

	item := &model.{{table_info.original_class_name}}{
    {%- for column in table_info.columns %}
      {%- if column.go_name is containing("Create") %}
      {%- elif column.go_name is containing("UpdateTime") %}
        {{column.go_name}}: in.{{column.go_name}}, //{{column.column_comment}}
      {%- endif %}
    {%- endfor %}

	}

	// 2.{{table_info.table_comment}}存在时,则直接更新{{table_info.table_comment}}
	_, err = q.Updates(item)
	
	if err != nil {
		logc.Errorf(l.ctx, "更新{{table_info.table_comment}}失败,参数:%+v,异常:%s", item, err.Error())
		return nil, errors.New("更新{{table_info.table_comment}}失败")
	}

    logc.Infof(l.ctx, "更新{{table_info.table_comment}}成功,参数：%+v", in)
	return &{{rpc_client}}.Update{{table_info.class_name}}Resp{}, nil
}
