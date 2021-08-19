package com.zcx.crm.workbench.service.impl;

import com.zcx.crm.settings.dao.UserDao;
import com.zcx.crm.settings.domain.User;
import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.dao.ActivityDao;
import com.zcx.crm.workbench.dao.ActivityRemarkDao;
import com.zcx.crm.workbench.domain.Activity;
import com.zcx.crm.workbench.domain.ActivityRemark;
import com.zcx.crm.workbench.service.ActivityService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ActivityServiceImpl implements ActivityService {

    @Autowired
    private ActivityDao activityDao;

    @Autowired
    private ActivityRemarkDao activityRemarkDao;

    @Autowired
    private UserDao userDao;

    @Override
    @Transactional(rollbackFor = Exception.class)   //如果被注解方法抛出Exception异常则事务回滚
    public boolean save(Activity activity) throws Exception {   //保存市场活动
        boolean flag = true;
        int count = activityDao.save(activity);
        if (count != 1) {
            throw new Exception("插入有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public PaginationVO<Activity> getpageList(Map<String, Object> map) {    //获取分页信息
        int total = activityDao.getTotalByCondition(map);
        List<Activity> dataList = activityDao.getActivityListByCondition(map);
        PaginationVO<Activity> vo = new PaginationVO<>();
        vo.setTotal(total);
        vo.setDataList(dataList);
        return vo;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean delete(String[] ids) throws Exception {  //批量删除市场活动
        boolean flag = true;

        int count1 = activityRemarkDao.getCountByAids(ids);
        int count2 = activityRemarkDao.deleteByAids(ids);

        if (count1 != count2) {
            throw new Exception("删除有误！");
        }

        int count3 = activityDao.delete(ids);

        if (count3 != ids.length) {
            throw new Exception("删除有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public Map<String, Object> getUserListAndActivity(String id) {      //获取全部用户以及根据id获取市场活动
        List<User> uList = userDao.getUserList();
        Activity a = activityDao.getById(id);
        Map<String, Object> map = new HashMap<>();
        map.put("uList", uList);
        map.put("a", a);
        return map;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean update(Activity activity) throws Exception { //更新市场活动
        boolean flag = true;
        int count = activityDao.update(activity);
        if (count != 1) {
            throw new Exception("修改有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public Activity detail(String id) { //根据id查询市场活动详细信息
        Activity activity = activityDao.detail(id);
        return activity;
    }

    @Override
    @Transactional(readOnly = true)
    public List<ActivityRemark> getRemarkListByAid(String activityId) { //根据id获取市场信息全部备注
        List<ActivityRemark> arList = activityRemarkDao.getRemarkListByAid(activityId);
        return arList;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean deleteRemark(String id) throws Exception {   //根据id删除市场信息备注
        boolean flag = true;
        int count = activityRemarkDao.deleteById(id);
        if (count != 1) {
            throw new Exception("删除有误！");
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean saveRemark(ActivityRemark activityRemark) throws Exception { //添加市场信息备注
        boolean flag = true;
        int count = activityRemarkDao.saveRemark(activityRemark);
        if (count != 1) {
            throw new Exception("添加有误！");
        }
        return flag;
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public boolean updateRemark(ActivityRemark activityRemark) throws Exception {   //更新市场信息备注
        boolean flag = true;
        int count = activityRemarkDao.updateRemark(activityRemark);
        if (count != 1) {
            throw new Exception("修改有误！");
        }
        return flag;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Activity> getActivityListByClueId(String clueId) {  //通过关联的线索id获取所有市场活动
        List<Activity> aList = activityDao.getActivityListByClueId(clueId);
        return aList;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map) {    //通过名称但不通过关联的线索id获取市场活动
        List<Activity> aList = activityDao.getActivityListByNameAndNotByClueId(map);
        return aList;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Activity> getActivityListByName(String aname) { //通过名称获取市场活动
        List<Activity> aList = activityDao.getActivityListByName(aname);
        return aList;
    }

    @Override
    @Transactional(readOnly = true)
    public List<Activity> getActivityListByContactsId(String contactsId) {  //通过关联的联系人id获取市场活动
        List<Activity> aList = activityDao.getActivityListByContactsId(contactsId);
        return aList;
    }
}
