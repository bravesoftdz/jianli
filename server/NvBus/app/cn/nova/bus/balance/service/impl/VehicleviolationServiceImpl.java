/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.balance.service.impl<br/>
 * <b>文件名：</b>VehicleviolationServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-9-11 下午05:17:09<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.VehicleviolationDao;
import cn.nova.bus.balance.model.Vehicleviolation;
import cn.nova.bus.balance.service.VehicleviolationService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>VehicleviolationServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-9-11 下午05:17:09<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class VehicleviolationServiceImpl implements VehicleviolationService {


	private VehicleviolationDao violationDao = new VehicleviolationDao();

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VehicleviolationService#save(cn.nova.bus.
	 * balance.model.Vehicleviolation)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Long save(Vehicleviolation vehicleviolation, Global global)
			throws ServiceException {
		Date date = new Date();
		if (vehicleviolation.getId() == 0) {
			String str = "";
			vehicleviolation.setCreateby(global.getUserinfo().getId());
			vehicleviolation.setCreatetime(date);
			vehicleviolation.setUpdateby(global.getUserinfo().getId());
			vehicleviolation.setUpdatetime(date);
			vehicleviolation.setBillor(global.getUserinfo().getId());
			vehicleviolation.setBilldate(date);
			vehicleviolation.setOrgid(global.getOrganization().getId());
			vehicleviolation.setHandledate(null);
			vehicleviolation.setStatus("0");    //未结算
			vehicleviolation.setIscash(false);    //现金罚款     0为非现金
			SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
			str = sf.format(new Date()) + (Math.random() * 9000 + 1000);
			vehicleviolation.setNotenum(str.substring(0, 12));
			if (!violationDao.notenumUnique(str).isEmpty()) {
				throw new ServiceException("0387");
			}
		} else {
			if (violationDao.isBalance(vehicleviolation.getId())) {
				throw new ServiceException("0389");
			}
			vehicleviolation.setHandledate(null);
			vehicleviolation.setUpdateby(global.getUserinfo().getId());
			vehicleviolation.setUpdatetime(date);
		}
		vehicleviolation = (Vehicleviolation) violationDao
				.merge(vehicleviolation);
		return vehicleviolation.getId();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VehicleviolationService#delete(java.lang.
	 * Long)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(Long id) throws ServiceException {
		if (violationDao.isBalance(id)) {
			throw new ServiceException("0388");
		}
		return violationDao.delete(Vehicleviolation.class, id);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VehicleviolationService#query(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(
				new Object[] { "id", "vehicleid", "billor", "orgid",
						"createby", "notenum", "routename", "violationdate",
						"departtime", "debit", "remark", "billdate",
						"handleret", "breachfee", "ishandle", "handledate",
						"createtime", "updatetime", "vehicleno", "handlorname",
						"billorname", "createname", "updatename", "orgname",
						"balancetype", "status" },
				violationDao.query(propertyFilterList), new Object[] {
						Long.class, Long.class, Long.class, Long.class,
						Long.class, String.class, String.class, Date.class,
						String.class, BigDecimal.class, String.class,
						Timestamp.class, String.class, BigDecimal.class,
						Boolean.class, Timestamp.class, Timestamp.class,
						Timestamp.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class });
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VehicleviolationService#processVehicleviolation
	 * (cn.nova.bus.balance.model.Vehicleviolation, cn.nova.bus.security.Global)
	 */
	@SuppressWarnings("unchecked")
	@Override
	public long processVehicleviolation(
			Vehicleviolation vehicleviolation, Global global)
			throws ServiceException {
		Vehicleviolation violation = (Vehicleviolation) violationDao.get(
				Vehicleviolation.class, vehicleviolation.getId());
		if (violation.isIshandle()) {
			throw new ServiceException("0390");
		}
		Date date = new Date();
		violation.setIshandle(true);
		violation.setHandlor(global.getUserinfo().getId());
		violation.setHandledate(date);
		violation.setBreachfee(vehicleviolation.getBreachfee());
		violation.setHandleret(vehicleviolation.getHandleret());
		violation.setUpdateby(global.getUserinfo().getId());
		violation.setUpdatetime(date);
		violation = (Vehicleviolation) violationDao.merge(violation);
		return violation.getId();
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.balance.service.VehicleviolationService#getRoutename(java
	 * .lang.Long)
	 */
	@Override
	public String getRoutename(long vehicleid) {
		return violationDao.getRoutenameByVehicleid(vehicleid);
	}

}
