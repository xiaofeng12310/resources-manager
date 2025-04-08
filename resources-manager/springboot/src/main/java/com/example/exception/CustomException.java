package com.example.exception;

import com.example.common.enums.ResultCodeEnum;

public class CustomException extends RuntimeException {
    private String code;
    private String msg;  // 新增msg字段

    // 通过枚举构造异常
    public CustomException(ResultCodeEnum resultCode) {
        super(resultCode.msg);
        this.code = resultCode.code;
        this.msg = resultCode.msg;
    }

    // 通过枚举+自定义消息构造异常
    public CustomException(ResultCodeEnum resultCode, String message) {
        super(message);
        this.code = resultCode.code;
        this.msg = message;
    }

    // 直接通过code+msg构造异常
    public CustomException(String code, String msg) {
        super(msg);
        this.code = code;
        this.msg = msg;
    }

    // Getter方法
    public String getCode() {
        return code;
    }

    public String getMsg() {
        return msg;
    }
}