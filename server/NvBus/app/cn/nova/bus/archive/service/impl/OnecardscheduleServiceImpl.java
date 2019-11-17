package cn.nova.bus.archive.service.impl;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.archive.dao.OnecardscheduleDao;
import cn.nova.bus.archive.model.Onecardschedule;
import cn.nova.bus.archive.service.OnecardscheduleService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


/**
 * <b>类描述：</b>一卡通参与班次<br/>
 * <b>类名称：</b>OnecardscheduleServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2012-9-12 6<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class OnecardscheduleServiceImpl implements OnecardscheduleService {
	
	//private IDAO<Onecardschedule> dao = new EntityManagerDaoSurport<Onecardschedule>();
	
	private OnecardscheduleDao onecardscheduledao = new OnecardscheduleDao();
	
	@Override
	public List<Map<String, Object>> findOnecardschedule(
			List<PropertyFilter> propertyFilterList,Date startdate,Date enddate) {
		Object[] fileds = { "id","orgid","orgname","typename","typecode","typeidname",
				"startdate","enddate","createname","updatename",
				"createtime","updatetime","typeid","createby","remarks"};		
		Object[] filedtypes = { long.class,long.class,String.class, String.class,long.class,String.class,
				Date.class,Date.class,String.class,String.class,
				Timestamp.class, Timestamp.class,Long.class,Long.class,String.class};
		return ListUtil.listToMap(fileds,
				onecardscheduledao.findOnecardschedule(propertyFilterList,startdate,enddate), filedtypes);
	}
	
	@Override
	public Onecardschedule updateOnecardschedule(Onecardschedule onecardschedule,
			String typeids) throws ServiceException  {
		Onecardschedule resultonecardschedule = null;
		String[] typeid = typeids.split(",");
		if(onecardschedule.getType()==0){
			List<Onecardschedule> olds = onecardscheduledao.qryOnecardschedule(
					onecardschedule.getOrgid(), onecardschedule.getType(), 0l,
					onecardschedule.getStartdate(),onecardschedule.getEnddate());
			if(olds!=null && olds.size()>0){
					throw new ServiceException("0418");
			}
		
			resultonecardschedule = onecardscheduledao.saveOnecardschedule(onecardschedule);
//			Onecardschedule oldcard = dao.get(Onecardschedule.class, onecardschedule.getId());
//			oldcard.setStartdate(onecardschedule.getStartdate());
//			oldcard.setEnddate(onecardschedule.getEnddate());
//			oldcard.setRemarks(onecardschedule.getRemarks());
//			oldcard.setUpdateby(onecardschedule.getUpdateby());
//			oldcard.setUpdatetime(onecardschedule.getUpdatetime());
//			resultonecardschedule = dao.merge(oldcard);
		}else{
			for(int a=0;a<typeid.length;a++){
//				//先判断是否存在相同日期段的记录
				List<Onecardschedule> olds = onecardscheduledao.qryOnecardschedule(
						onecardschedule.getOrgid(), onecardschedule.getType(), Long.parseLong(typeid[a]),
						onecardschedule.getStartdate(),onecardschedule.getEnddate());
				if(olds!=null && olds.size()>0){
					//选择的班线存在日期交叉，请重新选择！
					for(int j=0;j<olds.size();j++){
						if(olds.get(j).getId()!=onecardschedule.getId()){
							throw new ServiceException("0418");							
						}
					}
				}
//			//如果不存在 ，再找出存在相同记录不同日期的 班线，再进行修改
//			List<Onecardschedule> oldone = onecardscheduledao.qryOnecardschedule(
//						onecardschedule.getOrgid(),onecardschedule.getType(),Long.parseLong(typeid[a]),
//						null,null);		
//					//查询已经存在的
//			if (oldone!=null && oldone.size()>0 ){
//				for(int k=0;k<oldone.size();k++){
//					Onecardschedule old = oldone.get(k);
//					if(old.getStartdate() != onecardschedule.getStartdate()){
//						old.setStartdate(onecardschedule.getStartdate());
//						old.setEnddate(onecardschedule.getEnddate());
//						old.setRemarks(onecardschedule.getRemarks());
//						old.setUpdateby(onecardschedule.getUpdateby());
//						old.setUpdatetime(onecardschedule.getUpdatetime());
//						resultonecardschedule = dao.merge(old);									
//					}else{
//						onecardschedule.setTypeid(Long.parseLong(typeid[a]));
//						resultonecardschedule = onecardscheduledao.saveOnecardschedule(onecardschedule);								
//					}
//				}						
//			}else{
				onecardschedule.setTypeid(Long.parseLong(typeid[a]));
				resultonecardschedule = onecardscheduledao.saveOnecardschedule(onecardschedule);
			}
//		}	
	}
	return resultonecardschedule;
	}
	
	@Override
	public Onecardschedule saveOnecardschedule(Onecardschedule onecardschedule,
			String typeids)  throws ServiceException {	
		Onecardschedule results=null;
		String[] typeid = typeids.split(",");
		onecardschedule.setIsactive(true);
		if(onecardschedule.getType()==0){
			List<Onecardschedule> olddonecard = onecardscheduledao.qryOnecardschedule(
					onecardschedule.getOrgid(), onecardschedule.getType(), 0l,
					onecardschedule.getStartdate(),onecardschedule.getEnddate());
			if(olddonecard!=null && olddonecard.size()>0){
//				//如果存在激活的记录，则抛出错误
//				if(olddays.getIsactive()){
					//选择的班线存在日期交叉，请重新选择！
					throw new ServiceException("0418");
//				}else{
//					//如果存在删除了的记录，则修改
//					olddays.setIsactive(true);
//					olddays.setStartdate(onecardschedule.getStartdate());
//					olddays.setEnddate(onecardschedule.getEnddate());
//					olddays.setUpdateby(onecardschedule.getUpdateby());
//					olddays.setUpdatetime(onecardschedule.getUpdatetime());
//					results = onecardscheduledao.saveOnecardschedule(olddays);
//					return results;
//				}				 
			}
			onecardschedule.setTypeid(0l);
			results = onecardscheduledao.saveOnecardschedule(onecardschedule);
		}else{
			for(int i=0;i<typeid.length;i++){
				List<Onecardschedule> olds = onecardscheduledao.qryOnecardschedule(
						onecardschedule.getOrgid(), onecardschedule.getType(), Long.parseLong(typeid[i]),
						onecardschedule.getStartdate(),onecardschedule.getEnddate());
				if(olds!=null && olds.size()>0){
					//选择的班线存在日期交叉，请重新选择！
					throw new ServiceException("0418"); 
				}
				onecardschedule.setTypeid(Long.parseLong(typeid[i]));
				results = onecardscheduledao.saveOnecardschedule(onecardschedule);
			}	
		}
		 return results;			
	}	

	@SuppressWarnings("unchecked")
	@Override
	public boolean delschedule(long id){
		return onecardscheduledao.delete(Onecardschedule.class, id);		
	}
	
	@Override
	public List<Map<String, Object>> findscheduleOrRoute(long orgid,String type,boolean isupdate,long id,long routeid) {
		Object[] fileds = { "id", "name","code","starttime","checked" };
		return ListUtil.listToMap(fileds,
				onecardscheduledao.findscheduleOrRoute(orgid,type,isupdate,id,routeid), 
				new Object[] {long.class,String.class,String.class,String.class, boolean.class });
	}


}
