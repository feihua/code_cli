<template>
  <el-divider />
  <el-table :data="{{table_info.object_name}}List" table-layout="auto" @selection-change="handleSelectionChange" size="large">
    <el-table-column type="selection" width="55" />

  {%- for column in table_info.columns %}
    {%- if column.ts_name is containing("Status") %}
    <el-table-column label="{{column.column_comment}}" prop="{{column.ts_name}}" >
      <template #default="scope">
            <el-tag
              :type="scope.row.{{column.ts_name}} === 0 ? 'danger' : 'success'"
              disable-transitions
              size="large"
              effect="dark"
            >{ { scope.row.{{column.ts_name}} === 0 ? '禁用' : '启用' } }
            </el-tag
            >
      </template>
    </el-table-column>
    {%- elif column.ts_name is containing("status") %}
    <el-table-column label="{{column.column_comment}}" prop="{{column.ts_name}}" >
      <template #default="scope">
            <el-tag
              :type="scope.row.{{column.ts_name}} === 0 ? 'danger' : 'success'"
              disable-transitions
              size="large"
              effect="dark"
            >{ { scope.row.{{column.ts_name}} === 0 ? '禁用' : '启用' } }
            </el-tag
            >
      </template>
    </el-table-column>
    {%- elif column.ts_name is containing("Type") %}
    <el-table-column label="{{column.column_comment}}" prop="{{column.ts_name}}" >
      <template #default="scope">
            <el-tag
              :type="scope.row.{{column.ts_name}} === 0 ? 'danger' : 'success'"
              disable-transitions
              size="large"
              effect="dark"
            >{ { scope.row.{{column.ts_name}} === 0 ? '禁用' : '启用' } }
            </el-tag
            >
      </template>
    </el-table-column>
    {%- else %}
    <el-table-column label="{{column.column_comment}}" prop="{{column.ts_name}}" />
    {%- endif %}
  {%- endfor %}

    <el-table-column label="操作">
      <template #default="scope">
        <el-button type="primary" link @click="query{{table_info.class_name}}Detail(scope.row.id, false)" icon="Setting">详情</el-button>
        <el-button type="primary" link @click="query{{table_info.class_name}}Detail(scope.row.id, true)" icon="EditPen">编辑</el-button>
        <el-button type="danger" link @click="handleDelete(scope.$index, scope.row)" icon="Delete">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
  <el-pagination
    background
    style="margin-top: 12px; padding-bottom: 12px; padding-right: 12px"
    v-model:current-page="listParam.current"
    v-model:page-size="listParam.pageSize"
    :page-sizes="[10, 20, 30, 40]"
    layout="->,total, sizes, prev, pager, next, jumper"
    :total="listParam.total"
    @size-change="handleSizeChange"
    @current-change="handleCurrentChange" />
</template>

<script lang="ts" setup>
import type { {{table_info.class_name}}RecordVo } from '../data';
import type { IResponse } from '@/api/ajax';
import { remove{{table_info.class_name}} } from '../service';
import { onMounted, ref } from 'vue';
import { ElMessage, ElMessageBox } from 'element-plus';

import { use{{table_info.class_name}}Store } from '../store/{{table_info.object_name}}Store';
import { storeToRefs } from 'pinia';

const store = use{{table_info.class_name}}Store();

const { listParam, {{table_info.object_name}}List } = storeToRefs(store);
const { query{{table_info.class_name}}List, query{{table_info.class_name}}Detail } = store;

const value = ref(true);

const handleDelete = (index: number, row: {{table_info.class_name}}RecordVo) => {
  ElMessageBox.confirm('确定删除?', {
    confirmButtonText: '删除',
    cancelButtonText: '取消',
    type: 'warning',
  }).then(async () => {
    const res: IResponse = await remove{{table_info.class_name}}({ids:[row.id]});
    if (res.code === 0) {
      ElMessage.success(res.message);
      queryUserList(listParam.value);
    } else {
      ElMessage.error(res.message);
    }
  });
};

const handleSelectionChange = (recordVo: {{table_info.class_name}}RecordVo[]) => {
  // emit(
  //   'handleSelectMore',
  //   recordVo.map((value) => value.id),
  // );
};

const handleSizeChange = (val: number) => {
  query{{table_info.class_name}}List({ current: listParam.value.current, pageSize: val });
};

const handleCurrentChange = (val: number) => {
  query{{table_info.class_name}}List({ current: val, pageSize: listParam.value.pageSize });
};

onMounted(() => {
  query{{table_info.class_name}}List({ current: 1, pageSize: 10 });
});
</script>

<style scoped></style>
