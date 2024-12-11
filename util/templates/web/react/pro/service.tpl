import {request} from 'umi';
import type { {{table_info.class_name}}ListParams, {{table_info.class_name}}ListItem } from './data.d';

// 添加{{table_info.table_comment}}
export async function add{{table_info.class_name}}(params: {{table_info.class_name}}ListItem) {
  return request('/api/demo/{{table_info.object_name}}/add{{table_info.class_name}}', {
    method: 'POST',
    data: {
      ...params,
    },
  });
}

// 删除{{table_info.table_comment}}
export async function remove{{table_info.class_name}}(ids: number[]) {
  return request('/api/demo/{{table_info.object_name}}/delete{{table_info.class_name}}?ids=[' + ids + "]", {
    method: 'GET',
  });
}


// 更新{{table_info.table_comment}}
export async function update{{table_info.class_name}}(params: {{table_info.class_name}}ListItem) {
  return request('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}', {
    method: 'POST',
    data: {
      ...params,
    },
  });
}

// 批量更新{{table_info.table_comment}}状态
export async function update{{table_info.class_name}}Status(params: { {{table_info.object_name}}Ids: number[], {{table_info.object_name}}Status: number }) {
  return request('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}Status', {
    method: 'POST',
    data: {
      ...params,
    },

  });
}


// 查询{{table_info.table_comment}}详情
export async function query{{table_info.class_name}}Detail(id: number) {
  return request('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}Detail?id=' + id, {
    method: 'GET',
  });
}

// 分页查询{{table_info.table_comment}}列表
export async function query{{table_info.class_name}}List(params: {{table_info.class_name}}ListParams) {

  return request('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}List', {
    method: 'GET',
    params: {
      ...params,
    },
  });
}
