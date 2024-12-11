package {{table_info.table_name}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{table_info.class_name}}Logic 更新{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Update{{table_info.class_name}}Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewUpdate{{table_info.class_name}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{table_info.class_name}}Logic {
	return &Update{{table_info.class_name}}Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Update{{table_info.class_name}} 更新{{table_info.table_comment}}
func (l *Update{{table_info.class_name}}Logic) Update{{table_info.class_name}}(req *types.Update{{table_info.class_name}}Req) (resp *types.Update{{table_info.class_name}}Resp, err error) {

    _, err = l.svcCtx.{{table_info.class_name}}Service.Update{{table_info.class_name}}(l.ctx, &{{rpc_client}}.Update{{table_info.class_name}}Req{
    {%- for column in table_info.columns %}
      {%- if column.go_name is containing("Create") %}
      {%- elif column.go_name is containing("UpdateTime") %}
      {%- elif column.go_name is containing("UpdateBy") %}
        CreateBy: l.ctx.Value("userName").(string),
      {%- else %}
        {{column.go_name}}: req.{{column.go_name}}, //{{column.column_comment}}
      {%- endif %}
    {%- endfor %}

    })

	if err != nil {
	    logc.Errorf(l.ctx, "更新{{table_info.table_comment}}失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

	return &types.Update{{table_info.class_name}}Resp{
		Code:    "000000",
		Message: "更新{{table_info.table_comment}}成功",
	}, nil
}
