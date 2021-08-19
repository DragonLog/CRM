package com.zcx.crm.workbench.service.impl;

import com.zcx.crm.utils.DateTimeUtil;
import com.zcx.crm.utils.UUIDUtil;
import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.dao.CustomerDao;
import com.zcx.crm.workbench.dao.TranDao;
import com.zcx.crm.workbench.dao.TranHistoryDao;
import com.zcx.crm.workbench.domain.Customer;
import com.zcx.crm.workbench.domain.Tran;
import com.zcx.crm.workbench.domain.TranHistory;
import com.zcx.crm.workbench.service.TranService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class TranServiceImpl implements TranService {

    @Autowired
    private TranDao tranDao;

    @Autowired
    private TranHistoryDao tranHistoryDao;

    @Autowired
    private CustomerDao customerDao;

    @Override
    @Transactional(readOnly = true)
    public PaginationVO<Tran> getPageList(Map<String, Object> map) {    //分页信息
        int total = tranDao.getTotal();
        List<Tran> dataList = tranDao.getTranList(map);
        PaginationVO<Tran> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean save(Tran tran, String customerName) throws Exception {  //保存交易信息
        boolean flag = true;
        Customer customer = customerDao.getCustomerByName(customerName);
        if (customer == null) {
            customer = new Customer();
            customer.setId(UUIDUtil.getUUID());
            customer.setName(customerName);
            customer.setCreateBy(tran.getCreateBy());
            customer.setCreateTime(DateTimeUtil.getSysTime());
            customer.setContactSummary(tran.getContactSummary());
            customer.setNextContactTime(tran.getNextContactTime());
            customer.setOwner(tran.getOwner());
            customer.setWebsite("www.test.com");
            customer.setPhone("10086");
            int count1 = customerDao.save(customer);
            if (count1 != 1) {
                throw new Exception("插入有误！");
            }
        }
        tran.setCustomerId(customer.getId());
        int count2 = tranDao.save(tran);
        if (count2 != 1) {
            throw new Exception("插入有误！");
        }
        TranHistory tranHistory = new TranHistory();
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setTranId(tran.getId());
        tranHistory.setStage(tran.getStage());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setCreateBy(tran.getCreateBy());

        int count3 = tranHistoryDao.save(tranHistory);
        if (count3 != 1) {
            throw new Exception("插入有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public Tran detail(String id) { //获取详细信息
        Tran tran = tranDao.detail(id);
        return tran;
    }

    @Override
    @Transactional(readOnly = true)
    public List<TranHistory> getHistoryListByTranId(String tranId) {    //通过交易id获取交易历史
        List<TranHistory> thList = tranHistoryDao.getHistoryListByTranId(tranId);
        return thList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)   //改变交易阶段
    public boolean changeStage(Tran tran) throws Exception {
        boolean flag = true;
        int count1 = tranDao.changeStage(tran);
        if (count1 != 1) {
            throw new Exception("修改有误！");
        }
        TranHistory tranHistory = new TranHistory();
        tranHistory.setStage(tran.getStage());
        tranHistory.setId(UUIDUtil.getUUID());
        tranHistory.setCreateBy(tran.getEditBy());
        tranHistory.setCreateTime(DateTimeUtil.getSysTime());
        tranHistory.setExpectedDate(tran.getExpectedDate());
        tranHistory.setMoney(tran.getMoney());
        tranHistory.setTranId(tran.getId());
        int count2 = tranHistoryDao.save(tranHistory);
        if (count2 != 1) {
            throw new Exception("插入有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> getCharts() {    //获取图表数据
        int total = tranDao.getTotal();
        List<Map<String, Object>> dataList = tranDao.getCharts();
        Map<String, Object> map = new HashMap<>();
        map.put("total", total);
        map.put("dataList", dataList);
        return map;
    }

}
