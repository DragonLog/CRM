package com.zcx.crm.workbench;

import com.zcx.crm.utils.UUIDUtil;
import com.zcx.crm.workbench.domain.Activity;
import com.zcx.crm.workbench.service.ActivityService;
import org.junit.Assert;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"classpath:applicationContext.xml"}) //测试类要引入容器初始化配置文件
public class ActivityTest {

    @Autowired
    private ActivityService activityService;

    @Test
    public void testSave() throws Exception {
        Activity activity = new Activity();
        activity.setId(UUIDUtil.getUUID());
        activity.setName("宣传推广会");
        boolean flag =activityService.save(activity);
        Assert.assertEquals(flag, true);
    }

}
