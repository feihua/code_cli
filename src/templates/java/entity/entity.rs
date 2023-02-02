pub fn get_entity() -> &'static str {
    "package {{package_name}}.entity;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class {{class_name}} implements Serializable {
{% for column in java_columns %}
    //{{column.column_comment}}
    private {{column.java_type}} {{column.java_name}};
{% endfor %}
}
"
}