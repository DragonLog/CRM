package com.zcx.crm.workbench.service;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Customer;
import com.zcx.crm.workbench.domain.CustomerRemark;

import java.util.List;
import java.util.Map;

public interface CustomerService {
    PaginationVO<Customer> getPageList(Map<String, Object> map);

    Customer detail(String id);

    List<CustomerRemark> getRemarkListByCid(String customerId);

    List<String> getCustomerName(String cname);
}
