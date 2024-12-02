<template>
  <div>
    <a-button type="primary" @click="visible = true" style="width: 82px;">
      <template #icon>
        <PlusOutlined/>
      </template>
      新建
    </a-button>
    <a-modal
        v-model:open="visible"
        title="新建"
        ok-text="保存"
        cancel-text="取消"
        @ok="onOk"
        width="480px"
        style="padding-top: 15px"
    >
      <a-form ref="formRef" :model="formState" name="form_in_modal" :label-col="{ span: 7 }" :wrapper-col="{ span: 13 }">
      {%- for column in table_info.columns %}
        {% if column.column_key =="PRI"  %}
        {% elif column.ts_name is containing("create") %}
        {% elif column.ts_name is containing("update") %}
        {% elif column.ts_name is containing("remark") %}
        <a-form-item
            name="{{column.ts_name}}"
            label="{{column.column_comment}}"
            :rules="[{ required: true, message: '请输入{{column.column_comment}}' }]"
        >
            <a-textarea v-model:value="formState.{{column.ts_name}}" allow-clear placeholder="请选择{{column.column_comment}}"/>
       </a-form-item>
        {% elif column.ts_name is containing("Status") %}
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
        {% elif column.ts_name is containing("status") %}
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
        {% elif column.ts_name is containing("Sort") %}
        <a-form-item
            name="{{column.ts_name}}"
            label="{{column.column_comment}}"
            :rules="[{ required: true, message: '请输入{{column.column_comment}}' }]"
        >
            <a-input-number v-model:value="formState.{{column.ts_name}}" style="width: 234px" placeholder="请选择{{column.column_comment}}"/>
        </a-form-item>
        {% elif column.ts_name is containing("sort") %}
        <a-form-item
            name="{{column.ts_name}}"
            label="{{column.column_comment}}"
            :rules="[{ required: true, message: '请输入{{column.column_comment}}' }]"
        >
            <a-input-number v-model:value="formState.{{column.ts_name}}" style="width: 234px" placeholder="请选择{{column.column_comment}}"/>
        </a-form-item>
        {% elif column.ts_name is containing("Type") %}
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
        {% else %}
        <a-form-item
            name="{{column.ts_name}}"
            label="{{column.column_comment}}"
            :rules="[{ required: true, message: '请输入{{column.column_comment}}' }]"
        >
            <a-input v-model:value="formState.{{column.ts_name}}" placeholder="请选择{{column.column_comment}}"/>
        </a-form-item>
        {% endif %}
      {%- endfor %}

      </a-form>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import {reactive, ref} from 'vue';
import {type FormInstance, message} from 'ant-design-vue';

import {PlusOutlined} from "@ant-design/icons-vue"
import {use{{table_info.class_name}}Store} from "../store/{{table_info.object_name}}Store";
import type {Add{{table_info.class_name}}Param} from "../data";
import {add{{table_info.class_name}}} from "../service";

const store = use{{table_info.class_name}}Store()

const {query{{table_info.class_name}}List} = store


const formRef = ref<FormInstance>();
const visible = ref(false);
const formState = reactive<Add{{table_info.class_name}}Param>({
{%- for column in table_info.columns %}
  {% if column.column_key =="PRI"  %}
  {% elif column.ts_name is containing("create") %}
  {% elif column.ts_name is containing("update") %}
  {% else %}
    {% if column.ts_type == "string"  %}
    {{column.ts_name}}: '',
    {% else %}
    {{column.ts_name}}: 0,
    {% endif %}
  {% endif %}
{%- endfor %}

});

const onOk = () => {
  formRef.value?.validateFields()
      .then(async () => {
        const res = await add{{table_info.class_name}}(formState);
        if (res.code == 0) {
          message.success(res.message);
          query{{table_info.class_name}}List({current:1, pageSize: 10});
          visible.value = false;
          formRef.value?.resetFields();
        } else {
          message.error(res.message);
        }

      })
      .catch(info => {
        message.error(info);
      });
};
</script>
<style scoped>

</style>
