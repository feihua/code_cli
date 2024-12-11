info(
	desc: "{{table_info.table_comment}}"
	author: "{{author}}"
	email: "1002219331@qq.com"
)

type (
    // 添加{{table_info.table_comment}}请求参数
	Add{{table_info.class_name}}Req {
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {%- elif column.proto_name is containing("create") %}
    {%- elif column.proto_name is containing("update") %}
    {%- elif column.is_nullable =="YES" %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},optional"` //{{column.column_comment}}
    {%- elif column.proto_name is containing("status") %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},default=2"` //{{column.column_comment}}
    {%- else %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}"` //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}

    }
	Add{{table_info.class_name}}Resp {
		Code    string `json:"code"`
		Message string `json:"message"`
	}

    // 删除{{table_info.table_comment}}请求参数
	Delete{{table_info.class_name}}Req {
        Ids []int64 `form:"ids"`
    }
    Delete{{table_info.class_name}}Resp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 更新{{table_info.table_comment}}请求参数
    Update{{table_info.class_name}}Req {
{%- for column in table_info.columns %}
    {%- if column.proto_name is containing("create") %}
    {%- elif column.proto_name is containing("update") %}
    {%- elif column.is_nullable =="YES" %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},optional"` //{{column.column_comment}}
    {%- elif column.proto_name is containing("status") %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},default=2"` //{{column.column_comment}}
    {%- else %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}"` //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
    }
    Update{{table_info.class_name}}Resp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 更新{{table_info.table_comment}}状态请求参数
    Update{{table_info.class_name}}StatusReq {
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
        {{column.go_name}} []{{column.go_type}} `json:"{{column.java_name}}s"` //{{column.column_comment}}
    {%- elif column.proto_name is containing("status") %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},default=2"` //{{column.column_comment}}
    {%- else %}
    {%- endif %}
 {%- endfor %}

    }
    Update{{table_info.class_name}}StatusResp {
        Code    string `json:"code"`
        Message string `json:"message"`
    }

    // 查询{{table_info.table_comment}}详情请求参数
	Query{{table_info.class_name}}DetailReq {
		Id         int64  `form:"id"`
	}
	Query{{table_info.class_name}}DetailData {
{%- for column in table_info.columns %}
    {%- if column.go_type =="time.Time"  %}
    {{column.go_name}} string `json:"{{column.java_name}}"` //{{column.column_comment}}
    {%- else %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}"` //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
	}
	Query{{table_info.class_name}}DetailResp {
		Code     string              `json:"code"`
		Message  string              `json:"message"`
		Data     Query{{table_info.class_name}}DetailData `json:"data"`
	}
    // 分页查询{{table_info.table_comment}}列表请求参数
	Query{{table_info.class_name}}ListReq {
		Current         int64  `form:"current,default=1"` //第几页
		PageSize        int64  `form:"pageSize,default=20"` //每页的数量
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {%- elif column.proto_name is containing("create") %}
    {%- elif column.proto_name is containing("update") %}
    {%- elif column.proto_name is containing("remark") %}
    {%- elif column.proto_name is containing("sort") %}
    {%- elif column.proto_name is containing("status") %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},default=2"` //{{column.column_comment}}
    {%- else %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}},optional"` //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
	}
	Query{{table_info.class_name}}ListData {
{%- for column in table_info.columns %}
    {%- if column.go_type =="time.Time"  %}
    {{column.go_name}} string `json:"{{column.java_name}}"` //{{column.column_comment}}
    {%- else %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}"` //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
	}
	Query{{table_info.class_name}}ListResp {
		Code     string              `json:"code"`
		Message  string              `json:"message"`
		Current  int64               `json:"current,default=1"`
		Data     []*Query{{table_info.class_name}}ListData `json:"data"`
		PageSize int64               `json:"pageSize,default=20"`
		Success  bool                `json:"success"`
		Total    int64               `json:"total"`
	}
)

@server(
	group: demo/{{table_info.table_name}}
	prefix: /api/demo/{{table_info.object_name}}
)
service admin-api {
    // 添加{{table_info.table_comment}}
	@handler Add{{table_info.class_name}}
	post /add{{table_info.class_name}} (Add{{table_info.class_name}}Req) returns (Add{{table_info.class_name}}Resp)

	// 删除{{table_info.table_comment}}
	@handler Delete{{table_info.class_name}}
    get /delete{{table_info.class_name}} (Delete{{table_info.class_name}}Req) returns (Delete{{table_info.class_name}}Resp)

    // 更新{{table_info.table_comment}}
    @handler Update{{table_info.class_name}}
    post /update{{table_info.class_name}} (Update{{table_info.class_name}}Req) returns (Update{{table_info.class_name}}Resp)

    // 更新{{table_info.table_comment}}状态
    @handler Update{{table_info.class_name}}Status
    post /update{{table_info.class_name}}Status (Update{{table_info.class_name}}StatusReq) returns (Update{{table_info.class_name}}StatusResp)

    // 查询{{table_info.table_comment}}详情
	@handler Query{{table_info.class_name}}Detail
	get /query{{table_info.class_name}}Detail (Query{{table_info.class_name}}DetailReq) returns (Query{{table_info.class_name}}DetailResp)

    // 分页查询{{table_info.table_comment}}列表
	@handler Query{{table_info.class_name}}List
	get /query{{table_info.class_name}}List (Query{{table_info.class_name}}ListReq) returns (Query{{table_info.class_name}}ListResp)

}