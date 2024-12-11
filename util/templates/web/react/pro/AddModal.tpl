import React, {useEffect} from 'react';
import {Form, Input, InputNumber, Modal, Radio} from 'antd';
import type { {{table_info.class_name}}ListItem} from '../data.d';

export interface CreateFormProps {
  onCancel: () => void;
  onSubmit: (values: {{table_info.class_name}}ListItem) => void;
  createModalVisible: boolean;
}

const FormItem = Form.Item;

const formLayout = {
  labelCol: {span: 7},
  wrapperCol: {span: 13},
};

const CreateForm: React.FC<CreateFormProps> = (props) => {
  const [form] = Form.useForm();

  const {
    onSubmit,
    onCancel,
    createModalVisible,
  } = props;

  useEffect(() => {
    if (form && !createModalVisible) {
      form.resetFields();
    }
  }, [props.createModalVisible]);


  const handleSubmit = () => {
    if (!form) return;
    form.submit();
  };

  const handleFinish = (values: {{table_info.class_name}}ListItem) => {
    if (onSubmit) {
      onSubmit(values);
    }
  };

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


  const modalFooter = {okText: '保存', onOk: handleSubmit, onCancel};

  return (
    <Modal
      forceRender
      destroyOnClose
      title="新增"
      open={createModalVisible}
      {...modalFooter}
    >
      <Form
        {...formLayout}
        form={form}
        onFinish={handleFinish}
      >
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default CreateForm;
