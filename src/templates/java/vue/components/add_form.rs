pub fn get_vue_add() -> &'static str {
    "<template>
  <el-space direction=\"horizontal\" size=\"large\" style=\"margin-left: 20px;margin-top: 20px\">
    <el-button type=\"primary\" icon=\"Plus\" @click=\"dialogFormVisible = true\">新建</el-button>
    <el-button type=\"danger\" icon=\"Delete\" :disabled=\"btnDisabled\" @click=\"handleDeleteMore\">批量删除</el-button>
    <el-form :inline=\"true\" :model=\"searchParam\" class=\"demo-form-inline\" style=\"height: 32px;margin-left: 60px\" ref=\"sFormRef\">
      {% for column in java_columns %}
      <el-form-item label=\"{{column.column_comment}}\" prop=\"{{column.db_name}}\">
        <el-input v-model=\"searchParam.{{column.db_name}}\" placeholder=\"{{column.column_comment}}\"/>
      </el-form-item>{% endfor %}

<!--      <el-form-item label=\"状态\">-->
<!--        <el-select v-model=\"searchParam.status_id\" placeholder=\"请选择状态\">-->
<!--          <el-option label=\"启用\" value=\"1\"/>-->
<!--          <el-option label=\"禁用\" value=\"0\"/>-->
<!--        </el-select>-->
<!--      </el-form-item>-->
      <el-form-item>
        <el-button type=\"primary\" @click=\"handleQuery\" icon=\"Search\" style=\"width: 120px\">查询</el-button>
        <el-button @click=\"handleQueryReset(sFormRef)\" style=\"width: 100px\">重置</el-button>
      </el-form-item>
    </el-form>
  </el-space>

  <el-dialog v-model=\"dialogFormVisible\" title=\"新建\" style=\"width: 480px;border-radius: 10px\">
    <el-form
        label-width=\"100px\"
        :model=\"add{{class_name}}Param\"
        style=\"max-width: 380px\"
        :rules=\"rules\"
        status-icon
        ref=\"ruleFormRef\"
    >
      {% for column in java_columns %}
      <el-form-item label=\"{{column.column_comment}}\" prop=\"{{column.db_name}}\">
        <el-input v-model=\"add{{class_name}}Param.{{column.db_name}}\"/>
      </el-form-item>{% endfor %}
<!--      <el-form-item label=\"排序\" prop=\"sort\">-->
<!--        <el-input-number v-model=\"addParam.sort\" :min=\"1\" :max=\"10\"/>-->
<!--      </el-form-item>-->
<!--      <el-form-item label=\"状态\" prop=\"status_id\">-->
<!--        <el-radio-group v-model=\"addParam.status_id\">-->
<!--          <el-radio :label=\"1\">启用</el-radio>-->
<!--          <el-radio :label=\"0\">禁用</el-radio>-->
<!--        </el-radio-group>-->
<!--      </el-form-item>-->
<!--      <el-form-item label=\"备注\" prop=\"remark\">-->
<!--        <el-input v-model=\"addParam.remark\" :rows=\"2\" type=\"textarea\"/>-->
<!--      </el-form-item>-->
      <el-form-item>
        <el-button type=\"primary\" @click=\"handleAdd(ruleFormRef)\">保存</el-button>
        <el-button @click=\"dialogFormVisible = false\">取消</el-button>
      </el-form-item>
    </el-form>
  </el-dialog>
</template>

<script lang=\"ts\" setup>

import {reactive, ref} from \"vue\";
import type {FormRules, FormInstance} from \"element-plus\";
import type {IResponse} from \"@/api/ajax\";
import {add{{class_name}}} from \"@/views/{{table_name}}/service\";
import type {Add{{class_name}}Param, Search{{class_name}}Param} from \"@/views/{{table_name}}/data\";
import {remove} from \"@/views/log/service\";

const dialogFormVisible = ref(false)

const btnDisabled = ref<boolean>(true)
const {{table_name}}_ids = ref<number[]>([])

const ruleFormRef = ref<FormInstance>()
const sFormRef = ref<FormInstance>()

const add{{class_name}}Param = reactive<Add{{class_name}}Param>({})

const searchParam = reactive<Search{{class_name}}Param>({})

const rules = reactive<FormRules>({
  {% for column in java_columns %}
    {{column.db_name}}: [
    {required: true, message: '{{column.column_comment}}不能为空', trigger: 'blur'},
    // {min: 1, max: 5, message: 'Length should be 3 to 5', trigger: 'blur'},
  ],{% endfor %}
})

const emit = defineEmits(['handleQuery'])

const handleAdd = async (formEl: FormInstance | undefined) => {
  if (!formEl) return
  await formEl.validate(async (valid, fields) => {
    if (valid) {
      const addResult: IResponse = await add{{class_name}}(add{{class_name}}Param)
      if (addResult.code === 0) {
        dialogFormVisible.value = false
        formEl.resetFields()
        emit(\"handleQuery\", {current: 1, pageSize: 10});
      }
      addResult.code === 0 ? ElMessage.success(addResult.msg) : ElMessage.error(addResult.msg)
    } else {
      ElMessage.error(\"数据不能为空\")
    }
  })
}


const handleQuery = async () => {
  emit(\"handleQuery\", searchParam);
}

const handleQueryReset = async (formEl: FormInstance | undefined) => {
  formEl!.resetFields()
  emit(\"handleQuery\", {current: 1, pageSize: 10, ...searchParam});
}

const handleReceiveDeleteParam = async (ids: number[]) => {
  btnDisabled.value = ids.length <= 0;
  {{table_name}}_ids.value = ids
}

const handleDeleteMore = () => {
  ElMessageBox.confirm(
      '确定删除' + {{table_name}}_ids.value.length + '条记录不?',
      {
        confirmButtonText: '删除',
        cancelButtonText: '取消',
        type: 'warning',
      }
  ).then(async () => {
    let res: IResponse = await remove({{table_name}}_ids.value)
    if (res.code == 0) {
      emit(\"handleQuery\", {current: 1, pageSize: 10});
    }
    ElMessage({
      type: res.code === 0 ? 'success' : \"error\",
      message: res.msg,
    })
  })

}

defineExpose({
  handleReceiveDeleteParam
})

</script>

<style scoped>

</style>
"
}