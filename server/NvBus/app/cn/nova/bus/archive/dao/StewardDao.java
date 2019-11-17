package cn.nova.bus.archive.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.archive.model.Stewardworkexperience;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class StewardDao  extends EntityManagerDaoSurport{

	@SuppressWarnings("unchecked")// , ut.name as unitname ,u.name as createname,up.name as updatename
	public List<Object> querySteward(List<PropertyFilter> propertyFilterList,String isfinger) {
		StringBuilder sql = new StringBuilder("select s, ut.name as unitname ,u.name as createname,up.name as updatename" +
				" ,case when s.fingerstr1 is not null or s.fingerstr2 is not null or s.fingerstr3 is not null then 1 else 0 end as isfinger"+
				" from Steward s ,Unit ut,Userinfo u,Userinfo up ") 
		.append(" where s.createby = u.id and s.updateby = up.id and s.unitid = ut.id and s.isactive = 1 and s.islocaldelete = 0");
		//.append(" and d.unitid = u.id ");
		if(isfinger!=null&&isfinger.equals("True")){
			sql.append(" and (s.fingerstr1 is  not null or s.fingerstr2 is not null or s.fingerstr3 is not  null)  ");
		}else if(isfinger!=null&&isfinger.equals("False")){
			sql.append(" and  (s.fingerstr1 is   null and s.fingerstr2 is  null and s.fingerstr3 is   null)  ");
		}
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryWork(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(" select  w,uc.name as createname,up.name as updatename from Stewardworkexperience w ,Steward s ,Userinfo uc,Userinfo up ")
											.append( " where w.stewardid =s.id and w.isactive = 1 and w.createby = uc.id and w.updateby = up.id "); 
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public boolean update(String tablename,long detid,boolean isDelOne){
		int resultnum = 0;
		String sql = "";
		if(tablename.equals("Stewardworkexperience")){
			if(isDelOne){
				sql = "update "+tablename+" t set t.isactive = 0,t.islocaldelete = 1 where t.id = "+detid;
				resultnum = execute(sql);
			}else{
				sql = "update "+tablename+" t set t.isactive = 0,t.islocaldelete = 1 where t.stewardid = "+detid;
				resultnum = execute(sql);
			}			
		}else if(tablename.equals("Steward")){
			sql = "update "+tablename+" t set t.isactive = 0,t.islocaldelete = 1 where t.id = "+detid;
			resultnum = execute(sql);
		}
		if(resultnum > 0){
			return true;
		}else{
			return false;			
		}
		
	}
	
	@SuppressWarnings("unchecked")
	public boolean isExistVehicleSteward(long Stewardid){
		StringBuilder sql = new StringBuilder("select v from Schedulevehiclepeopleplan v where  " +
				" v.plansteward1.id = "+Stewardid+" or v.plansteward2.id = "+Stewardid);
		Query query = getEntityManager().createQuery(sql.toString());
		List<Object> list= query.getResultList();
		if(list.size()!=0){
			return true;
		}else{
			return false;
		}		
	}

	public long isExistStward(String idcard,String cardno,String code) {
		Map<String,Object> map = new HashMap<String, Object>();
		if(idcard!=null){
			map.put("idcard", idcard);
		}
		if(cardno!=null){
			map.put("cardno", cardno);
		}
		if(code!=null){
			map.put("code", code);
		}	
		map.put("isactive", true);
		List<Steward> steward = find(Steward.class, map);
		return steward!=null&&steward.size()>0?steward.get(0).getId():0;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> findPicturebyId(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select s.id,s.picture from Steward s") 
		.append(" where 1=1");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	@SuppressWarnings("unchecked")
	public List<Object> queryStewardFinger() {
		StringBuilder sql = new StringBuilder("select d.id, d.fingerstr1 fingerstr,d.name ")
		.append(" from Steward d where d.fingerstr1 is not null and d.isactive = 1")
		.append(" union all select d.id, d.fingerstr2 fingerstr ,d.name")
		.append("  from Steward d where d.fingerstr2 is not null and d.isactive = 1")
		.append(" union all select d.id, d.fingerstr3 fingerstr ,d.name")
		.append("  from Steward d where d.fingerstr3 is not null and d.isactive = 1");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	public List<Object> queryStewardBystewardid(long stewardid) {
		StringBuilder sql = new StringBuilder("select s.id,s.name from Steward s where s.id= ");
				sql.append(stewardid);
				Query query = getEntityManager().createNativeQuery(sql.toString());
				return query.getResultList();
	}
}
