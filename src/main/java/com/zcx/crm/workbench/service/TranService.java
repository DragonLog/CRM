package com.zcx.crm.workbench.service;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Tran;
import com.zcx.crm.workbench.domain.TranHistory;

import java.util.List;
import java.util.Map;

public interface TranService {
    PaginationVO<Tran> getPageList(Map<String, Object> map);

    boolean save(Tran tran, String customerName) throws Exception;

    Tran detail(String id);

    List<TranHistory> getHistoryListByTranId(String tranId);

    boolean changeStage(Tran tran) throws Exception;

    Map<String, Object> getCharts();
    
}
