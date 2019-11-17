/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.service<br/>
 * <b>文件名：</b>UnitServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import cn.nova.bus.base.dao.UnitDao;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.service.CardissueService;
import cn.nova.bus.base.service.UnitService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class UnitServiceImpl implements UnitService {
	
	private UnitDao dao = new UnitDao();

	
	private CardissueService cardservice;

	
	private BilltypeService billservice = new BilltypeServiceImpl();

	@Override
	public Unit save(Unit unit, Global global) throws ServiceException {
		cardservice = new CardissueServiceImpl();
		if (unit.getId() == 0) {
			if ( !StringUtils.isEmpty(unit.getCardno()) && global != null ) {
					unit = (Unit) dao.merge(unit);
					Cardissue cardissue = new Cardissue();
					cardissue.setStatus("0");
					cardissue.setTypeid(unit.getId());
					cardissue.setBilltypeid(billservice.getId("Unit"));
					cardissue.setType("5");
					cardissue.setIssueby(unit.getCreateby());
					cardissue.setIssueip(global.getIpAddress());
					cardissue.setTicketoutletsid(global.getTicketoutlets().getId());
					cardissue.setIssueorgid(unit.getOrgid());
					cardissue.setCardno(unit.getCardno());
					cardissue.setUpdateby(unit.getCreateby());
					cardissue.setCreateby(unit.getCreateby());
					cardissue.setTicketoutletsid(null);
					cardissue.setSerialnumber(unit.getAccountno());
					cardissue.setUpdatetime(unit.getCreatetime());
					cardissue.setIssuetime(unit.getCreatetime());
					cardissue.setCreatetime(unit.getCreatetime());
					cardissue.setValiddate(unit.getCreatetime());
					cardservice.save(cardissue, global.getIpAddress(),null);
					return unit;
			}else{
			  return (Unit) dao.merge(unit);
			}
		} else {
			return (Unit) dao.merge(unit);
		}
	}

	@Override
	public List<Unit> query() {
		return dao.query(Unit.class, null);
	}

	@Override
	public Unit getById(Long id) {
		return (Unit) dao.get(Unit.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Unit.class, "createname",
				"updatename", "districtname", "districtid" },
				dao.query(propertyFilterList), new Object[] { Unit.class,
						String.class, String.class, String.class, Long.class });
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Unit.class, id);
	}

	@Override
	public boolean unique(String value, String key) {
		@SuppressWarnings("rawtypes")
		List list = dao.getUnitList(value, key);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public boolean isApply(long id) {
		@SuppressWarnings("rawtypes")
		List list = dao.getVehicle(id);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public List<Map<String, Object>> getUnitInfo() {
		Object[] fileds = { "districtid", "code", "fullname", "contactperson", "type"};// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class,String.class,String.class};// 初始化要查询的字段
		return ListUtil.listToMap(fileds,dao.qryUnitInfo(), filedtypes);
	}

}
