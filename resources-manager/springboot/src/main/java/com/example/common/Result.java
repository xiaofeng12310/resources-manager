package com.example.common;

import com.example.common.enums.ResultCodeEnum;
import lombok.Data;

@Data  // 使用Lombok自动生成getter/setter
public class Result<T> {  // 添加泛型参数<T>
    private String code;
    private String msg;
    private T data;        // 使用泛型类型替代Object

    // 私有构造方法（带数据）
    private Result(T data) {
        this.data = data;
    }

    // 私有构造方法（无数据）
    private Result() {
    }

    // ------------------------- 成功响应 -------------------------
    // 无数据的成功响应
    public static Result<?> success() {
        Result<?> result = new Result<>();
        result.setCode(ResultCodeEnum.SUCCESS.code);
        result.setMsg(ResultCodeEnum.SUCCESS.msg);
        return result;
    }

    // 带数据的成功响应
    public static <T> Result<T> success(T data) {
        Result<T> result = new Result<>(data);
        result.setCode(ResultCodeEnum.SUCCESS.code);
        result.setMsg(ResultCodeEnum.SUCCESS.msg);
        return result;
    }

    // ------------------------- 错误响应 -------------------------
    // 通用错误（使用枚举）
    public static Result<?> error(ResultCodeEnum errorCode) {
        Result<?> result = new Result<>();
        result.setCode(errorCode.code);
        result.setMsg(errorCode.msg);
        return result;
    }

    // 自定义错误（指定code和msg）
    public static Result<?> error(String code, String msg) {
        Result<?> result = new Result<>();
        result.setCode(code);
        result.setMsg(msg);
        return result;
    }
}