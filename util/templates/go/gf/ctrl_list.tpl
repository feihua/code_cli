package {{table_info.table_name}}

/*
查询{{table_info.table_comment}}
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

 // Query{{table_info.class_name}}List 查询{{table_info.table_comment}}列表
func (c *ControllerV1) Query{{table_info.class_name}}List(ctx context.Context, req *v1.Query{{table_info.class_name}}ListReq) (res *v1.Query{{table_info.class_name}}ListRes, err error) {
	var input = model.Query{{table_info.class_name}}ListInput{}

	err = gconv.Struct(req, &input)
	if err != nil {
		return nil, err
	}
	output, err := service.{{table_info.class_name}}().Query{{table_info.class_name}}List(ctx, input)
	if err != nil {
		return nil, err
	}

	res = &v1.Query{{table_info.class_name}}ListRes{}

	err = gconv.Struct(output, res)
	if err != nil {
		return nil, err
	}

	return
}
