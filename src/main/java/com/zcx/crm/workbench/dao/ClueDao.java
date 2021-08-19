package com.zcx.crm.workbench.dao;


import com.zcx.crm.workbench.domain.Clue;

import java.util.List;
import java.util.Map;

public interface ClueDao {


    int save(Clue clue);

    Clue detail(String id);

    int getTotal();

    List<Clue> getClueList(Map<String, Object> map);

    Clue getById(String clueId);

    int delete(String clueId);
}
