package cn.nova.bus.hirebus.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.service.VehicleService;
import cn.nova.bus.base.service.impl.VehicleServiceImpl;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.hirebus.model.Hirebus;
import cn.nova.utils.orm.PropertyFilter;

@SuppressWarnings("rawtypes")
public class HirebusDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {

		String orgids=null;
		Long unitid=null;
		Long vehicleid=null;
		Long operater=null;
		String status=null;
		Date startdate = null;
		Date enddate = null;
		Date shiredate = null;
		Date ehiredate = null;
		String type=null;
		Long ticketoutletsid=null;
		Vehicle vehicle=null;
		
		if (propertyFilters != null && propertyFilters.size() > 0) {
			for (int t = 0; t < propertyFilters.size(); t++) {

				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!orgid")) {
					orgids = (String) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!unitid")) {
					unitid = (Long) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!vehicle.id")) {
					vehicleid = (Long) propertyFilters.get(t).getMatchValue();
					if(vehicleid!=null && vehicleid>0){
						VehicleService vehicleservice = new VehicleServiceImpl();
						vehicle = vehicleservice.findById(vehicleid);
//						if (vehicle!=null){
//							hirebus.setVehicle(vehicle);
//						}
					}
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!operater")) {
					operater = (Long) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!status")) {
					status = (String) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!startdate")) {
					startdate = (Date) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!enddate")) {
					enddate = (Date) propertyFilters.get(t).getMatchValue();
					continue;
				}

				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!hiredate") && propertyFilters.get(t).getMatchType().name()
						.equals("GE")) {
					shiredate = (Date) propertyFilters.get(t).getMatchValue();
					continue;
				}
				
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!hiredate") && propertyFilters.get(t).getMatchType().name()
						.equals("LE")) {
					ehiredate = (Date) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!type")) {
					type = (String) propertyFilters.get(t).getMatchValue();
					continue;
				}
				if (propertyFilters.get(t).getPropertyFullName()
						.equals("h!ticketoutletsid")) {
					ticketoutletsid = (Long) propertyFilters.get(t).getMatchValue();
					continue;
				}
			}
		}

		StringBuffer sb = new StringBuffer(
				"select h,u.name as unitname,u.fullname,us.name as operatername,org.name as orgname,v.vehicleno,tl.name as tlname,dt.name as districtname ")
				.append(" from Hirebus h left join h.vehicle v, ")
				.append(" Organization org,Unit u, Userinfo us,Ticketoutlets tl,District dt  ")
				.append(" where org.id=h.orgid and dt.id=h.districtid ")
				.append(" and u.id=h.unitid and us.id=h.operater and tl.id=h.ticketoutletsid ")
				.append(" and h.hiredate between :shiredate and :ehiredate ");
				//.append(" h.vehicle.id=v.id");
		if (orgids!=null && !"".equals(orgids)){
			sb.append(" and h.orgid in "+orgids);
		}
		if (unitid!=null && !"".equals(unitid)){
			sb.append(" and h.unitid="+unitid);
		}
		if (vehicle!=null){
			sb.append(" and h.vehicle.id="+vehicleid);
		}
		if (operater!=null && !"".equals(operater)){
			sb.append(" and h.operater="+operater);
		}
		if (status!=null && !"".equals(status)){
			sb.append(" and h.status='"+status+"'");
		}
		if (type!=null && !"".equals(type)){
			sb.append(" and h.type='"+type+"'");
		}
		if (ticketoutletsid!=null){
			sb.append(" and h.ticketoutletsid="+ticketoutletsid+"");
		}
		
		if(startdate!=null){
			sb.append(" and ( h.startdate between :startdate and :enddate or h.enddate between :startdate and :enddate)");
		}
		
		
		//		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sb.toString());
//		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		query.setParameter("shiredate", shiredate);
		query.setParameter("ehiredate", ehiredate);
		if(startdate!=null){
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);
		}
		
		List<Object> list=query.getResultList();
		return list;
	}

	/**
	 * 作废操作
	 * 
	 * @param hirebus
	 * @return
	 * @throws ServiceException
	 */
	public boolean wastePack(Hirebus hirebus) {
		StringBuffer sb = new StringBuffer(
				"update Hirebus set status=:status,updateby=:updateby,updatetime=:updatetime where id=:id");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("status", hirebus.getStatus());
		query.setParameter("updateby", hirebus.getUpdateby());
		query.setParameter("updatetime", hirebus.getUpdatetime());
		query.setParameter("id", hirebus.getId());

		return query.executeUpdate() > 0 ? true : false;
	}
}
