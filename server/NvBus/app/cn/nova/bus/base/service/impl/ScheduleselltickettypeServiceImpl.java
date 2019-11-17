package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.ScheduleselltickettypeDao;
import cn.nova.bus.base.model.Scheduleselltickettype;
import cn.nova.bus.base.service.ScheduleselltickettypeService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：班线可售票种设置</b><br/>
 * <b>类名称：</b>ScheduleselltickettypeServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class ScheduleselltickettypeServiceImpl implements
		ScheduleselltickettypeService {

	
	private IDAO<Scheduleselltickettype> dao = new EntityManagerDaoSurport<Scheduleselltickettype>();
	
	private ScheduleselltickettypeDao selltickettypedao = new ScheduleselltickettypeDao();
	
	@Override
	public List<Map<String, Object>> findselltickettype(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "id","orgid","orgname","typename","typecode","typeidname","tickettypename",
				"createname","updatename","createtime","updatetime",
				"types","typeid","createby","remarks","tickettypeid","synccode","canselltype","cansellvalue","canselltypevalue" };		
		Object[] filedtypes = { 
				long.class,long.class,String.class, String.class,long.class,String.class, String.class,
				String.class,String.class,Timestamp.class, Timestamp.class,
				Long.class,Long.class,Long.class,String.class,long.class,String.class,String.class,BigDecimal.class,String.class};
		return ListUtil.listToMap(fileds,
				selltickettypedao.findselltickettype(propertyFilterList), filedtypes);
	}

	/**
	 * 修改班次可售票种
	 */
	@Override
	public Scheduleselltickettype updateScheduleselltickettype(Scheduleselltickettype scheduleselltickettype,
			String typeids,String tickettypes) {
		Scheduleselltickettype resulttype = null;
		String tickettype = tickettypes.substring(1, tickettypes.length()-1);
		String[] ty = tickettype.split(",");
		String[] typeid = typeids.split(",");
		for(int a=0;a<typeid.length;a++){
			if(Long.parseLong(typeid[a])==scheduleselltickettype.getTypeid()){		
				List<Scheduleselltickettype> oldlist=selltickettypedao.qryScheduleselltickettype(
						scheduleselltickettype.getOrgid(),scheduleselltickettype.getType(),
						scheduleselltickettype.getTypeid(),0);		
				//查询已经存在的票种
				if(oldlist!=null && oldlist.size()>0){
					for(int i =0;i<oldlist.size();i++){
						Scheduleselltickettype scheduleselltype = oldlist.get(i);
						//如果新修改的票种（tickettype）中，不包含已经存在的票种，则删除掉已经添加的票种
						if(!tickettype.contains(String.valueOf(scheduleselltype.getTickettypeid()))){
//							selltickettypedao.deleteScheduleselltickettype(scheduleselltype.getId());					
						}else{// 否则 进行修改
							scheduleselltickettype.setUpdatetime(new Date());
							 if(selltickettypedao.updateScheduleselltickettype(
									scheduleselltype.getId(),scheduleselltype.getTickettypeid(),
									scheduleselltickettype.getUpdateby(),scheduleselltickettype.getRemarks(), scheduleselltickettype.getCanselltype(),scheduleselltickettype.getCansellvalue())){
								 resulttype =scheduleselltype;
							 } 
						}
					}
				}
				for(int k=0;k<ty.length;k++){
					List<Scheduleselltickettype> morelist=selltickettypedao.qryScheduleselltickettype(
							scheduleselltickettype.getOrgid(),scheduleselltickettype.getType(),
							scheduleselltickettype.getTypeid(),Long.parseLong(ty[k]));
					//遍历票种，再查询是否已经添加了该票种，如果之前没有添加，则新增。
					if(morelist.size()<=0){
						Scheduleselltickettype pcs = new Scheduleselltickettype();
						pcs.setCreateby(scheduleselltickettype.getCreateby());
						pcs.setCreatetime(new Date());
						pcs.setOrgid(scheduleselltickettype.getOrgid());
						pcs.setType(scheduleselltickettype.getType());
						pcs.setTypeid(scheduleselltickettype.getTypeid());
						pcs.setRemarks(scheduleselltickettype.getRemarks());
						pcs.setUpdateby(scheduleselltickettype.getUpdateby());
						pcs.setCanselltype(scheduleselltickettype.getCanselltype());
						pcs.setCansellvalue(scheduleselltickettype.getCansellvalue());
						pcs.setUpdatetime(new Date());
						pcs.setTickettypeid(Long.parseLong(ty[k]));
						resulttype = selltickettypedao.saveScheduleselltickettype(pcs);
					}
				}
				//返回，重新遍历，先把已经勾选的同一班次类型的票种，修改完，再处理 不同班次票种
				continue;
			}
			//查询勾选的其他班次类型的票种
			List<Scheduleselltickettype> otherlist=selltickettypedao.qryScheduleselltickettype(
					scheduleselltickettype.getOrgid(),scheduleselltickettype.getType(),
					Long.parseLong(typeid[a]),0);
			//如果已经添加了，该班次类型的票种，则进行修改或者删除
			if(otherlist!=null && otherlist.size()>0){
					for(int i =0;i<otherlist.size();i++){
						Scheduleselltickettype selltype = otherlist.get(i);
						if(!tickettype.contains(String.valueOf(selltype.getTickettypeid()))){
							selltickettypedao.deleteScheduleselltickettype(selltype.getId());					
						}else{
							scheduleselltickettype.setUpdatetime(new Date());
							 if(selltickettypedao.updateScheduleselltickettype(
									selltype.getId(),selltype.getTickettypeid(),
									scheduleselltickettype.getUpdateby(),scheduleselltickettype.getRemarks(),scheduleselltickettype.getCanselltype(),scheduleselltickettype.getCansellvalue())){
								 resulttype = selltype;
							 }
						}
					}
				}
				for(int i=0;i<ty.length;i++){
					//遍历勾选的班次类型  的其他票种					
					List<Scheduleselltickettype> moreotherlist=selltickettypedao.qryScheduleselltickettype(
							scheduleselltickettype.getOrgid(),scheduleselltickettype.getType(),
							Long.parseLong(typeid[a]),Long.parseLong(ty[i]));
					if(moreotherlist.size()<=0){
						//如果不存在该票种，则添加
						Scheduleselltickettype newselltype = new Scheduleselltickettype();
						newselltype.setCreateby(scheduleselltickettype.getCreateby());
						newselltype.setCreatetime(new Date());
						newselltype.setOrgid(scheduleselltickettype.getOrgid());
						newselltype.setType(scheduleselltickettype.getType());
						newselltype.setTypeid(Long.parseLong(typeid[a]));
						newselltype.setRemarks(scheduleselltickettype.getRemarks());
						newselltype.setUpdateby(scheduleselltickettype.getUpdateby());
						newselltype.setUpdatetime(new Date());
						newselltype.setCanselltype(scheduleselltickettype.getCanselltype());
						newselltype.setCansellvalue(scheduleselltickettype.getCansellvalue());
						newselltype.setTickettypeid(Long.parseLong(ty[i]));
						resulttype = selltickettypedao.saveScheduleselltickettype(newselltype);
					}
				}			
		}				
		return resulttype;	
	}
	
	/**
	 * 
	 */
	@Override
	public Scheduleselltickettype saveScheduleselltickettype(
			Scheduleselltickettype scheduleselltickettype,
			String typeids,String tickettypes)
	throws ServiceException {
		String tickettype = tickettypes.substring(1, tickettypes.length()-1);			
			scheduleselltickettype.setCreatetime(new Date());
			scheduleselltickettype.setUpdatetime(new Date());
			String[] tt = typeids.split(",");
			for (int i = 0; i < tt.length; i++) {
				String[] ty = tickettype.split(",");
				for(int k =0 ;k<ty.length;k++){
					List<Scheduleselltickettype> d= 
						selltickettypedao.qryScheduleselltickettype(
								scheduleselltickettype.getOrgid(),scheduleselltickettype.getType(),
								Long.parseLong(tt[i]),Long.parseLong(ty[k]));			
					if(d!=null && d.size()>0){
							throw new ServiceException("0384");   
					}		
				}				
			}
			Scheduleselltickettype result=null;			
		// 0全部班次、1线路、2班次
		if ("0".equals(scheduleselltickettype.getType())) {
			Scheduleselltickettype pcs = new Scheduleselltickettype();
			pcs.setCreateby(scheduleselltickettype.getCreateby());
			pcs.setCreatetime(scheduleselltickettype.getCreatetime());
			pcs.setOrgid(scheduleselltickettype.getOrgid());
			pcs.setUpdateby(scheduleselltickettype.getUpdateby());
			pcs.setUpdatetime(new Date());
			pcs.setCanselltype(scheduleselltickettype.getCanselltype());
			pcs.setCansellvalue(scheduleselltickettype.getCansellvalue());
			pcs.setType("0");
			pcs.setTypeid(0);
			pcs.setRemarks(scheduleselltickettype.getRemarks());
			String[] ty = tickettype.split(",");
			for (int i = 0; i < ty.length; i++) {
				pcs.setTickettypeid(Long.parseLong(ty[i]));						
				result = dao.merge(pcs);				
			}
		} else if ("1".equals(scheduleselltickettype.getType())) {
			String[] typeid = typeids.split(",");
			for (int i = 0; i < typeid.length; i++) {
				long routeid = Long.parseLong(typeid[i]);				
				Scheduleselltickettype pcs = new Scheduleselltickettype();
				pcs.setCreateby(scheduleselltickettype.getCreateby());
				pcs.setCreatetime(new Date());
				pcs.setOrgid(scheduleselltickettype.getOrgid());
				pcs.setType("1");
				pcs.setTypeid(routeid);
				pcs.setRemarks(scheduleselltickettype.getRemarks());
				pcs.setUpdateby(scheduleselltickettype.getUpdateby());
				pcs.setUpdatetime(new Date());
				pcs.setCanselltype(scheduleselltickettype.getCanselltype());
				pcs.setCansellvalue(scheduleselltickettype.getCansellvalue());
				String[] ty = tickettype.split(",");
				for (int j = 0; j < ty.length; j++) {
					pcs.setTickettypeid(Long.parseLong(ty[j]));						
					result = dao.merge(pcs);
				}
			}
		} else {
			String[] typeid = typeids.split(",");
			for (int i = 0; i < typeid.length; i++) {
				long scheduleid = Long.parseLong(typeid[i]);			
				Scheduleselltickettype pcs = new Scheduleselltickettype();
				pcs.setCreateby(scheduleselltickettype.getCreateby());
				pcs.setCreatetime(new Date());
				pcs.setOrgid(scheduleselltickettype.getOrgid());
				pcs.setType("2");
				pcs.setTypeid(scheduleid);
				pcs.setRemarks(scheduleselltickettype.getRemarks());
				pcs.setUpdateby(scheduleselltickettype.getUpdateby());
				pcs.setUpdatetime(new Date());
				pcs.setCanselltype(scheduleselltickettype.getCanselltype());
				pcs.setCansellvalue(scheduleselltickettype.getCansellvalue());
				String[] ty = tickettype.split(",");
				for (int j = 0; j < ty.length; j++) {
					pcs.setTickettypeid(Long.parseLong(ty[j]));						
					result = dao.merge(pcs);
				}
			}
		}
		return result;		
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public boolean delscheduleselltickettype(long id) {
		return selltickettypedao.delete(Scheduleselltickettype.class, id);
	}
	
	
	@Override
	public List<Map<String, Object>> findscheduleOrRoute(long orgid,String type,boolean isupdate,long id,long routeid) {
		Object[] fileds = { "id", "name","code","starttime","checked" };
		return ListUtil.listToMap(fileds,
				selltickettypedao.findscheduleOrRoute(orgid,type,isupdate,id,routeid), 
				new Object[] {long.class,String.class,String.class,String.class, boolean.class });
	}	

	/**
	 * 查询班次的可售票种
	 * @param scheduleid
	 * @return
	 */
	public List<Map<String,Object>> findCanSaleTicketType(long scheduleid){
		return ListUtil.listToMap(new Object[]{"tickettypecode"},
				selltickettypedao.findCanSaleTicketType(scheduleid), 
				new Object[] {String.class});
	}

}
