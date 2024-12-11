package {{table_info.table_name}}

/*
 添加{{table_info.table_comment}}
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

// Add{{table_info.class_name}} 添加{{table_info.table_comment}}
func (c *ControllerV1) Add{{table_info.class_name}}(ctx context.Context, req *v1.Add{{table_info.class_name}}Req) (res *v1.Add{{table_info.class_name}}Res, err error) {
	var input = model.Add{{table_info.class_name}}Input{}
	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	_, err = service.{{table_info.class_name}}().Add{{table_info.class_name}}(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Add{{table_info.class_name}}Res{}

	return
}
