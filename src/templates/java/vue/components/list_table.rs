pub fn get_vue_list() -> &'static str {
    "<template>
  <el-divider/>
  <el-table :data=\"props.tableData.data\" table-layout=\"auto\" @selection-change=\"handleSelectionChange\" size=\"large\">
    <el-table-column type=\"selection\" width=\"55\"/>
    {% for column in java_columns %}
    <el-table-column label=\"{{column.column_comment}}\" prop=\"{{column.db_name}}\"/>{% endfor %}
<!--    {% raw %}-->
<!--    <el-table-column label=\"状态\" prop=\"status_id\">-->
<!--      <template #default=\"scope\">-->
<!--        <el-tag-->
<!--            :type=\"scope.row.status_id === 0 ? 'danger' : 'success'\"-->
<!--            disable-transitions-->
<!--            size=\"large\"-->
<!--            effect=\"dark\"-->
<!--        >{{ scope.row.status_id === 0 ? '禁用' : '启用' }}-->
<!--        </el-tag-->
<!--        >-->
<!--      </template>-->
<!--    </el-table-column>-->
<!--    {% endraw %}-->
    <el-table-column label=\"操作\">
      <template #default=\"scope\">
        <el-button type=\"primary\" @click=\"handleEditView(scope.$index, scope.row)\" icon=\"EditPen\">编辑</el-button>
        <el-button type=\"danger\" @click=\"handleDelete(scope.$index, scope.row)\" icon=\"Delete\">删除</el-button>
      </template>
    </el-table-column>
  </el-table>
  <el-pagination
      background
      style=\"margin-top: 12px;padding-bottom: 12px;padding-right: 12px\"
      v-model:current-page=\"props.tableData.page_no\"
      v-model:page-size=\"pageSize\"
      :page-sizes=\"[10, 20, 30, 40]\"
      layout=\"->,total, sizes, prev, pager, next, jumper\"
      :total=\"props.tableData.total\"
      @size-change=\"handleSizeChange\"
      @current-change=\"handleCurrentChange\"
  />
</template>

<script lang=\"ts\" setup>

import type { {{class_name}}Vo} from \"@/views/{{table_name}}/data\";
import type {IResponse} from \"@/api/ajax\";
import {remove{{class_name}} } from \"@/views/{{table_name}}/service\";
import {ref} from \"vue\";

const props = defineProps<{
  tableData: IResponse
}>()


const currentPage = ref(1)
const pageSize = ref(10)


const emit = defineEmits(['handleQuery', 'handleEditView', 'handleSelectMore'])

const handleEditView = (index: number, row: {{class_name}}Vo) => {
  emit(\"handleEditView\", row);
}

const handleDelete = (index: number, row: {{class_name}}Vo) => {
  ElMessageBox.confirm(
      // '确定删除用户' + row.real_name + '?',
      '确定删除?',
      {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    let res: IResponse = await remove{{class_name}}([row.id])
    if (res.code == 0) {
      emit(\"handleQuery\", {current: currentPage.value, pageSize: pageSize.value});
    }
    ElMessage({
      type: res.code === 0 ? 'success' : \"error\",
      message: res.msg,
    })
  })

}

const handleSelectionChange = (recordVo: {{class_name}}Vo[]) => {
  emit('handleSelectMore', recordVo.map((value) => value.id))
}

const handleSizeChange = (val: number) => {
  pageSize.value = val
  emit(\"handleQuery\", {current: currentPage.value, pageSize: pageSize.value});
}

const handleCurrentChange = (val: number) => {
  currentPage.value = val
  props.tableData.page_no = val
  emit(\"handleQuery\", {current: currentPage.value, pageSize: pageSize.value});
}

</script>

<style scoped>

</style>
"
}