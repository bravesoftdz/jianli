package cn.nova.bus.check.service.impl;

import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import cn.nova.bus.check.dao.GpscheckDao;
import cn.nova.bus.check.model.Gpscheck;
import cn.nova.bus.check.service.GpscheckService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class GpscheckServiceImpl implements GpscheckService {

	
	private GpscheckDao dao = new GpscheckDao();
	
	@Override
	public Gpscheck save(Gpscheck entity) {
		
		Gpscheck results =(Gpscheck) dao.merge(entity);		
		
		return results;
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Gpscheck.class, id);
	}

	@Override
	public List<Map<String, Object>> query(boolean issummary,
			List<PropertyFilter> propertyFilterList) {
		boolean isquerychecked=true;
		if(!issummary){
			if (propertyFilterList != null && propertyFilterList.size() > 0) {
				for (int t = 0; t < propertyFilterList.size(); t++) {
					if (propertyFilterList.get(t).getPropertyFullName() // 查询GPS未检查的 已安检车辆
							.equals("gp!result")
							&& propertyFilterList.get(t).getMatchValue().equals("1")) {
						isquerychecked=false;
						break;
					}
				}
			}
			if (isquerychecked){
				return ListUtil.listToMap(new Object[] {
						"orgname","unitname","vehicleno","checkdate","checkresult",
						"resultname","remark","checkno","operatername",
						"creatname","updatename","createtime","updatetime",
						"vehicleid","orgid","id" },
						dao.querychecked(propertyFilterList),new Object[] { 
						String.class,String.class,String.class,Timestamp.class,String.class,
						String.class,String.class,String.class,String.class,
						String.class,String.class,Timestamp.class,Timestamp.class,
						long.class,long.class,long.class});
			}else {
				return ListUtil.listToMap(new Object[] {
						"orgname","unitname","vehicleno","checkdate","checkresult",
						"resultname","remark","checkno","operatername",
						"creatname","updatename","createtime","updatetime",
						"vehicleid","orgid","id" },
						dao.queryunchecked(propertyFilterList),new Object[] { 
						String.class,String.class,String.class,Timestamp.class,String.class,
						String.class,String.class,String.class,String.class,
						String.class,String.class,Timestamp.class,Timestamp.class,
						long.class,long.class,long.class});
			}
			
			
		}else{
			return ListUtil.listToMap(new Object[] {
					"orgname","unitname","vehicleno",
					"qualifiednum","unqualifiednum","tatolnum" }, 
					dao.querySummary(propertyFilterList),new Object[] { 
				    String.class,String.class,String.class,
				    long.class,long.class,long.class});
		} 
	}

	@Override
	public String qryCheckno(Long checkby) {
		return dao.qryCheckno(checkby);
	}
}
