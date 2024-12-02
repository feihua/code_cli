import React, { useEffect, useState } from 'react';
import type { MenuProps } from 'antd';
import { Button, Divider, Dropdown, message, Modal, Space, Switch, Table } from 'antd';
import type { ColumnsType } from 'antd/es/table';
import { DeleteOutlined, DownOutlined, EditOutlined, ExclamationCircleOutlined, PlusOutlined } from '@ant-design/icons';
import { {{table_info.class_name}}Vo } from './data';
import AddModal from './components/AddModal';
import UpdateModal from './components/UpdateModal';
import AdvancedSearchForm from './components/SearchForm';
import DetailModal from './components/DetailModal';
import { remove{{table_info.class_name}}, update{{table_info.class_name}}Status } from './service';
import use{{table_info.class_name}}Store from './store/{{table_info.object_name}}Store.ts';

const {{table_info.class_name}}: React.FC = () => {
  const { query{{table_info.class_name}}List, {{table_info.object_name}}List, listParam, total } = use{{table_info.class_name}}Store();
  const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);

  const [isShowEditModal, setShowEditModal] = useState<boolean>(false);
  const [isShowDetailModal, setShowDetailModal] = useState<boolean>(false);
  const [current{{table_info.class_name}}, setCurrent{{table_info.class_name}}] = useState<{{table_info.class_name}}Vo>({
  {{range .TableColumn}}{{table_info.class_name}}: {{if eq .TsType `string`}}''{{else}}0{{end}},
  {{end}}

  });

  const columns: ColumnsType<{{table_info.class_name}}Vo> = [
    {%- for column in table_info.columns %}
      {% if column.ts_name is containing("Name") %}
        {
          title: '{{column.column_comment}}',
          dataIndex: '{{column.ts_name}}',
          render: (text: string) => <a>{text}</a>,
        },
      {% elif column.ts_name is containing("name") %}
        {
          title: '{{column.column_comment}}',
          dataIndex: '{{column.ts_name}}',
          render: (text: string) => <a>{text}</a>,
        },
      {% elif column.ts_name is containing("Status") %}
        {
          title: '{{column.column_comment}}',
          dataIndex: '{{column.ts_name}}',
          render: (dom, entity) => {
            return (
              <Switch checked={entity.{{column.ts_name}} == 1} onChange={(flag) => {
                showStatusConfirm( [entity.id], flag ? 1 : 0)
              }}/>
            );
        },
        },
      {% elif column.ts_name is containing("status") %}
        {
          title: '{{column.column_comment}}',
          dataIndex: '{{column.ts_name}}',
          render: (dom, entity) => {
            return (
              <Switch checked={entity.{{column.ts_name}} == 1} onChange={(flag) => {
                showStatusConfirm( [entity.id], flag ? 1 : 0)
              }}/>
            );
        },
        },
      {% elif column.ts_name is containing("Type") %}
        {
          title: '{{column.column_comment}}',
          dataIndex: '{{column.ts_name}}',
          render: (_, { {{column.ts_name}} }) => (
              <>
                  { {{column.ts_name}} === 0 ? '禁用' : '启用'}
              </>
          ),
        },
      {% else %}
        {
          title: '{{column.column_comment}}',
          dataIndex: '{{column.ts_name}}',
        },
      {% endif %}
    {%- endfor %}

    {
      title: '操作',
      key: 'action',
      width: 280,
      render: (_, record) => (
        <div>
          <Button type="link" size={'small'} icon={<EditOutlined />} onClick={() => showDetailModal(record)}>
            详情
          </Button>
          <Button type="link" size={'small'} icon={<EditOutlined />} onClick={() => showEditModal(record)}>
            编辑
          </Button>
          <Button type="link" size={'small'} danger icon={<DeleteOutlined />} onClick={() => showDeleteConfirm(record)}>
            删除
          </Button>
          <Dropdown menu={ { items } }>
            <a
              onMouseEnter={(e) => {
                setCurrent{{table_info.class_name}}(record);
                return e.preventDefault();
              } }>
              <Space>
                更多
                <DownOutlined />
              </Space>
            </a>
          </Dropdown>
        </div>
      ),
    },
  ];

  const items: MenuProps['items'] = [
    {
      key: '1',
      label: (
        <a
          key="1"
          onClick={() => {
            //handleMoreModalVisible(true);
          } }>
          更多操作
        </a>
      ),
      icon: <PlusOutlined />,
    },
  ];

  const showStatusConfirm = (ids: number[], status: number) => {
    Modal.confirm({
      title: `确定${status == 1 ? '启用' : '禁用'}吗？`,
      icon: <ExclamationCircleOutlined />,
      async onOk() {
        await handleStatus(ids, status);
      },
      onCancel() {},
    });
  };
  const handleStatus = async (ids: number[], status: number) => {
    const hide = message.loading('正在更新状态');
    if (ids.length == 0) {
      hide();
      return true;
    }
    try {
      await update{{table_info.class_name}}Status({ ids, {{table_info.object_name}}Status: status });
      hide();
      message.success('更新状态成功');
      query{{table_info.class_name}}List(listParam);
      return true;
    } catch (error) {
      hide();
      return false;
    }
  };

  const showEditModal = (param: {{table_info.class_name}}Vo) => {
    setCurrent{{table_info.class_name}}(param);
    setShowEditModal(true);
  };

  const showDetailModal = (param: {{table_info.class_name}}Vo) => {
    setCurrent{{table_info.class_name}}(param);
    setShowDetailModal(true);
  };

  //删除单条数据
  const showDeleteConfirm = (param: {{table_info.class_name}}Vo) => {
    Modal.confirm({
      content: `确定删除${param.id}吗?`,
      async onOk() {
        await handleRemove([param.id]);
      },
      onCancel() {
        console.log('Cancel');
      },
    });
  };

  //批量删除
  const handleRemove = async (ids: number[]) => {
    const res = await remove{{table_info.class_name}}(ids);
    if (res.code == 0) {
      message.info(res.message);
      query{{table_info.class_name}}List(listParam);
    } else {
      message.error(res.message);
    }
  };

  useEffect(() => {
    query{{table_info.class_name}}List({
      current: 1,
      pageSize: 10,
    });
  }, []);

  const paginationProps = {
    defaultCurrent: 1,
    defaultPageSize: 10,
    current: listParam.current, //当前页码
    pageSize: listParam.pageSize, // 每页数据条数
    pageSizeOptions: [10, 20, 30, 40, 50],
    showQuickJumper: true,
    showTotal: (total: number) => <span>总共{total}条</span>,
    total: total,
    onChange: (current: number, pageSize: number) => {
      query{{table_info.class_name}}List({ current, pageSize });
    }, //改变页码的函数
    onShowSizeChange: (current: number, size: number) => {
      console.log('onShowSizeChange', current, size);
    },
  };

  return (
    <div style={ { padding: 24 } }>
      <div>
        <Space size={10}>
          <AddModal />
          <Button
            style={ { float: 'right' } }
            danger
            disabled={selectedRowKeys.length == 0}
            icon={<DeleteOutlined />}
            type={'primary'}
            onClick={async () => {
              await handleRemove(selectedRowKeys as number[]);
              setSelectedRowKeys([]);
            } }>
            批量删除
          </Button>
          <AdvancedSearchForm />
        </Space>
      </div>

      <Divider />

      <Table
        rowSelection={ {
          onChange: (selectedRowKeys: React.Key[]) => {
            setSelectedRowKeys(selectedRowKeys);
          },
        } }
        size={'middle'}
        columns={columns}
        dataSource={ {{table_info.object_name}}List}
        rowKey={'id'}
        pagination={paginationProps}
        // tableLayout={"fixed"}
      />

      <UpdateModal onCancel={() => setShowEditModal(false)} open={isShowEditModal} id={current{{table_info.class_name}}.id}></UpdateModal>
      <DetailModal onCancel={() => setShowDetailModal(false)} open={isShowDetailModal} id={current{{table_info.class_name}}.id}></DetailModal>
    </div>
  );
};

export default {{table_info.class_name}};
