package {{package_name}}.entity;

import java.io.Serializable;
import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 描述：{{table_info.table_comment}}
 * 作者：{{author}}
 * 日期：{{create_time}}
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class {{table_info.class_name}} implements Serializable {
{% for column in table_info.columns %}
    //{{column.column_comment}}
    private {{column.java_type}} {{column.java_name}};
{% endfor %}
}
