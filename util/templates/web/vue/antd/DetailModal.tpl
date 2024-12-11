<template>
  <div>
    <a-modal
        v-model:open="detailVisible"
        title="{{table_info.table_comment}}详情"
        footer=""
        width="480px"
        style="padding-top: 15px"
    >
    <a-form ref="formRef" :model="formState" name="form_in_modal" :label-col="{ span: 7 }"
            :wrapper-col="{ span: 13 }">
        <a-row>
              {%- for column in table_info.columns %}
                <a-col :span="12">
                <a-form-item
                  name="{{table_info.class_name}}"
                  label="{{column.column_comment}}"
                >
                {%- if column.ts_name is containing("remark") %}
                   <a-textarea v-model:value="formState.{{table_info.class_name}}" :bordered="false"/>
                {%- elif column.ts_name is containing("Status") %}
                  <a-radio-group v-model:value="formState.{{table_info.class_name}}" :bordered="false" disabled>
                      <a-radio :value="1">是</a-radio>
                      <a-radio :value="0">否</a-radio>
                  </a-radio-group>
                {%- elif column.ts_name is containing("status") %}
                  <a-radio-group v-model:value="formState.{{table_info.class_name}}" :bordered="false" disabled>
                      <a-radio :value="1">是</a-radio>
                      <a-radio :value="0">否</a-radio>
                  </a-radio-group>
                {%- elif column.ts_name is containing("Sort") %}
                  <a-input-number v-model:value="formState.{{table_info.class_name}}" style="width: 234px" :bordered="false"/>
                {%- elif column.ts_name is containing("sort") %}
                   <a-input-number v-model:value="formState.{{table_info.class_name}}" style="width: 234px" :bordered="false"/>
                {%- elif column.ts_name is containing("Type") %}
                  <a-radio-group v-model:value="formState.{{table_info.class_name}}" :bordered="false" disabled>
                      <a-radio :value="1">是</a-radio>
                      <a-radio :value="0">否</a-radio>
                  </a-radio-group>
                {%- else %}
                  <a-input v-model:value="formState.{{table_info.class_name}}" :bordered="false"/>
                {%- endif %}
                </a-form-item>
                </a-col>
              {%- endfor %}
        </a-row>
    </a-form>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import {ref} from 'vue';
import {type FormInstance} from 'ant-design-vue';

import type { {{table_info.class_name}}RecordVo} from "../data";
import {query{{table_info.class_name}}Detail} from "../service";
import type {IResponse} from "@/utils/ajax";

const formRef = ref<FormInstance>();
const detailVisible = ref(false);
const formState = ref<{{table_info.class_name}}RecordVo>({
{%- for column in table_info.columns %}
    {%- if column.ts_type == "string"  %}
    {{column.ts_name}}: '',
    {%- else %}
    {{column.ts_name}}: 0,
    {%- endif %}
{%- endfor %}
});

const handleVisible = async (id: number, open: boolean) => {
  detailVisible.value = open
  const res: IResponse = await query{{table_info.class_name}}Detail(id)
  formState.value = res.data
}

defineExpose({
  handleVisible
})
</script>
<style scoped>

</style>
