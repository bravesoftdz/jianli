package controllers.DepartinvoicesotherJl.service.impl;

import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import controllers.DepartinvoicesotherJl.dao.DepartinvoicesotherJlDao;
import controllers.DepartinvoicesotherJl.service.DepartinvoicesotherJlService;
import utils.bus365.serial.JSONUtil;
import java.util.List;
import java.util.Map;

public class DepartinvoicesotherJlServiceImpl implements DepartinvoicesotherJlService {

    @Override
    public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList) {
        DepartinvoicesotherJlDao dao = new DepartinvoicesotherJlDao();
        List<Map<String, Object>> map = ListUtil.listToMap(new Object[] {"testfield"}, dao.query(propertyFilterList), new Object[] {Integer.class});
        String json = JSONUtil.parseObject(map);
        play.Logger.info("测试查询结果："+json);
        return map;
    }
}
