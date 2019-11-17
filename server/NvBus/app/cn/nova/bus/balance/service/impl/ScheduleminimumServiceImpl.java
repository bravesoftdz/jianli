/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.balance.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.ScheduleminimumDao;
import cn.nova.bus.balance.model.Scheduleminimum;
import cn.nova.bus.balance.service.ScheduleminimumService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：添加和删除 时的唯一判断</b><br/>
 * <b>修改时间：20130522</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("unchecked")
public class ScheduleminimumServiceImpl implements ScheduleminimumService {


	private ScheduleminimumDao dao = new ScheduleminimumDao();

	@Override
	public Scheduleminimum save(Scheduleminimum turnover) throws ServiceException {
		//查看是否存在班次和车辆的保底数记录
		Scheduleminimum sm=(Scheduleminimum) dao.getScheduleminimum(turnover.getScheduleid(),turnover.getVehicleid());
		if(sm!=null){
			if(turnover.getId()<=0 || turnover.getId()!= sm.getId()){
				throw new ServiceException("0429");//该班次对应车辆已经添加过班次保底数，不允许重复！
			}	
		} 
		if (turnover.getNum() > dao.getVehicleNum(turnover.getVehicleid())) {
			throw new ServiceException("0225");//班次保底数不能大于车辆核定座位数！
		}
		if (turnover.getId() == 0) {
			return (Scheduleminimum) dao.merge(turnover);
		} else {
			return (Scheduleminimum) dao.merge(turnover);
		}
	}
	
	@Override
	public boolean delete(Scheduleminimum turnover) {
		if (turnover != null) {
			return dao.del(turnover);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Scheduleminimum.class, id);
	}

	@Override
	public List<Scheduleminimum> query() {
		return dao.query(Scheduleminimum.class, null);
	}

	@Override
	public Scheduleminimum getById(Long id) {
		return (Scheduleminimum) dao.get(Scheduleminimum.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Scheduleminimum.class,
				"createname", "updatename", "vehicleno", "schedulename" },
				dao.query(propertyFilterList), new Object[] {
						Scheduleminimum.class, String.class, String.class,
						String.class, String.class });
	}


	/* getScheduleminimum方法：<br/>
	 * <br/>
	 * @param scheduleid
	 * @param vehicleid
	 * @return 
	 * @see cn.nova.bus.balance.service.ScheduleminimumService#getScheduleminimum(long, long)
	 * @exception 
	 */
	@Override
	public Scheduleminimum getScheduleminimum(long scheduleid, long vehicleid) {
		
		return dao.getScheduleminimum(scheduleid,vehicleid);
	}

}
