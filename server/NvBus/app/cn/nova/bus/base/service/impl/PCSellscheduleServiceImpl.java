package cn.nova.bus.base.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.PCSellscheduleDao;
import cn.nova.bus.base.model.Pcsellschedule;
import cn.nova.bus.base.service.PCSellscheduleService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class PCSellscheduleServiceImpl implements PCSellscheduleService {


	private IDAO<Pcsellschedule> dao = new EntityManagerDaoSurport<Pcsellschedule>();

	private PCSellscheduleDao pcdao = new PCSellscheduleDao();

	@SuppressWarnings("unchecked")
	@Override
	public Boolean savePcsellschedule(Pcsellschedule pcsellschedule,
			String typeids) throws ServiceException {
		boolean result= false;
		pcsellschedule.setCreatetime(new Date());
		pcsellschedule.setUpdatetime(new Date());
		String[] types = typeids.split(",");
		for (int i = 0; i < types.length; i++) {
			List<Pcsellschedule> eixtoldlist=pcdao.qryPcsellschedule(pcsellschedule.getIp(), pcsellschedule.getOrgid(),
					  pcsellschedule.getType(),Long.parseLong(types[i]));
			if(eixtoldlist!=null && eixtoldlist.size()>0){
			 throw new ServiceException("0275");			
		  }
		}
			
//		List<Pcsellschedule> oldsellschedule = pcdao.qryPcsellschedule(
//				pcsellschedule.getIp(), pcsellschedule.getOrgid());
//		if (oldsellschedule != null && oldsellschedule.size() > 0) {
//			for (Pcsellschedule pcs : oldsellschedule) {
//				pcdao.delete(pcs);
//				pcdao.getEntityManager().flush();
//			}
//		}
		// 0全部班次、1线路、2班次
		if ("0".equals(pcsellschedule.getType())) {
			Pcsellschedule pcs = new Pcsellschedule();
			pcs.setCreateby(pcsellschedule.getCreateby());
			pcs.setCreatetime(pcsellschedule.getCreatetime());
			pcs.setIp(pcsellschedule.getIp());
			pcs.setOrgid(pcsellschedule.getOrgid());
			pcs.setType("0");
			pcs.setTypeid(0);
			pcs.setUpdateby(pcsellschedule.getUpdateby());
			pcs.setUpdatetime(new Date());
			if(pcdao.merge(pcs) != null){
				result = true;
			}
		} else if ("1".equals(pcsellschedule.getType())) {
			String[] typeid = typeids.split(",");// 12,45
			// 用于把id存到long类型的数组中,方便后面进行比较
			for (int i = 0; i < typeid.length; i++) {
				long routeid = Long.parseLong(typeid[i]);
				Pcsellschedule pcs = new Pcsellschedule();
				pcs.setCreateby(pcsellschedule.getCreateby());
				pcs.setCreatetime(new Date());
				pcs.setIp(pcsellschedule.getIp());
				pcs.setOrgid(pcsellschedule.getOrgid());
				pcs.setType("1");
				pcs.setTypeid(routeid);
				pcs.setUpdateby(pcsellschedule.getUpdateby());
				pcs.setUpdatetime(new Date());
				if(pcdao.merge(pcs)!=null){
					result = true;
				}
			}
		} else {
			String[] typeid = typeids.split(",");// 12,45
			// 用于把id存到long类型的数组中,方便后面进行比较
			for (int i = 0; i < typeid.length; i++) {
				long scheduleid = Long.parseLong(typeid[i]);
				Pcsellschedule pcs = new Pcsellschedule();
				pcs.setCreateby(pcsellschedule.getCreateby());
				pcs.setCreatetime(new Date());
				pcs.setIp(pcsellschedule.getIp());
				pcs.setOrgid(pcsellschedule.getOrgid());
				pcs.setType("2");
				pcs.setTypeid(scheduleid);
				pcs.setUpdateby(pcsellschedule.getUpdateby());
				pcs.setUpdatetime(new Date());
				if(pcdao.merge(pcs)!=null){
					result = true;
				}
			}
		}
		return result;

	}
	
	@SuppressWarnings("unchecked")
	@Override
	public boolean updatePcsellschedule(Pcsellschedule pcsellschedule,
			String typeids) throws ServiceException {
		boolean result = false;
		  String[] typeid = typeids.split(",");
		  List<Pcsellschedule> eixtoldlist=pcdao.qryPcsellschedule(pcsellschedule.getIp(), pcsellschedule.getOrgid(),
				  pcsellschedule.getType(),0);		  
		  if(eixtoldlist!=null && eixtoldlist.size()>0){
			  for(int i=0;i<eixtoldlist.size();i++){
				  Pcsellschedule oldsellschedule = eixtoldlist.get(i);
				  if(typeids.contains(String.valueOf(oldsellschedule.getTypeid()))){
					  oldsellschedule.setUpdatetime(new Date());
					  if(pcdao.merge(oldsellschedule)!=null){
						  result = true;
						  pcdao.getEntityManager().flush();
					  }
				  }else{					  
					  result  = pcdao.delete(oldsellschedule);
					  pcdao.getEntityManager().flush();
				  }
			  }
			  
			  for(int j=0;j<typeid.length;j++){
				  List<Pcsellschedule> iseixt= pcdao.qryPcsellschedule(pcsellschedule.getIp(), pcsellschedule.getOrgid(),
						  pcsellschedule.getType(),Long.parseLong(typeid[j]));
				  if(iseixt.size()<=0){						  
					  Pcsellschedule newsellschedule = new Pcsellschedule();
					  newsellschedule.setCreateby(pcsellschedule.getCreateby());
					  newsellschedule.setCreatetime(new Date());
					  newsellschedule.setIp(pcsellschedule.getIp());
					  newsellschedule.setOrgid(pcsellschedule.getOrgid());
					  newsellschedule.setType(pcsellschedule.getType());
					  newsellschedule.setTypeid(Long.parseLong(typeid[j]));
					  newsellschedule.setUpdateby(pcsellschedule.getUpdateby());
					  newsellschedule.setUpdatetime(new Date());
					  if(pcdao.merge(newsellschedule)!=null){
						  result = true;
						  pcdao.getEntityManager().flush();
					  }
				  }
			  }			  			
		  }else{
			  for(int i=0;i<typeid.length;i++){
				  pcsellschedule.setTypeid(Long.parseLong(typeid[i]));
				  pcsellschedule.setUpdatetime(new Date());
				  if(pcdao.merge(pcsellschedule)!=null){
					  result = true;
					  pcdao.getEntityManager().flush();
				  }
			  }
		  }
		return  result;
	}


	public List<Pcsellschedule> findEntyby(Map<String, Object> where) {
		List<Pcsellschedule> pcsellschedule = dao.find(Pcsellschedule.class,
				where);
		return pcsellschedule;
	}

	@Override
	public Boolean delpcsellschedule(long id) {
		return dao.delete(Pcsellschedule.class, id);
	}

	@Override
	public Boolean delschedule(Pcsellschedule pcsellschedule) {
	   return pcdao.delschedulewhere(pcsellschedule.getOrgid(),
				pcsellschedule.getIp(),pcsellschedule.getType());
	}

	@Override
	public List<Map<String, Object>> findsellschedule(
			List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "type", "ip", "orgid", "orgname" };// 初始化要查询的字段
		Object[] filedtypes = { String.class, String.class, Long.class,
				String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds,
				pcdao.findschedule(propertyFilterList), filedtypes);

	}

	@Override
	public List<Map<String, Object>> findschedulesname(
			Pcsellschedule pcsellschedule) {
		Object[] fileds = { "pcid", "id", "sellname", "sellcode", "starttime",
				"createtime", "createby", "updatetime", "updateby",
				"createname", "updatename" };
		return ListUtil.listToMap(fileds, pcdao.findschedulesname(
				pcsellschedule.getOrgid(), pcsellschedule.getType(),
				pcsellschedule.getIp(), pcsellschedule.getTypeid()));
	}

	@Override
	public List<Map<String, Object>> findscheduleOrRoute(Pcsellschedule pcsellschedule,long routeid,Boolean isupdate) {
		Object[] fileds = { "id", "name", "code","starttime" };
		return ListUtil.listToMap(fileds,
				pcdao.findscheduleOrRoute(pcsellschedule.getOrgid(), pcsellschedule.getType(),routeid,isupdate));
	}
}
