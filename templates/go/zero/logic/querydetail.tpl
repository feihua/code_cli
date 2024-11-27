package {{.GoName}}

import (
	"context"
	"github.com/feihua/zero-admin/api/admin/internal/common/errorx"
	"github.com/zeromicro/go-zero/core/logc"
	"google.golang.org/grpc/status"

	"github.com/zeromicro/go-zero/core/logx"
)

// Query{{.JavaName}}DetailLogic 查询{{.Comment}}详情
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Query{{.JavaName}}DetailLogic struct {
	logx.Logger
	ctx    context.Context
	svcCtx *svc.ServiceContext
}

func NewQuery{{.JavaName}}DetailLogic(ctx context.Context, svcCtx *svc.ServiceContext) *Query{{.JavaName}}DetailLogic {
	return &Query{{.JavaName}}DetailLogic{
		Logger: logx.WithContext(ctx),
		ctx:    ctx,
		svcCtx: svcCtx,
	}
}

// Query{{.JavaName}}Detail 查询{{.Comment}}详情
func (l *Query{{.JavaName}}DetailLogic) Query{{.JavaName}}Detail(req *types.Query{{.JavaName}}DetailReq) (resp *types.Query{{.JavaName}}DetailResp, err error) {

    detail, err := l.svcCtx.{{.JavaName}}Service.Query{{.JavaName}}Detail(l.ctx, &{{.RpcClient}}.Query{{.JavaName}}DetailReq{
		Id: req.Id,
	})

	if err != nil {
		logc.Errorf(l.ctx, "查询{{.Comment}}详情失败,参数：%+v,响应：%s", req, err.Error())
		s, _ := status.FromError(err)
		return nil, errorx.NewDefaultError(s.Message())
	}

    data := types.Query{{.JavaName}}DetailData{
        {{range .TableColumn}}{{.GoNamePublic}}: detail.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{end}}

	}
	return &types.Query{{.JavaName}}DetailResp{
		Code:    "000000",
		Message: "查询{{.Comment}}成功",
		Data:    data,
	}, nil
}
