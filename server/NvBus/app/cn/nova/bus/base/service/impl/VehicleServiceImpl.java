package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.base.dao.VehicleDao;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Initcard;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.model.Vehiclebrandmodel;
import cn.nova.bus.base.service.VehicleService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

public class VehicleServiceImpl implements VehicleService {

	private IDAO<Vehicle> dao = new EntityManagerDaoSurport<Vehicle>();

	private VehicleDao vehicleDao = new VehicleDao();

	
	@Override
	public boolean updateVehicle(Vehicle vehicle) {
		Vehicle veh=(Vehicle)vehicleDao.get(Vehicle.class, vehicle.getId());
		veh.setGprs(vehicle.getGprs());
		veh.setUpdatetime(new Date());
		vehicleDao.merge(veh);
		return true;
	}
	
	@Override
	public Vehicle save(Vehicle vehicle, Global global, Date validdate) throws ServiceException {
		// Cardissue carduse = null;
		/*
		 * if (vehicle.getCardno()!=null && !"".equals(vehicle.getCardno())) {
		 * Initcard card = vehicleDao.isExistCardNo(vehicle); if (card == null)
		 * { // 您输入的车辆IC卡不存在，请重新输入！ throw new ServiceException("0229"); } else {
		 * if (vehicleDao.isCardUsed(vehicle, card)) { // 您输入的车辆IC卡已经被使用，请重新输入！
		 * throw new ServiceException("0240"); } carduse =
		 * vehicleDao.getCardUsed(card); if (carduse != null) { //
		 * ：0正常,1已退,2挂失,3作废,4过期 carduse.setValiddate(validdate); if
		 * (carduse.getStatus().equals("2")) { // 您输入的车辆IC卡已经挂失，请重新输入！ throw new
		 * ServiceException("0230"); } else if (carduse.getStatus().equals("3"))
		 * { // 您输入的车辆IC卡已经作废，请重新输入！ throw new ServiceException("0231"); } else
		 * if (carduse.getStatus().equals("4")) { // 您输入的车辆IC卡已经过期，请重新输入！ //
		 * throw new ServiceException("0232"); Date curdate = new Date(); if
		 * (DateUtils.compare(validdate, curdate) > 0) { carduse.setStatus("0");
		 * }
		 * 
		 * } else if (carduse.getStatus().equals("1")) { carduse.setStatus("0");
		 * carduse.setUpdateby(vehicle.getCreateby()); carduse.setUpdatetime(new
		 * Date()); } } else { // 进行发卡操作 Billtype bt =
		 * vehicleDao.getBilltype("Vehicle"); carduse = new Cardissue();
		 * carduse.setBilltypeid(bt.getId());
		 * carduse.setCardno(vehicle.getCardno());
		 * carduse.setCreateby(vehicle.getUpdateby()); carduse.setCreatetime(new
		 * Date()); carduse.setIssueby(global.getUserinfo().getId());
		 * carduse.setIssueip(global.getIpAddress());
		 * carduse.setIssueorgid(global.getOrganization().getId());
		 * carduse.setIssuetime(new Date());
		 * carduse.setSerialnumber(card.getSerialnumber());
		 * carduse.setStatus("0");
		 * carduse.setTicketoutletsid(global.getTicketoutlets() .getId());
		 * carduse.setType("0"); carduse.setValiddate(validdate); //
		 * carduse.setTypeid(typeid)
		 * carduse.setUpdateby(global.getUserinfo().getId());
		 * carduse.setUpdatetime(new Date());
		 * 
		 * } } }
		 */
		/*
		 * if (vehicle.getVehiclebrandmodel() != null &&
		 * vehicle.getVehiclebrandmodel().getId() > 0) { Vehiclebrandmodel vb =
		 * (Vehiclebrandmodel) vehicleDao.get( Vehiclebrandmodel.class,
		 * vehicle.getVehiclebrandmodel() .getId()); if (vb.getRationseatnum()
		 * != vehicle.getSeatnum()) { // 乘客座位数与该厂牌的座位数不一致，请重新输入！ throw new
		 * ServiceException("0286"); } }
		 */
		Vehicle oldvehicle = vehicleDao.isExistDelVehicle(vehicle);
		// 恢复原来的车辆
		if (oldvehicle != null) {
			// 若有注销的车牌并且是本机构添加的则恢复原来车牌，但使用现在信息
			if (oldvehicle.getOrgid() == vehicle.getOrgid()) {
				oldvehicle.setCardno(vehicle.getCardno());
				oldvehicle.setColor(vehicle.getColor());
				oldvehicle.setCompulsoryinsureenddate(vehicle.getCompulsoryinsureenddate());
				oldvehicle.setCompulsoryinsureno(vehicle.getCompulsoryinsureno());
				oldvehicle.setCompulsoryinsurestartdate(vehicle.getCompulsoryinsurestartdate());
				oldvehicle.setContactperson(vehicle.getContactperson());
				oldvehicle.setContactphone(vehicle.getContactphone());
				oldvehicle.setContractenddate(vehicle.getContractenddate());
				oldvehicle.setContractno(vehicle.getContractno());
				oldvehicle.setCreateby(vehicle.getCreateby());
				oldvehicle.setCreatetime(new Date());
				oldvehicle.setGprs(vehicle.getGprs());
				oldvehicle.setGrantdate(vehicle.getGrantdate());
				oldvehicle.setIsactive(true);
				oldvehicle.setIsaudited(vehicle.isIsaudited());
				oldvehicle.setIsauditpass(vehicle.isIsauditpass());
				oldvehicle.setIslocaldelete(false);
				oldvehicle.setLiabilityinsureenddate(vehicle.getLiabilityinsureenddate());
				oldvehicle.setLiabilityinsureno(vehicle.getLiabilityinsureno());
				oldvehicle.setLiabilityinsurestartdate(vehicle.getLiabilityinsurestartdate());
				oldvehicle.setLicenseenddate(vehicle.getLicenseenddate());
				oldvehicle.setLicensestartdate(vehicle.getLicensestartdate());
				oldvehicle.setLoadamout(vehicle.getLoadamout());
				oldvehicle.setPicture(vehicle.getPicture());
				oldvehicle.setRationseatnum(vehicle.getRationseatnum());
				oldvehicle.setRemarks(vehicle.getRemarks());
				oldvehicle.setSeatnum(vehicle.getSeatnum());
				oldvehicle.setType(vehicle.getType());
				oldvehicle.setAuditroute(vehicle.getAuditroute());
				oldvehicle.setUnitid(vehicle.getUnitid());
				oldvehicle.setUpdateby(vehicle.getUpdateby());
				oldvehicle.setUpdatetime(new Date());
				oldvehicle.setVehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
				Vehiclebrandmodel vt = (Vehiclebrandmodel) vehicleDao.get(Vehiclebrandmodel.class,
						vehicle.getVehiclebrandmodelid());
				oldvehicle.setVehicletypeid(vt.getVehicletypeid());
				oldvehicle.setWorkenddate(vehicle.getWorkenddate());
				oldvehicle.setWorkno(vehicle.getWorkno());
				oldvehicle.setWorkstartdate(vehicle.getWorkstartdate());
				oldvehicle.setIsneedfinger(vehicle.getIsneedfinger());
				oldvehicle.setIsneedcheck(vehicle.getIsneedcheck());// 是否需要审核才报班
				oldvehicle = dao.merge(oldvehicle);
				/*
				 * if (carduse != null) { carduse.setTypeid(oldvehicle.getId());
				 * vehicleDao.getEntityManager().merge(carduse); }
				 */
				return oldvehicle;

			} else {
				// 若是其他机构添加的车辆,则所属单位、车型、核定座位数、乘客座位数都以原机构添加时的数据为准
				oldvehicle.setCardno(vehicle.getCardno());
				oldvehicle.setColor(vehicle.getColor());
				oldvehicle.setCompulsoryinsureenddate(vehicle.getCompulsoryinsureenddate());
				oldvehicle.setCompulsoryinsureno(vehicle.getCompulsoryinsureno());
				oldvehicle.setCompulsoryinsurestartdate(vehicle.getCompulsoryinsurestartdate());
				oldvehicle.setContactperson(vehicle.getContactperson());
				oldvehicle.setContactphone(vehicle.getContactphone());
				oldvehicle.setContractenddate(vehicle.getContractenddate());
				oldvehicle.setContractno(vehicle.getContractno());
				oldvehicle.setCreateby(vehicle.getCreateby());
				oldvehicle.setCreatetime(new Date());
				oldvehicle.setGprs(vehicle.getGprs());
				oldvehicle.setGrantdate(vehicle.getGrantdate());
				oldvehicle.setIsactive(true);
				oldvehicle.setIsaudited(vehicle.isIsaudited());
				oldvehicle.setIsauditpass(vehicle.isIsauditpass());
				oldvehicle.setIslocaldelete(false);
				oldvehicle.setLiabilityinsureenddate(vehicle.getLiabilityinsureenddate());
				oldvehicle.setLiabilityinsureno(vehicle.getLiabilityinsureno());
				oldvehicle.setLiabilityinsurestartdate(vehicle.getLiabilityinsurestartdate());
				oldvehicle.setLicenseenddate(vehicle.getLicenseenddate());
				oldvehicle.setLicensestartdate(vehicle.getLicensestartdate());
				oldvehicle.setLoadamout(vehicle.getLoadamout());
				oldvehicle.setPicture(vehicle.getPicture());
				oldvehicle.setAuditroute(vehicle.getAuditroute());
				oldvehicle.setRemarks(vehicle.getRemarks());
				oldvehicle.setType(vehicle.getType());
				oldvehicle.setUpdateby(vehicle.getUpdateby());
				oldvehicle.setUpdatetime(new Date());
				oldvehicle.setVehiclebrandmodelid(vehicle.getVehiclebrandmodelid());
				Vehiclebrandmodel vt = (Vehiclebrandmodel) vehicleDao.get(Vehiclebrandmodel.class,
						vehicle.getVehiclebrandmodelid());
				oldvehicle.setVehicletypeid(vt.getVehicletypeid());
				oldvehicle.setWorkenddate(vehicle.getWorkenddate());
				oldvehicle.setWorkno(vehicle.getWorkno());
				oldvehicle.setWorkstartdate(vehicle.getWorkstartdate());
				oldvehicle.setBalanceunitid(vehicle.getBalanceunitid());
				oldvehicle.setIsneedfinger(vehicle.getIsneedfinger());
				oldvehicle.setIsneedcheck(vehicle.getIsneedcheck());// 是否需要审核才报班
				oldvehicle = dao.merge(oldvehicle);
				/*
				 * if (carduse != null) { carduse.setTypeid(oldvehicle.getId());
				 * vehicleDao.getEntityManager().merge(carduse); }
				 */
				return oldvehicle;
			}
		} else {
			if (!"".equals(vehicle.getCardno())) {
				if (vehicleDao.isUsedByCardNo(vehicle)) {
					// 该IC卡号已经被使用！
					throw new ServiceException("0224");
				}
			}
			if (vehicleDao.isExistVehicle(vehicle)) {
				// 该车牌号码已经存在！
				throw new ServiceException("0228");

			}
			if (validdate != null) {
				Date now = new Date();
				Cardissue carduse = vehicleDao.getCard(vehicle.getCardno());
				if (carduse != null) {
					carduse.setValiddate(validdate);
					carduse.setUpdateby(vehicle.getUpdateby());
					carduse.setUpdatetime(now);
					vehicleDao.getEntityManager().merge(carduse);
				} else {
					Initcard initcard = vehicleDao.getInitcard(vehicle.getCardno());
					if (initcard != null) {
						carduse = new Cardissue();
						carduse.setBilltypeid((long) 10);
						carduse.setCardno(initcard.getCardno());
						carduse.setIssueby(initcard.getCreateby());
						carduse.setCreateby(initcard.getCreateby());
						carduse.setCreatetime(now);
						carduse.setIssueip(global.getIpAddress());
						carduse.setIssueorgid(initcard.getOrgid());
						carduse.setIssuetime(now);
						carduse.setSerialnumber(initcard.getSerialnumber());
						carduse.setStatus("0");
						carduse.setTicketoutletsid(global.getTicketoutlets().getId());
						carduse.setType("0");
						carduse.setTypeid(vehicle.getId());
						carduse.setUpdateby(vehicle.getUpdateby());
						carduse.setUpdatetime(now);
						carduse.setValiddate(validdate);
						vehicleDao.merge(carduse);
					}
				}
			}
			Vehiclebrandmodel vt = (Vehiclebrandmodel) vehicleDao.get(Vehiclebrandmodel.class,
					vehicle.getVehiclebrandmodelid());
			vehicle.setVehicletypeid(vt.getVehicletypeid());
			vehicle.setIschargeotherfee(false);
			vehicle.setIschargescheckfee(false);
			vehicle.setIschargestopfee(false);
			vehicle = dao.merge(vehicle);
			return vehicle;
		}
	}

	@Override
	public Vehicle findById(Long id) {
		return dao.get(Vehicle.class, id);
	}

	public boolean delete(Long id) {
		Vehicle vehicle = findById(id);
		vehicle.setIsactive(false);
		vehicle.setIslocaldelete(true);
		dao.merge(vehicle);
		return true;
	}

	/*
	 * query方法：车辆信息查询<br/> <br/>
	 * 
	 * @param propertyFilterList
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.base.service.VehicleService#query(java.util.List)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(
				new Object[] { "id", "vehicleno", "type", "vehicletypeid", "vehiclebrandmodelid", "unitid",
						"rationseatnum", "seatnum", "loadamout", "color", "contactperson", "contactphone", "remarks",
						"orgid", "cardno", "grantdate", "contractno", "contractstartdate", "contractenddate",
						"liabilityinsureno", "liabilityinsurestartdate", "liabilityinsureenddate", "compulsoryinsureno",
						"compulsoryinsurestartdate", "compulsoryinsureenddate", "licensestartdate", "licenseenddate",
						"workno", "workstartdate", "workenddate", "isaudited", "isauditpass", "gprs", "createtime",
						"createby", "updatetime", "updateby", "createbyname", "unitname", "brandname", "modelcode",
						"vehicletypename", "synccode", "validdate", "balanceunitid", "margin", "stopfee", "checkfee",
						"otherfee", "vehiclenodate", "balanceunitname", "routeid", "routename", "entercardno",
						"makedate", "cardnoprintdate", "istempvehicle", "fullname", "auditroute", "status",
						"updatebyname", "driverlicense", "roadno", "maintainvaliddate", "nextmaintaindistance",
						"isneedfinger", "seattype", "isneedcheck", "twodimensionno", "roadstartdate", "roadenddate",
						"fueltype", "fueltypecode", "pullinagreementno", "pullinStartdate", "pullinEnddate",
						"ischargestopfee", "ischargescheckfee", "ischargeotherfee","businesscertificateno","businesscertificatestartdate","businesscertificateenddate","technialstartdate","technialenddate","extinguisherstartdate","extinguisherenddate"},
				vehicleDao.qryVehicle(propertyFilterList),
				new Object[] { Long.class, String.class, String.class, Long.class, Long.class, Long.class, Short.class,
						Short.class, BigDecimal.class, String.class, String.class, String.class, String.class,
						Long.class, String.class, Date.class, String.class, Date.class, Date.class, String.class,
						Date.class, Date.class, String.class, Date.class, Date.class, Date.class, Date.class,
						String.class, Date.class, Date.class, boolean.class, boolean.class, String.class,
						Timestamp.class, Long.class, Timestamp.class, Long.class, String.class, String.class,
						String.class, String.class, String.class, String.class, Date.class, Long.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class, BigDecimal.class, Date.class,
						String.class, Long.class, String.class, String.class, Date.class, Date.class, boolean.class,
						String.class, String.class, String.class, String.class, String.class, String.class, Date.class,
						Long.class, boolean.class, String.class, boolean.class, String.class, Date.class, Date.class,
						String.class, String.class, String.class, Date.class, Date.class,
						Boolean.class, Boolean.class, Boolean.class,String.class,Date.class,Date.class,Date.class,Date.class,Date.class,Date.class});

	}

	/*
	 * query方法：查询车辆图片信息<br/> <br/>
	 * 
	 * @param vehicleid
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.base.service.VehicleService#query(long)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> getVehiclePic(long vehicleid) {
		return ListUtil.listToMap(new Object[] { "id", "picture" }, vehicleDao.getVehiclePic(vehicleid),
				new Object[] { Long.class, String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean updatePrintdate(long vehicleid, long userid) {
		Vehicle vehicle = (Vehicle) vehicleDao.get(Vehicle.class, vehicleid);
		vehicle.setCardnoprintdate(new Date());
		vehicle.setUpdateby(userid);
		vehicle.setUpdatetime(new Date());
		vehicleDao.getEntityManager().merge(vehicle);
		return true;
	}

	@Override
	public List<Map<String, Object>> qryVehicleById(long vehicleid) {
		// TODO Auto-generated method stub
		Object[] fileds = { "id", "cardno", "name", "code", "seatnum", "brandname", "unitname", "vehicletypename",
				"vehicletypeid", "unitid", "brandid", "balanceunitid", "balancename", "isneedfinger", "type", "value",
				"liabilityinsureenddate", "licenseenddate", "workenddate", "roadno", "compulsoryinsureenddate" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class, String.class, Short.class, String.class, String.class,
				String.class, Long.class, Long.class, Long.class, Long.class, String.class, boolean.class, String.class,
				String.class, Date.class, Date.class, Date.class, Date.class, Date.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, vehicleDao.qryVehicleById(vehicleid), filedtypes);
	}

	/**
	 * 查询车牌号信息
	 */
	@Override
	public List<Map<String, Object>> getVehicleInfo() {
		Object[] fileds = { "vehicleno", "vehiclebrandmodelid", "unitid", "rationseatnum", "seatnum", "loadamout",
				"color", "remarks", "cardno", "liabilityinsureno", "liabilityinsurestartdate", "liabilityinsureenddate",
				"compulsoryinsureno", "vehiclenodate", "makedate", "status", "driverlicense", "roadno", "type" };// 初始化要查询的字段
		Object[] filedtypes = { String.class, Long.class, Long.class, Integer.class, Integer.class, BigDecimal.class,
				String.class, String.class, String.class, String.class, Date.class, Date.class, String.class,
				Date.class, Date.class, String.class, String.class, String.class, String.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, vehicleDao.qryVehicleInfo(), filedtypes);
	}
	
	//车牌审核/取消审核
	public Boolean vehicleAudit(Vehicle vehicle){
		Vehicle vv = (Vehicle) vehicleDao.get(Vehicle.class, vehicle.getId());
		vv.setIsaudited(vehicle.getIsaudited());
		try {
			vehicleDao.merge(vv);
		} catch (Exception e) {
			play.Logger.error(vv.getVehicleno() + "车牌审核/取消审核失败：" + e.getMessage());
			return false;
		}
		return true;
	}

	@Override
	public Vehicle qryVehiclebyIdcard(long vehicleid, String gprs, String cardno,boolean isidcardlogin) {
		
		if(isidcardlogin){
			String sql = "select v from Vehicle v ,Driver d where d.vehicle.id = v.id "
					+ "and d.isactive = 1 and v.isactive =1 and d.islocaldelete = 0 "
					+ " and d.idcard =:idcard ";
			if (vehicleid>0) {
				sql += " and v.id =:vehicleid ";
			}
			Query query = vehicleDao.getEntityManager().createQuery(sql);
			if (vehicleid>0) {
				query.setParameter("vehicleid", vehicleid);
			}
			query.setParameter("idcard", gprs);
			List<Vehicle> vlist = query.getResultList();
			if (vlist!=null && vlist.size()>0) {
				return vlist.get(0);
			}else {
				return null;
			}
		}else {
			List<Vehicle> vehs=vehicleDao.qryVehicleByCardno(cardno);
			if(vehs!=null && vehs.size()>0){
				return vehs.get(0);
			}else{
				return null;
			}
		}
	}

}
