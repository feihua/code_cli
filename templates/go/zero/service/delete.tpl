package {{table_info.table_name}}_service

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Delete{{table_info.class_name}}Logic 删除{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Delete{{table_info.class_name}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewDelete{{table_info.class_name}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Delete{{table_info.class_name}}Logic {
	return &Delete{{table_info.class_name}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Delete{{table_info.class_name}} 删除{{table_info.table_comment}}
func (l *Delete{{table_info.class_name}}Logic) Delete{{table_info.class_name}}(in *{{rpc_client}}.Delete{{table_info.class_name}}Req) (*{{rpc_client}}.Delete{{table_info.class_name}}Resp, error) {
    q := query.{{table_info.original_class_name}}

	_, err := q.WithContext(l.ctx).Where(q.ID.In(in.Ids...)).Delete()

	if err != nil {
		logc.Errorf(l.ctx, "删除{{table_info.table_comment}}失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("删除{{table_info.table_comment}}失败")
	}

    logc.Infof(l.ctx, "删除{{table_info.table_comment}}成功,参数：%+v", in)
	return &{{rpc_client}}.Delete{{table_info.class_name}}Resp{}, nil
}
