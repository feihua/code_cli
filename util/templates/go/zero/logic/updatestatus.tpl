package {{table_info.table_name}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{table_info.class_name}}StatusLogic 更新{{table_info.table_comment}}状态状态
/*
Author: {{author}}
Date: {{create_time}}
*/
type Update{{table_info.class_name}}StatusLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewUpdate{{table_info.class_name}}StatusLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{table_info.class_name}}StatusLogic {
	return &Update{{table_info.class_name}}StatusLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Update{{table_info.class_name}}Status 更新{{table_info.table_comment}}状态
func (l *Update{{table_info.class_name}}StatusLogic) Update{{table_info.class_name}}Status(req *types.Update{{table_info.class_name}}StatusReq) (resp *types.Update{{table_info.class_name}}StatusResp, err error) {
    _, err = l.svcCtx.{{table_info.class_name}}Service.Update{{table_info.class_name}}Status(l.ctx, &{{rpc_client}}.Update{{table_info.class_name}}StatusReq{
    {%- for column in table_info.columns %}
      {%- if column.column_key =="PRI"  %}
      {{column.go_name}}s: req.{{column.go_name}}s, //{{column.column_comment}}
      {%- elif column.go_name is containing("UpdateBy") %}
        CreateBy: l.ctx.Value("userName").(string),
      {%- elif column.go_name is containing("Status") %}
      {{column.go_name}}: req.{{column.go_name}}, //{{column.column_comment}}
      {%- else %}
      {%- endif %}
    {%- endfor %}

    })

	if err != nil {
		logc.Errorf(l.ctx, "更新{{table_info.table_comment}}状态失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

	return &types.Update{{table_info.class_name}}StatusResp{
		Code:    "000000",
		Message: "更新{{table_info.table_comment}}状态成功",
	}, nil
}
