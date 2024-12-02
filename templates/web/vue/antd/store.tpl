import {ref} from 'vue'
import {defineStore} from 'pinia'
import type {List{{table_info.class_name}}Param, {{table_info.class_name}}RecordVo} from "../data";
import {query{{table_info.class_name}}List1} from "../service";

export const use{{table_info.class_name}}Store = defineStore('{{table_info.object_name}}', () => {
    const listParam = ref<List{{table_info.class_name}}Param>({
        current: 1,
        pageSize: 10,
      });
    const {{table_info.object_name}}List = ref<{{table_info.class_name}}RecordVo[]>([])

    function query{{table_info.class_name}}List(params: List{{table_info.class_name}}Param) {
        delete params.total;
        listParam.value = params;
        query{{table_info.class_name}}List1(params).then(res => {
            {{table_info.object_name}}List.value = res.data
            listParam.value.total = res.total || 0;
        })

    }


    return {listParam, {{table_info.object_name}}List, query{{table_info.class_name}}List}
})
