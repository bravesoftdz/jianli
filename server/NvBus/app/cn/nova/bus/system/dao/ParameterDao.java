package cn.nova.bus.system.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Parameter;
import cn.nova.bus.system.model.Parameterorgdetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class ParameterDao extends EntityManagerDaoSurport {

	 
	public IDAO<Parameter> dao = new EntityManagerDaoSurport<Parameter>();
	
	public IDAO<Parameterorgdetail> pdao = new EntityManagerDaoSurport<Parameterorgdetail>();
	
	@SuppressWarnings("unchecked")
	public List<Object> queryParameter(List<PropertyFilter> propertyFilterList,String orgids) {
		StringBuilder sql = new StringBuilder(" select nvl(pd.updatetime,p.updatetime) as updatetime,nvl(pduu.name,puu.name) as updatename,")
								.append(" nvl(pd.value,p.value) as showvalue,oa.name as orgname,oa.id as orgids,p.type,trim(p.code),p.unit,")
								.append(" p.id as pid,pd.id as did,p.iseditable,p.remark" )
								.append(" from parameter p ")
								.append("  join Organization oa on oa.islocal=1 and oa.isactive=1 and (oa.type=1 or oa.type=2) and oa.id in ").append(orgids)
								.append("  left join parameterorgdetail pd on p.id=pd.parameterid  and pd.orgid = oa.id")
								.append("  left join userinfo pduc on pduc.id=pd.createby")
								.append("  left join userinfo pduu on pduu.id=pd.updateby")
								.append("  left join userinfo puu on p.updateby=puu.id")
								.append(" where p.isvisible=1 ");
			sql.append(PropertyFilter.toJpql(propertyFilterList,true))		
			   .append(" order by oa.id,p.code");
			Query query = getEntityManager().createNativeQuery(sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public String findParamValue(String code,Long orgid) {
		String sql = "";
		Object value = null;
		Query query = null;
		if (orgid!=null&&orgid!=0){
			sql = sql +"select d.value from Parameter p ,Parameterorgdetail d " +
					"where d.parameterid = p.id  and p.code= '"+code+"' and d.orgid = "+orgid;
		}else{
			sql = sql+ "select p.value from Parameter p  where p.code = '"+code+"'";
		}
		try {
			query = getEntityManager().createNativeQuery(sql);
			value = query.getSingleResult();
		} catch (Exception e) {
			sql =  "select p.value from Parameter p  where p.code = '"+code+"'";
			query = getEntityManager().createNativeQuery(sql);
			try {
				value = query.getSingleResult();
			} catch (RuntimeException e2) {
				play.Logger.error("找不到参数"+code);
				throw e2;
			}
		}
		 return (String) value;
	}
	
	public List<Object> findParamsValue(String codes, Long orgid){
		String sql = "";
		Query query = null;
		if (orgid!=null&&orgid!=0){
			sql = "select cast(p.code as varchar2(4)) code, nvl(d.value, p.value) from Parameter p left join Parameterorgdetail d on (d.parameterid = p.id and d.orgid = "+orgid +" )" +
					"where p.code in (" + codes + ")";
		}else{
			sql = "select cast(p.code as varchar2(4)) code, p.value from Parameter p  where p.code in (" + codes + ")";
		}
		query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Parameterorgdetail> getDetail(Long orgid,Long parameterid){
		Map<String,Object> where = new HashMap<String, Object>();
		if(orgid!=null){
			where.put("orgid", orgid);			
		}
		if(parameterid!=null){
			where.put("parameterid", parameterid);
		}
		List<Parameterorgdetail> list  = pdao.find(Parameterorgdetail.class, where);
		return list;
	}
	

	public String findParamByStatoin(String code,Long departstationid){
		String sql = "";
		Object value = null;
		Query query = null;
		if (departstationid!=null&&departstationid!=0){
			sql = sql +"select d.value from Parameter p ,Parameterorgdetail d,Organization org " +
					"where d.parameterid = p.id and d.orgid=org.id and p.code= '"+code+"' and org.station.id = "+departstationid;
		}else{
			sql = sql+ "select p.value from Parameter p  where p.code = '"+code+"'";
		}
		try {
			query = getEntityManager().createQuery(sql);
			value = query.getSingleResult();
		} catch (Exception e) {
			sql =  "select p.value from Parameter p  where p.code = '"+code+"'";
			query = getEntityManager().createQuery(sql);
			value = query.getSingleResult();
		}
		 return (String) value;
	}	
}
