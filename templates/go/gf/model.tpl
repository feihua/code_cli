package model

/*
Author: {{author}}
Date: {{create_time}}
*/

import (
	"github.com/gogf/gf/v2/os/gtime"
)

// Add{{table_info.class_name}}Input 添加{{table_info.table_comment}}参数
type Add{{table_info.class_name}}Input struct {
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {%- elif column.proto_name is containing("create") %}
    {%- elif column.proto_name is containing("update") %}
    {%- else %}
        {{column.go_name}} {{column.go_type}} //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}

}


// Add{{table_info.class_name}}Output 添加{{table_info.table_comment}}响应
type Add{{table_info.class_name}}Output struct {
}

// Delete{{table_info.class_name}}Input 删除{{table_info.table_comment}}参数
type Delete{{table_info.class_name}}Input struct {
	Ids []int `json:"ids"`
}

// Delete{{table_info.class_name}}Output 删除{{table_info.table_comment}}响应
type Delete{{table_info.class_name}}Output struct {
}

// Update{{table_info.class_name}}Input 更新{{table_info.table_comment}}参数
type Update{{table_info.class_name}}Input struct {
{%- for column in table_info.columns %}
    {%- if column.proto_name is containing("create") or column.proto_name is containing("update") %}
    {%- else %}
        {{column.go_name}} {{column.go_type}} //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}

// Update{{table_info.class_name}}Output 更新{{table_info.table_comment}}响应
type Update{{table_info.class_name}}Output struct {
}

// Update{{table_info.class_name}}StatusInput 更新{{table_info.table_comment}}状态参数
type Update{{table_info.class_name}}StatusInput struct {
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {{column.go_name}}s {{column.go_type}} //{{column.column_comment}}
    {%- elif column.go_name is containing("status") or column.go_name is containing("Status")  %}
    {{column.go_name}} {{column.go_type}} //{{column.column_comment}}
    {%- else %}
    {%- endif %}
 {%- endfor %}

}

// Update{{table_info.class_name}}StatusOutput 更新{{table_info.table_comment}}状态响应
type Update{{table_info.class_name}}StatusOutput struct {
}


// {{table_info.class_name}}DetailInput 查询{{table_info.table_comment}}详情参数
type Query{{table_info.class_name}}DetailInput struct {
	Id int `json:"id"`
}

// {{table_info.class_name}}DetailOutput 查询{{table_info.table_comment}}详情响应
type Query{{table_info.class_name}}DetailOutput struct {
	Record Query{{table_info.class_name}}DetailOutputItem `json:"record"`
}

 // Query{{table_info.class_name}}DetailOutputItem 查询{{table_info.table_comment}}响应
type Query{{table_info.class_name}}DetailOutputItem struct {
{%- for column in table_info.columns %}
    {%- if column.go_type =="time.Time"  %}
    {{column.go_name}} gtime.Time //{{column.column_comment}}
    {%- else %}
    {{column.go_name}} {{column.go_type}} //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
}


// Query{{table_info.class_name}}ListInput 查询{{table_info.table_comment}}列表参数
type Query{{table_info.class_name}}ListInput struct {
	PageNum  int `json:"pageNum"`
	PageSize int `json:"pageSize"`
{%- for column in table_info.columns %}
    {%- if column.column_key =="PRI"  %}
    {%- elif column.go_name is containing("create") %}
    {%- elif column.go_name is containing("update") %}
    {%- elif column.go_name is containing("remark") %}
    {%- elif column.go_name is containing("sort") %}
    {%- elif column.go_name is containing("Sort") %}
    {%- else %}
        {{column.go_name}} {{column.go_type}} //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
}

// Query{{table_info.class_name}}ListOutput 查询{{table_info.table_comment}}列表响应
type Query{{table_info.class_name}}ListOutput struct {
	List     []Query{{table_info.class_name}}ListOutputItem `json:"list"`
	PageNum  int                            `json:"pageNum"`
	PageSize int                            `json:"pageSize"`
	Total    int                            `json:"total"`
}

 // Query{{table_info.class_name}}ListOutputItem 查询{{table_info.table_comment}}响应
type Query{{table_info.class_name}}ListOutputItem struct {
{%- for column in table_info.columns %}
    {%- if column.go_type =="time.Time"  %}
    {{column.go_name}} gtime.Time //{{column.column_comment}}
    {%- else %}
    {{column.go_name}} {{column.go_type}} //{{column.column_comment}}
    {%- endif %}
 {%- endfor %}
}
