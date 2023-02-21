pub fn get_react_search() -> &'static str {
    "
import React from 'react';
import {SearchOutlined} from '@ant-design/icons';
import {Button, Form, Input, Select, Space} from 'antd';
import { {{class_name}}Vo} from \"../data\";

const {Option} = Select;

interface Create{{class_name}}FormProps {
    search: (values: {{class_name}}Vo) => void;
    reSet: () => void;
}

const SearchForm: React.FC<Create{{class_name}}FormProps> = ({search, reSet}) => {
    const FormItem = Form.Item;
    const [form] = Form.useForm();

    const onFinish = (values: any) => {
        search(values)
    };

    const onReset = () => {
        form.resetFields();
        reSet()
    };

    const searchForm = () => {
        return (
            <>
                {% for column in java_columns %}
                <FormItem
                    label=\"{{column.column_comment}}\"
                    name=\"{{column.db_name}}\"
                    rules={[{required: true, message: '请输入{{column.column_comment}}!'}]}
                >
                    <Input/>
                </FormItem>{% endfor %}
                {/*<FormItem*/}
                {/*    label={'状态'}*/}
                {/*    name=\"status_id\"*/}
                {/*>*/}
                {/*    {% raw %}*/}
                {/*    <Select style={{width: 200}}>*/}
                {/*        <Option value=\"1\">启用</Option>*/}
                {/*        <Option value=\"0\">禁用</Option>*/}
                {/*    </Select>*/}
                {/*    {% endraw %}*/}
                {/*</FormItem>*/}
                <FormItem>
                    {% raw %}
                    <Space>
                        <Button type=\"primary\" htmlType=\"submit\" icon={<SearchOutlined/>} style={{width: 120}}>
                            查询
                        </Button>
                        <Button htmlType=\"button\" onClick={onReset} style={{width: 100}}>
                            重置
                        </Button>
                    </Space>
                    {% endraw %}
                </FormItem>
            </>
        )
    }
    return (
        <Form form={form} name=\"horizontal_login\" layout=\"inline\" onFinish={onFinish}>
            {searchForm()}
        </Form>
    );
};

export default SearchForm;
"
}