package com.zcx.crm.settings.web.controller;

import com.zcx.crm.settings.domain.User;
import com.zcx.crm.settings.service.UserService;
import com.zcx.crm.utils.MD5Util;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.HashMap;
import java.util.Map;

@Controller //控制层注解
@RequestMapping("settings/user")  //访问前缀
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping(value = "login.do", method = RequestMethod.POST)  //访问后缀以及请求方法
    @ResponseBody  //以json形式返回
    public Map<String, Object> login(HttpServletRequest request, String loginAct, String loginPwd) throws Exception {   //springmvc自动为参数赋值
        loginPwd = MD5Util.getMD5(loginPwd);
        String ip = request.getRemoteAddr();
        User user = userService.login(loginAct, loginPwd, ip);
        request.getSession().setAttribute("user", user);
        Map<String, Object> map = new HashMap<>();
        map.put("success", true);
        return map; //按原路径返回
    }

    @RequestMapping(value = "logout.do", method = RequestMethod.GET)    //上面方法为登录，此方法为登出
    public String logout(HttpServletRequest request) {
        HttpSession session = request.getSession();
        session.removeAttribute("user");
        return "redirect:/login.jsp";  //springmvc重定向
    }
}
