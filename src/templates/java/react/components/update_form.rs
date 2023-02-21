pub fn get_react_update() -> &'static str {
    "import React, {useEffect} from 'react';
import {Form, Input, InputNumber, Modal, Radio} from 'antd';
import { {{class_name}}Vo} from \"../data\";
import TextArea from \"antd/es/input/TextArea\";

interface Update{{class_name}}FormProps {
    open: boolean;
    onCreate: (values: {{class_name}}Vo) => void;
    onCancel: () => void;
    {{table_name}}Vo?: {{class_name}}Vo;
}

const UpdateForm: React.FC<Update{{class_name}}FormProps> = ({open, onCreate, onCancel, userVo}) => {
    const [form] = Form.useForm();
    const FormItem = Form.Item;

    useEffect(() => {
        if (userVo) {
            form.setFieldsValue(userVo);
        }
    }, [open]);

    const handleOk = () => {
        form.validateFields()
            .then((values) => {
                form.resetFields();
                onCreate(values);
            })
            .catch((info) => {
                console.log('Validate Failed:', info);
            });
    }

    const formContent = () => {
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
                {/*    label=\"排序\"*/}
                {/*    name=\"sort\"*/}
                {/*    rules={[{required: true, message: '请输入排序!'}]}>*/}
                {/*    <InputNumber defaultValue={1}/>*/}
                {/*</FormItem>*/}
                {/*<FormItem*/}
                {/*    label=\"状态\"*/}
                {/*    name=\"status_id\"*/}
                {/*    rules={[{required: true, message: '请输入状态!'}]}>*/}
                {/*    <Radio.Group defaultValue={1}>*/}
                {/*        <Radio value={1}>启用</Radio>*/}
                {/*        <Radio value={0}>禁用</Radio>*/}
                {/*    </Radio.Group>*/}
                {/*</FormItem>*/}
                {/*<FormItem*/}
                {/*    label=\"备注\"*/}
                {/*    name=\"remark\"*/}
                {/*>*/}
                {/*    <TextArea rows={2}/>*/}
                {/*</FormItem>*/}
            </>
        )
    }

    const modalFooter = {title: \"更新\", okText: '保存', onOk: handleOk, onCancel, cancelText: '取消', open, width: 480};
    const formLayout = {labelCol: {span: 7}, wrapperCol: {span: 13}, form};

    return (
        {% raw %}
        <Modal {...modalFooter} style={{top: 150}}>
            <Form {...formLayout} style={{marginTop: 30}}>
                {formContent()}
            </Form>
        </Modal>
        {% endraw %}
    );
};

export default UpdateForm;
"
}