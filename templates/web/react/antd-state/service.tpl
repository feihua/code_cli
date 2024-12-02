import type { IResponse } from '@/api/ajax'
import { axiosInstance } from '@/api/ajax'
import { List{{table_info.class_name}}Param, {{table_info.class_name}}Vo } from './data';

/**
 * @description: 添加{{table_info.table_comment}}
 * @params {record} {{table_info.class_name}}Vo
 * @return {Promise}
 */
export const add{{table_info.class_name}} = async (params: {{table_info.class_name}}Vo): Promise<IResponse> => {
  const res = await axiosInstance.post('/api/demo/{{table_info.object_name}}/add{{table_info.class_name}}', params);
  return res.data;
};

/**
 * @description: 删除{{table_info.table_comment}}
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{table_info.class_name}} = async (ids: number[]): Promise<IResponse> => {
  const res = await axiosInstance.get('/api/demo/{{table_info.object_name}}/delete{{table_info.class_name}}?ids=[' + ids + ']');
  return res.data;
};

/**
 * @description: 更新{{table_info.table_comment}}
 * @params {record} {{table_info.class_name}}Vo
 * @return {Promise}
 */
export const update{{table_info.class_name}} = async (params: {{table_info.class_name}}Vo): Promise<IResponse> => {
  const res = await axiosInstance.post('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}', params);
  return res.data;
};

/**
 * @description: 批量更新{{table_info.table_comment}}状态
 @params {ids} number[]
 @params { {{table_info.object_name}}Status} number
 * @return {Promise}
 */
export const update{{table_info.class_name}}Status = async (params: { ids: number[]; {{table_info.object_name}}Status: number }): Promise<IResponse> => {
  const res = await axiosInstance.post('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}Status', params);
  return res.data;
};

/**
 * @description: 查询{{table_info.table_comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{table_info.class_name}}Detail = async (id: number): Promise<IResponse> => {
  const res = await axiosInstance.get('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}Detail?id=' + id);
  return res.data;
};

/**
 * @description: 分页查询{{table_info.table_comment}}列表
 * @params {params} List{{table_info.class_name}}Param
 * @return {Promise}
 */
export const query{{table_info.class_name}}List1 = async (params: List{{table_info.class_name}}Param): Promise<IResponse> => {
  const res = await axiosInstance.get('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}List', { params });
  return res.data;
};
