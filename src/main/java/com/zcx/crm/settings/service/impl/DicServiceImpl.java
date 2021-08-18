package com.zcx.crm.settings.service.impl;

import com.zcx.crm.settings.dao.DicTypeDao;
import com.zcx.crm.settings.dao.DicValueDao;
import com.zcx.crm.settings.domain.DicType;
import com.zcx.crm.settings.domain.DicValue;
import com.zcx.crm.settings.service.DicService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service    //业务层注解
public class DicServiceImpl implements DicService {

    @Autowired  //注入持久层
    private DicTypeDao dicTypeDao;

    @Autowired
    private DicValueDao dicValueDao;

    @Override
    @Transactional(readOnly = true) //启动事务为只读
    public Map<String, List<DicValue>> getAll() {   //获取字典键值
        Map<String, List<DicValue>> map = new HashMap<>();
        List<DicType> dtList = dicTypeDao.getTypeList();
        for (DicType dt : dtList) {
            String code = dt.getCode();
            List<DicValue> dvList = dicValueDao.getListByCode(code);
            map.put(code + "List", dvList);
        }
        return map;
    }
}
