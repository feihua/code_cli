import React from 'react';
import { SearchOutlined } from '@ant-design/icons';
import { Button, Form, FormProps, Input, Select, Space } from 'antd';
import { List{{table_info.class_name}}Param } from '../data';
import use{{table_info.class_name}}Store from '../store/{{table_info.object_name}}Store.ts';

const AdvancedSearchForm: React.FC = () => {
  const FormItem = Form.Item;
  const [form] = Form.useForm();
  const { query{{table_info.class_name}}List } = use{{table_info.class_name}}Store();
  const onFinish: FormProps<List{{table_info.class_name}}Param>['onFinish'] = (values) => {
    query{{table_info.class_name}}List({ ...values, current: 1, pageSize: 10 });
  };

  const onReset = () => {
    form.resetFields();
    query{{table_info.class_name}}List({ current: 1, pageSize: 10 });
  };

  const searchForm = () => {
      return (
          <>
              {%- for column in table_info.columns %}
                <FormItem
                  name="{{column.ts_name}}"
                  label="{{column.column_comment}}"
                  rules={[{required: true, message: '请输入{{column_comment.column_comment}!'}]}
                >
                {%- if column.column_key =="PRI"  %}
                {%- elif column.ts_name is containing("create") %}
                {%- elif column.ts_name is containing("update") %}
                {%- elif column.ts_name is containing("sort") %}
                {%- elif column.ts_name is containing("Sort") %}
                {%- elif column.ts_name is containing("remark") %}
                {%- elif column.ts_name is containing("Status") %}
                    <Select style={ {width: 200}}>
                        <Select.Option value="1">正常</Select.Option>
                        <Select.Option value="0">禁用</Select.Option>
                    </Select>
                {%- elif column.ts_name is containing("status") %}
                    <Select style={ {width: 200}}>
                        <Select.Option value="1">正常</Select.Option>
                        <Select.Option value="0">禁用</Select.Option>
                    </Select>
                {%- elif column.ts_name is containing("Type") %}
                    <Select style={ {width: 200}}>
                        <Select.Option value="1">正常</Select.Option>
                        <Select.Option value="0">禁用</Select.Option>
                    </Select>
                {%- else %}
                    <Input id="search-{{column.ts_name}}" placeholder={'请输入{{column.column_comment}!'}/>
                {%- endif %}
                </FormItem>
              {%- endfor %}

              <FormItem>
                  <Space>
                      <Button type="primary" htmlType="submit" icon={<SearchOutlined/>} style={ {width: 120}}>
                          查询
                      </Button>
                      <Button htmlType="button" onClick={onReset} style={ {width: 100}}>
                          重置
                      </Button>
                  </Space>
              </FormItem>
          </>
      )
  }
  return (
    <Form form={form} name="horizontal_login" layout="inline" onFinish={onFinish}>
      {searchForm()}
    </Form>
  );
};

export default AdvancedSearchForm;
