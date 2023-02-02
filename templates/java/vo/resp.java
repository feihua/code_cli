package {{package_name}}.bean;

import java.io.Serializable;
import lombok.Data;

@Data
@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
@ApiModel("{{table_comment}}响应vo")
public class {{class_name}}Resp implements Serializable {
{% for column in java_columns %}
    @ApiModelProperty("{{column.column_comment}}")
    private {{column.java_type}} {{column.java_name}}
{% endfor %}
}
