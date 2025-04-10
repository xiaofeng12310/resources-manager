package com.example.exception;

import cn.hutool.log.Log;
import cn.hutool.log.LogFactory;
import com.example.common.Result;
import com.example.common.enums.ResultCodeEnum;
import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;

@ControllerAdvice(basePackages="com.example.controller")
public class GlobalExceptionHandler {
    private static final Log log = LogFactory.get();

    @ExceptionHandler(Exception.class)
    @ResponseBody
    public Result<?> error(HttpServletRequest request, Exception e) {
        log.error("异常信息：", e);
        return Result.error(ResultCodeEnum.SYSTEM_ERROR);
    }

    @ExceptionHandler(CustomException.class)
    @ResponseBody
    public Result<?> customError(HttpServletRequest request, CustomException e) {
        // 优先使用异常中的msg，若为空则使用父类的message
        String errorMsg = (e.getMsg() != null) ? e.getMsg() : e.getMessage();
        return Result.error(e.getCode(), errorMsg);
    }
}