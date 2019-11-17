package cn.nova.bus.base.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.model.Schedulestop;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class TicketentranceDao extends EntityManagerDaoSurport {
	
	public IDAO<Ticketentrance> tdao = new EntityManagerDaoSurport<Ticketentrance>();
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select t, o.name as orgname,c.name as createname,u.name as updatename " +
					" from Ticketentrance t ,Organization o,Userinfo u,Userinfo c " +
					" where c.id=t.createby and t.orgid = o.id and t.isactive = 1 and u.id=t.updateby ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();	
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistScheduleEntrance( Long ticketentranceid,boolean isactive) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ticketentranceid", ticketentranceid);
		map.put("isactive", isactive);
		List<Schedulestop> schedulestops = find(Schedulestop.class, map);
		return  schedulestops != null &&schedulestops.size() > 0 ? true:false;
	}
	
	@SuppressWarnings("unchecked")
	public Ticketentrance getEntrance( long orgid,String name,boolean isactive) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("orgid", orgid);
		map.put("name", name);
		map.put("isactive", isactive);
		List<Ticketentrance> ticketentrance = find(Ticketentrance.class, map);
		return ticketentrance != null && ticketentrance.size() > 0 ? ticketentrance
				.get(0) : null;
	}
	

	@SuppressWarnings("unchecked")
	public boolean update(long id){
		int resultnum = 0;
		String sql = "update Ticketentrance t set t.isactive = 0 where t.id = "+id;
			resultnum = tdao.execute(sql);		
		if(resultnum > 0){
			return true;
		}else{
			return false;			
		}
		
	}
}
