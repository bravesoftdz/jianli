package cn.nova.bus.archive.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.VipbooktimeDao;
import cn.nova.bus.archive.model.Vipbooktime;
import cn.nova.bus.archive.service.VipbooktimeService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：VIP订票取消时间设置</b><br/>
 * <b>类名称：</b>VipbooktimeServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class VipbooktimeServiceImpl implements VipbooktimeService {

	private VipbooktimeDao vipbooktimedao = new VipbooktimeDao();

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "orgname", "vipgrade", "booktime", "createname",
				"updatename", "createtime", "updatetime", "id", "orgid",
				"createby" };
		Object[] filedtypes = { String.class, String.class, long.class,
				String.class, String.class, Timestamp.class, Timestamp.class,
				Long.class, Long.class, Long.class };
		return ListUtil.listToMap(fileds,
				vipbooktimedao.find(propertyFilterList), filedtypes);
	}

	@Override
	public Vipbooktime merge(Vipbooktime vipbooktime) throws ServiceException {
		if (vipbooktime.getId() <= 0) {
			boolean isexist = vipbooktimedao.isExist(vipbooktime.getOrgid(),
					vipbooktime.getVipgrade());
			if (isexist) {
				throw new ServiceException("0456");// 该会员等级已经设置了订票自动取消时间！
			}
		}
		return (Vipbooktime) vipbooktimedao.merge(vipbooktime);
	}

	@Override
	public boolean delete(Vipbooktime vipbooktime) {
		return vipbooktimedao.delete(vipbooktime);
	}

}
