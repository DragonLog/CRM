package com.zcx.crm.workbench.service.impl;

import com.zcx.crm.utils.DateTimeUtil;
import com.zcx.crm.utils.UUIDUtil;
import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.dao.*;
import com.zcx.crm.workbench.domain.*;
import com.zcx.crm.workbench.service.ClueService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
import java.util.Map;

@Service
public class ClueServiceImpl implements ClueService {

    @Autowired
    private ClueDao clueDao;
    @Autowired
    private ClueActivityRelationDao clueActivityRelationDao;
    @Autowired
    private ClueRemarkDao clueRemarkDao;
    @Autowired
    private CustomerDao customerDao;
    @Autowired
    private CustomerRemarkDao customerRemarkDao;
    @Autowired
    private ContactsDao contactsDao;
    @Autowired
    private ContactsRemarkDao contactsRemarkDao;
    @Autowired
    private ContactsActivityRelationDao contactsActivityRelationDao;
    @Autowired
    private TranDao tranDao;
    @Autowired
    private TranHistoryDao tranHistoryDao;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(Clue clue) throws Exception {   //保存线索
        boolean flag = true;
        int count = clueDao.save(clue);
        if (count != 1) {
            throw new Exception("插入有误!");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public Clue detail(String id) { //获取线索详细信息
        Clue clue = clueDao.detail(id);
        return clue;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean unbund(String id) throws Exception { //解除与市场活动的绑定
        boolean flag = true;
        int count = clueActivityRelationDao.unbund(id);
        if (count != 1) {
            throw new Exception("删除有误！");
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean bund(String cid, String[] aids) throws Exception {   //与市场活动绑定
        boolean flag = true;
        for(String aid : aids) {
            ClueActivityRelation clueActivityRelation = new ClueActivityRelation();
            clueActivityRelation.setId(UUIDUtil.getUUID());
            clueActivityRelation.setActivityId(aid);
            clueActivityRelation.setClueId(cid);
            int count = clueActivityRelationDao.bund(clueActivityRelation);
            if (count != 1) {
                throw new Exception("插入有误！");
            }
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public PaginationVO<Clue> getPageList(Map<String, Object> map) {    //获取分页信息
        int total = clueDao.getTotal();
        List<Clue> dataList = clueDao.getClueList(map);
        PaginationVO<Clue> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean convert(String clueId, Tran tran, String createBy) throws Exception {    //转换线索
        String createTime = DateTimeUtil.getSysTime();
        boolean flag = true;
        Clue clue = clueDao.getById(clueId);
        String company = clue.getCompany();
        Customer customer = customerDao.getCustomerByName(company);
        if (customer == null) {
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setAddress(clue.getAddress());
            customer.setWebsite(clue.getWebsite());
            customer.setPhone(clue.getPhone());
            customer.setOwner(clue.getOwner());
            customer.setNextContactTime(clue.getNextContactTime());
            customer.setName(company);
            customer.setDescription(clue.getDescription());
            customer.setCreateTime(createTime);
            customer.setCreateBy(createBy);
            customer.setContactSummary(clue.getContactSummary());
            int count1 = customerDao.save(customer);
            if (count1 != 1) {
                throw new Exception("插入有误！");
            }
        }
        Contacts contacts = new Contacts();
        contacts.setId(UUIDUtil.getUUID());
        contacts.setSource(clue.getSource());
        contacts.setOwner(clue.getOwner());
        contacts.setNextContactTime(clue.getNextContactTime());
        contacts.setMphone(clue.getMphone());
        contacts.setJob(clue.getJob());
        contacts.setFullname(clue.getFullname());
        contacts.setEmail(clue.getEmail());
        contacts.setDescription(clue.getDescription());
        contacts.setCustomerId(customer.getId());
        contacts.setCreateTime(createTime);
        contacts.setCreateBy(createBy);
        contacts.setContactSummary(clue.getContactSummary());
        contacts.setAppellation(clue.getAppellation());
        contacts.setAddress(clue.getAddress());
        int count2 = contactsDao.save(contacts);
        if (count2 != 1) {
            throw new Exception("插入有误!");
        }
        List<ClueRemark> clueRemarkList = clueRemarkDao.getRemarkListByCid(clueId);
        for (ClueRemark clueRemark : clueRemarkList) {
            String noteContent = clueRemark.getNoteContent();
            CustomerRemark customerRemark = new CustomerRemark();
            customerRemark.setId(UUIDUtil.getUUID());
            customerRemark.setCreateBy(createBy);
            customerRemark.setCreateTime(createTime);
            customerRemark.setCustomerId(customer.getId());
            customerRemark.setEditFlag("0");
            customerRemark.setNoteContent(noteContent);
            int count3 = customerRemarkDao.save(customerRemark);
            if (count3 != 1) {
                throw new Exception("插入有误！");
            }

            ContactsRemark contactsRemark = new ContactsRemark();
            contactsRemark.setId(UUIDUtil.getUUID());
            contactsRemark.setCreateBy(createBy);
            contactsRemark.setCreateTime(createTime);
            contactsRemark.setContactsId(contacts.getId());
            contactsRemark.setEditFlag("0");
            contactsRemark.setNoteContent(noteContent);
            int count4 = contactsRemarkDao.save(contactsRemark);
            if (count4 != 1) {
                throw new Exception("插入有误！");
            }
        }
        List<ClueActivityRelation> clueActivityRelationList = clueActivityRelationDao.getListByClueId(clueId);
        for (ClueActivityRelation clueActivityRelation : clueActivityRelationList) {
            String activityId = clueActivityRelation.getActivityId();
            ContactsActivityRelation contactsActivityRelation = new ContactsActivityRelation();
            contactsActivityRelation.setId(UUIDUtil.getUUID());
            contactsActivityRelation.setContactsId(contacts.getId());
            contactsActivityRelation.setActivityId(activityId);
            int count5 = contactsActivityRelationDao.save(contactsActivityRelation);
            if (count5 != 1) {
                throw new Exception("插入有误！");
            }
        }
        if (tran != null) {
            tran.setSource(clue.getSource());
            tran.setOwner(clue.getOwner());;
            tran.setNextContactTime(clue.getNextContactTime());
            tran.setDescription(clue.getDescription());
            tran.setCustomerId(customer.getId());
            tran.setContactSummary(clue.getContactSummary());
            tran.setContactsId(contacts.getId());
            int count6 = tranDao.save(tran);
            if (count6 != 1) {
                throw new Exception("插入有误！");
            }
            TranHistory tranHistory = new TranHistory();
            tranHistory.setId(UUIDUtil.getUUID());
            tranHistory.setCreateBy(createBy);
            tranHistory.setCreateTime(createTime);
            tranHistory.setExpectedDate(tran.getExpectedDate());
            tranHistory.setMoney(tran.getMoney());
            tranHistory.setStage(tran.getStage());
            tranHistory.setTranId(tran.getId());
            int count7 = tranHistoryDao.save(tranHistory);
            if (count7 != 1) {
                throw new Exception("插入有误！");
            }
        }
        for (ClueRemark clueRemark : clueRemarkList) {
            int count8 = clueRemarkDao.delete(clueRemark);
            if (count8 != 1) {
                throw new Exception("删除有误！");
            }
        }
        for (ClueActivityRelation clueActivityRelation :clueActivityRelationList) {
            int count9 = clueActivityRelationDao.delete(clueActivityRelation);
            if (count9 != 1) {
                throw new Exception("删除有误！");
            }
        }
        int count10 = clueDao.delete(clueId);
        if (count10 != 1) {
            throw new Exception("删除有误！");
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean saveRemark(ClueRemark clueRemark) throws Exception { //保存线索备注
        boolean flag = true;
        int count = clueRemarkDao.saveRemark(clueRemark);
        if (count != 1) {
            throw new Exception("添加有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ClueRemark> getRemarkListByCid(String clueId) { //通过线索id获取线索备注
        List<ClueRemark> crList = clueRemarkDao.getRemarkListByCid(clueId);
        return crList;
    }
}
