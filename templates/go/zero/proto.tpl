syntax = "proto3";

package {{table_info.table_name}};

option go_package = "{{table_info.table_name}}";

import "api.proto";

// 添加{{table_info.table_comment}}请求参数
message Add{{table_info.class_name}}Req {

{%- for column in table_info.columns %}
{%- if column.column_key =="PRI"  %}
{%- elif column.proto_name is containing("create") %}
{%- elif column.proto_name is containing("update") %}
{%- else %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}[(api.body) = "{{column.java_name}}"]; //{{column.column_comment}}
{%- endif %}
{%- endfor %}

}
message Add{{table_info.class_name}}Resp {
  string msg = 1;
  api.Code code = 2;
}

// 删除{{table_info.table_comment}}请求参数
message Delete{{table_info.class_name}}Req {
  repeated int64 ids = 1[(api.body) = "ids"];
}

message Delete{{table_info.class_name}}Resp {
  string msg = 1;
  api.Code code = 2;
}

// 更新{{table_info.table_comment}}请求参数
message Update{{table_info.class_name}}Req {
{%- for column in table_info.columns %}
{%- if column.proto_name is containing("create") %}
{%- elif column.proto_name is containing("update") %}
{%- else %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}[(api.body) = "{{column.java_name}}"]; //{{column.column_comment}}
{%- endif %}
{%- endfor %}
}

message Update{{table_info.class_name}}Resp {
  string msg = 1;
  api.Code code = 2;
}

// 更新{{table_info.table_comment}}状态请求参数
message Update{{table_info.class_name}}StatusReq {
{%- for column in table_info.columns %}
{%- if column.column_key =="PRI"  %}
  repeated {{column.proto_type}} {{column.proto_name}} = {{loop.index}}[(api.body) = "{{column.java_name}}"]; //{{column.column_comment}}
{%- elif column.proto_name is containing("status") %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}[(api.body) = "{{column.java_name}}"]; //{{column.column_comment}}
{%- else %}
{%- endif %}
{%- endfor %}

}

message Update{{table_info.class_name}}StatusResp {
  string msg = 1;
  api.Code code = 2;
}

// 查询{{table_info.table_comment}}详情请求参数
message Query{{table_info.class_name}}DetailReq {
{%- for column in table_info.columns %}
{%- if column.column_key =="PRI"  %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}[(api.body) = "{{column.java_name}}"]; //{{column.column_comment}}
{%- endif %}
{%- endfor %}

}

message Query{{table_info.class_name}}DetailResp {
  string msg = 1;
  api.Code code = 2;
  int64 Total = 3;
  Query{{table_info.class_name}}DetailData data = 4;
}

message Query{{table_info.class_name}}DetailData {
{%- for column in table_info.columns %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}; //{{column.column_comment}}
{%- endfor %}
}

// 分页查询{{table_info.table_comment}}列表请求参数
message Query{{table_info.class_name}}ListReq {
{%- for column in table_info.columns %}
{%- if column.column_key =="PRI"  %}
{%- elif column.proto_name is containing("create") %}
{%- elif column.proto_name is containing("update") %}
{%- elif column.proto_name is containing("sort") %}
{%- elif column.proto_name is containing("remark") %}
{%- else %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}[(api.body) = "{{column.java_name}}"]; //{{column.column_comment}}
{%- endif %}
{%- endfor %}

  int64 page_num = 1[(api.body) = "pageNo"]; //第几页
  int64 page_size = 2[(api.body) = "pageSize"]; //每页的数量
}


message Query{{table_info.class_name}}ListResp {
  string msg = 1;
  api.Code code = 2;
  int64 Total = 3;
  repeated Query{{table_info.class_name}}ListData data = 4;
}

message Query{{table_info.class_name}}ListData {
{%- for column in table_info.columns %}
  {{column.proto_type}} {{column.proto_name}} = {{loop.index}}; //{{column.column_comment}}
{%- endfor %}
}

// {{table_info.table_comment}}服务
service {{table_info.class_name}}Handler {

  // 添加{{table_info.table_comment}}
  rpc Add{{table_info.class_name}}(Add{{table_info.class_name}}Req) returns(Add{{table_info.class_name}}Resp) {}
  // 删除{{table_info.table_comment}}
  rpc Delete{{table_info.class_name}}(Delete{{table_info.class_name}}Req) returns(Delete{{table_info.class_name}}Resp) {}
  // 更新{{table_info.table_comment}}
  rpc Update{{table_info.class_name}}(Update{{table_info.class_name}}Req) returns(Update{{table_info.class_name}}Resp) {}
  // 更新{{table_info.table_comment}}状态
  rpc Update{{table_info.class_name}}Status(Update{{table_info.class_name}}StatusReq) returns(Update{{table_info.class_name}}StatusResp) {}
  // 查询{{table_info.table_comment}}详情
  rpc Query{{table_info.class_name}}Detail(Query{{table_info.class_name}}DetailReq) returns(Query{{table_info.class_name}}DetailResp) {}
  // 分页查询{{table_info.table_comment}}列表
  rpc Query{{table_info.class_name}}List(Query{{table_info.class_name}}ListReq) returns(Query{{table_info.class_name}}ListResp) {}

}
