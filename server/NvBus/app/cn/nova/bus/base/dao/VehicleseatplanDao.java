/**
 * 
 */
package cn.nova.bus.base.dao;

import java.util.ArrayList;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Vehicleseatplan;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author ice
 *
 */
public class VehicleseatplanDao extends EntityManagerDaoSurport {
	//查询车辆座位图主表
	public List<Object> find(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select vb.id,vb.brandname,vb.modelcode,vb.rationseatnum,vb.orgid ")
		.append(",vs.vehiclebrandmodelid, vs.createtime, vs.createby, vs.updatetime, vs.updateby ")
		.append(",uc.name as createbyname,uu.name as updatebyname")
		.append(" from Vehiclebrandmodel vb left join Vehicleseatplan vs on vb.id=vehiclebrandmodelid and vs.isactive=1")
		.append(" left join Userinfo uc on vs.createby=uc.id")
		.append(" left join Userinfo uu on vs.updateby=uu.id")
		.append(" where vb.isactive=1")
		.append(PropertyFilter.toJpql(propertyFilterList,true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	//查询车辆座位图明细表用来展现座位图
	public List<Object> finddetail(Vehicleseatplan vehicleseatplan) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQO_t!vehicleseatplan", vehicleseatplan));
		return super.query(Vehicleseatplandetail.class, propertyFilters);
	}

	//按车辆品牌型号和座位号查询打印备注
	public String getSeatnoRemark(long vehiclebrandmodelid, short seatno) {
		String result = String.valueOf(seatno);
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!vehicleseatplan.vehiclebrandmodelid", vehiclebrandmodelid));
		propertyFilters.add(new PropertyFilter("EQR_t!seatno", seatno));
		Vehicleseatplandetail vehicleseatplandetail =  (Vehicleseatplandetail) super.uniqueResult(Vehicleseatplandetail.class, propertyFilters);
		if(vehicleseatplandetail!=null&&vehicleseatplandetail.getRemarks()!=null&&!vehicleseatplandetail.getRemarks().equals("")){
			result = vehicleseatplandetail.getRemarks();
		}
		return result;
	}
	
	//按车辆品牌型号ID删除车辆座位图明细表
	public boolean deleteByVehiclebrandmodelid(long vehiclebrandmodelid){
		String sql="delete from Vehicleseatplandetail t where t.vehicleseatplan.vehiclebrandmodelid="+vehiclebrandmodelid ;
		this.execute(sql);				
		return false;
	}
}
