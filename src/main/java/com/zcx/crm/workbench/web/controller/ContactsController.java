package com.zcx.crm.workbench.web.controller;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.*;
import com.zcx.crm.workbench.service.ActivityService;
import com.zcx.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
@RequestMapping("workbench/contacts")
public class ContactsController {

    @Autowired
    private ContactsService contactsService;

    @Autowired
    private ActivityService activityService;

    @RequestMapping(value = "getPageList.do", method = RequestMethod.GET)   //分页信息
    @ResponseBody
    public PaginationVO<Contacts> getPageList(int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        int skipCount = (pageNo - 1) * pageSize;
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        PaginationVO<Contacts> vo = contactsService.getPageList(map);
        return vo;
    }

    @RequestMapping(value = "detail.do", method = RequestMethod.GET)    //联系人详细信息
    public ModelAndView detail(String id) {
        Contacts contacts = contactsService.detail(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("c", contacts);
        modelAndView.setViewName("/workbench/contacts/detail.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "getRemarkListByCid.do", method = RequestMethod.GET)   //通过联系人id获取备注
    @ResponseBody
    public List<ContactsRemark> getRemarkListByCid(String contactsId) {
        List<ContactsRemark> crList = contactsService.getRemarkListByCid(contactsId);
        return crList;
    }

    @RequestMapping(value = "getActivityListByContactsId.do", method = RequestMethod.GET)
    @ResponseBody
    public List<Activity> getActivityListByContactsId(String contactsId) {  //通过联系人id获取市场活动
        List<Activity> aList = activityService.getActivityListByContactsId(contactsId);
        return aList;
    }

}
