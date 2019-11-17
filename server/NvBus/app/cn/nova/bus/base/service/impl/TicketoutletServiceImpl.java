/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

import javax.persistence.Query;

import cn.nova.bus.base.dao.TicketoutletsDao;
import cn.nova.bus.base.model.Ticketoutlets;
import cn.nova.bus.base.service.TicketoutletService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class TicketoutletServiceImpl implements TicketoutletService {


	private TicketoutletsDao dao = new TicketoutletsDao();

	@Override
	public Ticketoutlets save(Ticketoutlets ticketoutlet)
			throws ServiceException {
		if (ticketoutlet.getId() == -1) {
			Long idByName = dao.checkNameUnique(ticketoutlet, false);
			if (idByName > 0) {
				if (dao.checkNameUnique(ticketoutlet, true) > 0) {
					throw new ServiceException(ticketoutlet.getName(), "0327");
				}
				ticketoutlet.setId(idByName);
				ticketoutlet.setIsactive(true);
			}
			if ("0".equals(ticketoutlet.getType())) {
				Long idByType = dao.checkTypeUnique(ticketoutlet, false);
				if (idByType > 0) {
					if (dao.checkTypeUnique(ticketoutlet, true) > 0) {
						throw new ServiceException("0328");
					}
					ticketoutlet.setId(idByType);
					ticketoutlet.setIsactive(true);
					ticketoutlet.setType(ticketoutlet.getType());
				}
			}
			String code = StringUtils.toJianPin(ticketoutlet.getName());
			if(dao.isExistTicketoutlets(code)){
				for(int i=1;i<=100;i++){
					code=code+i;
					if(!dao.isExistTicketoutlets(code)){
						break;
					}
				}
			}
			ticketoutlet.setCode(code);
			//getCode(ticketoutlet);// 添加时获取code编码
			return (Ticketoutlets) dao.merge(ticketoutlet);
		} else {
			Ticketoutlets outlets = (Ticketoutlets) dao.get(
					Ticketoutlets.class, ticketoutlet.getId());
			if (!ticketoutlet.getName().equals(outlets.getName())) {
				if (dao.checkNameUnique(ticketoutlet, true) > 0) {
					throw new ServiceException(ticketoutlet.getName(), "0327");
				}
			}
			if ("0".equals(ticketoutlet.getType())) {
				if (!ticketoutlet.getType().equals(outlets.getType())) {
					if (dao.checkTypeUnique(ticketoutlet, true) > 0) {
						throw new ServiceException("0328");
					}
				}
			}
			return (Ticketoutlets) dao.merge(ticketoutlet);
		}

	}

	private void getCode(Ticketoutlets ticketoutlet) {// 给该Code赋值
		Query query = dao.getEntityManager()
				.createQuery(
						"select max(t.code) as maxno from Ticketoutlets t "
								+ "where t.code like '"
								+ ticketoutlet.getCode() + "%'");
		Object tempstr = query.getSingleResult();
		if (tempstr == null || "".equals(tempstr)) {
			ticketoutlet.setCode(ticketoutlet.getCode() + "001");
		} else {
			String str = null;
			if (tempstr.toString().length() < 3) {
				str = tempstr.toString();
			} else {
				str = tempstr.toString().substring(
						tempstr.toString().length() - 3);
			}
			if (!isNumeric(str)) {
				ticketoutlet.setCode(ticketoutlet.getCode() + "001");
			} else {
				Long count = new Long(str);
				count++;
				String lastno = "0001";
				if (count < 10) {
					lastno = "00" + count.toString();
				} else if (count < 100 && count > 10) {
					lastno = "0" + count.toString();
				}
				ticketoutlet.setCode(ticketoutlet.getCode() + lastno);
			}
		}
	}

	public boolean isNumeric(String str) {
		Pattern pattern = Pattern.compile("[0-9]*");
		Matcher isNum = pattern.matcher(str);
		if (!isNum.matches()) {
			return false;
		}
		return true;
	}

	@Override
	public Ticketoutlets findById(Long id) {
		return (Ticketoutlets) dao.get(Ticketoutlets.class, id);
	}

	public boolean delete(Long id) {
		return dao.delete(Ticketoutlets.class, id);
	}

	@SuppressWarnings("rawtypes")
	@Override
	public List query(String sql) {
		return dao.find(sql);
	}

	@Override
	public List<Map<String, Object>> query(Object[] filed, String sql) {
		return dao.query(filed, sql);
	}

	@Override
	public List<Ticketoutlets> findList(Map<String, Object> where) {
		List<Ticketoutlets> list = dao.find(Ticketoutlets.class, where);
		return list;
	}

	@Override
	public List<Map<String, Object>> query(Object[] fileds, String sql,
			Object[] filedtype) {
		return dao.query(fileds, sql, filedtype);
	}

	@Override
	public Ticketoutlets findByCode(String code) {
		Map<String, Object> conditions = new HashMap<String, Object>();
		conditions.put("code", code);
		return (Ticketoutlets) dao
				.uniqueResult(Ticketoutlets.class, conditions);
		// List<PropertyFilter> propertyFilters = new
		// ArrayList<PropertyFilter>();
		// propertyFilters.add(new PropertyFilter("EQS_t!code", code));
		// return (Ticketoutlets) dao.uniqueResult(Ticketoutlets.class,
		// propertyFilters);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(
				new Object[] { Ticketoutlets.class, "districtname",
						"createname", "orgname", "dicgrade", "dictype" ,"startstationname"},
				dao.query(buildFromHttpRequest), new Object[] {
						Ticketoutlets.class, String.class, String.class,
						String.class, String.class, String.class, String.class });
	}

}
