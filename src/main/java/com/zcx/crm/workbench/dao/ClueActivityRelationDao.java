package com.zcx.crm.workbench.dao;


import com.zcx.crm.workbench.domain.ClueActivityRelation;

import java.util.List;

public interface ClueActivityRelationDao {


    int unbund(String id);

    int bund(ClueActivityRelation clueActivityRelation);

    List<ClueActivityRelation> getListByClueId(String clueId);

    int delete(ClueActivityRelation clueActivityRelation);
}
