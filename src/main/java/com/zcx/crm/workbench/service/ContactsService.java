package com.zcx.crm.workbench.service;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Contacts;
import com.zcx.crm.workbench.domain.ContactsRemark;

import java.util.List;
import java.util.Map;

public interface ContactsService {
    PaginationVO<Contacts> getPageList(Map<String, Object> map);

    Contacts detail(String id);

    List<ContactsRemark> getRemarkListByCid(String contactsId);

    List<Contacts> getContactsListByName(String cname);
}
