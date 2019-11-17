package cn.nova.bus.balance.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.model.Orgdayneedbalance;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface OrgdayneedbalanceService {

	public boolean save(Orgdayneedbalance orgdayneedbalance);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean delete(Orgdayneedbalance orgdayneedbalance);

}
