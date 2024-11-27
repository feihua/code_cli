package {{package_name}}.util;

import io.swagger.v3.oas.annotations.media.Schema;

import lombok.Data;

/**
 * 描述：统一返回
 * 作者：{{author}}
 * 日期：{{create_time}}
 */
@Data
@Schema(description = "统一返回响应vo")
public class Result<T> {

	private int code;
	private String msg;
	private boolean success = true;
	private T data;

	public static Result<String> success() {
		Result<String> result = new Result<>();
		result.setCode(0);
		result.setMsg("操作成功");
		return result;
	}

	public static <T> Result<T> success(T data) {
		Result<T> result = new Result<>();
		result.setCode(0);
		result.setMsg("操作成功");
		result.setData(data);
		return result;
	}

	public static Result<String> error(int code, String msg) {
		Result<String> result = new Result<>();
		result.setCode(code);
		result.setMsg(msg);
		return result;
	}
}