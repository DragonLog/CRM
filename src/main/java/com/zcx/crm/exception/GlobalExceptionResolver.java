package com.zcx.crm.exception;

import org.springframework.web.bind.annotation.ControllerAdvice;
import org.springframework.web.bind.annotation.ExceptionHandler;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.HashMap;
import java.util.Map;

@ControllerAdvice   //增强控制器注解
public class GlobalExceptionResolver {  //定义全局异常处理

    @ExceptionHandler(Exception.class)  //所有的控制器如果抛出Exception异常都会转到这里处理
    @ResponseBody
    public Map<String, Object> doException(Exception ex) {
//        ex.printStackTrace();         //可以选择打印异常堆栈
        Map<String, Object> map = new HashMap<>();
        map.put("success", false);
        map.put("msg", ex.getMessage());
        return map;
    }

}
