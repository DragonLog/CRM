package com.zcx.crm.workbench.web.controller;

import com.zcx.crm.settings.domain.User;
import com.zcx.crm.settings.service.UserService;
import com.zcx.crm.utils.DateTimeUtil;
import com.zcx.crm.utils.UUIDUtil;
import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Activity;
import com.zcx.crm.workbench.domain.ActivityRemark;
import com.zcx.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller //所有控制器如果抛出Exception异常都会转到全局异常处理的增强控制器
@RequestMapping("workbench/activity")
public class ActivityController {

    @Autowired
    private ActivityService activityService;

    @Autowired
    private UserService userService;

    @RequestMapping(value = "getUserList.do", method = RequestMethod.GET)   //获取用户列表
    @ResponseBody
    public List<User> getUserList() {
        List<User> users = userService.getUserList();
        return users;
    }

    @RequestMapping(value = "save.do", method = RequestMethod.POST) //保存市场活动
    @ResponseBody
    public Map<String, Object> save(@RequestBody Activity activity, HttpServletRequest request) throws Exception {  //springmvc控制器接收参数有许多形式
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User) request.getSession().getAttribute("user")).getName();

        activity.setId(id);
        activity.setCreateTime(createTime);
        activity.setCreateBy(createBy);

        boolean flag = activityService.save(activity);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "getPageList.do", method = RequestMethod.POST)  //获取分页信息
    @ResponseBody
    public PaginationVO<Activity> getPageList(@RequestBody Map<String, Object> map) {
        int pageNo = (int) map.get("pageNo");
        int pageSize = (int) map.get("pageSize");
        int skipCount = (pageNo - 1) * pageSize;
        map.put("skipCount", skipCount);
        map.remove("pageNo");
        PaginationVO<Activity> vo = activityService.getpageList(map);
        return vo;
    }

    @RequestMapping(value = "delete.do", method = RequestMethod.POST)   //删除市场活动
    @ResponseBody
    public Map<String, Object> delete(@RequestParam("id") String[] ids) throws Exception {
        boolean flag = activityService.delete(ids);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "getUserListAndActivity.do", method = RequestMethod.GET)    //根据id获取用户列表和市场活动
    @ResponseBody
    public Map<String, Object> getUserListAndActivity(String id) {
        Map<String, Object> map = activityService.getUserListAndActivity(id);
        return map;
    }

    @RequestMapping(value = "update.do", method = RequestMethod.POST)   //更新市场活动
    @ResponseBody
    public Map<String, Object> update(@RequestBody Activity activity, HttpServletRequest request) throws Exception {
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User) request.getSession().getAttribute("user")).getName();

        activity.setEditTime(editTime);
        activity.setEditBy(editBy);

        boolean flag = activityService.update(activity);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "detail.do", method = RequestMethod.GET)    //市场活动详细信息
    public ModelAndView detail(String id) { //ModelAndView是非常方便的包含数据与视图的类
        Activity activity = activityService.detail(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("activity", activity);
        modelAndView.setViewName("/workbench/activity/detail.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "getRemarkListByAid.do", method = RequestMethod.GET)    //通过id获取备注列表
    @ResponseBody
    public List<ActivityRemark> getRemarkListByAid(String activityId) {
        List<ActivityRemark> arList = activityService.getRemarkListByAid(activityId);
        return arList;
    }

    @RequestMapping(value = "deleteRemark.do", method = RequestMethod.POST) //删除备注
    @ResponseBody
    public Map<String, Object> deleteRemark(String id) throws Exception {
        boolean flag = activityService.deleteRemark(id);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "saveRemark.do", method = RequestMethod.POST)   //保存备注
    @ResponseBody
    public Map<String, Object> saveRemark(String noteContent, String activityId, HttpServletRequest request) throws Exception {
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User) request.getSession().getAttribute("user")).getName();
        String editFlag = "0";
        ActivityRemark activityRemark = new ActivityRemark();
        activityRemark.setNoteContent(noteContent);
        activityRemark.setActivityId(activityId);
        activityRemark.setId(id);
        activityRemark.setCreateBy(createBy);
        activityRemark.setCreateTime(createTime);
        activityRemark.setEditFlag(editFlag);
        boolean flag = activityService.saveRemark(activityRemark);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("ar", activityRemark);
        return map;
    }

    @RequestMapping(value = "updateRemark.do", method = RequestMethod.POST) //更新备注
    @ResponseBody
    public Map<String, Object> updateRemark(String id, String noteContent, HttpServletRequest request) throws Exception {
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User) request.getSession().getAttribute("user")).getName();
        String editFlag = "1";
        ActivityRemark activityRemark = new ActivityRemark();
        activityRemark.setId(id);
        activityRemark.setNoteContent(noteContent);
        activityRemark.setEditFlag(editFlag);
        activityRemark.setEditBy(editBy);
        activityRemark.setEditTime(editTime);
        boolean flag = activityService.updateRemark(activityRemark);
        Map<String, Object> map = new HashMap<>();
        map.put(("success"), flag);
        map.put("ar", activityRemark);
        return map;
    }
}
