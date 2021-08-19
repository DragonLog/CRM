package com.zcx.crm.settings.dao;

import com.zcx.crm.settings.domain.DicValue;

import java.util.List;

public interface DicValueDao {
    List<DicValue> getListByCode(String code);
}
