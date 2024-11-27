<template>
  <div>
    <a-modal
        v-model:open="updateVisible"
        title="编辑"
        ok-text="保存"
        cancel-text="取消"
        @ok="onOk"
        width="480px"
        style="padding-top: 15px"
    >
      <a-form ref="formRef" :model="formState" name="form_in_modal" :label-col="{ span: 7 }"
            :wrapper-col="{ span: 13 }">
      {{- range .TableColumn}}
      {{- if isContain .JavaName "create"}}
         {{- else if isContain .JavaName "update"}}
         {{- else if isContain .JavaName "id"}}
         {{- else if isContain .JavaName "Sort"}}
      <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
          <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px" placeholder="请选择{{.ColumnComment}}"/>
       </a-form-item>
      {{- else if isContain .JavaName "sort"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
          <a-input-number v-model:value="formState.{{.JavaName}}" style="width: 234px" placeholder="请选择{{.ColumnComment}}"/>
    </a-form-item>
      {{- else if isContain .JavaName "status"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
      <a-radio-group v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}">
          <a-radio :value="1">是</a-radio>
          <a-radio :value="0">否</a-radio>
      </a-radio-group>
    </a-form-item>
      {{- else if isContain .JavaName "Status"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
      <a-radio-group v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}">
          <a-radio :value="1">是</a-radio>
          <a-radio :value="0">否</a-radio>
      </a-radio-group>
    </a-form-item>
      {{- else if isContain .JavaName "Type"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
      <a-radio-group v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}">
          <a-radio :value="1">正常</a-radio>
          <a-radio :value="0">禁用</a-radio>
      </a-radio-group>
    </a-form-item>
      {{- else if isContain .JavaName "remark"}}
    <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
          <a-textarea v-model:value="formState.{{.JavaName}}" allow-clear  placeholder="请选择{{.ColumnComment}}"/>
    </a-form-item>
      {{- else}}
      <a-form-item name="{{.JavaName}}"label="{{.ColumnComment}}" :rules="[{ required: true, message: '请输入{{.ColumnComment}}' }]">
          <a-input v-model:value="formState.{{.JavaName}}" placeholder="请选择{{.ColumnComment}}"/>
      </a-form-item>{{- end}}{{- end}}
    </a-form>
    </a-modal>
  </div>
</template>
<script lang="ts" setup>
import {ref} from 'vue';
import {type FormInstance, message} from 'ant-design-vue';

import {use{{.JavaName}}Store} from "../store/{{.LowerJavaName}}Store";
import type {Update{{.JavaName}}Param} from "../data";
import {query{{.JavaName}}Detail, update{{.JavaName}}} from "../service";
import type {IResponse} from "@/utils/ajax";
import {storeToRefs} from "pinia";

const store = use{{.JavaName}}Store()
const {listParam} = storeToRefs(store)
const {query{{.JavaName}}List} = store


const formRef = ref<FormInstance>();
const updateVisible = ref(false);
const formState = ref<Update{{.JavaName}}Param>({
  {{- range .TableColumn}}
  {{- if isContain .JavaName "create"}}
  {{- else if isContain .JavaName "update"}}
  {{- else}}
  {{if eq .TsType "string"}}{{.JavaName}}: '',{{else}}{{.JavaName}}: 0,{{end}}
  {{- end}}
  {{- end}}

});

const onOk = () => {

  formRef.value?.validateFields()
      .then(async () => {
        const res = await update{{.JavaName}}(formState.value);
        if (res.code == 0) {
          message.success(res.message);
          query{{.JavaName}}List(listParam.value);
          updateVisible.value = false;
          formRef.value?.resetFields();
        } else {
          message.error(res.message);
        }
      })
      .catch(info => {
        message.error(info);
      });
};

const handleVisible = async (id: number, open: boolean) => {
  updateVisible.value = open
  const res: IResponse = await query{{.JavaName}}Detail(id)
  formState.value = res.data
}

defineExpose({
  handleVisible
})
</script>
<style scoped>

</style>
