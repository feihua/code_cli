package {{table_info.table_name}}

/*
更新{{table_info.table_comment}}
Author: {{author}}
Date: {{create_time}}
*/

import (
	"context"
	"github.com/gogf/gf/v2/util/gconv"
	"{{project_name}}/internal/model"
	"{{project_name}}/internal/service"

	"{{project_name}}/api/{{table_info.table_name}}/v1"
)

// Update{{table_info.class_name}} 更新{{table_info.table_comment}}状态
func (c *ControllerV1) Update{{table_info.class_name}}Status(ctx context.Context, req *v1.Update{{table_info.class_name}}StatusReq) (res *v1.Update{{table_info.class_name}}Res, err error) {
	var input = model.Update{{table_info.class_name}}StatusInput{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{table_info.class_name}}().Update{{table_info.class_name}}Status(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Update{{table_info.class_name}}StatusRes{}

	return
}
