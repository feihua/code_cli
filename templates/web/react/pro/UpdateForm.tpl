import React, {useEffect} from 'react';
import {Form, Input, InputNumber, Modal, Radio} from 'antd';
import type { {{table_info.class_name}}ListItem} from '../data.d';

export interface UpdateFormProps {
  onCancel: () => void;
  onSubmit: (values: {{table_info.class_name}}ListItem) => void;
  updateModalVisible: boolean;
  currentData: Partial<{{table_info.class_name}}ListItem>;
}

const FormItem = Form.Item;

const formLayout = {
  labelCol: {span: 7},
  wrapperCol: {span: 13},
};

const UpdateForm: React.FC<UpdateFormProps> = (props) => {
  const [form] = Form.useForm();

  const {
    onSubmit,
    onCancel,
    updateModalVisible,
    currentData,
  } = props;

  useEffect(() => {
    if (form && !updateModalVisible) {
      form.resetFields();
    }
  }, [props.updateModalVisible]);

  useEffect(() => {
    if (currentData) {
      form.setFieldsValue({
        ...currentData,
      });
    }
  }, [props.currentData]);

  const handleSubmit = () => {
    if (!form) return;
    form.submit();
  };

  const handleFinish = (values: { [key: string]: any }) => {
    if (onSubmit) {
      onSubmit(values as {{table_info.class_name}}ListItem);
    }
  };

  const renderContent = () => {
    return (
      <>
        <FormItem
          name="id"
          label="主键"
          hidden
        >
          <Input id="update-id"/>
        </FormItem>

          {%- for column in table_info.columns %}
            <FormItem
              name="{{column.ts_name}}"
              label="{{column.column_comment}}"
              rules={[{required: true, message: '请输入{{column_comment.column_comment}!'}]}
            >
            {%- if column.column_key =="PRI"  %}
            {%- elif column.ts_name is containing("create") %}
            {%- elif column.ts_name is containing("update") %}
            {%- elif column.ts_name is containing("Status") %}
                <Radio.Group>
                  <Radio value={0}>禁用</Radio>
                  <Radio value={1}>正常</Radio>
                </Radio.Group>
            {%- elif column.ts_name is containing("status") %}
                <Radio.Group>
                  <Radio value={0}>禁用</Radio>
                  <Radio value={1}>正常</Radio>
                </Radio.Group>
            {%- elif column.ts_name is containing("Sort") %}
                <InputNumber style={ {width: 255} }/>
            {%- elif column.ts_name is containing("sort") %}
                <InputNumber style={ {width: 255} }/>
            {%- elif column.ts_name is containing("Type") %}
                <Radio.Group>
                  <Radio value={0}>禁用</Radio>
                  <Radio value={1}>正常</Radio>
                </Radio.Group>
            {%- elif column is containing("remark") %}
                <Input.TextArea rows={2} placeholder={'请输入备注'}/>
            {%- else %}
                <Input id="update-{{column.ts_name}}" placeholder={'请输入{{column.column_comment}!'}/>
            {%- endif %}
            </FormItem>
          {%- endfor %}

      </>
    );
  };


  const modalFooter = {okText: '保存', onOk: handleSubmit, onCancel};

  return (
    <Modal
      forceRender
      destroyOnClose
      title="编辑"
      open={updateModalVisible}
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

export default UpdateForm;
