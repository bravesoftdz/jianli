package cn.nova.bus.base.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.SchedulestationcontrolDao;
import cn.nova.bus.base.model.Schedulestationcontrol;
import cn.nova.bus.base.service.SchedulestationcontrolService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class SchedulestationcontrolServiceImpl implements
		SchedulestationcontrolService {

	
	private SchedulestationcontrolDao schedulestationcontrolServicedao = new SchedulestationcontrolDao();
	
	@Override
	public List<Map<String, Object>> findSchedulestationcontrolList(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "departorgname","routename","stationname",
							"cansellnum","canselltime","createname", 
							"updatename","createtime","updatetime",
							"id","routeid","updateby","createby","stationid","departorgid" };		
		Object[] filedtypes = { 
				String.class, String.class,String.class,
				Integer.class,Integer.class,String.class,
				String.class,Timestamp.class, Timestamp.class,
				Long.class,Long.class,Long.class,Long.class,Long.class,Long.class};
		return ListUtil.listToMap(fileds,
				schedulestationcontrolServicedao.findSchedulestationcontrolList(propertyFilterList),filedtypes);
	}
	
	@Override
	public List<Map<String, Object>> findControlroutestation(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { 
				"id","routeid","stationid","routename",
				"stationname","cansellnum","canselltime","isselect" };		
		Object[] filedtypes = { 
				Long.class,	Long.class,Long.class,	String.class,
				String.class,Integer.class,Integer.class,boolean.class};
		return ListUtil.listToMap(fileds,
				schedulestationcontrolServicedao.findControlroutestation(propertyFilterList),filedtypes);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean edtSchedulestationcontrol(
			Schedulestationcontrol schedulestationcontrol,
			List<Schedulestationcontrol> stationlist) {
		//是否有数据被修改 or 新数据添加
		boolean isAlter = false;
		//修改
//		if(schedulestationcontrol.getId() != 0){
			if (stationlist!=null){
				for(Schedulestationcontrol station : stationlist){
					//根据线路和站点ID 查询是否已经存在改站点的控制
					long id = schedulestationcontrolServicedao.findControlId
							(schedulestationcontrol.getDepartorgid(), schedulestationcontrol.getRouteid(),station.getStationid());
					if(id>0){
						//如果存在，则修改
						Schedulestationcontrol oldcontrol = (Schedulestationcontrol) schedulestationcontrolServicedao.get(Schedulestationcontrol.class, id);
						//是否有数据被修改
						if(oldcontrol.getCansellnum() != station.getCansellnum() 
								||oldcontrol.getCanselltime() != station.getCanselltime() ){
							isAlter = true;
						}
						oldcontrol.setCansellnum(station.getCansellnum());
						oldcontrol.setCanselltime(station.getCanselltime());
						oldcontrol.setUpdateby(schedulestationcontrol.getUpdateby());
						oldcontrol.setUpdatetime(schedulestationcontrol.getUpdatetime());
						schedulestationcontrolServicedao.merge(oldcontrol);
					}else{
						isAlter = true;
						//如果不存在，则新添加该线路站点的控制
						Schedulestationcontrol newadd = new Schedulestationcontrol();
						newadd.setCansellnum(station.getCansellnum());
						newadd.setCanselltime(station.getCanselltime());
						newadd.setCreateby(schedulestationcontrol.getCreateby());
						newadd.setCreatetime(schedulestationcontrol.getUpdatetime());
						newadd.setDepartorgid(schedulestationcontrol.getDepartorgid());
						newadd.setRouteid(schedulestationcontrol.getRouteid());
						newadd.setStationid(station.getStationid());
						newadd.setUpdateby(schedulestationcontrol.getUpdateby());
						newadd.setUpdatetime(schedulestationcontrol.getUpdatetime());
						schedulestationcontrolServicedao.merge(newadd);
					}
				}
			}
//			else{
//				//修改时，没有攥在任何站点，将删除已经控制的记录
//				SchedulestationcontrolServicedao.delSchedulestationcontrol(
//						schedulestationcontrol.getDepartorgid(),schedulestationcontrol.getRouteid(),0);
//			}
//		}else{//添加
//			if (stationlist!=null){
//				for(Schedulestationcontrol station : stationlist){
//					schedulestationcontrol.setStationid(station.getStationid());
//					schedulestationcontrol.setCansellnum(station.getCansellnum());
//					schedulestationcontrol.setCanselltime(station.getCanselltime());
//					SchedulestationcontrolServicedao.merge(schedulestationcontrol);
//					continue;
//				}
//			
//			}
//		}
		
		return isAlter;
	}

	@Override
	public Boolean delSchedulestationcontrol(long departorgid, long routeid,
			long stationid) {
		return schedulestationcontrolServicedao.delSchedulestationcontrol(departorgid, routeid, stationid);
	}

	@Override
	public Schedulestationcontrol getSchedulestationcontrol(long routeid,
			long stationid) {
		return schedulestationcontrolServicedao.getSchedulestationcontrol(routeid, stationid);
	}

}
