import React from 'react';
import {Form, Input, InputNumber, message, Modal, Radio} from 'antd';
import { {{table_info.class_name}}Vo} from "../data";

interface AddModalProps {
    open: boolean;
    onCreate: (values: {{table_info.class_name}}Vo) => void;
    onCancel: () => void;
}

const AddModal: React.FC<AddModalProps> = ({open, onCreate, onCancel}) => {
    const [form] = Form.useForm();
    const FormItem = Form.Item;

    const handleOk = () => {
        form.validateFields()
            .then((values) => {
                console.log(values)
                onCreate(values);
                form.resetFields();
            })
            .catch((info) => {
                message.error(info);
            });
    }

    const renderContent = () => {
        return (
          <>
          {%- for column in table_info.columns %}
            {%- if column.column_key =="PRI"  %}
            {%- elif column.ts_name is containing("create") %}
            {%- elif column.ts_name is containing("update") %}
            {%- elif column.ts_name is containing("Status") or column.ts_name is containing("status") or column.ts_name is containing("Type") %}
            <FormItem
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              rules={[{required: true, message: '请输入{{column.column_comment}}!'}]}
            >
                <Radio.Group>
                  <Radio value={0}>禁用</Radio>
                  <Radio value={1}>正常</Radio>
                </Radio.Group>
            </FormItem>
            {%- elif column.ts_name is containing("Sort") or column.ts_name is containing("sort") %}
            <FormItem
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              rules={[{required: true, message: '请输入{{column.column_comment}}!'}]}
            >
                <InputNumber style={ {width: 255} }/>
            </FormItem>
            {%- elif column is containing("remark") %}
            <FormItem
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              rules={[{required: true, message: '请输入{{column.column_comment}}!'}]}
            >
                <Input.TextArea rows={2} placeholder={'请输入备注'}/>
            </FormItem>
            {%- else %}
            <FormItem
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              rules={[{required: true, message: '请输入{{column.column_comment}}!'}]}
            >
                <Input id="create-{{column.ts_name}}" placeholder={'请输入{{column.column_comment}}!'}/>
            </FormItem>
            {%- endif %}

          {%- endfor %}

          </>
        );
    };

  return (
    <Modal title="新建" okText="保存" onOk={handleOk} onCancel={onCancel} cancelText="取消" open={open} width={480} style={ { top: 150 } }>
      <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} initialValues={ { sort: 1, status_id: 1 } } style={ { marginTop: 30 } }>
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default AddModal;