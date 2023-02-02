pub fn get_req() -> &'static str {
    "package {{package_name}}.vo.req;

import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;

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
@ApiModel(\"{{table_comment}}请求vo\")
public class {{class_name}}Req implements Serializable {
{% for column in java_columns %}
    @ApiModelProperty(\"{{column.column_comment}}\")
    private {{column.java_type}} {{column.java_name}};
{% endfor %}
}"
}
