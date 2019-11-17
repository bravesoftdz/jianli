package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.SetDriverVehicle;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class SetDriverVehicleDao extends EntityManagerDaoSurport{
	/*
	 * 查询
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySetDriverVehicle(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder()
		.append(" select s.id, s.orgid, s.driverid, s.vehicleid, s.remark, ")
		.append(" s.createtime, s. createby, s.updatetime, s.updateby, ")
		.append(" org.name orgname, d.name drivername, v.vehicleno, u1.name createname, u2.name updatename from ")
		.append(" Setdrivervehicle s, Organization org, Driver d, Vehicle v, Userinfo u1, Userinfo u2 ")
		.append(" where s.orgid=org.id and s.driverid=d.id and s.vehicleid=v.id ") 
		.append(" and s.createby=u1.id and s.updateby=u2.id ")
		.append(" and d.isactive='1'  ");
		sql.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by org.name, d.name, v.vehicleno ");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		//System.out.println("<<驾驶员驾驶车辆设置>>    -->    "+sql.toString());
		return query.getResultList();
	}

	/*
	 * 查询本地机构
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryCurOrg(String orgids) {
		StringBuilder sql = new StringBuilder()
		.append(" select o.id, o.name, o.code from Organization o")
		.append(" where  o.isactive=1");  //(o.type='1' or o.type='2') and
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();
	}
	/*
	 * 由驾驶员联动显示未关联的车牌
	 */
	public List<Object> queryvehicleno(String orgid,String driverid){
		StringBuffer sql= new StringBuffer();
		String conSql = "";
		
		if(driverid!=null && !driverid.equals("")){
			conSql = " and d.id='"+driverid+"' ";
			sql.append(" select 0,v.vehicleno,v.id from vehicle v where ")
			.append(" not exists ( select s.vehicleid from driver d, SetDriverVehicle s ")
			.append(" where s.driverid=d.id and s.vehicleid=v.id ")
			.append(conSql)
			.append(" ) ");
		}
		else{
			sql.append("  select 1,v.vehicleno,v.id from vehicle v where 1<>1 ");
		}
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return list.size()>0?list:null;		
	}
	
	/*
	 * 修改时查询是否有驾驶员和车牌号相同的记录
	 */
	public List isExistDriverVehicle(SetDriverVehicle setDriverVehicle){
		//
		String conSql = "";
		if(setDriverVehicle!=null){
			conSql = " and s.driverid="+setDriverVehicle.getDriverid()
					+" and s.vehicleid="+setDriverVehicle.getVehicleid()
					+" and s.id<>"+setDriverVehicle.getId();
		}
		
		StringBuffer sql= new StringBuffer()
		.append(" select d.name drivername, v.vehicleno from setdrivervehicle s, driver d, vehicle v ")
		.append(" where s.driverid=d.id and s.vehicleid=v.id ")
		.append(conSql);
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return list;
	}
}
