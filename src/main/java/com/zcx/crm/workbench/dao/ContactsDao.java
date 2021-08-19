package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.Contacts;

import java.util.List;
import java.util.Map;

public interface ContactsDao {

    int save(Contacts contacts);

    int getTotal();

    List<Contacts> getContactsList(Map<String, Object> map);

    Contacts detail(String id);

    List<Contacts> getContactsListByName(String cname);
}
