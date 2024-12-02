<template>
  <el-button type="primary" icon="Plus" @click="visible = true">新建</el-button>
  <el-dialog v-model="visible" title="新建" style="width: 480px; border-radius: 10px">
    <el-form label-width="100px" :model="addParam" style="max-width: 380px" :rules="rules" status-icon ref="ruleFormRef">

    {%- for column in table_info.columns %}
    <el-form-item label="{{column.column_comment}}">
      {%- if column.column_key =="PRI"  %}
      {%- elif column.ts_name is containing("create") %}
      {%- elif column.ts_name is containing("update") %}
      {%- elif column.ts_name is containing("remark") %}
        <el-input v-model="addParam.{{table_info.class_name}}" :rows="2" type="textarea" 请输入{{column.column_comment}}/>
      {%- elif column.ts_name is containing("Status") %}
        <el-radio-group v-model="addParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {%- elif column.ts_name is containing("status") %}
        <el-radio-group v-model="addParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {%- elif column.ts_name is containing("Sort") %}
        <el-input-number v-model="addParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {%- elif column.ts_name is containing("sort") %}
        <el-input-number v-model="addParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {%- elif column.ts_name is containing("Type") %}
        <el-radio-group v-model="addParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {%- else %}
        <el-input v-model="addParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>

      {%- endif %}
      </el-form-item>
    {%- endfor %}

      <el-form-item>
        <el-button type="primary" @click="handleAdd(ruleFormRef)">保存</el-button>
        <el-button @click="visible = false">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue';
import { ElMessage, type FormInstance, type FormRules } from 'element-plus';
import { add{{table_info.class_name}} } from '../service';
import type { Add{{table_info.class_name}}Param } from '../data';
import { use{{table_info.class_name}}Store } from '../store/{{table_info.object_name}}Store';

const store = use{{table_info.class_name}}Store();

const { query{{table_info.class_name}}List } = store;
const visible = ref(false);

const ruleFormRef = ref<FormInstance>();

const addParam = reactive<Add{{table_info.class_name}}Param>({
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

const handleAdd = async (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  await formEl.validate(async (valid) => {
    if (valid) {
      const res = await add{{table_info.class_name}}(addParam);
      if (res.code == 0) {
        ElMessage.success(res.message);
        query{{table_info.class_name}}List({ current: 1, pageSize: 10 });
        visible.value = false;
        ruleFormRef.value?.resetFields();
      } else {
        ElMessage.error(res.message);
      }
    } else {
      ElMessage.error('数据不能为空');
    }
  });
};
</script>

<style scoped></style>
