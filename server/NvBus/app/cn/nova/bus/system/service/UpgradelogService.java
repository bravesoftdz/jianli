package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Version;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：系统升级日志接口</b><br/>
 * <b>类名称：</b>UpgradelogService.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-05-03 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface UpgradelogService {

	/**
	 * 查询系统升级日志表
	 * 
	 * @param month
	 * @param checkstationid
	 * @param routeid
	 * @param unitid
	 * @return
	 */
	public List<Map<String, Object>> QryUpgradelog(
			List<PropertyFilter> propertyFilterList);

	/**
	 * 根据日志ID 获取升级日志内容
	 * 
	 * @param logid
	 * @return
	 */
	public List<Map<String, Object>> getContextbyid(Long logid);

	/**
	 * 查询更新版本
	 * 
	 * @return
	 */
	public List<Map<String, Object>> qryversion();

}
