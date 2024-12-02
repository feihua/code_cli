<template>
  <el-dialog :model-value="detailFormVisible" title="详情" style="width: 880px;border-radius: 10px" destroy-on-close :close="handleViewClose">
      <el-descriptions title="{{table_info.table_comment}}详情">
      {{range .TableColumn}}<el-descriptions-item label="{{column.column_comment}}">{ {detailParam.{{table_info.class_name}} } }</el-descriptions-item>
      {{end}}
      </el-descriptions>
    <el-form
        label-width="100px"
        :model="detailParam"
        style="max-width: 380px"
        status-icon
    >
    <el-row :gutter="20">

    {%- for column in table_info.columns %}
    <el-col :span="6">
    <el-form-item label="{{column.column_comment}}">
      {%- if column.ts_name is containing("remark") %}
         <el-input v-model="detailParam.{{table_info.class_name}}" :rows="2" type="textarea" 请输入备注/>
      {%- elif column.ts_name is containing("Status") %}
        <el-radio-group v-model="detailParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {%- elif column.ts_name is containing("status") %}
        <el-radio-group v-model="detailParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {%- elif column.ts_name is containing("Sort") %}
        <el-input-number v-model="detailParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {%- elif column.ts_name is containing("sort") %}
        <el-input-number v-model="detailParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {%- elif column.ts_name is containing("Type") %}
        <el-radio-group v-model="detailParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-radio :label="1">启用</el-radio>
          <el-radio :label="0">禁用</el-radio>
        </el-radio-group>
      {%- else %}
        <el-input v-model="detailParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>

      {%- endif %}
      </el-form-item></el-col>
    {%- endfor %}

     </el-row>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {ref} from "vue";
import type {IResponse} from "@/api/ajax";
import {query{{table_info.class_name}}Detail} from "../service";
import type { {{table_info.class_name}}RecordVo} from "../data.d";

const detailFormVisible = ref(false)
const detailParam = ref<{{table_info.class_name}}RecordVo>({
{{range .TableColumn}}
  {{if eq .TsType "string"}}{{table_info.class_name}}: '',{{else}}{{table_info.class_name}}: 0,{{end}}{{end}}

})

const query{{table_info.class_name}}Info = async (id: number) => {
  const res: IResponse = await query{{table_info.class_name}}Detail(id)
  detailParam.value = res.data

}

const emit = defineEmits(['handleEdit'])

const handleViewClose = () => {
  emit("handleEdit");
}

defineExpose({
  query{{table_info.class_name}}Info
});

</script>

<style scoped>

</style>