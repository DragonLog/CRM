package com.zcx.crm.workbench.service;

import com.zcx.crm.vo.PaginationVO;
import com.zcx.crm.workbench.domain.Clue;
import com.zcx.crm.workbench.domain.ClueRemark;
import com.zcx.crm.workbench.domain.Tran;

import java.util.List;
import java.util.Map;

public interface ClueService {
    boolean save(Clue clue) throws Exception;

    Clue detail(String id);

    boolean unbund(String id) throws Exception;

    boolean bund(String cid, String[] aids) throws Exception;

    PaginationVO<Clue> getPageList(Map<String, Object> map);

    boolean convert(String clueId, Tran tran, String createBy) throws Exception;

    boolean saveRemark(ClueRemark clueRemark) throws Exception;

    List<ClueRemark> getRemarkListByCid(String clueId);
}
