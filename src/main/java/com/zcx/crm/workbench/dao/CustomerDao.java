package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.Customer;

import java.util.List;
import java.util.Map;

public interface CustomerDao {

    int save(Customer customer);

    Customer getCustomerByName(String company);

    int getTotal();

    List<Customer> getCustomerList(Map<String, Object> map);

    Customer detail(String id);

    List<String> getCustomerName(String cname);
}
