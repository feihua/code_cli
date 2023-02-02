pub fn get_entity() -> &'static str {
    "package {{package_name}}.bean;

import java.io.Serializable;
import lombok.Data;

@Data
public class {{class_name}}Bean implements Serializable {
{% for column in java_columns %}
    //{{column.column_comment}}
    private {{column.java_type}} {{column.java_name}}
{% endfor %}
}
"
}