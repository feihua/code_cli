<template>
  <el-dialog :model-value="dialogUpdateFormVisible" title="更新" style="width: 480px;border-radius: 10px">
    <el-form
        label-width="100px"
        :model="updateParam"
        style="max-width: 380px"
        :rules="rules"
        ref="ruleFormRef"
    >

    {%- for column in table_info.columns %}

      {%- if column.column_key =="PRI"  %}
      {%- elif column.ts_name is containing("create") %}
      {%- elif column.ts_name is containing("update") %}
      {%- elif column.ts_name is containing("remark") %}
       <el-form-item label="{{column.column_comment}}">
        <el-input v-model="updateParam.{{table_info.class_name}}" :rows="2" type="textarea"请输入{{column.column_comment}}"/>
       </el-form-item>
      {%- elif column.ts_name is containing("Status") or column.ts_name is containing("status") or column.ts_name is containing("Type") %}
       <el-form-item label="{{column.column_comment}}">
        <el-radio-group v-model="addParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
       </el-form-item>
      {%- elif column.ts_name is containing("Sort") or column.ts_name is containing("sort") %}
       <el-form-item label="{{column.column_comment}}">
        <el-input-number v-model="updateParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
       </el-form-item>
      {%- else %}
       <el-form-item label="{{column.column_comment}}">
        <el-input v-model="updateParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
       </el-form-item>
      {%- endif %}

    {%- endfor %}

      <el-form-item>
        <el-button type="primary" @click="handleEdit(ruleFormRef)">保存</el-button>
        <el-button @click="handleEditViewClose">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import { onMounted, reactive, ref} from "vue";
import type {Update{{table_info.class_name}}Param} from "../data.d";
import { type FormRules, type FormInstance, ElMessage, ElMessageBox } from 'element-plus'
import type {IResponse} from "@/api/ajax";
import {update{{table_info.class_name}} } from "../service";
import {query{{table_info.class_name}}Detail} from "../service";

const ruleFormRef = ref<FormInstance>()
let updateParam = ref<Update{{table_info.class_name}}Param>({
{%- for column in table_info.columns %}
  {%- if column.ts_name is containing("create") or column.ts_name is containing("update") %}
  {%- else %}
    {%- if column.ts_type == "string"  %}
    {{column.ts_name}}: '',
    {%- else %}
    {{column.ts_name}}: 0,
    {%- endif %}
  {%- endif %}
{%- endfor %}

})

const dialogUpdateFormVisible = ref(false)


const rules = reactive<FormRules>({
{%- for column in table_info.columns %}
  {%- if column.column_key =="PRI"  %}
  {%- elif column.ts_name is containing("create") %}
  {%- elif column.ts_name is containing("update") %}
  {%- elif column.ts_name is containing("remark") %}
  {%- else %}
    {{table_info.class_name}}: [
        {required: true, message: '{{column.column_comment}}不能为空', trigger: 'blur'},
        // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
      ],
  {%- endif %}
{%- endfor %}

})

const emit = defineEmits(['handleQuery', 'handleEdit'])

const handleEditViewClose = () => {
  emit("handleEdit");
}

const handleEdit = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate(async (valid, fields) => {
    if (valid) {
      const updateResult: IResponse = await update{{table_info.class_name}}(updateParamVo.value)
      if (updateResult.code === 0) {
        dialogUpdateFormVisible.value = false
        formEl.resetFields()
        emit("handleQuery", {current: 1, pageSize: 10});
      }
      updateResult.code === 0 ? ElMessage.success(updateResult.message) : ElMessage.error(updateResult.message)
    } else {
      ElMessage.error("数据不能为空")
    }
  })
}

const query{{table_info.class_name}}Info = async (id: number) => {
  const res: IResponse = await query{{table_info.class_name}}Detail(id)
  updateParam.value = res.data

}

defineExpose({
  query{{table_info.class_name}}Info
});
</script>

<style scoped>

</style>