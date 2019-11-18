package controllers.DepartinvoicesotherJl.service;

import cn.nova.utils.orm.PropertyFilter;

import java.util.List;
import java.util.Map;

public interface DepartinvoicesotherJlService {
    List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
}
