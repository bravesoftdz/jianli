/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.dao<br/>
 * <b>文件名：</b>VehicleDao.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-7-6-下午03:58:00<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Initcard;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：车辆信息查询</b><br/>
 * <b>类名称：</b>VehicleDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class VehicleDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> qryVehicle(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder("select v.id,v.vehicleno,v.type,")
				.append("v.vehicletypeid,v.vehiclebrandmodelid,v.unitid,v.rationseatnum,")
				.append("v.seatnum,v.loadamout,v.color,v.contactperson,")
				.append("v.contactphone,v.remarks,v.orgid,v.cardno,v.grantdate,")
				.append("v.contractno,v.contractstartdate,v.contractenddate,")
				.append("v.liabilityinsureno,v.liabilityinsurestartdate,")
				.append("v.liabilityinsureenddate,v.compulsoryinsureno,")
				.append("v.compulsoryinsurestartdate,v.compulsoryinsureenddate,")
				.append("v.licensestartdate,v.licenseenddate,v.workno,")
				.append("v.workstartdate,v.workenddate,v.isaudited,")
				.append("v.isauditpass,v.gprs,v.createtime,v.createby,")
				.append("v.updatetime,v.updateby,u.name as createbyname,")
				.append("n.name as unitname,vbm.brandname,vbm.modelcode,")
				.append("vt.name as vehicletypename,v.synccode,cs.validdate,")
				.append(" v.balanceunitid,v.margin,v.stopfee,v.checkfee,")
				.append(" v.otherfee,v.vehiclenodate,bn.name as balanceunitname,")
				.append(" v.routeid,r.name as routename,v.entercardno,v.makedate,")
				.append(" v.cardnoprintdate,v.istempvehicle,n.fullname,v.auditroute,v.status,up.name as updatebyname,")
				.append(" v.driverlicense,v.roadno,v.maintainvaliddate,v.nextmaintaindistance,v.isneedfinger,v.seattype, ")
				.append(" v.isneedcheck ,v.twodimensionno,v.roadstartdate,v.roadenddate,tt.value as fueltype,v.fueltype as fueltypecode ")
				.append(" ,v.pullinagreementno,v.pullinStartdate,v.pullinEnddate ")
				.append(" ,v.ischargestopfee as ischargestopfee, v.ischargescheckfee as ischargescheckfee, v.ischargeotherfee as ischargeotherfee ")
				.append(" ,v.businesscertificateno businesscertificateno,v.businesscertificatestartdate businesscertificatestartdate,v.businesscertificateenddate businesscertificateenddate ")
				.append(" ,v.technialstartdate technialstartdate,v.technialenddate technialenddate,v.extinguisherstartdate extinguisherstartdate,v.extinguisherenddate extinguisherenddate ")
				.append(" from Vehicle v ")
				.append(" left join vehiclebrandmodel vbm on vbm.id = v.vehiclebrandmodelid")
				.append(" left join Cardissue cs on v.cardno=cs.cardno  ")
				.append(" left join Route r on v.routeid=r.id ")
				.append(" left join Userinfo u on u.id = v.createby ")
				.append(" left join Unit n on n.id = v.unitid ")
				.append(" left join Vehicletype vt on vt.id = v.vehicletypeid ")
				.append(" left join Unit bn on v.balanceunitid=bn.id ")
				.append(" left join Userinfo up on v.updateby = up.id ")
				.append(" left join digitaldictionary t on t.tablename = 'vehicle' and t.columnname = 'fueltype' ")
				.append(" left join digitaldictionarydetail tt on tt.digitaldictionaryid = t.id and tt.code = v.fueltype ")
				.append(" where v.isactive = '1'");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = em.createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Vehicle isExistDelVehicle(Vehicle vehicle) {
		StringBuilder sql = new StringBuilder(
				"select v from Vehicle v where v.vehicleno=:vehicleno and v.isactive=0");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleno", vehicle.getVehicleno());
		List list = query.getResultList();
		return (Vehicle) (list != null && list.size() > 0 ? list.get(0) : null);
	}

	public boolean isExistVehicle(Vehicle vehicle) {
		if (vehicle.getId() > 0) {
			StringBuilder sql = new StringBuilder(
					"select v from Vehicle v where v.vehicleno=:vehicleno and v.isactive=1")
					.append(" and v.id!=:id");
			Query query = em.createQuery(sql.toString());
			query.setParameter("vehicleno", vehicle.getVehicleno());
			query.setParameter("id", vehicle.getId());
			List list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select v from Vehicle v where v.vehicleno=:vehicleno and v.isactive=1");
			Query query = em.createQuery(sql.toString());
			query.setParameter("vehicleno", vehicle.getVehicleno());
			List list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;

		}
	}

	public boolean isUsedByCardNo(Vehicle vehicle) {
		if (vehicle.getId() > 0) {
			StringBuilder sql = new StringBuilder(
					"select v.id from Vehicle v where v.cardno=:cardno and v.isactive=1")
					.append(" and v.id!=:id");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("cardno", vehicle.getCardno());
			query.setParameter("id", vehicle.getId());
			List list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		} else {
			StringBuilder sql = new StringBuilder(
					"select v.id from Vehicle v where v.cardno=:cardno and v.isactive=1");
			Query query = em.createNativeQuery(sql.toString());
			query.setParameter("cardno", vehicle.getCardno());
			List list = query.getResultList();
			return list != null && list.size() > 0 ? true : false;
		}
	}

	@SuppressWarnings("unchecked")
	public List<Object> getVehiclePic(long vehicleid) {
		StringBuilder sql = new StringBuilder(
				"select v.id,v.picture from Vehicle v where v.id=:vehicleid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return query.getResultList();
	}
	
	public Initcard isExistCardNo(Vehicle vehicle) {
		StringBuilder sql = new StringBuilder(
				"select c from Initcard c where c.cardno=:cardno and c.cardtype='0'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", vehicle.getCardno());
		List list = query.getResultList();
		return (Initcard) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	
	public Cardissue getCardUsed(Initcard card) {
		StringBuilder sql = new StringBuilder(
				"select c from Cardissue c where c.cardno=:cardno and c.type='0'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", card.getCardno());
		List list = query.getResultList();
		return (Cardissue) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	public Cardissue getCard(String cardno) {
		StringBuilder sql = new StringBuilder(
				"select c from Cardissue c where c.cardno=:cardno and c.type='0'");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", cardno);
		List list = query.getResultList();
		return (Cardissue) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	public Initcard getInitcard(String cardno) {
		StringBuilder sql = new StringBuilder(
				"select c from Initcard c where c.cardno=:cardno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", cardno);
		List list = query.getResultList();
		return (Initcard) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	
	public boolean isCardUsed(Vehicle vehicle,Initcard card) {
		StringBuilder sql = new StringBuilder(
				"select c from Vehicle c where c.cardno=:cardno and c.isactive=1")
		.append(" and c.id!=:vehicleid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", card.getCardno());
		query.setParameter("vehicleid", vehicle.getId());
		List list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
	
	public Billtype getBilltype(String code) {
		StringBuilder sql = new StringBuilder(
				"select c from Billtype c where c.code=:code and c.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		List list = query.getResultList();
		return (Billtype) (list != null && list.size() > 0 ? list.get(0) : null);
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> qryVehicleById(long vehicleid) {
		StringBuilder sql = new StringBuilder();
		sql.append(
		"select t.id,t.cardno,t.vehicleno as name,t.cardno as code,t.seatnum,v.brandname,")
		.append(" u.name as unitname,ve.name as vehicletypename ,ve.id as vehicletypeid,t.unitid,v.id as brandid,")
		.append(" t.balanceunitid,u2.name as balancename,t.isneedfinger,t.type,dd.value,")
		.append(" t.liabilityinsureenddate,t.licenseenddate,t.workenddate,t.roadenddate,t.compulsoryinsureenddate")
		.append(" from Vehicle t ,Vehiclebrandmodel  v,Unit u,Vehicletype ve,Unit u2,Digitaldictionary d,Digitaldictionarydetail dd ")
		.append(" where t.isactive=1 and t.unitid=u.id and d.tablename = 'vehicle' ")
		.append(" and d.columnname='type' and dd.digitaldictionary.id=d.id and t.type=dd.code ")
		.append(" and t.vehiclebrandmodelid=v.id and t.vehicletypeid=ve.id and t.id=:vehicleid ")
		.append(" and t.balanceunitid=u2.id");
		System.out.println(sql);
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return query.getResultList();
	}
	/**
	 * 获取车辆信息
	 * @return
	 */
	public List<Object> qryVehicleInfo() {
		StringBuilder sql = new StringBuilder();
		sql.append("select v.vehicleno,v.vehiclebrandmodelid,v.unitid,v.rationseatnum,v.seatnum,v.loadamout,")
		.append("v.color,v.remarks,v.cardno,v.liabilityinsureno,v.liabilityinsurestartdate,v.liabilityinsureenddate,")
		.append("v.compulsoryinsureno,v.vehiclenodate,v.makedate,v.status,v.driverlicense,v.roadno,v.type from vehicle v");
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Vehicle> qryVehicleByCardno(String cardno) {
		StringBuilder sql = new StringBuilder();
		sql.append("select t")
				.append(" from Vehicle t where t.isactive=1 and t.status='0' and t.cardno=:cardno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", cardno);
		return query.getResultList();
	}
}
