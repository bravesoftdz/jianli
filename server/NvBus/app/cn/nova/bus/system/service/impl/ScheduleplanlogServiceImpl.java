/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.service.impl<br/>
 * <b>文件名：</b>ScheduleplanlogServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-3-8 上午09:44:56<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.dao.ScheduleplanlogDao;
import cn.nova.bus.system.service.ScheduleplanlogService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplanlogServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-3-8 上午09:44:56<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class ScheduleplanlogServiceImpl implements ScheduleplanlogService {

	
	public ScheduleplanlogDao planlogDao = new ScheduleplanlogDao();

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.system.service.ScheduleplanlogService#queryScheduleplanlog
	 * (java.util.List)
	 */
	@Override
	public List<Map<String, Object>> queryScheduleplanlog(
			List<PropertyFilter> buildFromHttpRequest, String type) {
		return ListUtil.listToMap(new Object[] { "orgname", "operation",
				"selecttype", "typename", "startdate", "enddate", "ip", "result",
				"createtime", "createname", "username" },
				planlogDao.queryScheduleplanlog(buildFromHttpRequest, type),
				new Object[] { String.class, String.class, String.class,
						String.class, Timestamp.class, Timestamp.class,
						String.class, String.class, Timestamp.class,
						String.class, String.class });
	}

}
