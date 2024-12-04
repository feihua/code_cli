package {{table_info.table_name}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Add{{table_info.class_name}}Logic 添加{{table_info.table_comment}}
/*
Author: {{author}}
Date: {{create_time}}
*/
type Add{{table_info.class_name}}Logic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewAdd{{table_info.class_name}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Add{{table_info.class_name}}Logic {
	return &Add{{table_info.class_name}}Logic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Add{{table_info.class_name}} 添加{{table_info.table_comment}}
func (l *Add{{table_info.class_name}}Logic) Add{{table_info.class_name}}(req *types.Add{{table_info.class_name}}Req) (resp *types.Add{{table_info.class_name}}Resp, err error) {

    _, err = l.svcCtx.{{table_info.class_name}}Service.Add{{table_info.class_name}}(l.ctx, &{{rpc_client}}.Add{{table_info.class_name}}Req{
    {%- for column in table_info.columns %}
      {%- if column.column_key =="PRI"  %}
      {%- elif column.go_name is containing("CreateTime") %}
      {%- elif column.go_name is containing("Update") %}
      {%- elif column.go_name is containing("CreateBy") %}
        CreateBy: l.ctx.Value("userName").(string),
      {%- else %}
        {{column.go_name}}: req.{{column.go_name}}, //{{column.column_comment}}
      {%- endif %}
    {%- endfor %}

    })

	if err != nil {
		logc.Errorf(l.ctx, "添加{{table_info.table_comment}}失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

	return &types.Add{{table_info.class_name}}Resp{
		Code:    "000000",
		Message: "添加{{table_info.table_comment}}成功",
	}, nil
}
