pub fn get_react_index() -> &'static str {
    "import React, {useEffect, useState} from 'react';
import {Button, Divider, message, Modal, Space, Table, Tag} from 'antd';
import type {ColumnsType} from 'antd/es/table';
import {DeleteOutlined, EditOutlined, PlusOutlined, SettingOutlined} from '@ant-design/icons';
import { {{class_name}}Vo} from './data.d';
import AddForm from \"./components/AddForm\";
import UpdateForm from \"./components/UpdateForm\";
import {add{{class_name}}, handleResp, remove{{class_name}}, update{{class_name}}, list{{class_name}}} from \"./service\";
import SearchForm from \"./components/SearchForm\";

const {{class_name}}: React.FC = () => {
    const [selectedRowKeys, setSelectedRowKeys] = useState<React.Key[]>([]);
    const [isShowAddModal, setShowAddModal] = useState<boolean>(false);
    const [isShowEditModal, setShowEditModal] = useState<boolean>(false);
    const [{{table_name}}ListData, set{{class_name}}ListData] = useState<{{class_name}}Vo[]>([]);
    const [current{{class_name}}, setCurrent{{class_name}}] = useState<{{class_name}}Vo>();
    const [currentPage, setCurrentPage] = useState<number>(1);
    const [pageSize, setPageSize] = useState<number>(10);
    const [total, setTotal] = useState<number>(10);

    const columns: ColumnsType<{{class_name}}Vo> = [
        {% for column in java_columns %}
        {
            title: '{{column.column_comment}}',
            dataIndex: '{{column.db_name}}',
        },{% endfor %}
        // {
        //     title: '手机号',
        //     dataIndex: 'mobile',
        //     render: (text: string) => <a>{text}</a>,
        // },
        // {
        //     title: '状态',
        //     dataIndex: 'status_id',
        //     render: (_, {status_id}) => (
        //         <>
        //             {% raw %}
        //             {
        //                 <Tag color={status_id === 0 ? '#ff4d4f' : '#67c23a'} style={{width: 50, height: 30, textAlign: \"center\", paddingTop: 4}}>
        //                     {status_id === 0 ? '禁用' : '启用'}
        //                 </Tag>
        //             }
        //             {% endraw %}
        //         </>
        //     ),
        // },
        {
            title: '操作',
            key: 'action',
            render: (_, record) => (
                {% raw %}
                <Space size=\"small\">
                    <Button type=\"primary\" icon={<EditOutlined/>} onClick={() => showEditModal(record)}>编辑</Button>
                    <Button type=\"primary\" danger icon={<DeleteOutlined/>}
                            onClick={() => showDeleteConfirm(record)}>删除</Button>
                </Space>
                 {% endraw %}
            ),
        },
    ];

    const showModal = () => {
        setShowAddModal(true);
    };

    const handleAddOk = async (user: {{class_name}}Vo) => {
        if (handleResp(await add{{class_name}}(user))) {
            setShowAddModal(false);
            let res = await listUser({current: currentPage, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);
        }
    }

    const handleAddCancel = () => {
        setShowAddModal(false);
    };


    const showEditModal = (user: {{class_name}}Vo) => {
        setCurrent{{class_name}}(user)
        setShowEditModal(true);
    };

    const handleEditOk = async (user: {{class_name}}Vo) => {
        if (handleResp(await update{{class_name}}(user))) {
            setShowEditModal(false);
            let res = await listUser({
                current: currentPage, pageSize,
            })
            setTotal(res.total)
            res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);
        }
    };

    const handleEditCancel = () => {
        setShowEditModal(false);
    };

    //删除单条数据
    const showDeleteConfirm = (user: {{class_name}}Vo) => {
        Modal.confirm({
            content: `确定删除${user.real_name}吗?`,
            async onOk() {
                await handleRemove([user.id]);
            },
            onCancel() {
                console.log('Cancel');
            }
        })
    };

    //批量删除
    const handleRemove = async (ids: number[]) => {
        if (handleResp(await remove{{class_name}}(ids))) {
            let res = await listUser({current: currentPage, mobile: \"\", pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);
        }

    };

    const handleSearchOk = async (user: {{class_name}}Vo) => {
        let res = await listUser({current: currentPage, ...user, pageSize})
        setTotal(res.total)
        res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);
    };

    const handleResetOk = async () => {
        let res = await listUser({current: currentPage, pageSize})
        setTotal(res.total)
        res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);
    };

    useEffect(() => {
        listUser({
            current: currentPage, pageSize
        }).then(res => {
            setTotal(res.total)
            res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);
        });
    }, []);


    const paginationProps = {
        defaultCurrent: 1,
        defaultPageSize: 10,
        current: currentPage,
        pageSize,
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
            let res = await listUser({current: page, pageSize})
            setTotal(res.total)
            res.code === 0 ? set{{class_name}}ListData(res.data) : message.error(res.msg);

        }, //改变页码的函数
        onShowSizeChange: (current: number, size: number) => {
            console.log('onShowSizeChange', current, size)
        }
    }

    return (
        {% raw %}
        <div style={{padding: 24}}>
            <div>

                <Space size={100}>
                    <Button type=\"primary\" icon={<PlusOutlined/>} onClick={showModal}>新建</Button>
                    <SearchForm search={handleSearchOk} reSet={handleResetOk}></SearchForm>
                </Space>

            </div>

            <Divider/>

            <Table
                rowSelection={{
                    onChange: (selectedRowKeys: React.Key[]) => {
                        setSelectedRowKeys(selectedRowKeys)
                    },
                }}
                size={\"middle\"}
                columns={columns}
                {% endraw %}
                dataSource={ {{table_name}}ListData }
                rowKey={'id'}
                pagination={paginationProps}
                // tableLayout={\"fixed\"}
            />

            <AddForm onCancel={handleAddCancel} onCreate={handleAddOk} open={isShowAddModal}></AddForm>
            <UpdateForm onCancel={handleEditCancel} onCreate={handleEditOk} open={isShowEditModal} {{table_name}}Vo={current{{class_name}}}></UpdateForm>

            {selectedRowKeys.length > 0 &&
                {% raw %}
                <div>
                    已选择 {selectedRowKeys.length} 项
                    <Button style={{float: \"right\"}} danger icon={<DeleteOutlined/>} type={'primary'}
                            onClick={async () => {
                                await handleRemove(selectedRowKeys as number[]);
                                setSelectedRowKeys([]);
                            }}
                    >
                        批量删除
                    </Button>
                </div>
            {% endraw %}
            }

        </div>

    );
};

export default {{class_name}};
"
}