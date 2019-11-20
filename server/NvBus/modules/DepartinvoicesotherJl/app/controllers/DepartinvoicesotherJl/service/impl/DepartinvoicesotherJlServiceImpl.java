package controllers.DepartinvoicesotherJl.service.impl;

import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import controllers.DepartinvoicesotherJl.dao.DepartinvoicesotherJlDao;
import controllers.DepartinvoicesotherJl.service.DepartinvoicesotherJlService;
import utils.bus365.serial.JSONUtil;

import java.util.Date;
import java.util.List;
import java.util.Map;

public class DepartinvoicesotherJlServiceImpl implements DepartinvoicesotherJlService {

    @Override
    public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList) {
        DepartinvoicesotherJlDao dao = new DepartinvoicesotherJlDao();
        List<Map<String, Object>> map = ListUtil.listToMap(new Object[] {"id","code","name","type","parentid","serversaddress","stationid","isactive",
                "createtime","updatetime","districtid","islocal","synccode"}, dao.query(propertyFilterList), new Object[] {Long.class, String.class, String.class, String.class, Long.class, String.class,
        Long.class, Boolean.class, Date.class, Date.class, Long.class, Boolean.class, String.class});
        String json = JSONUtil.parseObject(map);
        play.Logger.info("测试查询结果："+json);
        return map;
    }
}
