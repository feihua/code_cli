import type {IResponse} from "@/api/ajax";
import type {Add{{table_info.class_name}}Param, Update{{table_info.class_name}}Param, List{{table_info.class_name}}Param} from "./data";
import {axiosInstance} from "@/api/ajax";
import { ElMessage } from 'element-plus'

/**
 * @description: 添加{{table_info.table_comment}}
 * @params {params} Add{{table_info.class_name}}Param
 * @return {Promise}
 */
export const add{{table_info.class_name}} = async (params: Add{{table_info.class_name}}Param): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{table_info.object_name}}/add{{table_info.class_name}}', params).then(res => res.data);
};

/**
 * @description: 删除{{table_info.table_comment}}
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{table_info.class_name}} = async (ids: number[]): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{table_info.object_name}}/delete{{table_info.class_name}}?ids=[' + ids + "]").then(res => res.data);
};


/**
 * @description: 更新{{table_info.table_comment}}
 * @params {params} Update{{table_info.class_name}}Param
 * @return {Promise}
 */
export const update{{table_info.class_name}} = async (params: Update{{table_info.class_name}}Param): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}', params).then(res => res.data);
};

/**
 * @description: 批量更新{{table_info.table_comment}}状态
 @params {ids} number[]
 @params { {{table_info.object_name}}Status} number
 * @return {Promise}
 */
export const update{{table_info.class_name}}Status = async (params: { ids: number[], {{table_info.object_name}}Status: number }): Promise<IResponse> => {
  return axiosInstance.post('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}Status', params).then(res => res.data);
};

/**
 * @description: 查询{{table_info.table_comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{table_info.class_name}}Detail = async (id: number): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}Detail?id=' + id).then(res => res.data);
};


/**
 * @description: 分页查询{{table_info.table_comment}}列表
 * @params {params} List{{table_info.class_name}}Param
 * @return {Promise}
 */
export const query{{table_info.class_name}}List = async(params: List{{table_info.class_name}}Param): Promise<IResponse> => {
  return axiosInstance.get('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}List', {params}).then(res => res.data);
};


/**
 * 统一处理
 * @param resp
 */
export const handleResp = (resp: IResponse): boolean => {
  resp.code === 0 ? ElMessage.success(resp.msg) : ElMessage.error(resp.msg);
  return resp.code === 0
};