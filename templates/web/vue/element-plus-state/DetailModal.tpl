<template>
  <el-dialog :model-value="detailVisible" title="详情" style="width: 620px; border-radius: 6px" destroy-on-close @close="closeDetail">
    <el-descriptions column="2" style="padding-left: 50px; padding-top: 20px; padding-bottom: 50px">
{%- for column in table_info.columns %}
  <el-descriptions-item label="{{column.column_comment}}">{ {detailRecordVo.{{table_info.ts_name}} } }</el-descriptions-item>
{%- endfor %}

    </el-descriptions>
  </el-dialog>
</template>

<script lang="ts" setup>
import { use{{table_info.class_name}}Store } from '../store/{{table_info.object_name}}Store';
import { storeToRefs } from 'pinia';

const store = use{{table_info.class_name}}Store();
const { detailRecordVo, detailVisible } = storeToRefs(store);
const { closeDetail } = store;
</script>

<style scoped></style>
