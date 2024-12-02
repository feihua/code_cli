<template>
  <el-space direction="horizontal" size="large" style="margin-left: 20px;margin-top: 20px">
    <el-button type="primary" icon="Plus" @click="dialogFormVisible = true">新建</el-button>
    <el-button type="danger" icon="Delete" :disabled="btnDisabled" @click="handleDeleteMore">批量删除</el-button>
    <el-form :inline="true" :model="searchParam" class="demo-form-inline" style="height: 32px;margin-left: 60px">

    {%- for column in table_info.columns %}
    <el-form-item label="{{column.column_comment}}">
      {% if column.column_key =="PRI"  %}
      {% elif column.ts_name is containing("create") %}
      {% elif column.ts_name is containing("update") %}
      {% elif column.ts_name is containing("remark") %}
      {% elif column.ts_name is containing("Status") %}
        <el-select v-model="searchParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      {% elif column.ts_name is containing("status") %}
        <el-select v-model="searchParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      {% elif column.ts_name is containing("Sort") %}
      {% elif column.ts_name is containing("sort") %}
      {% elif column.ts_name is containing("Type") %}
        <el-select v-model="searchParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      {% else %}
        <el-input v-model="searchParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>

      {% endif %}
      </el-form-item>
    {%- endfor %}

     <el-form-item>
        <el-button type="primary" @click="handleQuery" icon="Search" style="width: 120px">查询</el-button>
        <el-button @click="handleQueryReset" style="width: 100px">重置</el-button>
      </el-form-item>
    </el-form>
  </el-space>

  <el-dialog v-model="dialogFormVisible" title="新建" style="width: 480px;border-radius: 10px">
    <el-form
        label-width="100px"
        :model="addParam"
        style="max-width: 380px"
        :rules="rules"
        status-icon
        ref="ruleFormRef"
    >

    {%- for column in table_info.columns %}
    <el-form-item label="{{column.column_comment}}">
      {% if column.column_key =="PRI"  %}
      {% elif column.ts_name is containing("create") %}
      {% elif column.ts_name is containing("update") %}
      {% elif column.ts_name is containing("remark") %}
        <el-input v-model="addParam.{{table_info.class_name}}" :rows="2" type="textarea" 请输入备注/>
      {% elif column.ts_name is containing("Status") %}
        <el-select v-model="addParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      {% elif column.ts_name is containing("status") %}
        <el-select v-model="addParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      {% elif column.ts_name is containing("Sort") %}
        <el-input-number v-model="addParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {% elif column.ts_name is containing("sort") %}
        <el-input-number v-model="addParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>
      {% elif column.ts_name is containing("Type") %}
        <el-select v-model="addParam.{{table_info.class_name}}" placeholder="请选择状态">
          <el-option label="启用" value="1"/>
          <el-option label="禁用" value="0"/>
        </el-select>
      {% else %}
        <el-input v-model="addParam.{{table_info.class_name}}" placeholder="请输入{{column.column_comment}}"/>

      {% endif %}
      </el-form-item>
    {%- endfor %}

      <el-form-item>
        <el-button type="primary" @click="handleAdd(ruleFormRef)">保存</el-button>
        <el-button @click="dialogFormVisible = false">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang="ts" setup>

import {reactive, ref} from "vue";
import { type FormRules, type FormInstance, ElMessage, ElMessageBox } from 'element-plus'
import type {IResponse} from "@/api/ajax";
import {add{{table_info.class_name}}, remove{{table_info.class_name}} } from "../service";
import type {Add{{table_info.class_name}}Param, Search{{table_info.class_name}}Param} from "../data";

const dialogFormVisible = ref(false)

const btnDisabled = ref<boolean>(true)
const {{table_info.object_name}}Ids = ref<number[]>([])

const ruleFormRef = ref<FormInstance>()

const addParam = reactive<Add{{table_info.class_name}}Param>({
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

})

const searchParam = reactive<Search{{table_info.class_name}}Param>({})

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

const emit = defineEmits(['handleQuery'])

const handleAdd = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate(async (valid, fields) => {
    if (valid) {
      const addResult: IResponse = await add{{table_info.class_name}}(addParam)
      if (addResult.code === 0) {
        dialogFormVisible.value = false
        formEl.resetFields()
        emit("handleQuery", {current: 1, pageSize: 10});
      }
      addResult.code === 0 ? ElMessage.success(addResult.msg) : ElMessage.error(addResult.msg)
    } else {
      ElMessage.error("数据不能为空")
    }
  })
}


const handleQuery = async () => {
  emit("handleQuery", searchParam);
}

const handleQueryReset = async () => {
  {{range .TableColumn}}
  searchParam.{{table_info.class_name}} = undefined
  {{end}}
  emit("handleQuery", {current: 1, pageSize: 10, ...searchParam});
}

const handleReceiveDeleteParam = async (ids: number[]) => {
  btnDisabled.value = ids.length <= 0;
  {{table_info.object_name}}Ids.value = ids
}

const handleDeleteMore = () => {
  ElMessageBox.confirm(
      '确定删除记录不?',
      {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    const res: IResponse = await remove{{table_info.class_name}}({{table_info.object_name}}Ids.value)
    if (res.code == 0) {
      emit("handleQuery", {current: 1, pageSize: 10});
    }
    ElMessage({
      type: res.code === 0 ? 'success' : "error",
      message: res.message,
    })
  })

}

defineExpose({
  handleReceiveDeleteParam
})

</script>

<style scoped>

</style>