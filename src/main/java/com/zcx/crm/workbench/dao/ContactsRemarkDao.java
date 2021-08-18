package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.ContactsRemark;

import java.util.List;

public interface ContactsRemarkDao {

    int save(ContactsRemark contactsRemark);

    List<ContactsRemark> getRemarkListByCid(String contactsId);
}
