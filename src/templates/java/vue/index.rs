pub fn get_vue_index() -> &'static str {
    "
<template>

  <div style=\";background-color: white\">
    <AddForm @handleQuery=\"handleQueryWithPageParam\" ref=\"addChildrenRef\"/>
    <ListTable :tableData=\"tableData\" @handleEditView=\"handleEditView\" @handleQuery=\"handleQueryWithPageParam\"
               @handleSelectMore=\"handleSelectMore\"/>
    <UpdateForm v-model=\"dialogUpdateFormVisible\" @handleQuery=\"handleQuery\" @handleEdit=\"dialogUpdateFormVisible = false\" :record=\"recordVo\"/>
  </div>

</template>

<script lang=\"ts\" setup>
import {onMounted, ref} from 'vue'
import {list{{class_name}}} from \"@/views/{{table_name}}/service\";
import type {IResponse} from \"@/api/ajax\";
import type {Search{{class_name}}Param, {{class_name}}ListParam, {{class_name}}Vo} from \"@/views/{{table_name}}/data.d\";
import AddForm from \"@/views/{{table_name}}/components/AddForm.vue\";
import UpdateForm from \"@/views/{{table_name}}/components/UpdateForm.vue\";
import ListTable from \"@/views/{{table_name}}/components/ListTable.vue\";

const dialogUpdateFormVisible = ref(false)
const childrenRef = ref();
const addChildrenRef = ref();

const tableData = ref<IResponse>({code: 0, data: [], msg: \"\"})
const searchParam = ref<Search{{class_name}}Param>({})

const currentPage = ref(1)
const pageSize = ref(10)

const recordVo = ref<{{class_name}}Vo>()

const handleQuery = async (data: {{class_name}}ListParam) => {
  dialogUpdateFormVisible.value = false
  searchParam.value = {...data}
  let res: IResponse = await list{{class_name}}({...data, ...searchParam.value, current: currentPage.value, pageSize: pageSize.value})
  tableData.value = {...res}
}

const handleQueryWithPageParam = async (data: {{class_name}}ListParam) => {
  currentPage.value = data.current || 1
  pageSize.value = data.pageSize || 10
  await handleQuery(data)
}

const handleEditView = (row: {{class_name}}Vo) => {
  recordVo.value = row
  dialogUpdateFormVisible.value = true
}

const handleSelectMore = (ids: number[]) => {
  addChildrenRef.value.handleReceiveDeleteParam(ids)
}


onMounted(async () => {
  await handleQuery({current: currentPage.value, pageSize: pageSize.value})
})


</script>

<style lang=\"less\" scoped>

</style>
"
}