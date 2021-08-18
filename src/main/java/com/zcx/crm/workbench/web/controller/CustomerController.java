package com.zcx.crm.workbench.web.controller;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Customer;
import com.zcx.crm.workbench.domain.CustomerRemark;
import com.zcx.crm.workbench.service.CustomerService;
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
@RequestMapping("workbench/customer")
public class CustomerController {

    @Autowired
    private CustomerService customerService;

    @RequestMapping(value = "getPageList.do", method = RequestMethod.GET)   //分页信息
    @ResponseBody
    public PaginationVO<Customer> getPageList(int pageNo, int pageSize) {
        Map<String, Object> map = new HashMap<>();
        int skipCount = (pageNo - 1) * pageSize;
        map.put("pageSize", pageSize);
        map.put("skipCount", skipCount);
        PaginationVO<Customer> vo = customerService.getPageList(map);
        return vo;
    }

    @RequestMapping(value = "detail.do", method = RequestMethod.GET)    //客户详细信息
    public ModelAndView detail(String id) {
        Customer customer = customerService.detail(id);
        ModelAndView modelAndView = new ModelAndView();
        modelAndView.addObject("c", customer);
        modelAndView.setViewName("/workbench/customer/detail.jsp");
        return modelAndView;
    }

    @RequestMapping(value = "getRemarkListByCid.do", method = RequestMethod.GET)    //通过客户id获取备注
    @ResponseBody
    public List<CustomerRemark> getRemarkListByCid(String customerId) {
        List<CustomerRemark> crList = customerService.getRemarkListByCid(customerId);
        return crList;
    }

}
