package v1

/*
{{table_info.table_comment}}请求参数和响应
Author: {{author}}
Date: {{create_time}}
*/
import (
	"github.com/gogf/gf/v2/frame/g"
	"github.com/gogf/gf/v2/os/gtime"
)

// Add{{table_info.class_name}}Req 添加{{table_info.table_comment}}
type Add{{table_info.class_name}}Req struct {
	g.Meta `path:"/{{table_info.object_name}}/save{{table_info.class_name}}" tags:"{{table_info.table_comment}}操作" method:"post" summary:"添加{{table_info.table_comment}}"`
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {%- elif column.go_name is containing("create") %}
    {%- elif column.go_name is containing("update") %}
    {%- elif column.is_nullable =="YES" %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}} description:"{{column.column_comment}}"`
    {%- else %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}" description:"{{column.column_comment}}" v:"required#请输入{{column.java_name}}{{column.column_comment}}"`
    {%- endif %}
 {%- endfor %}

}
type Add{{table_info.class_name}}Res struct {
}

// Delete{{table_info.class_name}}Req 删除{{table_info.table_comment}}
type Delete{{table_info.class_name}}Req struct {
	g.Meta `path:"/{{table_info.object_name}}/delete{{table_info.class_name}}" tags:"{{table_info.table_comment}}操作" method:"post" summary:"删除{{table_info.table_comment}}"`
	Ids    []int64 `json:"ids" v:"required#请输入ids" dc:"主键"`
}
type Delete{{table_info.class_name}}Res struct {
}

// Update{{table_info.class_name}}Req 更新{{table_info.table_comment}}
type Update{{table_info.class_name}}Req struct {
	g.Meta `path:"/{{table_info.object_name}}/update{{table_info.class_name}}" tags:"{{table_info.table_comment}}操作" method:"post" summary:"更新{{table_info.table_comment}}"`
{%- for column in table_info.columns %}
    {%- if column.go_name is containing("create") %}
    {%- elif column.go_name is containing("update") %}
    {%- elif column.is_nullable =="YES" %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}} description:"{{column.column_comment}}"`
    {%- else %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}" description:"{{column.column_comment}}" v:"required#请输入{{column.java_name}}{{column.column_comment}}"`
    {%- endif %}
 {%- endfor %}
}
type Update{{table_info.class_name}}Res struct {
}

// Update{{table_info.class_name}}StatusReq 更新{{table_info.table_comment}}状态
type Update{{table_info.class_name}}StatusReq struct {
	g.Meta `path:"/{{table_info.object_name}}/update{{table_info.class_name}}Status" tags:"{{table_info.table_comment}}操作" method:"post" summary:"更新{{table_info.table_comment}}状态"`
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {{column.go_name}}s {{column.go_type}} `json:"{{column.java_name}}s" description:"{{column.column_comment}}" v:"required#请输入{{column.java_name}}{{column.column_comment}}"`
    {%- elif column.go_name is containing("status") or column.go_name is containing("Status")  %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}" description:"{{column.column_comment}}" v:"required#请输入{{column.java_name}}{{column.column_comment}}"`
    {%- else %}
    {%- endif %}
 {%- endfor %}


}
type Update{{table_info.class_name}}StatusRes struct {
}

// Query{{table_info.class_name}}DetailReq 查询{{table_info.table_comment}}详情
type Query{{table_info.class_name}}DetailReq struct {
	g.Meta   `path:"/{{table_info.object_name}}/query{{table_info.class_name}}Detail" tags:"{{table_info.table_comment}}操作" method:"post" summary:"查询{{table_info.table_comment}}详情"`
}
type Query{{table_info.class_name}}DetailRes struct {
	g.Meta   `mime:"application/json" example:"string"`
	Data     {{table_info.class_name}}Detail    `json:"data"`
	PageNum  int              `json:"pageNum"`
	PageSize int              `json:"pageSize"`
	Total    int              `json:"total"`
}

type {{table_info.class_name}}Detail struct {
{%- for column in table_info.columns %}
    {%- if column.go_type =="time.Time"  %}
    {{column.go_name}} gtime.Time `json:"{{column.java_name}}" description:"{{column.column_comment}}"`
    {%- else %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}" description:"{{column.column_comment}}"`
    {%- endif %}
 {%- endfor %}

}

// Query{{table_info.class_name}}ListReq 查询{{table_info.table_comment}}
type Query{{table_info.class_name}}ListReq struct {
	g.Meta   `path:"/{{table_info.object_name}}/query{{table_info.class_name}}List" tags:"{{table_info.table_comment}}操作" method:"post" summary:"查询{{table_info.table_comment}}列表"`
	PageNum  int `json:"pageNum" d:"1"  v:"min:0#分页号码错误"     dc:"分页号码，默认1"`
	PageSize int `json:"pageSize" d:"10" v:"max:50#分页数量最大50条" dc:"分页数量，最大50"`
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {%- elif column.go_name is containing("create") %}
    {%- elif column.go_name is containing("update") %}
    {%- elif column.go_name is containing("remark") %}
    {%- elif column.go_name is containing("sort") %}
    {%- elif column.go_name is containing("Sort") %}
    {%- else %}
        {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}" description:"{{column.column_comment}}"`
    {%- endif %}
 {%- endfor %}

}
type Query{{table_info.class_name}}ListRes struct {
	g.Meta   `mime:"application/json" example:"string"`
	List     []{{table_info.class_name}}List `json:"list"`
	PageNum  int              `json:"pageNum"`
	PageSize int              `json:"pageSize"`
	Total    int              `json:"total"`
}

type {{table_info.class_name}}List struct {
{%- for column in table_info.columns %}
    {%- if column.go_type =="time.Time"  %}
    {{column.go_name}} gtime.Time `json:"{{column.java_name}}" description:"{{column.column_comment}}"`
    {%- else %}
    {{column.go_name}} {{column.go_type}} `json:"{{column.java_name}}" description:"{{column.column_comment}}"`
    {%- endif %}
 {%- endfor %}


}

