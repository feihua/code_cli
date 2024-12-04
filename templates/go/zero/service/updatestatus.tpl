package {{table_info.table_name}}_service

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{table_info.class_name}}StatusLogic 更新{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Update{{table_info.class_name}}StatusLogic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewUpdate{{table_info.class_name}}StatusLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{table_info.class_name}}StatusLogic {
	return &Update{{table_info.class_name}}StatusLogic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Update{{table_info.class_name}}Status 更新{{table_info.table_comment}}状态
func (l *Update{{table_info.class_name}}StatusLogic) Update{{table_info.class_name}}Status(in *{{rpc_client}}.Update{{table_info.class_name}}StatusReq) (*{{rpc_client}}.Update{{table_info.class_name}}StatusResp, error) {
    q := query.{{table_info.original_class_name}}

	_, err := q.WithContext(l.ctx).Where(q.ID.In(in.Ids...)).Update(q.Status, in.Status)

	if err != nil {
		logc.Errorf(l.ctx, "更新{{table_info.table_comment}}状态失败,参数:%+v,异常:%s", in, err.Error())
		return nil, errors.New("更新{{table_info.table_comment}}状态失败")
	}

    logc.Infof(l.ctx, "更新{{table_info.table_comment}}状态成功,参数：%+v", in)
	return &{{rpc_client}}.Update{{table_info.class_name}}StatusResp{}, nil
}
