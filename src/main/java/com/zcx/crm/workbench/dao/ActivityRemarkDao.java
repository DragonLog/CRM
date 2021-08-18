package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.ActivityRemark;

import java.util.List;

public interface ActivityRemarkDao {
    int getCountByAids(String[] ids);

    int deleteByAids(String[] ids);

    List<ActivityRemark> getRemarkListByAid(String activityId);

    int deleteById(String id);

    int saveRemark(ActivityRemark activityRemark);

    int updateRemark(ActivityRemark activityRemark);
}
