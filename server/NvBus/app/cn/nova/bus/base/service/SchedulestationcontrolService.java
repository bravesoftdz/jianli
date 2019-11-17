package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Schedulestationcontrol;
import cn.nova.utils.orm.PropertyFilter;

/**
 * <b>类描述：班次站点售票控制</b><br/>
 * <b>类名称：</b>SchedulestationcontrolServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public interface SchedulestationcontrolService {

	/**
	 * 查询已控制的线路站点信息
	 * @param propertyFilterList
	 * @return
	 */
	public List<Map<String, Object>> findSchedulestationcontrolList(List<PropertyFilter> propertyFilterList) ;	

	public List<Map<String, Object>> findControlroutestation(
			List<PropertyFilter> propertyFilterList);
	/**
	 * 添加或修改 班次站点售票控制
	 * @param schedulestationcontrol
	 * @param stationlist
	 * @param orgid
	 * @return
	 */
	public boolean edtSchedulestationcontrol(Schedulestationcontrol schedulestationcontrol,
			List<Schedulestationcontrol> stationlist );
	
	/**
	 * 删除线路站点控制，直接删除指定记录
	 * @param departorgid
	 * @param routeid
	 * @param stationid
	 * @return
	 */	
	public Boolean delSchedulestationcontrol(long departorgid,long routeid,long stationid);
	
	/**
	 * 按线路、站点查询 班次站点售票控制
	 * @param routeid
	 * @param stationid
	 * @return
	 */
	public Schedulestationcontrol getSchedulestationcontrol(long routeid,long stationid);

}
