import React, {useEffect, useState} from 'react';
import type {MenuProps} from 'antd';
import {Button, Divider, message, Modal, Space, Table, Switch, Dropdown} from 'antd';
import type {ColumnsType} from 'antd/es/table';
import {DeleteOutlined, EditOutlined, PlusOutlined, SettingOutlined, ExclamationCircleOutlined, DownOutlined} from '@ant-design/icons';
import { {{table_info.class_name}}Vo} from './data';
import AddModal from "./components/AddModal";
import UpdateModal from "./components/UpdateModal";
import AdvancedSearchForm from "./components/SearchForm";
import DetailModal from "./components/DetailModal";
import {add{{table_info.class_name}}, handleResp, remove{{table_info.class_name}}, update{{table_info.class_name}}, query{{table_info.class_name}}List, update{{table_info.class_name}}Status} from "./service";


const {{table_info.class_name}}: React.FC = () => {
    const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
    const [isShowAddModal, setShowAddModal] = useState<boolean>(false);
    const [isShowEditModal, setShowEditModal] = useState<boolean>(false);
    const [isShowDetailModal, setShowDetailModal] = useState<boolean>(false);
    const [{{table_info.object_name}}ListData, set{{table_info.class_name}}ListData] = useState<{{table_info.class_name}}Vo[]>([]);
    const [current{{table_info.class_name}}, setCurrent{{table_info.class_name}}] = useState<{{table_info.class_name}}Vo>({
      {{- range .TableColumn}}
        {{table_info.class_name}}: {{if eq .TsType `string`}}''{{else}}0{{end}},
      {{- end}}
    });
    const [currentPage, setCurrentPage] = useState<number>(1);
    const [pageSize, setPageSize] = useState<number>(10);
    const [total, setTotal] = useState<number>(10);

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
        width:280,
        render: (_, record) => (
            <div>
                <Button type="link" size={'small'} icon={<EditOutlined/>} onClick={() => showDetailModal(record)}>详情</Button>
                <Button type="link" size={'small'} icon={<EditOutlined/>} onClick={() => showEditModal(record)}>编辑</Button>
                <Button type="link" size={'small'} danger icon={<DeleteOutlined/>}
                        onClick={() => showDeleteConfirm(record)}>删除</Button>
                <Dropdown menu={ {items} }>
                            <a onMouseEnter={(e) => {
                              setCurrent{{table_info.class_name}}(record)
                              return e.preventDefault()
                            } }>
                              <Space>
                                更多
                                <DownOutlined/>
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
        <a key="1" onClick={() => {
            //handleMoreModalVisible(true);
          }}
        >
          更多
        </a>
      ),
      icon: <PlusOutlined/>,
    },
   ];

   const showStatusConfirm = (ids: number[], status: number) => {
    Modal.confirm({
      title: `确定${status == 1 ? "启用" : "禁用"}吗？`,
      icon: <ExclamationCircleOutlined/>,
      async onOk() {
        await handleStatus(ids, status)
        //actionRef.current?.clearSelected?.();
        //actionRef.current?.reload?.();
      },
      onCancel() {
      },
    });
   };
    const handleStatus = async (ids: number[], status: number) => {
      const hide = message.loading('正在更新状态');
      if (ids.length == 0) {
        hide();
        return true;
      }
      try {
        await update{{table_info.class_name}}Status({ ids, {{table_info.object_name}}Status: status});
        hide();
        message.success('更新状态成功');
        return true;
      } catch (error) {
        hide();
        return false;
      }
    };

    const showModal = () => {
        setShowAddModal(true);
    };

    const handleAddOk = async (param: {{table_info.class_name}}Vo) => {
        if (handleResp(await add{{table_info.class_name}}(param))) {
            setShowAddModal(false);
            const res = await query{{table_info.class_name}}List({current: currentPage, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);
        }
    }

    const handleAddCancel = () => {
        setShowAddModal(false);
    };


    const showEditModal = (param: {{table_info.class_name}}Vo) => {
        setCurrent{{table_info.class_name}}(param)
        setShowEditModal(true);
    };

    const handleEditOk = async (param: {{table_info.class_name}}Vo) => {
        if (handleResp(await update{{table_info.class_name}}(param))) {
            setShowEditModal(false);
            const res = await query{{table_info.class_name}}List({
                current: currentPage, pageSize,
            })
            setTotal(res.total)
            res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);
        }
    };

    const handleEditCancel = () => {
        setShowEditModal(false);
    };

    const showDetailModal = (param: {{table_info.class_name}}Vo) => {
        setCurrent{{table_info.class_name}}(param)
        setShowDetailModal(true);
    };


    const handleDetailCancel = () => {
        setShowDetailModal(false);
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
            }
        })
    };

    //批量删除
    const handleRemove = async (ids: number[]) => {
        if (handleResp(await remove{{table_info.class_name}}(ids))) {
            const res = await query{{table_info.class_name}}List({current: currentPage, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);
        }

    };

    const handleSearchOk = async (param: {{table_info.class_name}}Vo) => {
        const res = await query{{table_info.class_name}}List({current: currentPage, ...param, pageSize})
        setTotal(res.total)
        res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);
    };

    const handleResetOk = async () => {
        const res = await query{{table_info.class_name}}List({current: currentPage, pageSize})
        setTotal(res.total)
        res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);
    };

    useEffect(() => {
        query{{table_info.class_name}}List({
            current: currentPage, pageSize
        }).then(res => {
            setTotal(res.total)
            res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);
        });
    }, []);


    const paginationProps = {
        defaultCurrent: 1,
        defaultPageSize: 10,
        current: currentPage, //当前页码
        pageSize, // 每页数据条数
        pageSizeOptions: [10, 20, 30, 40, 50],
        showQuickJumper: true,
        showTotal: (total: number) => (
            <span>总共{total}条</span>
        ),
        total,
        onChange: async (page: number, pageSize: number) => {
            console.log('onChange', page, pageSize)
            setCurrentPage(page)
            setPageSize(pageSize)
            const res = await query{{table_info.class_name}}List({current: page, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{table_info.class_name}}ListData(res.data) : message.error(res.message);

        }, //改变页码的函数
        onShowSizeChange: (current: number, size: number) => {
            console.log('onShowSizeChange', current, size)
        }
    }

    return (
        <div style={ {padding: 24}}>
            <div>
                <Space size={100}>
                    <Button type="primary" icon={<PlusOutlined/>} onClick={showModal}>新建</Button>
                    <AdvancedSearchForm search={handleSearchOk} reSet={handleResetOk}></AdvancedSearchForm>
                </Space>
            </div>

            <Divider/>

            <Table
                rowSelection={ {
                    onChange: (selectedRowKeys: React.Key[]) => {
                        setSelectedRowKeys(selectedRowKeys)
                    },
                }}
                size={"middle"}
                columns={columns}
                dataSource={ {{table_info.object_name}}ListData}
                rowKey={'id'}
                pagination={paginationProps}
                // tableLayout={"fixed"}
            />

            <AddModal onCancel={handleAddCancel} onCreate={handleAddOk} open={isShowAddModal}></AddModal>
            <UpdateModal onCancel={handleEditCancel} onCreate={handleEditOk} open={isShowEditModal} id={current{{table_info.class_name}}.id}></UpdateModal>
            <DetailModal onCancel={handleDetailCancel}  open={isShowDetailModal} id={current{{table_info.class_name}}.id}></DetailModal>

            {selectedRowKeys.length > 0 &&
                <div>
                    已选择 {selectedRowKeys.length} 项
                    <Button style={ {float: "right"}} danger icon={<DeleteOutlined/>} type={'primary'}
                            onClick={async () => {
                                await handleRemove(selectedRowKeys as number[]);
                                setSelectedRowKeys([]);
                            }}
                    >
                        批量删除
                    </Button>
                </div>
            }

        </div>
    );
};

export default {{table_info.class_name}};
