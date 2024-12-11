import React, { useEffect } from 'react';
import { Form, Input, message, Modal, Radio } from 'antd';
import { query{{table_info.class_name}}Detail, update{{table_info.class_name}} } from '../service';
import use{{table_info.class_name}}Store from '../store/{{table_info.object_name}}Store.ts';

interface UpdateModalProps {
  open: boolean;
  onCancel: () => void;
  id: number;
}

const UpdateModal: React.FC<UpdateModalProps> = ({ open, onCancel, id }) => {
  const [form] = Form.useForm();
  const FormItem = Form.Item;
  const { query{{table_info.class_name}}List, listParam } = use{{table_info.class_name}}Store();

  useEffect(() => {
    if (open) {
      query{{table_info.class_name}}Detail(id).then((res) => {
        form.setFieldsValue(res.data);
      });
    }
  }, [open]);

  const handleOk = () => {
    form
      .validateFields()
      .then(async (values) => {
        const res = await update{{table_info.class_name}}(values);
        if (res.code == 0) {
          message.info(res.message);
          query{{table_info.class_name}}List(listParam);
          form.resetFields();
          onCancel();
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
            <FormItem
              name="id"
              label="主键"
              hidden
            >
              <Input id="update-id"/>
            </FormItem>
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
              {%- elif column.ts_name is containing("Sort") or column.ts_name is containing("sort")%}
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
    <Modal title="更新" okText="保存" onOk={handleOk} onCancel={onCancel} cancelText="取消" open={open} width="480" style={ { top: 150 } }>
      <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} style={ { marginTop: 30 } }>
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default UpdateModal;
