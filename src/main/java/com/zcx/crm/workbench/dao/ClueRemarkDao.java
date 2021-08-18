package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.ClueRemark;

import java.util.List;

public interface ClueRemarkDao {

    int saveRemark(ClueRemark clueRemark);

    List<ClueRemark> getRemarkListByCid(String clueId);

    int delete(ClueRemark clueRemark);
}
