package com.zcx.crm.workbench.service.impl;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.dao.ContactsDao;
import com.zcx.crm.workbench.dao.ContactsRemarkDao;
import com.zcx.crm.workbench.domain.Contacts;
import com.zcx.crm.workbench.domain.ContactsRemark;
import com.zcx.crm.workbench.service.ContactsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ContactsServiceImpl implements ContactsService {

    @Autowired
    private ContactsDao contactsDao;

    @Autowired
    private ContactsRemarkDao contactsRemarkDao;

    @Override
    @Transactional(readOnly = true)
    public PaginationVO<Contacts> getPageList(Map<String, Object> map) {    //分页信息
        int total = contactsDao.getTotal();
        List<Contacts> dataList = contactsDao.getContactsList(map);
        PaginationVO<Contacts> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    @Transactional(readOnly = true)
    public Contacts detail(String id) { //获取详细信息
        Contacts contacts = contactsDao.detail(id);
        return contacts;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ContactsRemark> getRemarkListByCid(String ContactsId) { //根据联系人id获取联系人备注
        List<ContactsRemark> crList = contactsRemarkDao.getRemarkListByCid(ContactsId);
        return crList;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Contacts> getContactsListByName(String cname) { //根据名称获取联系人
        List<Contacts> cList = contactsDao.getContactsListByName(cname);
        return cList;
    }
}
