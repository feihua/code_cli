pub fn get_react_service() -> &'static str {
    "import {axiosInstance, IResponse} from \"../../api/ajax\";
import { {{class_name}}ListParam, {{class_name}}Vo } from \"./data\";
import {message} from \"antd\";

/**
 * @description: {{table_comment}}数据列表
 * @params {param} UserListReq
 * @return {Promise}
 */
export const list{{class_name}} = (param: {{class_name}}ListParam): Promise<IResponse> => {
    return axiosInstance.post('api/{{table_name}}_list', param).then(res => res.data);
};

/**
 * @description: 添加{{table_comment}}数据
 * @params {param} AddParam
 * @return {Promise}
 */
export const add{{class_name}} = (param: {{class_name}}Vo): Promise<IResponse> => {
    return axiosInstance.post('api/{{table_name}}_save', param).then(res => res.data);
};

/**
 * @description: 更新{{table_comment}}数据
 * @params {user} UpdateParam
 * @return {Promise}
 */
export const update{{class_name}} = (param: {{class_name}}Vo): Promise<IResponse> => {
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
    resp.code === 0 ? message.success(resp.msg) : message.error(resp.msg);
    return resp.code === 0
};

"
}