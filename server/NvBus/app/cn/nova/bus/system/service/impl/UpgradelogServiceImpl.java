/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.service.impl<br/>
 * <b>文件名：</b>UpgradelogServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-05-08<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import play.Play;

import cn.nova.bus.common.NvBusVerifyConst;
import cn.nova.bus.system.dao.UpgradelogDao;
import cn.nova.bus.system.model.Version;
import cn.nova.bus.system.service.UpgradelogService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：系统升级日志</b><br/>
 * <b>类名称：</b>UpgradelogServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-5-08 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class UpgradelogServiceImpl implements UpgradelogService {

	private UpgradelogDao dao = new UpgradelogDao();

	/**
	 * 升级日志查询
	 */
	@Override
	public List<Map<String, Object>> QryUpgradelog(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "version", "needpopup",
				"upgradetime" }, dao.queryUpgradelog(propertyFilterList),
				new Object[] { Long.class, String.class, boolean.class,
						Timestamp.class });
	}

	/**
	 * 根据日志ID 查找 升级日志内容
	 */
	@Override
	public List<Map<String, Object>> getContextbyid(Long logid) {
		return ListUtil.listToMap(new Object[] { "id", "upgradecontext" },
				dao.qryContextbyid(logid), new Object[] { Long.class,
						String.class });
	}

	/**
	 * 查询更新版本
	 */
	public List<Map<String, Object>> qryversion() {
		List<Object> list = null;
		String appName = Play.applicationPath.getName();
		if(NvBusVerifyConst.NVBUS_VERIFY_APP_NAME.equals(appName)){
			list = dao.qryVersionVerify();
		}else{
			list = dao.qryversion();
		}
		return ListUtil.listToMap(new Object[] { "id", "versionnum","updatetime"},
				list, new Object[] { Long.class,
						String.class,Date.class });
	}

}
