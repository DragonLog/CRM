package com.zcx.crm.workbench.service;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Activity;
import com.zcx.crm.workbench.domain.ActivityRemark;

import java.util.List;
import java.util.Map;

public interface ActivityService {
    boolean save(Activity activity) throws Exception;

    PaginationVO<Activity> getpageList(Map<String, Object> map);

    boolean delete(String[] ids) throws Exception;

    Map<String, Object> getUserListAndActivity(String id);

    boolean update(Activity activity) throws Exception;

    Activity detail(String id);

    List<ActivityRemark> getRemarkListByAid(String activityId);

    boolean deleteRemark(String id) throws Exception;

    boolean saveRemark(ActivityRemark activityRemark) throws Exception;

    boolean updateRemark(ActivityRemark activityRemark) throws Exception;

    List<Activity> getActivityListByClueId(String clueId);

    List<Activity> getActivityListByNameAndNotByClueId(Map<String, Object> map);

    List<Activity> getActivityListByName(String aname);

    List<Activity> getActivityListByContactsId(String contactsId);
}
