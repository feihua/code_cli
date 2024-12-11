<template>
  <a-form
      ref="formRef"
      :model="formState"
      name="horizontal_login"
      layout="inline"
      @finish="onFinish"
  >
        {%- for column in table_info.columns %}
          {%- if column.column_key =="PRI"  %}
          {%- elif column.ts_name is containing("create") %}
          {%- elif column.ts_name is containing("update") %}
          {%- elif column.ts_name is containing("remark") %}
          {%- elif column.ts_name is containing("Status") or column.ts_name is containing("status") or column.ts_name is containing("Type")%}
          <a-form-item
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              :rules="[{ required: true, message: '请输入{{column.column_comment}}' }]"
          >
              <a-radio-group v-model:value="formState.{{column.ts_name}}" placeholder="请选择{{column.column_comment}}">
                  <a-radio :value="1">是</a-radio>
                  <a-radio :value="0">否</a-radio>
              </a-radio-group>
          </a-form-item>
          {%- elif column.ts_name is containing("Sort") or column.ts_name is containing("sort") %}
          {%- else %}
          <a-form-item
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              :rules="[{ required: true, message: '请输入{{column.column_comment}}' }]"
          >
              <a-input v-model:value="formState.{{column.ts_name}}" placeholder="请选择{{column.column_comment}}"/>
          </a-form-item>
          {%- endif %}
        {%- endfor %}


    <a-form-item>
      <ASpace>
        <a-button type="primary" html-type="submit" style="width: 120px">
          <template #icon>
            <SearchOutlined/>
          </template>
          查询
        </a-button>
        <a-button style="margin: 0 8px;width: 100px" @click="resetFields">重置</a-button>
      </ASpace>
    </a-form-item>
  </a-form>
</template>
<script lang="ts" setup>
import {reactive, ref} from 'vue';
import type {FormInstance} from "ant-design-vue";

import {use{{table_info.class_name}}Store} from "../store/{{table_info.object_name}}Store";
import {SearchOutlined} from "@ant-design/icons-vue";
import type {Search{{table_info.class_name}}Param} from "../data";

const store = use{{table_info.class_name}}Store()
const {query{{table_info.class_name}}List} = store
const formRef = ref<FormInstance>();

const formState = reactive<Search{{table_info.class_name}}Param>({
{%- for column in table_info.columns %}
  {%- if column.column_key =="PRI"  %}
  {%- elif column.ts_name is containing("create") %}
  {%- elif column.ts_name is containing("update") %}
  {%- elif column.ts_name is containing("remark") %}
  {%- else %}
     {{column.ts_name}}: undefined,
  {%- endif %}
{%- endfor %}

});
const onFinish = (values: any) => {
  query{{table_info.class_name}}List({ ...values, current:1, pageSize: 10 })
};

const resetFields = () => {
  formRef.value?.resetFields();
  query{{table_info.class_name}}List({})
};

</script>

