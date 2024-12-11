package {{table_info.table_name}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{table_info.class_name}}DetailLogic 查询{{table_info.table_comment}}详情
/*
Author: {{author}}
Date: {{create_time}}
*/
type Query{{table_info.class_name}}DetailLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewQuery{{table_info.class_name}}DetailLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{table_info.class_name}}DetailLogic {
	return &Query{{table_info.class_name}}DetailLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Query{{table_info.class_name}}Detail 查询{{table_info.table_comment}}详情
func (l *Query{{table_info.class_name}}DetailLogic) Query{{table_info.class_name}}Detail(req *types.Query{{table_info.class_name}}DetailReq) (resp *types.Query{{table_info.class_name}}DetailResp, err error) {

    detail, err := l.svcCtx.{{table_info.class_name}}Service.Query{{table_info.class_name}}Detail(l.ctx, &{{rpc_client}}.Query{{table_info.class_name}}DetailReq{
		Id: req.Id,
	})

	if err != nil {
		logc.Errorf(l.ctx, "查询{{table_info.table_comment}}详情失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

    data := types.Query{{table_info.class_name}}DetailData{
    {%- for column in table_info.columns %}
        {{column.go_name}}: detail.{{column.go_name}}, //{{column.column_comment}}
    {%- endfor %}
	}
	return &types.Query{{table_info.class_name}}DetailResp{
		Code:    "000000",
		Message: "查询{{table_info.table_comment}}成功",
		Data:    data,
	}, nil
}
