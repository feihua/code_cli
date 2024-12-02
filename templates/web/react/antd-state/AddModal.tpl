import React, { useState } from 'react';
import { Button, Form, Input, message, Modal, Radio } from 'antd';
import { PlusOutlined } from '@ant-design/icons';
import { add{{table_info.class_name}} } from '../service.ts';
import use{{table_info.class_name}}Store from '../store/{{table_info.object_name}}Store.ts';

const AddModal: React.FC = () => {
  const [form] = Form.useForm();
  const FormItem = Form.Item;
  const [open, setOpen] = useState<boolean>(false);
  const { query{{table_info.class_name}}List } = use{{table_info.class_name}}Store();

  const handleOk = () => {
    form
      .validateFields()
      .then(async (values) => {
        const res = await add{{table_info.class_name}}(values);
        if (res.code == 0) {
          message.info(res.message);
          query{{table_info.class_name}}List({ current: 1, pageSize: 10 });
          form.resetFields();
          setOpen(false);
        } else {
          message.error(res.message);
        }
      })
      .catch((info) => {
        message.error(info);
      });
  };

    const renderContent = () => {
        return (
          <>
            {%- for column in table_info.columns %}
              <FormItem
                name="{{column.ts_name}}"
                label="{{column.column_comment}}"
                rules={[{required: true, message: '请输入{{column_comment.column_comment}!'}]}
              >
              {% if column.column_key =="PRI"  %}
              {% elif column.ts_name is containing("create") %}
              {% elif column.ts_name is containing("update") %}
              {% elif column.ts_name is containing("Status") %}
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
              {% elif column.ts_name is containing("status") %}
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
              {% elif column.ts_name is containing("Sort") %}
                  <InputNumber style={ {width: 255} }/>
              {% elif column.ts_name is containing("sort") %}
                  <InputNumber style={ {width: 255} }/>
              {% elif column.ts_name is containing("Type") %}
                  <Radio.Group>
                    <Radio value={0}>禁用</Radio>
                    <Radio value={1}>正常</Radio>
                  </Radio.Group>
              {%- elif column is containing("remark") %}
                  <Input.TextArea rows={2} placeholder={'请输入备注'}/>
              {% else %}
                  <Input id="create-{{column.ts_name}}" placeholder={'请输入{{column.column_comment}!'}/>
              {% endif %}
              </FormItem>
            {%- endfor %}

          </>
        );
    };

  return (
    <>
      <Button type="primary" icon={<PlusOutlined />} onClick={() => setOpen(true)}>
        新建
      </Button>
      <Modal title="新建" okText="保存" onOk={handleOk} onCancel={() => setOpen(false)} cancelText="取消" open={open} width={480} style={ { top: 150 } }>
        <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} initialValues={ { sort: 1, status_id: 1 } } style={ { marginTop: 30 } }>
          {renderContent()}
        </Form>
      </Modal>
    </>
  );
};

export default AddModal;
