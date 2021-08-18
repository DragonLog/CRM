package com.zcx.crm.workbench.web.controller;

import com.zcx.crm.settings.domain.User;
import com.zcx.crm.settings.service.UserService;
import com.zcx.crm.utils.DateTimeUtil;
import com.zcx.crm.utils.UUIDUtil;
import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.*;
import com.zcx.crm.workbench.service.ActivityService;
import com.zcx.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("workbench/clue")
public class ClueController {

    @Autowired
    private ClueService clueService;

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping(value = "getUserList.do", method = RequestMethod.GET)   //获取用户列表
    @ResponseBody
    public List<User> getUserList() {
        List<User> uList = userService.getUserList();
        return uList;
    }

    @RequestMapping(value = "save.do", method = RequestMethod.POST) //保存线索
    @ResponseBody
    public Map<String, Object> save(@RequestBody Clue clue, HttpServletRequest request) throws Exception {
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User) request.getSession().getAttribute("user")).getName();
        clue.setId(id);
        clue.setCreateTime(createTime);
        clue.setCreateBy(createBy);
        boolean flag = clueService.save(clue);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "detail.do", method = RequestMethod.GET)    //线索详细信息
    public ModelAndView detail(String id) {
        Clue clue = clueService.detail(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("c", clue);
        modelAndView.setViewName("/workbench/clue/detail.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "getActivityListByClueId.do", method = RequestMethod.GET)   //通过id获取市场活动列表
    @ResponseBody
    public List<Activity> getActivityListByClueId(String clueId) {
        List<Activity> aList = activityService.getActivityListByClueId(clueId);
        return aList;
    }

    @RequestMapping(value = "unbund.do", method = RequestMethod.POST)   //解除绑定
    @ResponseBody
    public Map<String, Object> unbund(String id) throws Exception {
        boolean flag = clueService.unbund(id);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "getActivityListByNameAndNotByClueId.do", method = RequestMethod.GET)   //通过名称但不通过线索id获取市场活动
    @ResponseBody
    public List<Activity> getActivityListByNameAndNotByClueId(String aname, String clueId) {
        Map<String, Object> map = new HashMap<>();
        map.put("aname", aname);
        map.put("clueId", clueId);
        List<Activity> aList = activityService.getActivityListByNameAndNotByClueId(map);
        return aList;
    }

    @RequestMapping(value = "bund.do", method = RequestMethod.POST) //绑定
    @ResponseBody
    public Map<String, Object> bund(String cid, @RequestParam("aid") String[] aids) throws Exception {
        boolean flag = clueService.bund(cid, aids);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        return map;
    }

    @RequestMapping(value = "getActivityListByName.do", method = RequestMethod.GET) //根据名称获取市场活动
    @ResponseBody
    public List<Activity> getActivityListByName(String aname) {
        List<Activity> aList = activityService.getActivityListByName(aname);
        return aList;
    }

    @RequestMapping(value = "getPageList.do", method = RequestMethod.GET)   //获取分页信息
    @ResponseBody
    public PaginationVO<Clue> getPageList(int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        int skipCount = (pageNo - 1) * pageSize;
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        PaginationVO<Clue> vo = clueService.getPageList(map);
        return vo;
    }

    @RequestMapping(value = "convert.do")   //转换
    public String convert(String flag, String clueId, String money, String name, String expectedDate, String stage, String activityId, HttpServletRequest request) throws Exception {
       Tran tran = null;
       String createBy = ((User)request.getSession().getAttribute("user")).getName();
       if ("a".equals(flag)) {
            tran = new Tran();
            tran.setMoney(money);
            tran.setName(name);
            tran.setExpectedDate(expectedDate);
            tran.setActivityId(activityId);
            tran.setStage(stage);
            tran.setId(UUIDUtil.getUUID());
            tran.setCreateBy(createBy);
            tran.setCreateTime(DateTimeUtil.getSysTime());
       }

       boolean flag1 = clueService.convert(clueId, tran, createBy);
       return "redirect:/workbench/clue/index.jsp";
    }

    @RequestMapping(value = "saveRemark.do", method = RequestMethod.POST)   //保存线索备注
    @ResponseBody
    public Map<String, Object> saveRemark(String noteContent, String clueId, HttpServletRequest request) throws Exception {
        String id = UUIDUtil.getUUID();
        String createTime = DateTimeUtil.getSysTime();
        String createBy = ((User) request.getSession().getAttribute("user")).getName();
        String editFlag = "0";
        ClueRemark clueRemark = new ClueRemark();
        clueRemark.setNoteContent(noteContent);
        clueRemark.setClueId(clueId);
        clueRemark.setId(id);
        clueRemark.setCreateBy(createBy);
        clueRemark.setCreateTime(createTime);
        clueRemark.setEditFlag(editFlag);
        boolean flag = clueService.saveRemark(clueRemark);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("cr", clueRemark);
        return map;
    }

    @RequestMapping(value = "getRemarkListByCid.do", method = RequestMethod.GET)    //通过id获取线索备注
    @ResponseBody
    public List<ClueRemark> getRemarkListByCid(String clueId) {
        List<ClueRemark> crList = clueService.getRemarkListByCid(clueId);
        return crList;
    }

}
