import React from 'react';
import {SearchOutlined} from '@ant-design/icons';
import {Button, Form, FormProps, Input, Select, Space} from 'antd';
import { {{table_info.class_name}}Vo} from "../data";

interface CreateFormProps {
    search: (values: {{table_info.class_name}}Vo) => void;
    reSet: () => void;
}

const AdvancedSearchForm: React.FC<CreateFormProps> = ({search, reSet}) => {
    const FormItem = Form.Item;
    const [form] = Form.useForm();


    const onFinish: FormProps<{{table_info.class_name}}Vo>['onFinish'] = (values) => {
        search(values);
    };

    const onReset = () => {
        form.resetFields();
        reSet()
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