package cn.nova.bus.archive.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.ViproomcheckinDao;
import cn.nova.bus.archive.model.Viproomcheckin;
import cn.nova.bus.archive.service.ViproomcheckinService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

public class ViproomcheckinServiceImpl implements ViproomcheckinService {

	
	private IDAO<Viproomcheckin> dao = new EntityManagerDaoSurport<Viproomcheckin>();
	
	private ViproomcheckinDao viproomcheckindao = new ViproomcheckinDao();
	
	@Override
	public Viproomcheckin saveViproomcheckin(Viproomcheckin viproomcheckin,String ticketsellids)
			throws ServiceException {
		Viproomcheckin results=null;
		String[] typeid = ticketsellids.split(",");
		for(int i=0;i<typeid.length;i++){
			boolean isexit = viproomcheckindao.isExitVipIn(
					viproomcheckin.getVipid(),Long.parseLong(typeid[i]));
			if(isexit){
				//该会员卡已持车票登记，不需要重复登记
				throw new ServiceException("0416"); 
			}
			viproomcheckin.setTicketsellid(Long.parseLong(typeid[i]));
			results = dao.merge(viproomcheckin);			
		}	
		return results;
	}

	/**
	 * 查询会员进入贵宾室历史记录
	 */
	@Override
	public List<Map<String, Object>> queryViproomcheckin(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = {
				"id","mobilephone","vipcardno","schedulestatus","ticketno",
				"departdate","checkintime","customername","chedulecode",
				"gradename","sex","seatno","departtime","ischecked",
				"ticketentrance","endstationname","checkebyname","checkorg"};
		Object[] filedtypes = { 
				long.class,String.class,String.class,String.class,String.class,
				Date.class,Timestamp.class,String.class,String.class,
				String.class,String.class,String.class,String.class,boolean.class,
				String.class,String.class,String.class,String.class};
	return ListUtil.listToMap(fileds,viproomcheckindao.queryViproomcheckinlist(propertyFilterList) ,filedtypes);
	}
	
	/**
	 * 根据卡号获取顾客购票信息
	 */
	@Override
	public List<Map<String, Object>> queryTicketdetail(String vipcardno) {
		Object[] fileds = { 
				"ischecked","selltime","departdate","departtime","fullprice","seatno","ticketentrance",
				"ischeckedticket","schedulename","reachname","ticketoutname","routename","ticketno",
				"sellid","isinroom"};
		Object[] filedtypes = { 
				boolean.class,String.class,String.class,String.class,String.class,String.class,String.class,
				boolean.class,String.class,String.class,String.class,String.class,String.class,
				long.class,boolean.class};
	return ListUtil.listToMap(fileds, viproomcheckindao.queryTicketdetail(vipcardno),filedtypes);	
	}

}
