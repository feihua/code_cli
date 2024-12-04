package {{table_info.table_name}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{table_info.class_name}}ListLogic 查询{{table_info.table_comment}}列表
/*
Author: {{author}}
Date: {{create_time}}
*/
type Query{{table_info.class_name}}ListLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewQuery{{table_info.class_name}}ListLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{table_info.class_name}}ListLogic {
	return &Query{{table_info.class_name}}ListLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Query{{table_info.class_name}}List 查询{{table_info.table_comment}}列表
func (l *Query{{table_info.class_name}}ListLogic) Query{{table_info.class_name}}List(req *types.Query{{table_info.class_name}}ListReq) (resp *types.Query{{table_info.class_name}}ListResp, err error) {
    result, err := l.svcCtx.{{table_info.class_name}}Service.Query{{table_info.class_name}}List(l.ctx, &{{rpc_client}}.Query{{table_info.class_name}}ListReq{
		PageNum:    req.Current,
		PageSize:   req.PageSize,
        {%- for column in table_info.columns %}
          {%- if column.column_key =="PRI"  %}
          {%- elif column.go_name is containing("Create") %}
          {%- elif column.go_name is containing("Update") %}
          {%- elif column.go_name is containing("CreateBy") %}
          {%- elif column.go_name is containing("Sort") %}
          {%- elif column.go_name is containing("Remark") %}
          {%- else %}
            {{column.go_name}}: req.{{column.go_name}}, //{{column.column_comment}}
          {%- endif %}
        {%- endfor %}

	})

	if err != nil {
		logc.Errorf(l.ctx, "查询字{{table_info.table_comment}}列表失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

    var list []*types.Query{{table_info.class_name}}ListData

	for _, detail := range result.List {
		list = append(list, &types.Query{{table_info.class_name}}ListData{
        {%- for column in table_info.columns %}
            {{column.go_name}}: detail.{{column.go_name}}, //{{column.column_comment}}
        {%- endfor %}
		})
	}

	return &types.Query{{table_info.class_name}}ListResp{
		Code:    "000000",
		Message: "查询{{table_info.table_comment}}列表成功",
		Current:  req.Current,
        Data:     list,
        PageSize: req.PageSize,
        Success:  true,
        Total:    result.Total,
	}, nil
}
