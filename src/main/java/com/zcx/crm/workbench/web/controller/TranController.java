package com.zcx.crm.workbench.web.controller;

import com.zcx.crm.settings.domain.User;
import com.zcx.crm.settings.service.UserService;
import com.zcx.crm.utils.DateTimeUtil;
import com.zcx.crm.utils.UUIDUtil;
import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Activity;
import com.zcx.crm.workbench.domain.Contacts;
import com.zcx.crm.workbench.domain.Tran;
import com.zcx.crm.workbench.domain.TranHistory;
import com.zcx.crm.workbench.service.ActivityService;
import com.zcx.crm.workbench.service.ContactsService;
import com.zcx.crm.workbench.service.CustomerService;
import com.zcx.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("workbench/transaction")
public class TranController {

    @Autowired
    private TranService tranService;

    @Autowired
    private UserService userService;

    @Autowired
    private ActivityService activityService;

    @Autowired
    private ContactsService contactsService;

    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "getPageList.do", method = RequestMethod.GET)   //分页信息
    @ResponseBody
    public PaginationVO<Tran> getPageList(int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        int skipCount = (pageNo - 1) * pageSize;
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        PaginationVO<Tran> vo = tranService.getPageList(map);
        return vo;
    }

    @RequestMapping(value = "add.do", method = RequestMethod.GET)   //添加交易调度
    public ModelAndView add() {
        List<User> userList = userService.getUserList();
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("uList", userList);
        modelAndView.setViewName("/workbench/transaction/save.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "getActivityListByName.do", method = RequestMethod.GET) //通过名称获取市场活动
    @ResponseBody
    public List<Activity> getActivityListByName(String aname) {
        List<Activity> aList = activityService.getActivityListByName(aname);
        return aList;
    }

    @RequestMapping(value = "getContactsListByName.do", method = RequestMethod.GET) //通过名称获取联系人
    @ResponseBody
    public List<Contacts> getContactsListByName(String cname) {
        List<Contacts> cList = contactsService.getContactsListByName(cname);
        return cList;
    }

    @RequestMapping(value = "getCustomerName.do", method = RequestMethod.GET)
    @ResponseBody
    public List<String> getCustomerName(String name) {  //获取客户名称
        List<String> sList = customerService.getCustomerName(name);
        return sList;
    }

    @RequestMapping(value = "save.do", method = RequestMethod.POST) //保存交易
    public String save(Tran tran, String customerName, HttpServletRequest request) throws Exception {
        tran.setId(UUIDUtil.getUUID());
        tran.setCreateTime(DateTimeUtil.getSysTime());
        tran.setCreateBy(((User) request.getSession().getAttribute("user")).getName());
        boolean flag = tranService.save(tran, customerName);
        return "redirect:/workbench/transaction/index.jsp";
    }

    @RequestMapping(value = "detail.do", method = RequestMethod.GET)
    public ModelAndView detail(String id, HttpServletRequest request) { //交易详细信息
        Tran tran = tranService.detail(id);
        String stage = tran.getStage();
        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        String possibility = pMap.get(stage);
        tran.setPossibility(possibility);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("t", tran);
        modelAndView.setViewName("/workbench/transaction/detail.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "getHistoryListByTranId.do", method = RequestMethod.GET)    //通过交易id获取交易历史
    @ResponseBody
    public List<TranHistory> getHistoryListByTranId(String tranId, HttpServletRequest request) {
        List<TranHistory> thList = tranService.getHistoryListByTranId(tranId);
        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        for (TranHistory tranHistory : thList) {
            String stage = tranHistory.getStage();
            String possibility = pMap.get(stage);
            tranHistory.setPossibility(possibility);
        }
        return thList;
    }

    @RequestMapping(value = "changeStage.do", method = RequestMethod.POST)  //改变交易阶段
    @ResponseBody
    public Map<String, Object> changeStage(Tran tran, HttpServletRequest request) throws Exception {
        Map<String, String> pMap = (Map<String, String>) request.getServletContext().getAttribute("pMap");
        String editTime = DateTimeUtil.getSysTime();
        String editBy = ((User) request.getSession().getAttribute("user")).getName();
        tran.setEditBy(editBy);
        tran.setEditTime(editTime);
        tran.setPossibility(pMap.get(tran.getStage()));
        boolean flag = tranService.changeStage(tran);
        Map<String, Object> map = new HashMap<>();
        map.put("success", flag);
        map.put("t", tran);
        return map;
    }

    @RequestMapping(value = "getCharts.do", method = RequestMethod.GET) //获取图表信息
    @ResponseBody
    public Map<String, Object> getCharts() {
        Map<String, Object> map = tranService.getCharts();
        return map;
    }

}
