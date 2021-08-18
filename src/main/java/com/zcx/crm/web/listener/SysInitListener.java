package com.zcx.crm.web.listener;

import com.zcx.crm.settings.domain.DicValue;
import com.zcx.crm.settings.service.DicService;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import java.util.*;


public class SysInitListener implements ServletContextListener {    //监听器

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        ServletContext application = servletContextEvent.getServletContext();
        WebApplicationContext webApplicationContext = WebApplicationContextUtils.getWebApplicationContext(application); //取出spring容器
        DicService dicService = (DicService) webApplicationContext.getBean("dicServiceImpl");   //从spring容器中取出业务层
        Map<String, List<DicValue>> map = dicService.getAll();
        Set<String> set = map.keySet();
        for (String key : set) {
            application.setAttribute(key, map.get(key));    //在全局对象中插入数据字典
        }
        ResourceBundle resourceBundle = ResourceBundle.getBundle("Stage2Possibility");  //读取“阶段可能性”配置文件
        Enumeration<String> keys = resourceBundle.getKeys();
        Map<String, String> pMap = new HashMap<>();
        while (keys.hasMoreElements()) {
            String key = keys.nextElement();
            String value = resourceBundle.getString(key);
            pMap.put(key, value);
        }
        application.setAttribute("pMap", pMap); //同样插入到全局对象中
    }

    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }
}
