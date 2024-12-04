<template>

  <div style=";background-color: white">
    <AddModal @handleQuery="handleQueryWithPageParam" ref="addChildrenRef"/>
    <ListTable :tableData="tableData" @handleEditView="handleEditView" @handleDetailView="handleDetailView" @handleQuery="handleQueryWithPageParam"
               @handleSelectMore="handleSelectMore"/>
    <UpdateModal v-model="dialogUpdateModalVisible" @handleQuery="handleQuery" @handleEdit="dialogUpdateModalVisible = false"
               ref="updateChildrenRef"/>
    <DetailModal v-model="detailFormVisible" ref="childrenRef" @handleEdit="detailFormVisible = false"/>
  </div>

</template>

<script lang="ts" setup>
import {onMounted, ref} from 'vue'
import {query{{table_info.class_name}}List} from "./service";
import type {IResponse} from "@/api/ajax";
import type {Search{{table_info.class_name}}Param, List{{table_info.class_name}}Param, {{table_info.class_name}}RecordVo} from "./data.d";
import AddModal from "./components/AddModal.vue";
import UpdateModal from "./components/UpdateModal.vue";
import ListTable from "./components/ListTable.vue";
import DetailModal from "./components/DetailModal.vue";

const dialogUpdateModalVisible = ref(false)
const detailFormVisible = ref(false)
const childrenRef = ref();
const addChildrenRef = ref();
const updateChildrenRef = ref();

const tableData = ref<IResponse>({code: 0, data: [], msg: ""})
const searchParam = ref<Search{{table_info.class_name}}Param>({})

const currentPage = ref(1)
const pageSize = ref(10)

const recordVo = ref<{{table_info.class_name}}RecordVo>({
{%- for column in table_info.columns %}
  {%- if column.ts_type == "string"  %}
  {{column.ts_name}}: '',
  {%- else %}
  {{column.ts_name}}: 0,
  {%- endif %}
{%- endfor %}

})

const handleQuery = async (data: List{{table_info.class_name}}Param) => {
  dialogUpdateModalVisible.value = false
  detailFormVisible.value = false
  searchParam.value = {...data}
  const res: IResponse = await query{{table_info.class_name}}List({...data, ...searchParam.value, current: currentPage.value, pageSize: pageSize.value})
  tableData.value = {...res}
}

const handleQueryWithPageParam = async (data: List{{table_info.class_name}}Param) => {
  currentPage.value = data.current || 1
  pageSize.value = data.pageSize || 10
  await handleQuery(data)
}

const handleEditView = (row: {{table_info.class_name}}RecordVo) => {
  recordVo.value = row
  dialogUpdateModalVisible.value = true
  updateChildrenRef.value.query{{table_info.class_name}}Info(row.id)
}

const handleDetailView = (row: {{table_info.class_name}}RecordVo) => {
  recordVo.value = row
  detailFormVisible.value = true
  childrenRef.value.query{{table_info.class_name}}Info(row.id)
}

const handleSelectMore = (ids: number[]) => {
  addChildrenRef.value.handleReceiveDeleteParam(ids)
}


onMounted(async () => {
  await handleQuery({current: currentPage.value, pageSize: pageSize.value})
})


</script>

<style scoped>

</style>
