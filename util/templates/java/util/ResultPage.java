package {{package_name}}.util;

import io.swagger.v3.oas.annotations.media.Schema;

import java.io.Serializable;
import java.util.List;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * 描述：分页统一返回
 * 作者：{{author}}
 * 日期：{{create_time}}
 */
@NoArgsConstructor
@AllArgsConstructor
@Data
@Schema(description = "分页统一返回响应vo")
public class ResultPage<T> implements Serializable {

	private List<T> list;
	private Integer pageNum;
	private Integer pageSize;
	private long total;

}
