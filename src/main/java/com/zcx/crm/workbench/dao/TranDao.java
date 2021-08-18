package com.zcx.crm.workbench.dao;

import com.zcx.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface TranDao {

    int save(Tran tran);

    int getTotal();

    List<Tran> getTranList(Map<String, Object> map);

    Tran detail(String id);

    int changeStage(Tran tran);

    List<Map<String, Object>> getCharts();
}
