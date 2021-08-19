package com.zcx.crm.workbench.service.impl;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.dao.CustomerDao;
import com.zcx.crm.workbench.dao.CustomerRemarkDao;
import com.zcx.crm.workbench.domain.Customer;
import com.zcx.crm.workbench.domain.CustomerRemark;
import com.zcx.crm.workbench.service.CustomerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class CustomerServiceImpl implements CustomerService {

    @Autowired
    private CustomerDao customerDao;

    @Autowired
    private CustomerRemarkDao customerRemarkDao;

    @Override
    @Transactional(readOnly = true)
    public PaginationVO<Customer> getPageList(Map<String, Object> map) {    //分页信息
        int total = customerDao.getTotal();
        List<Customer> dataList = customerDao.getCustomerList(map);
        PaginationVO<Customer> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    @Transactional(readOnly = true)
    public Customer detail(String id) { //获取详细信息
        Customer customer = customerDao.detail(id);
        return customer;
    }

    @Override
    @Transactional(readOnly = true)
    public List<CustomerRemark> getRemarkListByCid(String customerId) { //通过客户id获取客户备注
        List<CustomerRemark> crList = customerRemarkDao.getRemarkListByCid(customerId);
        return crList;
    }

    @Override
    public List<String> getCustomerName(String cname) {  //通过名称获取客户
        List<String> sList = customerDao.getCustomerName(cname);
        return sList;
    }
}
