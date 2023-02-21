pub fn get_vue_service() -> &'static str {
    "
    import type {IResponse} from \"@/api/ajax\";
import type {Add{{class_name}}Param, Update{{class_name}}Param, {{class_name}}ListParam} from \"@/views/{{table_name}}/data\";
import {axiosInstance} from \"@/api/ajax\";

/**
 * @description: {{table_comment}}数据列表
 * @params {param} ListParam
 * @return {Promise}
 */
export const list{{class_name}} = (param: {{class_name}}ListParam): Promise<IResponse> => {
    console.log(param)
    return axiosInstance.post('api/{{table_name}}_list', param).then(res => res.data);
};

/**
 * @description: 添加{{table_comment}}数据
 * @params {param} AddParam
 * @return {Promise}
 */
export const add{{class_name}} = (param: Add{{class_name}}Param): Promise<IResponse> => {
    return axiosInstance.post('api/{{table_name}}_save', param).then(res => res.data);
};

/**
 * @description: 更新{{table_comment}}数据
 * @params {param} UpdateParam
 * @return {Promise}
 */
export const update{{class_name}} = (param: Update{{class_name}}Param): Promise<IResponse> => {
    return axiosInstance.post('api/{{table_name}}_update', param).then(res => res.data);
};

/**
 * @description: 删除{{table_comment}}数据
 * @params {ids} number[]
 * @return {Promise}
 */
export const remove{{class_name}} = (ids: Number[]): Promise<IResponse> => {
    return axiosInstance.post('api/{{table_name}}_delete', {ids: ids}).then(res => res.data);
};


/**
 * 统一处理
 * @param resp
 */
export const handleResp = (resp: IResponse): boolean => {
    resp.code === 0 ? ElMessage.success(resp.msg) : ElMessage.error(resp.msg);
    return resp.code === 0
};
"
}