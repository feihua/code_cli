package {{.GoName}}servicelogic

import (
	"context"
	"errors"
	"fmt"
	"github.com/zeromicro/go-zero/core/logc"
	"github.com/zeromicro/go-zero/core/logx"
)

// Update{{.JavaName}}Logic 更新{{.Comment}}
/*
Author: {{.Author}}
Date: {{.CreateTime}}
*/
type Update{{.JavaName}}Logic struct {
	ctx    context.Context
	svcCtx *svc.ServiceContext
	logx.Logger
}

func NewUpdate{{.JavaName}}Logic(ctx context.Context, svcCtx *svc.ServiceContext) *Update{{.JavaName}}Logic {
	return &Update{{.JavaName}}Logic{
		ctx:    ctx,
		svcCtx: svcCtx,
		Logger: logx.WithContext(ctx),
	}
}

// Update{{.JavaName}} 更新{{.Comment}}
func (l *Update{{.JavaName}}Logic) Update{{.JavaName}}(in *{{.RpcClient}}.Update{{.JavaName}}Req) (*{{.RpcClient}}.Update{{.JavaName}}Resp, error) {
    q := query.{{.UpperOriginalName}}.WithContext(l.ctx)

    // 1.根据{{.Comment}}id查询{{.Comment}}是否已存在
	_, err := q.Where(query.{{.UpperOriginalName}}.ID.Eq(in.Id)).First()

	if err != nil {
		logc.Errorf(l.ctx, "根据{{.Comment}}id：%d,查询{{.Comment}}失败,异常:%s", in.Id, err.Error())
		return nil, errors.New(fmt.Sprintf("查询{{.Comment}}失败"))
	}

	item := &model.{{.UpperOriginalName}}{
	{{- range .TableColumn}}
		{{- if isContain .GoNamePublic "Create"}}
        {{- else if isContain .GoNamePublic "UpdateTime"}}
        {{- else if isContain .GoNamePublic "Id"}}
        {{Replace .GoNamePublic "Id" "ID"}}: in.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- else}}
        {{.GoNamePublic}}: in.{{.GoNamePublic}}, //{{.ColumnComment}}
        {{- end}}
        {{- end}}
	}

	// 2.{{.Comment}}存在时,则直接更新{{.Comment}}
	_, err = q.Updates(item)
	
	if err != nil {
		logc.Errorf(l.ctx, "更新{{.Comment}}失败,参数:%+v,异常:%s", item, err.Error())
		return nil, errors.New("更新{{.Comment}}失败")
	}

    logc.Infof(l.ctx, "更新{{.Comment}}成功,参数：%+v", in)
	return &{{.RpcClient}}.Update{{.JavaName}}Resp{}, nil
}
