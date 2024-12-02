<template>
  <el-dialog :model-value="updateVisible" title="更新" style="width: 480px; border-radius: 10px" @close="closeUpdate" >
    <el-form label-width="100px" :model="detailRecordVo" style="max-width: 380px" :rules="rules" ref="ruleFormRef">
    
    {%- for column in table_info.columns %}
    <el-form-item label="{{column.column_comment}}">
      {% if column.column_key =="PRI"  %}
      {% elif column.ts_name is containing("create") %}
      {% elif column.ts_name is containing("update") %}
      {% elif column.ts_name is containing("remark") %}
        <el-input v-model="detailRecordVo.{{table_info.class_name}}" :rows="2" type="textarea" 请输入{{column.column_comment}}/>
      {% elif column.ts_name is containing("Status") %}
        <el-radio-group v-model="detailRecordVo.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {% elif column.ts_name is containing("status") %}
        <el-radio-group v-model="detailRecordVo.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {% elif column.ts_name is containing("Sort") %}
        <el-input-number v-model="detailRecordVo.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {% elif column.ts_name is containing("sort") %}
        <el-input-number v-model="detailRecordVo.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {% elif column.ts_name is containing("Type") %}
        <el-radio-group v-model="detailRecordVo.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {% else %}
        <el-input v-model="detailRecordVo.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>

      {% endif %}
      </el-form-item>
    {%- endfor %}

        <el-form-item>
          <el-button type="primary" @click="handleEdit(ruleFormRef)">保存</el-button>
          <el-button @click="closeUpdate">取消</el-button>
        </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>
import { reactive, ref } from 'vue';
import { ElMessage, type FormInstance, type FormRules } from 'element-plus';
import type { IResponse } from '@/api/ajax';
import { update{{table_info.class_name}} } from '../service';
import { use{{table_info.class_name}}Store } from '../store/{{table_info.object_name}}Store';
import { storeToRefs } from 'pinia';

const store = use{{table_info.class_name}}Store();

const { listParam, detailRecordVo, updateVisible } = storeToRefs(store);
const { closeUpdate, query{{table_info.class_name}}List } = store;

const ruleFormRef = ref<FormInstance>();

const rules = reactive<FormRules>({
{%- for column in table_info.columns %}
  {% if column.column_key =="PRI"  %}
  {% elif column.ts_name is containing("create") %}
  {% elif column.ts_name is containing("update") %}
  {% elif column.ts_name is containing("remark") %}
  {% else %}
    {{table_info.class_name}}: [
        {required: true, message: '{{column.column_comment}}不能为空', trigger: 'blur'},
        // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
      ],
  {% endif %}
{%- endfor %}
})

const handleEdit = async (formEl: FormInstance | undefined) => {
  if (!formEl) return;
  await formEl.validate(async (valid) => {
    if (valid) {
      const res: IResponse = await update{{table_info.class_name}}(detailRecordVo.value);
      if (res.code === 0) {
        ElMessage.success(res.message);
        formEl.resetFields();
        updateVisible.value = false;
        query{{table_info.class_name}}List(listParam.value);
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
