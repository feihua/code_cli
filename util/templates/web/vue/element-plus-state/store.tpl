import { ref } from 'vue';
import { defineStore } from 'pinia';
import type { List{{table_info.class_name}}Param, {{table_info.class_name}}RecordVo } from '../data';
import { query{{table_info.class_name}}Detail1, query{{table_info.class_name}}List1 } from '../service';

export const use{{table_info.class_name}}Store = defineStore('{{table_info.object_name}}', () => {
  const detailRecordVo = ref<{{table_info.class_name}}RecordVo>({
{%- for column in table_info.columns %}
  {%- if column.column_key =="PRI"  %}
  {%- elif column.ts_name is containing("create") %}
  {%- elif column.ts_name is containing("update") %}
  {%- else %}
    {%- if column.ts_type == "string"  %}
    {{column.ts_name}}: '',
    {%- else %}
    {{column.ts_name}}: 0,
    {%- endif %}
  {%- endif %}
{%- endfor %}

  });

  const updateVisible = ref<boolean>(false);
  const detailVisible = ref<boolean>(false);

  const listParam = ref<List{{table_info.class_name}}Param>({
    current: 1,
    pageSize: 10,
  });
  const {{table_info.object_name}}List = ref<{{table_info.class_name}}RecordVo[]>([]);

  function query{{table_info.class_name}}List(params: List{{table_info.class_name}}Param) {
    delete params.total;
    listParam.value = params;
    query{{table_info.class_name}}List1(params).then((res) => {
      {{table_info.object_name}}List.value = res.data;
      listParam.value.total = res.total || 0;
    });
  }

  function query{{table_info.class_name}}Detail(id: number, flag: boolean) {
    flag ? (updateVisible.value = true) : (detailVisible.value = true);
    query{{table_info.class_name}}Detail1(id).then((res) => {
      detailRecordVo.value = res.data;
    });
  }

  function closeDetail() {
    detailVisible.value = false;
  }

  function closeUpdate() {
    updateVisible.value = false;
  }

  return {
    listParam,
    detailRecordVo,
    updateVisible,
    detailVisible,
    {{table_info.object_name}}List,
    query{{table_info.class_name}}List,
    query{{table_info.class_name}}Detail,
    closeDetail,
    closeUpdate,
  };
});
