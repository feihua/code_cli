<template>
  <ASpace style="margin-bottom: 10px">
    <AddModal />
    <SearchForm style="margin-left: 20px" />
  </ASpace>
  <a-table :columns="columns" :data-source="{{table_info.object_name}}List" :pagination="listParam" @change="handlePageChange"
           table-layout="fixed">
    <template #bodyCell="{ column, record }">
      <template v-if="column.key === '{{table_info.object_name}}Name'">
        <a-button type="link" @click="handleDetail(record)">{ { record.{{table_info.object_name}}Name } }</a-button>
      </template>
      <template v-if="column.key === 'status'">
        <a-switch :checked="record.status===1" size="small"
                  @click="(value: boolean, event: Event) => handleSwitchChange(value, event, record)"/>
      </template>
      <template v-else-if="column.key === 'action'">
        <span>
          <a-button type="link" @click="handleDetail(record)">
            <template #icon>
              <EditOutlined/>
            </template>
            详情
          </a-button>
          <a-button type="link" @click="handleEdit(record)">
            <template #icon>
              <EditOutlined/>
            </template>
            编辑
          </a-button>
          <a-button danger type="link" @click="handleDelete(record)">
            <template #icon>
              <DeleteOutlined/>
            </template>
            删除
          </a-button>
        </span>
      </template>
    </template>
  </a-table>

  <UpdateModal ref="updateChildrenRef"></UpdateModal>
  <DetailModal ref="detailChildrenRef"></DetailModal>
</template>

<script lang="ts" setup>
import {DeleteOutlined, EditOutlined, ExclamationCircleOutlined} from '@ant-design/icons-vue';
import AddModal from "./components/AddModal.vue";
import {use{{table_info.class_name}}Store} from "./store/{{table_info.object_name}}Store";
import type { {{table_info.class_name}}RecordVo} from "./data";
import {createVNode, onMounted, ref} from "vue";
import {storeToRefs} from "pinia";
import UpdateModal from "./components/UpdateModal.vue";
import DetailModal from "./components/DetailModal.vue";
import {message, Modal} from "ant-design-vue";
import {remove{{table_info.class_name}}, update{{table_info.class_name}}Status} from "./service";
import SearchForm from "./components/SearchForm.vue";

const updateChildrenRef = ref()
const detailChildrenRef = ref()

const store = use{{table_info.class_name}}Store()
const {listParam, {{table_info.object_name}}List,} = storeToRefs(store)
const {query{{table_info.class_name}}List} = store

const columns = [
{{- range .TableColumn}}
    {
        title: '{{column.column_comment}}',
        dataIndex: '{{table_info.class_name}}',
        key: '{{table_info.class_name}}',
    },
{{- end}}
    {
      title: '操作',
      key: 'action',
    },
];

const handleDetail = (record: {{table_info.class_name}}RecordVo) => {
  detailChildrenRef.value.handleVisible(record.id, true)
}

const handleEdit = (record: {{table_info.class_name}}RecordVo) => {
  updateChildrenRef.value.handleVisible(record.id, true)
}

const handleDelete = (record: {{table_info.class_name}}RecordVo) => {
  Modal.confirm({
    cancelText: "取消",
    okText: "确定",
    centered: true,
    title: '确定删除?',
    icon: createVNode(ExclamationCircleOutlined),
    async onOk() {
      const res = await remove{{table_info.class_name}}({ids:[record.id]});
      if (res.code == 0) {
        message.success(res.message);
        query{{table_info.class_name}}List(listParam.value);
      } else {
        message.error(res.message);
      }
    },
    onCancel() {
    },
  });
}


const handlePageChange = (obj: any) => {
  query{{table_info.class_name}}List({...obj})
}

const handleSwitchChange = async (checked: boolean, event: Event, record: {{table_info.class_name}}RecordVo) => {
  const res = await update{{table_info.class_name}}Status({ids: [record.id], status: checked ? 1 : 0});
  if (res.code == 0) {
    message.success(res.message);
    query{{table_info.class_name}}List(listParam.value);
  } else {
    message.error(res.message);
  }
}

onMounted(() => {
  query{{table_info.class_name}}List({current: 1, pageSize: 10});
})

</script>

