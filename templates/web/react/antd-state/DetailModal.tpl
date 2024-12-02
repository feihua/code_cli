import React, { useEffect } from 'react';
import { Col, Form, Input, Modal, Radio, Row } from 'antd';
import { query{{table_info.class_name}}Detail } from '../service';

export interface DetailModalProps {
  onCancel: () => void;
  open: boolean;
  id: number;
}

const DetailModal: React.FC<DetailModalProps> = (props) => {
  const { open, id, onCancel } = props;
  const [form] = Form.useForm();
  const FormItem = Form.Item;

  useEffect(() => {
    if (open) {
      query{{table_info.class_name}}Detail(id).then((res) => {
        form.setFieldsValue(res.data);
      });
    }
  }, [open]);

    const renderContent = () => {
        return (
          <>
          <Row>
            {%- for column in table_info.columns %}
              <Col span={12}>
              <FormItem
                name="{{column.ts_name}}"
                label="{{column.column_comment}}"
                rules={[{required: true, message: '请输入{{column_comment.column_comment}!'}]}
              >
              {% if column.ts_name is containing("Status") %}
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
                  <Input id="detail-{{column.ts_name}}" placeholder={'请输入{{column.column_comment}!'}/>
              {% endif %}
              </FormItem>
              </Col>
            {%- endfor %}

             </Row>
          </>
        );
    };


  return (
    <Modal forceRender destroyOnClose title="订单详情" open={open} footer={false} width={1200} onCancel={onCancel}>
      <Form labelCol={ { span: 7 } } wrapperCol={ { span: 13 } } form={form} style={ { marginTop: 30 } }>
        {renderContent()}
      </Form>
    </Modal>
  );
};

export default DetailModal;
