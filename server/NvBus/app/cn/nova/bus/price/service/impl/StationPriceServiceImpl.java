/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.price.service.impl<br/>
 * <b>文件名：</b>StationPriceServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2013-4-25  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.price.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.dao.StationPriceDao;
import cn.nova.bus.price.model.Stationprice;
import cn.nova.bus.price.service.StationPriceService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：站点平时票价管理</b><br/>
 * <b>类名称：</b>StationPriceServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2013-4-25  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class StationPriceServiceImpl implements StationPriceService {


	private StationPriceDao stationpricedao = new StationPriceDao();
	
	/**
	 * 查询站点平时票价
	 */
	@Override
	public List<Map<String, Object>> qryStationPrice(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { 
				"orgname","departstationname","reachstationname","departstationid","reachstationid",
				"id","orgid","fullprice","halfprice","studentprice",
				"createname","updatename","createtime","updatetime","createby" },
				stationpricedao.qryStationPrice(propertyFilterList), 
				new Object[] {
						String.class, String.class, String.class,long.class,long.class,
						long.class,long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,
						String.class,String.class,Timestamp.class,Timestamp.class,long.class });
	}

	/**
	 * 添加和修改站点平时票价
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Stationprice save(Stationprice stp) throws ServiceException {
		if(stp.getId()<=0){
			List<PropertyFilter> pf = new ArrayList<PropertyFilter>();
			pf.clear();
			pf.add(new PropertyFilter("EQL_o!id",stp.getOrgid()));
			pf.add(new PropertyFilter("EQL_dt!id",stp.getDepartstationid()));
			pf.add(new PropertyFilter("EQL_rt!id",stp.getReachstationid()));
			List<Object> re = stationpricedao.qryStationPrice(pf);
			if(re!=null && re.size()>0){
				//该到达站的平时票价已经添加，请重新输入！
				throw new ServiceException("0426");
			}
		}else{
			Stationprice s = (Stationprice) stationpricedao.get(Stationprice.class,stp.getId());
			stp.setCreateby(s.getCreateby());
			stp.setCreatetime(s.getCreatetime());
		}
		return (Stationprice) stationpricedao.merge(stp);
		
	}

	/**
	 * 删除站点平时票价
	 */
	@SuppressWarnings("unchecked")
	@Override
	public boolean delete(long id) throws ServiceException {
		return stationpricedao.delete(Stationprice.class, id);
	}

}
