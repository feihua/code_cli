package {{table_info.table_name}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Delete{{table_info.class_name}}Logic 删除{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Delete{{table_info.class_name}}Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewDelete{{table_info.class_name}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Delete{{table_info.class_name}}Logic {
	return &Delete{{table_info.class_name}}Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Delete{{table_info.class_name}} 删除{{table_info.table_comment}}
func (l *Delete{{table_info.class_name}}Logic) Delete{{table_info.class_name}}(req *types.Delete{{table_info.class_name}}Req) (resp *types.Delete{{table_info.class_name}}Resp, err error) {
	_, err = l.svcCtx.{{table_info.class_name}}Service.Delete{{table_info.class_name}}(l.ctx, &{{rpc_client}}.Delete{{table_info.class_name}}Req{
    		Ids: req.Ids,
    	})

	if err != nil {
		logc.Errorf(l.ctx, "删除{{table_info.table_comment}}失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

	return &types.Delete{{table_info.class_name}}Resp{
		Code:    "000000",
		Message: "删除{{table_info.table_comment}}成功",
	}, nil
}
