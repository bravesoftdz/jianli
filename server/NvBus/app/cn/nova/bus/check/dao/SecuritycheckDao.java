package cn.nova.bus.check.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.check.model.Securitycheckplan;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class SecuritycheckDao extends EntityManagerDaoSurport {

	private ParameterService parameterService = new ParameterServiceImpl();
	/*
	 * 车辆安检
	 * 2016.3.15 查询结果页面新增 workno,qualification,roadno三列
	 */
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.id,t.result,t.createby,t.updateby,t.checkby,t.orgid,t.light,t.mirror,")
				.append(" t.drive,t.brake,t.turn,t.wheel,t.hang,t.leak,t.window,t.safety,t.createtime,")
				.append(" t.updatetime,t.checktime,t.remarks,v.vehicleno as vehicleno, ")
				.append(" v.vehiclebrandmodelid as vehiclebrandmodelid, un.name as unitname, us.name as checkname, ")
				.append(" u.name as createname, use.name as updatename, v.type as type, o.name as orgname,r.name as routename, ")
				.append(" t.camera, t.returncheck ,t.notenum,vt.name vehicletypename,d.name as drivername, ")
				.append(" v.workno,d.qualification,v.roadno,ddd.value as fueltype ")//新增 workno,qualification,roadno三列lichun
				.append(" , t.reprinttimes as reprinttimes")//新增重打次数列
				.append(" from Securitycheck t left join  Driver d on t.driverid=d.id , Userinfo u, Vehicle v left join Route r on r.id= v.routeid ")
				.append("  left join digitaldictionary dd on dd.tablename = 'vehicle' and dd.columnname = 'fueltype' ")
				.append(" left join digitaldictionarydetail ddd on ddd.digitaldictionaryid = dd.id and ddd.code = v.fueltype ")
				.append(" ,vehicletype vt, Unit un, Userinfo us, Userinfo use, Organization o where ")
				.append(" t.createby=u.id  and t.vehicleid=v.id and v.unitid=un.id and t.orgid=o.id and v.vehicletypeid =vt.id ")
				.append(" and t.checkby=us.id and t.updateby=use.id ")
				.append(PropertyFilter.toJpql(propertyFilterList, true))
				.append(" order by t.checktime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public Long getBySecurityId(Long vehicleno, String periodtype) {
		StringBuffer sql = new StringBuffer(
				"select s.id from Securitycheck s where s.vehicleid=:vehicleno");
		sql.append(" and s.id=(select max(se.id) from Securitycheck se where se.vehicleid=:vehicleno");
		sql.append(" and se.result='1' and se.periodtype=:periodtype group by vehicleid)");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleno", vehicleno);
		query.setParameter("vehicleno", vehicleno);
		query.setParameter("periodtype", periodtype);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (long) 0;
		}
		return (Long) query.getSingleResult();
	}

	@SuppressWarnings("unchecked")
	public Securitycheck getSecurityCheckInfo(long vehicleid,
			String periodtype, Date departdate) {
		StringBuffer sql = new StringBuffer(
				"select s from Securitycheck s where s.vehicleid=:vehicleid");
		sql.append(
				" and s.periodtype=:periodtype and s.checktime >= :departdate ").append(
				" order by s.checktime desc");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("periodtype", periodtype);
		query.setParameter("departdate", departdate);
		List<Securitycheck> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}

	public String getSerialnumber(Long checkby) {
		String sql = "select t.notenum from Securitycheck t where t.id = ";
		sql = sql + "(select max(s.id) from Securitycheck s where s.checkby = "
				+ checkby + ")";
		Query query = em.createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return "0001";
		} else {
			String notenum = (String) query.getSingleResult();
			String num = notenum.substring(notenum.length() - 3,
					notenum.length());
			int i = Integer.parseInt(num);
			if (i < 10) {
				i = i + 1;
				return "000" + i;
			} else if (i < 100) {
				i = i + 1;
				return "00" + i;
			} else if (i < 1000) {
				i = i + 1;
				return "0" + i;
			} else {
				i = i + 1;
				return "" + i;
			}
		}
	}

	// 通过车辆ID从安检计划表中获取安检计划信息
	@SuppressWarnings("unchecked")
	public List<Securitycheckplan> getCheckListbyVehicleId(long vehicleId,
			Date checkDate) {
		Query query = null;
		StringBuffer sql = new StringBuffer(
				"select scp from Securitycheckplan scp");
		sql.append(" where scp.vehicleid=:vehicleId and scp.startdate<=:checkDate and scp.enddate>=:checkDate order by scp.periodtype");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleId", vehicleId);
		query.setParameter("checkDate", checkDate);
		// System.out.println("scheduleReportSql="+sql.toString());
		return query.getResultList();
	}

	// 通过车辆ID和安检日期判断是否存在对应安检类型的安检记录
	@SuppressWarnings("unchecked")
	public List<Securitycheck> getCheckList(long vehicleid, String periodType,
			Date checkDate,String valitype) {
		Query query = null;
		Date startdate = checkDate;
		Date enddate = checkDate;
		StringBuffer sql = new StringBuffer("select sc from Securitycheck sc");
		sql.append(" where sc.vehicleid=:vehicleid   ");//and sc.periodtype=:periodType
		if ("0".equals(periodType)) { // 为0时是日检
			// 车辆安检有效时间类型：0:当日内有效，1:24小时内有效
			if (valitype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {//24小时内有效
				SimpleDateFormat sdf2 = new SimpleDateFormat("HH:mm:ss");
			    String departtime = sdf2.format(new Date());
			    //安检日期增加当前时间，
			    startdate = DateUtils.mergerDateAndTime(checkDate, departtime);
			    enddate = DateUtils.add(checkDate, -1);
			}else{//当日内有效
				startdate=DateUtils.add(checkDate, 1);
				enddate = checkDate;
			}
			
		} else if ("1".equals(periodType)) { // 为1 时是月检
			enddate = DateUtils.add(checkDate,
					-DateUtils.getMonth_Date(checkDate));
		} else if ("4".equals(periodType)) { // 为4 时是半月检
			enddate = DateUtils.add(checkDate, -15);
		} else if ("2".equals(periodType)) { // 为2 时是季检
			enddate = DateUtils.add(checkDate, -90);
		} else if ("3".equals(periodType)) { // 为3 时是年检
			enddate = DateUtils.add(checkDate, -365);
		}
		sql.append(" and trunc(sc.checktime) >= :enddate and trunc(sc.checktime) <= :startdate");
		sql.append(" order by sc.checktime desc");
		query = getEntityManager().createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
//		query.setParameter("periodType", periodType);
		// System.out.println("scheduleReportSql=" + sql.toString());
		return query.getResultList();
	}

	public Long getVehicleid(String cardno) {
		StringBuffer sql = new StringBuffer("select v.id from Vehicle v ");
		sql.append(" where v.cardno='").append(cardno).append("'");
		Query query = getEntityManager().createQuery(sql.toString());
		List list = query.getResultList();
		if (list.isEmpty()) {
			return null;
		}
		return (Long) query.getSingleResult();
	}

	/**
	 * 根据车辆ID 或者报班卡号获取存在安检计划的车辆
	 * 
	 * @param cardno
	 * @param vehicleid
	 * @param departdate 发车时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> getSecurityVehicle(String cardno, Long vehicleid,Date departdate) {
//		String d = DateUtils.formatDate(new Date());
		StringBuffer sql = new StringBuffer(
				"select t.id securitycheckid,t.notenum,t.checktime,t.periodtype,t.result,")
				.append("t.remarks,v.vehicleno,v.cardno,v.id vehicleid,u.name checker,u.id as checkerid,")
				.append(" u.code as checkercode,vt.name vehicletypename,ut.name unitname,v.workno,d.name as driver1name")
				.append(" ,v.routeid,r.name as routename,v.roadno,v.liabilityinsureno,v.liabilityinsurestartdate")
				//20615 内蒙古通达南站站务需求 ，车辆安检时【车牌ONIDCHANGE事件】 - 增加查询交强险编号：compulsoryinsureno
				.append(" ,v.liabilityinsureenddate,v.workstartdate,v.workenddate,v.driverlicense,v.checkfee,d.id as driverid,v.compulsoryinsureno AS compulsoryinsureno ")
				.append(" ,v.licenseenddate,v.compulsoryinsureenddate ")
				.append(" from Vehicle v left join Route r on v.routeid=r.id left join Driver d on v.id= d.vehicleid left join Securitycheck t ")
				.append(" left join Userinfo u on  t.checkby = u.id ")
				.append(" on t.vehicleid = v.id and t.checktime >= :departdate , ")
//				.append(" >= to_date('"+departdate+"','yyyy-mm-dd hh24:mi:ss'), ")
				.append(" vehicletype vt,unit ut")
				.append(" where v.unitid = ut.id and v.isactive=1 ")
				.append(" and v.vehicletypeid=vt.id ");
		if (vehicleid != null && vehicleid != 0) {
			sql.append(" and v.id = " + vehicleid);
		}
		if (cardno != null && !cardno.equals("")) {
			sql.append(" and v.cardno = '" + cardno+"'");
		}
		sql.append(" order by t.checktime desc ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}
	
	/**
	 * 根据车辆ID 和发车时间，查询该车的发班里程
	 * 
	 * @param vehicleid
	 * @param departdate 发车时间
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryDipartInfo(long vehicleid,Date departdate) {
//		String d = DateUtils.formatDate(new Date());
		StringBuffer sql = new StringBuffer(
				"select sum(r.distance)*2 as departdistance,")
		.append(" max(ds.printtime) as printtime,v.id as vehicleid")
		.append(" from departinvoices ds ,")
		.append(" vehicle v,schedule s,route r")
		.append(" where ds.scheduleid = s.id and s.routeid = r.id ")
		.append(" and ds.status <> '1' and ds.printtime >= :departdate")
		.append(" and ds.vehicleid = v.id and v.id = :vehicleid")
		.append(" group by v.id ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		query.setParameter("vehicleid", vehicleid);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryCheckinfo(long id) {
		StringBuilder sql = new StringBuilder(
				"select t.id,t.notenum,t.checktime, ");
		sql.append(" r.name as routename, dic.value as color, v.vehicleno, ");
		sql.append(" o.name as checkorg, u.name as checker,u.id as checkerid,u.code as checkercode, ");
		sql.append(" vt.name as vehicletypename,t.rechecktime,u.idcard,v.workno,v.driverlicense,");
		sql.append(" vu.name as vehicleunitname ");//addby dongy 2017年12月16日 12:48:35 #15318 车辆安检合格通知单中新增车属单位源
		sql.append(" from Securitycheck t, Vehicle v left join v.route r, Digitaldictionary dig, ");
		sql.append(" Digitaldictionarydetail dic, Organization o, Userinfo u,  Vehicletype vt,Unit vu ");
		sql.append(" where t.vehicleid=v.id and t.checkby=u.id and t.orgid=o.id and ");
		sql.append(" v.vehicletypeid=vt.id and vu.id = v.unitid and");
		sql.append(" dig.tablename='vehicle' and dig.columnname='color' and ");
		sql.append(" dic.digitaldictionary.id=dig.id and dic.code=v.color and t.id=:id");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("id", id);
		if (query.getResultList().size() < 0) {
			return null;
		}
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Vehicle> getVehicle(String cardNo) {
		StringBuffer sql = new StringBuffer(
				"select v from Vehicle v where v.cardno=:cardno and isactive=1 ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("cardno", cardNo);
		return query.getResultList();
	}

	public Vehicle getVehicle(long vehicleid) {
		StringBuffer sql = new StringBuffer(
				"select v from Vehicle v where v.id=:vehicleid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		return (Vehicle) query.getSingleResult();
	}

	/**
	 * @param propertyFromHttpRequest
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querySecuritycheck(
			List<PropertyFilter> propertyFromHttpRequest) {
		StringBuilder sql = new StringBuilder(
				"select to_char(s.checktime,'yyyy-mm-dd') checktime,")
				.append(" count(s.id) count, sum(case s.result when '1' then 1 else 0 end) checkresult, ")
				.append(" sum(case s.light when '合格' then 0 else 1 end) light, ")
				.append(" sum(case s.mirror when '合格' then 0 else 1 end) mirror, ")
				.append(" sum(case s.drive when '合格' then 0 else 1 end) drive, ")
				.append(" sum(case s.brake when '合格' then 0 else 1 end) brake, ")
				.append(" sum(case s.turn when '合格' then 0 else 1 end) turn, ")
				.append(" sum(case s.wheel when '合格' then 0 else 1 end) wheel, ")
				.append(" sum(case s.hang when '合格' then 0 else 1 end) hang, ")
				.append(" sum(case s.leak when '合格' then 0 else 1 end) leak, ")
				.append(" sum(case s.window when '合格' then 0 else 1 end) window, ")
				.append(" sum(case s.safety when '合格' then 0 else 1 end) safety, ")
				.append(" sum(case s.camera when '合格' then 0 else 1 end) camera, ")
				.append(" sum(case s.returncheck when '合格' then 0 else 1 end) returncheck ")
				.append(" from securitycheck s where 1=1 ")
				.append(PropertyFilter.toJpql(propertyFromHttpRequest, true))
				.append(" group by to_char(s.checktime,'yyyy-mm-dd') ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFromHttpRequest);
		return query.getResultList();
	}
	
	//用来查询结果集
	public List<Object> queryCardValidate(long orgid, long vehicleid,long driverid,long driverid1)
	{
		StringBuilder sql = new StringBuilder("select '' cardName,'' cardNo, null endDate, 0 days from dual ");
		Vehicle vehicle = getVehicle(vehicleid);
		Driver driver = null;
		Driver driver1 = null;
		if(driverid!=0)
		   driver = getDriver(driverid);
		if(driverid1!=0)
		   driver1 = getDriver(driverid1);
		// 证件有效期到期提示天数
		int showdate = Integer.parseInt(parameterService.findParamValue(ParamterConst.Param_2024,
				orgid));
		if (vehicle.getLicenseenddate() != null
				&& DateUtils.compare(vehicle.getLicenseenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(vehicle.getLicenseenddate(), -showdate),
						new Date()) < 0) {
			sql.append(" union all  select trim('行驶证') cardName , v.driverlicense cardNo, v.licenseenddate endDate,"
					+ "ceil(v.licenseenddate-sysdate) from vehicle v where v.id = "+vehicle.getId());
		/*	msg = msg
					+ "   行驶证        "+vehicle.getDriverlicense()+"             "+vehicle.getLicenseenddate()+"        "
					+ DateUtils.getIntervalDays(new Date(),
							DateUtils.add(vehicle.getLicenseenddate(), 2))
					+ "天\r";
			flag = -1;*/
		}
		if (vehicle.getWorkenddate() != null
				&& DateUtils.compare(vehicle.getWorkenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(vehicle.getWorkenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('营运证') cardName, v.workno cardNo,v.workenddate endDate ,"
					+ " ceil(v.workenddate-sysdate) from vehicle v where v.id ="+vehicle.getId());
		}
		if (vehicle.getLiabilityinsureenddate() != null
				&& DateUtils.compare(vehicle.getLiabilityinsureenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getLiabilityinsureenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('承运险') cardName, v.liabilityinsureno cardNo,v.liabilityinsureenddate endDate ,"
					+ " ceil(v.liabilityinsureenddate-sysdate) from vehicle v where v.id ="+vehicle.getId());
		}
		if (vehicle.getCompulsoryinsureenddate() != null
				&& DateUtils.compare(vehicle.getCompulsoryinsureenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getCompulsoryinsureenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('交强险') cardName, v.compulsoryinsureno cardNo,v.compulsoryinsureenddate endDate ,"
					+ " ceil(v.compulsoryinsureenddate-sysdate) from vehicle v where v.id ="+vehicle.getId());
		}
		//第三者责任险
		if (vehicle.getContractenddate() != null
				&& DateUtils.compare(vehicle.getContractenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getContractenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('第三者责任险') cardName, v.contractno cardNo,v.contractenddate endDate ,"
					+ " ceil(v.contractenddate-sysdate) from vehicle v where v.id ="+vehicle.getId());
		}
		//新增驾驶证有效期判断
		if (driver!=null&&driver.getDrivinglicenseenddate() != null
				&& DateUtils.compare(driver.getDrivinglicenseenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(driver.getDrivinglicenseenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('正驾驶驾驶证') cardName, v.drivinglicense cardNo,v.drivinglicenseenddate endDate ,"
					+ " ceil(v.drivinglicenseenddate-sysdate) from driver v where v.id ="+driver.getId());
		}
		//新增从业资格证有效期判断
		if (driver!=null&&driver.getQualificationenddate() != null
				&& DateUtils.compare(driver.getQualificationenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(driver.getQualificationenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('正驾驶从业资格证') cardName, v.qualification cardNo,v.qualificationenddate endDate ,"
					+ " ceil(v.qualificationenddate-sysdate) from driver v where v.id ="+driver.getId());
		}
		//新增驾驶证有效期判断
		if (driver1!=null&&driver1.getDrivinglicenseenddate() != null
				&& DateUtils.compare(driver1.getDrivinglicenseenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(driver1.getDrivinglicenseenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('副驾驶驾驶证') cardName, v.drivinglicense cardNo,v.drivinglicenseenddate endDate ,"
					+ " ceil(v.drivinglicenseenddate-sysdate) from driver v where v.id ="+driver1.getId());
		}
		//新增从业资格证有效期判断
		if (driver1!=null&&driver1.getQualificationenddate() != null
				&& DateUtils.compare(driver1.getQualificationenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(driver1.getQualificationenddate(), -showdate),
						new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('副驾驶从业资格证') cardName, v.qualification cardNo,v.qualificationenddate endDate ,"
					+ " ceil(v.qualificationenddate-sysdate) from driver v where v.id ="+driver1.getId());
		}
		//20615 内蒙古通达南站站务需求 begin tianhb 2018年6月7日  证件到期提醒增加 线路标志牌和经营许可证 BEGIND
		if (null != vehicle.getRoadenddate()
				&& DateUtils.compare(vehicle.getRoadenddate(),new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(vehicle.getRoadenddate(), - showdate),new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('线路标志牌') cardName, v.roadno cardNo,v.roadenddate endDate ,"
					+ " ceil(v.roadenddate-sysdate) from vehicle v where v.id =" + vehicle.getId());
		}
		if (null != vehicle.getBusinesscertificateenddate()
				&& DateUtils.compare(vehicle.getBusinesscertificateenddate(),new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(vehicle.getBusinesscertificateenddate(), -showdate),new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('经营许可证') cardName, v.businesscertificateno cardNo,v.businesscertificateenddate endDate ,"
					+ " ceil(v.businesscertificateenddate-sysdate) from vehicle v where v.id =" + vehicle.getId());
		}
		//灭火器有效期 
		if (null != vehicle.getExtinguisherenddate()
				&& DateUtils.compare(vehicle.getExtinguisherenddate(),new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(vehicle.getExtinguisherenddate(), -showdate),new Date()) < 0) {
			if(sql.toString().length()>1){
				sql.append(" union all ");
			}
			sql.append(" select trim('灭火器有效期') cardName, '' as cardNo,v.extinguisherenddate endDate ,"
					+ " ceil(v.extinguisherenddate-sysdate) from vehicle v where v.id =" + vehicle.getId());
		}
		
		//20615 内蒙古通达南站站务需求 begin tianhb 2018年6月7日  证件到期提醒增加 线路标志牌和经营许可证 END
		Query query = getEntityManager().createNativeQuery(sql.toString());
//		JPAPropertyFilterUtil.setParameter(query, propertyFromHttpRequest);
		return query.getResultList();
	}
	
	//新增通过driverid获取driver对象
	public Driver getDriver(long driverid)
	{
		String sql="select d from Driver d where d.id =:driverid";
		Query query = em.createQuery(sql.toString());
		query.setParameter("driverid", driverid);
		return (Driver) query.getSingleResult();
	}
	//通过车牌号查询出车辆ID
	public Long getVehicleId(String vehicleno)
	{
		String sql="select v from Vehicle v where v.vehicleno =:vehicleno";
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleno", vehicleno);
		Vehicle vehicle = (Vehicle) query.getSingleResult();
		return vehicle.getId();
		
	}

	public String getVehicleUnitName(Long vehicleid) {
		String sql="select u.name from Vehicle v,unit u  where u.id = v.unitid and v.id=:vehicleid";
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		List list = query.getResultList();
		return (String) (list.get(0)!=null&&list.size()>=1 ? list.get(0):"");
	}

	public List<Object> qrySecurityVehicleExpirydate(long vehicleid, Integer days) {
		StringBuffer sql=new StringBuffer();
		sql.append(" SELECT v.id,'车辆行驶证' AS certificateType,v.driverlicense AS certificateNo,v.licenseenddate AS duedate,CASE WHEN TRUNC(v.licenseenddate-sysdate)>0 THEN TRUNC(v.licenseenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Vehicle v WHERE v.id=:vehicleid ")
		.append(" UNION ")
		.append(" SELECT v.id,'营运证' AS certificateType,v.workno AS certificateNo,v.workenddate AS duedate,CASE WHEN TRUNC(v.workenddate-sysdate)>0 THEN TRUNC(v.workenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Vehicle v WHERE v.id=:vehicleid ")
		.append(" UNION ")
		.append(" SELECT v.id,'交强险' AS certificateType,v.compulsoryinsureno AS certificateNo,v.liabilityinsureenddate AS duedate,CASE WHEN TRUNC(v.liabilityinsureenddate-sysdate)>0 THEN TRUNC(v.liabilityinsureenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Vehicle v WHERE v.id=:vehicleid ")
		.append(" UNION ")
		.append(" SELECT v.id,'承运险' AS certificateType,v.liabilityinsureno AS certificateNo,v.compulsoryinsureenddate AS duedate,CASE WHEN TRUNC(v.compulsoryinsureenddate-sysdate)>0 THEN TRUNC(v.compulsoryinsureenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Vehicle v WHERE v.id=:vehicleid ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("vehicleid", vehicleid);
		List list = query.getResultList();
		return list;
	}

	public List<Object> qrySecurityDriverExpirydate(long driverid, Integer days) {
		StringBuffer sql=new StringBuffer();
        sql.append(" SELECT v.id,'准驾证' AS certificateType,v.workno AS certificateNo,v.workenddate AS duedate,CASE WHEN TRUNC(v.workenddate-sysdate)>0 THEN TRUNC(v.workenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Driver v WHERE v.id=:driverid ")
        .append(" UNION ")
        .append(" SELECT v.id,'从业资格证' AS certificateType,v.qualification AS certificateNo,v.qualificationenddate AS duedate,CASE WHEN TRUNC(v.qualificationenddate-sysdate)>0 THEN TRUNC(v.qualificationenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Driver v WHERE v.id=:driverid ")
        .append(" UNION ")
        .append(" SELECT v.id,'驾驶证' AS certificateType,v.drivinglicense AS certificateNo,v.drivinglicenseenddate AS duedate,CASE WHEN TRUNC(v.drivinglicenseenddate-sysdate)>0 THEN TRUNC(v.drivinglicenseenddate-sysdate)+1 ELSE 0 END AS remaindays FROM Driver v WHERE v.id=:driverid ");
        Query query = em.createNativeQuery(sql.toString());
		query.setParameter("driverid", driverid);
		List list = query.getResultList();
		return list;
	}
}
