package {{package_name}}.vo.req.{{module_name}};

import io.swagger.v3.oas.annotations.media.Schema;

import java.io.Serializable;
import java.util.Date;

import jakarta.validation.constraints.NotBlank;
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
@Builder(toBuilder = true)
@NoArgsConstructor
@AllArgsConstructor
@Schema(description = "{{table_info.table_comment}}请求vo")
public class {{table_info.class_name}}Req implements Serializable {
{% for column in table_info.columns %}
    @Schema(description = "{{column.column_comment}}", requiredMode = Schema.RequiredMode.REQUIRED)
    @NotBlank(message = "{{column.column_comment}}{{column.java_name}}不能为空")
    private {{column.java_type}} {{column.java_name}};
{% endfor %}

}
