package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.CustomerRemark;

import java.util.List;

public interface CustomerRemarkDao {

    int save(CustomerRemark customerRemark);

    List<CustomerRemark> getRemarkListByCid(String customerId);
}
