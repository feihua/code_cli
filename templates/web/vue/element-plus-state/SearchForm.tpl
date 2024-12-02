<template>
  <el-form :inline="true" :model="searchParam" class="demo-form-inline" style="height: 32px; margin-left: 20px" ref="formRef">
    {%- for column in table_info.columns %}
    <el-form-item label="{{column.column_comment}}">
      {% if column.column_key =="PRI"  %}
      {% elif column.ts_name is containing("create") %}
      {% elif column.ts_name is containing("update") %}
      {% elif column.ts_name is containing("sort") %}
      {% elif column.ts_name is containing("Sort") %}
      {% elif column.ts_name is containing("remark") %}
        <el-input v-model="searchParam.{{table_info.class_name}}" :rows="2" type="textarea" 请输入{{column.column_comment}}/>
      {% elif column.ts_name is containing("Status") %}
        <el-radio-group v-model="searchParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {% elif column.ts_name is containing("status") %}
        <el-radio-group v-model="searchParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {% elif column.ts_name is containing("Type") %}
        <el-radio-group v-model="searchParam.{{table_info.class_name}}" placeholder="请选择{{column.column_comment}}">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {% else %}
        <el-input v-model="searchParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>

      {% endif %}
      </el-form-item>
    {%- endfor %}
    
     <el-form-item>
        <el-button type="primary" @click="onFinish" icon="Search" style="width: 120px">查询</el-button>
        <el-button @click="resetFields" style="width: 100px">重置</el-button>
      </el-form-item>
  </el-form>
</template>
<script lang="ts" setup>
import { reactive, ref } from 'vue';

import { use{{table_info.class_name}}Store } from '../store/{{table_info.object_name}}Store';
import type { List{{table_info.class_name}}Param } from '../data';
import type { FormInstance } from 'element-plus';

const store = use{{table_info.class_name}}Store();
const { query{{table_info.class_name}}List } = store;
const formRef = ref<FormInstance>();

const searchParam = reactive<List{{table_info.class_name}}Param>({
  current: 1,
  pageSize: 10,
{%- for column in table_info.columns %}
  {% if column.column_key =="PRI"  %}
  {% elif column.ts_name is containing("create") %}
  {% elif column.ts_name is containing("update") %}
  {% elif column.ts_name is containing("remark") %}
  {% else %}
    {% if column.ts_type == "string"  %}
    {{column.ts_name}}: '',
    {% else %}
    {{column.ts_name}}: 0,
    {% endif %}
  {% endif %}
{%- endfor %}

});

const onFinish = () => {
  query{{table_info.class_name}}List(searchParam);
};

const resetFields = () => {
  formRef.value?.resetFields();
  query{{table_info.class_name}}List({ current: 1, pageSize: 10 });
};
</script>
