import { axiosInstance, IResponse } from '@/api/ajax.ts';
import { {{table_info.class_name}}Vo, {{table_info.class_name}}ListParam } from "./data";
import { message } from "antd";

/**
 * @description: 添加{{table_info.table_comment}}
 * @params {record} {{table_info.class_name}}Vo
 * @return {Promise}
 */
export const add{{table_info.class_name}} = (params: {{table_info.class_name}}Vo): Promise<IResponse> => {
    return axiosInstance.post('/api/demo/{{table_info.object_name}}/add{{table_info.class_name}}', params).then(res => res.data);
};

/**
 * @description: 删除{{table_info.table_comment}}
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{table_info.class_name}} = (ids: number[]): Promise<IResponse> => {
    return axiosInstance.get('/api/demo/{{table_info.object_name}}/delete{{table_info.class_name}}?ids=[' + ids + "]").then(res => res.data);
};


/**
 * @description: 更新{{table_info.table_comment}}
 * @params {record} {{table_info.class_name}}Vo
 * @return {Promise}
 */
export const update{{table_info.class_name}} = (params: {{table_info.class_name}}Vo): Promise<IResponse> => {
    return axiosInstance.post('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}', params).then(res => res.data);
};

/**
 * @description: 批量更新{{table_info.table_comment}}状态
 @params {ids} number[]
 @params { {{table_info.object_name}}Status} number
 * @return {Promise}
 */
export const update{{table_info.class_name}}Status = (params: { ids: number[], {{table_info.object_name}}Status: number }): Promise<IResponse> => {
    return axiosInstance.post('/api/demo/{{table_info.object_name}}/update{{table_info.class_name}}Status', params).then(res => res.data);
};

/**
 * @description: 查询{{table_info.table_comment}}详情
 * @params {id} number
 * @return {Promise}
 */
export const query{{table_info.class_name}}Detail = (id: number): Promise<IResponse> => {
    return axiosInstance.get('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}Detail?id=' + id).then(res => res.data);
};


/**
 * @description: 分页查询{{table_info.table_comment}}列表
 * @params {params} {{table_info.class_name}}ListParam
 * @return {Promise}
 */
export const query{{table_info.class_name}}List = (params: {{table_info.class_name}}ListParam): Promise<IResponse> => {
    return axiosInstance.get('/api/demo/{{table_info.object_name}}/query{{table_info.class_name}}List', {params}).then(res => res.data);
};


/**
 * 统一处理
 * @param resp
 */
export const handleResp = (resp: IResponse): boolean => {
    resp.code === 0 ? message.success(resp.msg) : message.error(resp.msg);
    return resp.code === 0
};