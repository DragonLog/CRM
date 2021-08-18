package com.zcx.crm.settings.service.impl;

import com.zcx.crm.settings.dao.UserDao;
import com.zcx.crm.settings.domain.User;
import com.zcx.crm.settings.service.UserService;
import com.zcx.crm.utils.DateTimeUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional(readOnly = true)
    public User login(String loginAct, String loginPwd, String ip) throws Exception {  //登录验证
        Map<String, String> map = new HashMap<>();
        map.put("loginAct", loginAct);
        map.put("loginPwd", loginPwd);
        User user = userDao.login(map);
        if (user == null) { //抛出各种登录错误给控制层
            throw new Exception("账号密码错误!");
        }
        String expireTime = user.getExpireTime();
        String currentTime = DateTimeUtil.getSysTime();
        if (expireTime.compareTo(currentTime) < 0) {
            throw new Exception("账号已失效!");
        }
        String lockState = user.getLockState();
        if ("0".equals(lockState)) {
            throw new Exception("账号已锁定!");
        }
        String allowIps = user.getAllowIps();
        if (allowIps != null) {
            if (!allowIps.contains(ip)) {
                throw new Exception("IP地址受限!请联系管理员!");
            }
        }
        return user;
    }

    @Override
    @Transactional(readOnly = true)
    public List<User> getUserList() {   //获取所有登录用户
        List<User> users = userDao.getUserList();
        return users;
    }
}
