package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import util.DateUtils;
import util.UserTransaction;

import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.pack.dao.PackStockDao;
import cn.nova.bus.pack.dao.PackdepartinvoicesDao;
import cn.nova.bus.pack.dao.PackdepartinvoicesdetailDao;
import cn.nova.bus.pack.dao.PackdepartinvoicespackDao;
import cn.nova.bus.pack.dao.PacktturnoverdetailDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packdepartinvoicesdetail;
import cn.nova.bus.pack.model.Packdepartinvoicespack;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packpickup;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.pack.service.PackStockService;
import cn.nova.bus.pack.vo.PackStockVO;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import util.SystemException;

public class PackStockServiceImpl implements PackStockService {

	private PackStockDao packStockDao = new PackStockDao();
	private PacktturnoverdetailDao packturnoverdetaildao = new PacktturnoverdetailDao();
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	private PackdepartinvoicespackDao packdeppackdao = new PackdepartinvoicespackDao();
	private PackdepartinvoicesdetailDao packdepdetaildao = new PackdepartinvoicesdetailDao();
	private PackdepartinvoicesDao packdepdao = new PackdepartinvoicesDao();
	private ParameterService parameterService = new ParameterServiceImpl();
	UserTransaction usertransaction = new UserTransaction();
	private BillinuseService billinuseService = new BillinuseServiceImpl();

	@Override
	public List<Map<String, Object>> queryschedule(
			List<PropertyFilter> propertyFilters, Date departdate) {

		/**
		 * vie.scheduleid, vie.code, vie.name, vie.departdate,vie.departtime,
		 * 
		 * vie.isdeparted, vie.status, vie.vehicleid, vie.packno, vie.vehicleno,
		 * 
		 * vie.routeid,vie.unitname,vie. collectstatus,vie.packprice
		 * ,vie.paymethod,
		 * 
		 * vie.payvalue,nvl(vr.isdeparted,vie.isdeparted) isdeparted,dr.name as
		 * drivername,dr.mobilephone as mobilephone,
		 * 
		 * vie.isreported
		 */
		return ListUtil.listToMap(

		new Object[] {  "scheduleid", "vehiclereportid",
				"departdate", "code", "vehicleno", "departtime", "unitname",
				"phone1", "phone2", "phone3", //"pieces", "totalfee",
				"isdeparted", "status", "name1", "name2", "name3", "routename",
				"routeid",  "schedule" },
				packStockDao.queryschedule(propertyFilters, departdate),
				new Object[] {  Long.class,
						Long.class, Date.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, //Long.class, Double.class, 
						String.class,
						String.class, String.class, String.class, String.class,
						String.class, Long.class, Long.class });
	}

	/**
	 * 保存提领数据
	 * 
	 * @param packpickup
	 * @return
	 * @throws ServiceException
	 */
	@SuppressWarnings("unchecked")
	@Override
	public Packpickup savepackpickup(Packpickup packpickup, String packpickno,
			int packpickups, long sellby) throws ServiceException {
		Billtype billtype = billtypeService
				.findByCode(ConstDefiniens.PackReBill);
		if (packpickno != null && "".equals(packpickno)) {
			Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
					packpickup.getOperator(), new Long(packpickno));
			if (billinuse == null || "2".equals(billinuse.getStatus())) {
				// 您的票据已经用完
				throw new ServiceException("0143");
			}
		}
		if (packpickup.getId() == 0) {
			// 修改行包状态
			packpickup = (Packpickup) packStockDao.merge(packpickup);
			StringBuffer sb = new StringBuffer(
					"update Pack set status='2',signby=:signby,signtime=:signtime,updateby=:signby,")
					.append(" takename=:takename,takecertificateno=:takecertificateno,")
					.append(" updatetime=:signtime where id=:packid");
			Query query = packStockDao.getEntityManager().createQuery(
					sb.toString());
			query.setParameter("packid", packpickup.getPackid());
			// query.setParameter("custodial",packpickup.getShipprice());//packpickup.getShipprice()
			query.setParameter("signby", packpickup.getOperator());
			query.setParameter("takename", packpickup.getSignaturer());
			query.setParameter("takecertificateno",
					packpickup.getTakecertificateno());
			query.setParameter("signtime", new Date());
			query.executeUpdate();
			// packStockDao.save(packpickup);
			/*
			 * if (query.executeUpdate() > 0) { packStockDao.save(packpickup); }
			 * else { throw new ServiceException("0442"); }
			 */

			// 到货提领信息插入行包营收缴款明细表
			play.Logger
					.info("行包提领营收缴款开始——————————————————————————————————————————");
			PacktturnoverdetailDao dao = new PacktturnoverdetailDao();

			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			Date now = new Date();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
			propertyFilters.add(new PropertyFilter("EQD_t!moneydate", now));
			// propertyFilters.add(new PropertyFilter("EQD_t!datafrom","1"));
			propertyFilters.add(new PropertyFilter("EQL_t!sellby", sellby));
			propertyFilters.add(new PropertyFilter("EQS_t!paymethod", "0"));
			List<Packtturnoverdetail> list = dao
					.qryPacktturnoverdetailBypackno(propertyFilters, true);
			Packtturnoverdetail packtturnoverdetail = null;
			if (list != null && list.size() > 0) {
				packtturnoverdetail = list.get(0);
				if (packpickno != null) {
					packtturnoverdetail.setTicketendno(packpickno);// 结束票号
				}
				packtturnoverdetail.setPickups(packtturnoverdetail.getPickups()
						+ packpickups);
				if (packpickup.getTotalfee() != null) {
					if (packtturnoverdetail.getPickupamount() == null) {
						packtturnoverdetail.setPickupamount(packpickup
								.getTotalfee());// 合计金额
						packtturnoverdetail.setMoneypayable(packpickup
								.getTotalfee());// 合计金额
					} else {
						packtturnoverdetail.setPickupamount(packpickup
								.getTotalfee().add(
										packtturnoverdetail.getPickupamount()));// 合计金额
						packtturnoverdetail.setMoneypayable(packpickup
								.getTotalfee().add(
										packtturnoverdetail.getMoneypayable()));// 合计金额
					}

				}
				if (packpickup.getShipprice() != null) {
					if (packtturnoverdetail.getShipprice() == null) {
						packtturnoverdetail.setShipprice(packpickup
								.getShipprice());// 代收运费
					} else {
						packtturnoverdetail.setShipprice(packpickup
								.getShipprice().add(
										packtturnoverdetail.getShipprice()));// 代收运费
					}

				}
				if (packpickup.getPackfee() != null) {
					if (packtturnoverdetail.getServicefee() == null) {
						packtturnoverdetail.setServicefee(packpickup
								.getPackfee());// 综合服务费
					} else {
						packtturnoverdetail.setServicefee(packpickup
								.getPackfee().add(
										packtturnoverdetail.getServicefee()));// 综合服务费
					}

				}

				if (packpickup.getGoodsprice() != null) {
					if (packtturnoverdetail.getPackprice() == null) {
						packtturnoverdetail.setPackprice(packpickup
								.getGoodsprice());// 代收货款
					} else {
						packtturnoverdetail.setPackprice(packpickup
								.getGoodsprice().add(
										packtturnoverdetail.getPackprice()));// 代收货款
					}
				}
				packtturnoverdetail.setUpdatetime(now);
				if (packpickno != null) {
					packtturnoverdetail.setTicketnum(packtturnoverdetail
							.getTicketnum() + 1);// 用票数
				}

			} else {
				packtturnoverdetail = new Packtturnoverdetail();// 今天还未存在营收缴款
				
				packtturnoverdetail.setPaymethod("0");
				packtturnoverdetail.setMoneydate(packpickup.getSigndate()); // 提领日期
				packtturnoverdetail.setSellby(sellby);// 办理员
				if (packpickno != null) {

					packtturnoverdetail.setTicketstartno(packpickno);// 起始票号
					packtturnoverdetail.setTicketendno(packpickno);// 结束票号
				} else {
					packtturnoverdetail.setTicketstartno("0");// 起始票号
					packtturnoverdetail.setTicketendno("0");// 结束票号
				}
				packtturnoverdetail.setPickups(packpickups);
				if (packpickup.getTotalfee() == null) {
					packtturnoverdetail.setPickupamount(BigDecimal.valueOf(0));// 提领金额
					packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));// 应缴款
				} else {
					packtturnoverdetail.setPickupamount(packpickup
							.getTotalfee());
					packtturnoverdetail.setMoneypayable(packpickup
							.getTotalfee());
				}
				packtturnoverdetail.setIsturnover(false); // 未缴款
				packtturnoverdetail.setIsaudit(false); // 未审核

				if (packpickup.getShipprice() == null) { // 代收运费
					packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
				} else {
					packtturnoverdetail.setShipprice(packpickup.getShipprice());
				}
				if (packpickup.getPackfee() == null) {// 综合服务费
					packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));
				} else {
					packtturnoverdetail.setServicefee(packpickup.getPackfee());
				}

				if (packpickup.getGoodsprice() == null) { // 代收货款
					packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));
				} else {
					packtturnoverdetail
							.setPackprice(packpickup.getGoodsprice());
				}
				packtturnoverdetail.setOrgid(packpickup.getOrgid());
				packtturnoverdetail.setDatafrom("1");// 到货
				if (packpickno != null) {
					packtturnoverdetail.setTicketnum(1);// 用票数
				}
				packtturnoverdetail.setCreateby(sellby);
				packtturnoverdetail.setCreatetime(now);
				packtturnoverdetail.setUpdateby(sellby);
				packtturnoverdetail.setUpdatetime(now);
			}
			packtturnoverdetail = packturnoverdetaildao
					.merge(packtturnoverdetail);
			play.Logger
					.info("行包提领营收缴款结束——————————————————————————————————————————");

			// Packtturnoverdetail packtturnoverdetail = new
			// Packtturnoverdetail();
			// packtturnoverdetail.setMoneydate(packpickup.getSigndate());
			// packtturnoverdetail.setSellby(packpickup.getOperator());
			//
			// packtturnoverdetail.setTicketstartno(packpickno);
			// packtturnoverdetail.setTicketendno(packpickno);
			//
			// packtturnoverdetail.setPickups(packpickups);
			// packtturnoverdetail.setPickupamount(packpickup.getTotalfee());
			//
			// packtturnoverdetail.setMoneypayable(packpickup.getTotalfee());
			// packtturnoverdetail.setIsturnover(false);
			// packtturnoverdetail.setIsaudit(false);
			// packtturnoverdetail.setShipprice(packpickup.getShipprice());
			// packtturnoverdetail.setPackfee(packpickup.getPackfee());
			// packtturnoverdetail.setUnloadfee(packpickup.getHandfee());
			//
			// // packtturnoverdetail.setCustodial(pack.getCustodial());
			// // packtturnoverdetail.setTransitfee(pack.getTransitfee());
			// // packtturnoverdetail.setInsuredamount(pack.getInsuredamount());
			// // packtturnoverdetail.setInsurancefee(pack.getInsurancefee());
			// // packtturnoverdetail.setInsurance(pack.getInsurance());
			// // packtturnoverdetail.setDeliveryfee(pack.getDeliveryfee());
			// // packtturnoverdetail.setServicefee(pack.getServicefee());
			// // packtturnoverdetail.setOtherfee(pack.getOtherfee());
			// packtturnoverdetail.setPackprice(packpickup.getGoodsprice());
			// packtturnoverdetail.setOrgid(packpickup.getOrgid());
			// packtturnoverdetail.setDatafrom("1");
			// packtturnoverdetail.setCreateby(packpickup.getCreateby());
			// packtturnoverdetail.setCreatetime(packpickup.getCreatetime());
			// packtturnoverdetail.setUpdateby(packpickup.getUpdateby());
			// packtturnoverdetail.setUpdatetime(packpickup.getUpdatetime());
			//
			// packturnoverdetaildao.merge(packtturnoverdetail);

		} else {
			packpickup = (Packpickup) packStockDao.getEntityManager().merge(
					packpickup);
		}
		return packpickup;
	}

	/**
	 * 查询行包员日营收
	 * 
	 * @param userid
	 * @param date
	 * @return
	 */
	@Override
	public List<Map<String, Object>> querysellbyrevenue(long userid, Date date) {
		return ListUtil.listToMap(new Object[] { "acceptpieces",
				"accepttotalfee", "goodspieces", "goodstotalfee", "pkuppieces",
				"pkuptotalfee" },
				packStockDao.querysellbyrevenue(userid, date), new Object[] {
						Integer.class, Float.class, Integer.class, Float.class,
						Integer.class, Float.class });
	}

	@Override
	public boolean cancelPack(Pack pack) throws ServiceException {
		return packStockDao.cancelPack(pack);
	}

	@Override
	public PackStockVO querystockscheduleBy(Global global,
			String departinvoicesno, String isbukai, String isreprint,
			List<Map<String, Object>> result,
			List<PropertyFilter> propertyFilters) throws ServiceException {
		// TODO Auto-generated method stub
		String param8080= parameterService.findParamValue("8080", global.getUserinfo().getOrgid());
		String param8088 = parameterService.findParamValue("8088", global.getUserinfo().getOrgid());
		boolean usebalance =false;
		if("1".equals(param8080)&&("1".equals(param8088))){
			usebalance = true;//打印货物结算单按结算单号走true
		}
		if ((!isreprint.equals("2"))&&usebalance) {// 原号重打时
			Billtype billtype = billtypeService
					.findByCode(ConstDefiniens.BalanceBill);
			// 补零操作
			if (billtype.getTicketnolength() != departinvoicesno.length()) {
				departinvoicesno = StringUtils.strPad(departinvoicesno,
						(int) billtype.getTicketnolength(), "0");
			}

			long createdby = global.getUserinfo().getId();
			Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
					createdby, new Long(departinvoicesno));
			String curDepartinvoicesno = departinvoicesno;

			if (billinuse == null || "2".equals(billinuse.getStatus())) {
				// 您的票据已经用完
				throw new ServiceException("0143");
			}
			// 补零操作
			curDepartinvoicesno = String.valueOf(billinuse.getNextno());

			if (billtype.getTicketnolength() != curDepartinvoicesno.length()) {
				curDepartinvoicesno = StringUtils.strPad(curDepartinvoicesno,
						(int) billtype.getTicketnolength(), "0");
			}
			if (!curDepartinvoicesno.equals(departinvoicesno)) {
				// 您的票据当前号码与系统的号码不一致，请重置票号！
				throw new ServiceException("0144");
			}

			billinuse.setNextno(billinuse.getNextno() + 1);

			if (billinuse.getNextno() > billinuse.getEndno() + 1) {
				// 当前票段剩余票数不够打印
				throw new ServiceException("0171");
			}
			// 本次若是最后一张票据
			if (billinuse.getNextno() > billinuse.getEndno()) {
				billinuse.setStatus("2");
			}
			billinuse.setUpdateby(createdby);
			billinuse.setUpdatetime(new Date());
			packStockDao.getEntityManager().merge(billinuse);

		}

		PackStockVO packStockVO = new PackStockVO();
		List<Object> list = packStockDao.querystockscheduleBy(propertyFilters);

		Packdepartinvoices packdepartinvoices = new Packdepartinvoices();

		if (list != null && list.size() > 0) {
			Object[] objects = (Object[]) list.get(0);
			if (objects[0] != null) {
				packStockVO.setCode(objects[0].toString());
			}
			if (objects[1] != null) {
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
				try {
					String str = sf.format(sf.parse(objects[1].toString()));
					packStockVO.setDepartdate(str);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					play.Logger.error(e.getMessage(), e);
				}
				try {
					packdepartinvoices.setDepartdate(sf.parse(objects[1]
							.toString()));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (objects[2] != null) {
				packStockVO.setDeparttime(objects[2].toString());
				packdepartinvoices.setDeparttime(objects[2].toString());
			}
			if (objects[3] != null) {
				packStockVO.setVehicleno(objects[3].toString());
			}
			if (objects[4] != null) {
				packStockVO.setDrivername(objects[4].toString());
			}
			if (objects[5] != null) {
				packStockVO.setUnitname(objects[5].toString());
			}
			if (objects[6] != null) {
				packdepartinvoices.setScheduleplanid(Long.parseLong(objects[6]
						.toString()));
			}
			if (objects[7] != null) {
				packdepartinvoices.setScheduleid(Long.parseLong(objects[7]
						.toString()));
			}
			if (objects[8] != null) {
				packdepartinvoices.setVehicleid(Long.parseLong(objects[8]
						.toString()));
			}
			if (objects[9] != null) {
				packdepartinvoices.setReportid(Long.parseLong(objects[9]
						.toString()));
			}

			packdepartinvoices.setDepartinvoicesno(departinvoicesno);
			packdepartinvoices.setPrintip(global.getIpAddress());
			packdepartinvoices.setPrintby(global.getUserinfo().getId());
			packdepartinvoices.setPrintorgid(global.getUserinfo().getOrgid());
			packdepartinvoices.setPrinttime(new Date());
			packdepartinvoices.setStatus("0");// 行包结算单正常
			if (isbukai.equals("1")) {// 补开
				packdepartinvoices.setPrintway("1");
			} else if (isreprint.equals("1") || isreprint.equals("2")) {// 重打
				packdepartinvoices.setPrintway("2");
			} else {
				packdepartinvoices.setPrintway("0"); // 发班
			}
			packdepartinvoices.setDatatype("0");// 微机单
			packdepartinvoices.setCancelby(99999999);
			packdepartinvoices.setCreateby(global.getUserinfo().getId());
			packdepartinvoices.setCreatetime(new Date());
			packdepartinvoices.setUpdateby(global.getUserinfo().getId());
			packdepartinvoices.setUpdatetime(new Date());
		}
		packdepartinvoices = (Packdepartinvoices) packdepdao
				.merge(packdepartinvoices);
		Packdepartinvoicesdetail packdepdetail = new Packdepartinvoicesdetail();
		Packdepartinvoicespack packdeppack = new Packdepartinvoicespack();
		int sumpieces = 0;
		BigDecimal sumshipprice = new BigDecimal(0);
		BigDecimal sumpackfee = new BigDecimal(0);
		BigDecimal sumhandfee = new BigDecimal(0);
		BigDecimal sumtransitfee = new BigDecimal(0);
		BigDecimal suminsuredamount = new BigDecimal(0);
		BigDecimal suminsurancefee = new BigDecimal(0);
		BigDecimal sumdeliveryfee = new BigDecimal(0);
		BigDecimal sumotherfee = new BigDecimal(0);
		BigDecimal sumtotalfee = new BigDecimal(0);
		BigDecimal sumpackprice = new BigDecimal(0);
		BigDecimal sumcustodial = new BigDecimal(0);
		BigDecimal sumservicefee = new BigDecimal(0);
		BigDecimal sumbalancefeecountmoney = new BigDecimal(0);

		for (int i = 0; i < result.size() - 1; i++) {
			Map packinfo = result.get(i);
			packdepdetail.setPackdepartinvoicesid(packdepartinvoices.getId());
			packdepdetail.setSendstationid(Long.parseLong(packinfo.get(
					"sendstationid").toString()));
			packdepdetail.setTostationid(Long.parseLong(packinfo.get(
					"tostationid").toString()));

			sumpieces = sumpieces
					+ Integer.parseInt((packinfo.get("pieces").toString()));
			sumshipprice = sumshipprice.add(new BigDecimal(packinfo.get(
					"shipprice").toString()));
			sumpackfee = sumpackfee.add(new BigDecimal(packinfo.get("packfee")
					.toString()));
			sumhandfee = sumhandfee.add(new BigDecimal(packinfo.get("handfee")
					.toString()));
			sumtransitfee = sumtransitfee.add(new BigDecimal(packinfo.get(
					"transitfee").toString()));
			suminsuredamount = suminsuredamount.add(new BigDecimal(packinfo
					.get("insuredamount").toString()));
			suminsurancefee = suminsurancefee.add(new BigDecimal(packinfo.get(
					"insurancefee").toString()));
			sumdeliveryfee = sumdeliveryfee.add(new BigDecimal(packinfo.get(
					"deliveryfee").toString()));
			sumotherfee = sumotherfee.add(new BigDecimal(packinfo.get(
					"otherfee").toString()));
			sumtotalfee = sumtotalfee.add(new BigDecimal(packinfo.get(
					"totalfee").toString()));
			sumcustodial = sumcustodial.add(new BigDecimal(packinfo.get(
					"custodial").toString()));
			sumservicefee = sumservicefee.add(new BigDecimal(packinfo.get(
					"servicefee").toString()));
			sumpackprice = sumpackprice.add(new BigDecimal(packinfo.get(
					"packprice").toString()));
			sumbalancefeecountmoney = sumbalancefeecountmoney
					.add(new BigDecimal(packinfo.get("balancefeecountmoney")
							.toString()));

			packdepdetail.setPieces(Short.parseShort(packinfo.get("pieces")
					.toString()));
			packdepdetail.setShipprice(new BigDecimal(packinfo.get("shipprice")
					.toString()));
			packdepdetail.setPackfee(new BigDecimal(packinfo.get("packfee")
					.toString()));
			packdepdetail.setHandfee(new BigDecimal(packinfo.get("handfee")
					.toString()));
			packdepdetail.setTransitfee(new BigDecimal(packinfo.get(
					"transitfee").toString()));
			packdepdetail.setInsuredamount(new BigDecimal(packinfo.get(
					"insuredamount").toString()));
			packdepdetail.setInsurancefee(new BigDecimal(packinfo.get(
					"insurancefee").toString()));
			packdepdetail.setDeliveryfee(new BigDecimal(packinfo.get(
					"deliveryfee").toString()));
			packdepdetail.setOtherfee(new BigDecimal(packinfo.get("otherfee")
					.toString()));
			packdepdetail.setTotalfee(new BigDecimal(packinfo.get("totalfee")
					.toString()));
			packdepdetail.setCustodial(new BigDecimal(packinfo.get("custodial")
					.toString()));
			packdepdetail.setServicefee(new BigDecimal(packinfo.get(
					"servicefee").toString()));
			packdepdetail.setPackprice(new BigDecimal(packinfo.get("packprice")
					.toString()));
			packdepdetail.setBalanceamount(new BigDecimal(packinfo.get(
					"balancefeecountmoney").toString()));

			packdepdetail.setCreateby(global.getUserinfo().getId());
			packdepdetail.setCreatetime(new Date());
			packdepdetail.setUpdateby(global.getUserinfo().getId());
			packdepdetail.setUpdatetime(new Date());

			packdeppack.setPackid(Long.parseLong(packinfo.get("packid")
					.toString()));
			packdeppack.setPackdepartinvoicesid(packdepartinvoices.getId());
			packdeppack.setCreateby(global.getUserinfo().getId());
			packdeppack.setCreatetime(new Date());
			packdeppack.setUpdateby(global.getUserinfo().getId());
			packdeppack.setUpdatetime(new Date());
			try {
				usertransaction.begin();
				packdepdetaildao.merge(packdepdetail);
				packdeppackdao.merge(packdeppack);
				usertransaction.commit();
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				try {
					usertransaction.rollback();
				} catch (SystemException e1) {
					// TODO Auto-generated catch block
					e1.printStackTrace();
				}
				e.printStackTrace();
			}
		}

		packdepartinvoices.setPieces((short) sumpieces);
		packdepartinvoices.setShipprice(sumshipprice);
		packdepartinvoices.setPackfee(sumpackfee);
		packdepartinvoices.setHandfee(sumhandfee);
		packdepartinvoices.setTransitfee(sumtransitfee);
		packdepartinvoices.setInsuredamount(suminsuredamount);
		packdepartinvoices.setInsurancefee(suminsurancefee);
		packdepartinvoices.setDeliveryfee(sumdeliveryfee);
		packdepartinvoices.setOtherfee(sumotherfee);
		packdepartinvoices.setTotalfee(sumtotalfee);
		packdepartinvoices.setCustodial(sumcustodial);
		packdepartinvoices.setServicefee(sumservicefee);
		packdepartinvoices.setPackprice(sumpackprice);
		packdepartinvoices.setBalanceamount(sumbalancefeecountmoney);

		try {
			usertransaction.begin();
			boolean rs = packdepdao.updatePackdepById(packdepartinvoices);
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			e.printStackTrace();
		}

		return packStockVO;
	}

	@Override
	public boolean updatPackBy(String singbillno,
			List<PropertyFilter> propertyFilters) {
		// TODO Auto-generated method stub
		return packStockDao.updatPackBy(singbillno, propertyFilters);
	}

	@Override
	public List<Map<String, Object>> qrysendVehicle(Date departdate,
			String param, long orgid) throws ServiceException {
		return ListUtil.listToMap(
				new Object[] { "id", "schcode", "vehicleno" },
				packStockDao.qrysendVehicle(departdate, param, orgid),
				new Object[] { long.class, String.class, String.class });
	}

	public List<Map<String, Object>> qrysendSchedule(Date departdate,
			String param, long orgid) throws ServiceException {
		return ListUtil.listToMap(
				new Object[] { "id", "schcode", "vehicleno", "starttime",
						"scheduleid" },//
				packStockDao.qrysendSchedule(departdate, param, orgid),
				new Object[] { long.class, String.class, String.class,
						String.class, long.class });//
	}

	/**
	 * 签发行包
	 */
	@Override
	public boolean senderPack(Date departdate, String packno,
			long vehiclereportid, long scheduleid, long signby, String flag_pack)
			throws ServiceException {
		Date now = new Date();
		List<Pack> list = packStockDao.findPackinfo(packno);
		// 判断是否存在单号
		if (list == null || list.size() == 0) {
			// 单号为packno 行包不存在！
			throw new ServiceException("0506");
		}
		Pack pack = list.get(0);

		// 0:发货库存1:签发出库2:提领出库3:作废4:到货库存5:已退票6:中转库存7: 转至它站
		if (pack.getStatus().equals("1")) {
			throw new ServiceException("0513");
		} else if (pack.getStatus().equals("2")) {
			throw new ServiceException("0507");
		} else if (pack.getStatus().equals("3")) {
			throw new ServiceException("0508");
		} else if (pack.getStatus().equals("4")) {
			throw new ServiceException("0509");
		} else if (pack.getStatus().equals("5")) {
			throw new ServiceException("0510");
		} else if (pack.getStatus().equals("7")) {
			throw new ServiceException("0512");
		}

		// 判断该行包的目的地在ticketprice, 根据日期、
		// long scheduleplanid=vp.getScheduleplanid();
		long stationid = pack.getTostationid();
		if (flag_pack != null && flag_pack.equals("isVehicle")) { // 签发给报道车辆
			Vehiclereport vp = (Vehiclereport) packStockDao.get(
					Vehiclereport.class, vehiclereportid);
			List<Object> tplist = packStockDao.findRoute(vp.getDepartdate(),
					vp.getScheduleplanid(), stationid);
			if (tplist == null || tplist.size() == 0) {
				// 要签发的行包站点在该班次线路中不存在
				throw new ServiceException("0442");
			}
			pack.setVehicleid(vp.getVehicleid());
			pack.setScheduleid(vp.getScheduleid());
			pack.setVehiclereportid(new Long(vp.getId()));
		}
		if (flag_pack != null && flag_pack.equals("isSchedule")) { // 签发给计划班次
			pack.setScheduleid(scheduleid);
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!scheduleid",
					scheduleid));
			propertyFilters.add(new PropertyFilter("EQD_t!departdate",
					departdate));
			Scheduleplan sp = (Scheduleplan) packStockDao.uniqueResult(
					Scheduleplan.class, propertyFilters);
			if (sp == null) {
				// 要签发的行包站点在该班次线路中不存在
				throw new ServiceException("0442");
			} else {
				List<Object> tplist = packStockDao.findRoute(
						sp.getDepartdate(), sp.getId(), stationid);
				if (tplist == null || tplist.size() == 0) {
					// 要签发的行包站点在该班次线路中不存在
					throw new ServiceException("0442");
				}
			}
		}

		// 对付、并未回收款
//		if (pack.getPaymethod().equals("1")
//				&& pack.getRecyclestatus().equals("0")) {
//			throw new ServiceException("0514");
//		}
//		// 判断结算状态balancestatus结算状态：0未结算 1已结算
//		if ("1".equals(pack.getBalancestatus())) {
//			throw new ServiceException("0515");
//		}

		// 更新签发信息
		pack.setSignby(signby);
		pack.setSigntime(now);
		pack.setUpdateby(signby);
		pack.setUpdatetime(now);
		pack.setStatus("1");// 签发出库
		packStockDao.merge(pack);
		return true;
	}

	/**
	 * 查询车辆签发的行包信息
	 */
	@Override
	public List<Map<String, Object>> querystockSendPack(long vehiclereportid,long scheduleid,
			String flag_pack) throws ServiceException {
		// p.name,p.departdate,p.sender,p.senderphone,p.consignee,p.consigneephone,p.signby
		// ,p.signtime,p.createtime
		return ListUtil.listToMap(new Object[] { "id", "packno", "pieces",
				"name", "departdate", "sender", "senderphone", "consignee",
				"consigneephone", "uname", "signtime", "createtime", "weight",
				"packed", "shipprice", "packfee", "handfee", "insuredamount",
				"transitfee", "insurancefee", "insurance", "deliveryfee",
				"otherfee", "totalfee", "senderaddress", "consigneeaddress",
				"paymethod", "signby", "servicefee", "takename",
				"takecertificateno", "zhuanyuntostationid", "collectby",
				"collectdate", "recycleby", "recycledate", "balancestatus",
				"goodsstatus", "sellname", "paymethodname", "packedname" },
				packStockDao.querystockSendPack(vehiclereportid,scheduleid, flag_pack),
				new Object[] { long.class, String.class, long.class,
						String.class, Timestamp.class, String.class,
						String.class, String.class, String.class, String.class,
						Timestamp.class, Timestamp.class, Float.class,
						String.class, Float.class, Float.class, Float.class,
						Float.class, Float.class, Float.class, Float.class,
						Float.class, Float.class, Float.class, String.class,
						String.class, String.class, long.class, Float.class,
						String.class, String.class, long.class, long.class,
						Timestamp.class, long.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class });
	}

	@Override
	public List<Map<String, Object>> havaPackdepart(Pack pack) {
		// TODO Auto-generated method stub

		return ListUtil.listToMap(new Object[] { "packid"

		}, packStockDao.havaPackdepart(pack), new Object[] { long.class

		});
	}

	@Override
	public boolean updatepack(String packids, long routeid, long scheduleid,
			Long vehicleid, String stationids, long signby, Date signtime,
			Date departdate) throws ServiceException {
		if (packStockDao.checkschedule(routeid, stationids)) {
			throw new ServiceException("0442");
		}
		return packStockDao.updatepack(packids, scheduleid, vehicleid, signby,
				signtime, departdate);
	}

	// 查询页面选择行包
	public boolean choosenSenderPack(Date departdate, String pknos,
			long vehiclereportid,long scheduleid, long signby, String flag_pack, Long routeid, Global global)
			throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		boolean flag = false;
		String[] packno = pknos.split(",");
		Date updatetime = new Date();//更新时间
		Date signDate = DateUtils.strToDate(DateUtils.formatDate(new Date()));//实际签发日期
		if (packno != null && packno.length > 0) {
			for (int i = 0; i < packno.length; i++) {
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQS_t!packno",
						packno[i]));
				Pack pack = (Pack) packStockDao.uniqueResult(Pack.class,
						propertyFilters);
				if (flag_pack != null && flag_pack.equals("isVehicle")) {
					Vehiclereport vp = (Vehiclereport) packStockDao.get(
							Vehiclereport.class, vehiclereportid);
					signDate = vp.getDepartdate();
					long stationid = pack.getTostationid();
					// List<Ticketprice> tplist = packStockDao.findTicketprice(
					// vp.getDepartdate(), vp.getScheduleplanid(),
					// stationid);
					List<Object> tplist = packStockDao.findRoute(
							vp.getDepartdate(), vp.getScheduleplanid(), stationid);
					if (tplist == null || tplist.size() == 0) {
						// 要签发的行包站点在该班次线路中不存在
						throw new ServiceException("0442");
					}
					pack.setVehicleid(vp.getVehicleid());
					pack.setScheduleid(vp.getScheduleid());
					pack.setVehiclereportid(new Long(vp.getId()));
				}
				if (flag_pack != null && flag_pack.equals("isSchedule")) {// 签发给计划班次
					// pack.setScheduleid(packSetID);
					// Scheduleplan sp = (Scheduleplan) packStockDao.get(
					// Scheduleplan.class, packSetID);
					// long stationid = pack.getTostationid();
					// List<Object> tplist = packStockDao.findRoute(
					// sp.getDepartdate(), packSetID, stationid);
					// if (tplist == null || tplist.size() == 0) {
					// // 要签发的行包站点在该班次线路中不存在
					// throw new ServiceException("0442");
					// }
					long stationid = pack.getTostationid();
					pack.setScheduleid(scheduleid);
					propertyFilters = new ArrayList<PropertyFilter>();
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQL_t!scheduleid",
							scheduleid));
					propertyFilters.add(new PropertyFilter("EQD_t!departdate",
							departdate));
					Scheduleplan sp = (Scheduleplan) packStockDao.uniqueResult(
							Scheduleplan.class, propertyFilters);
					if (sp == null) {
						// 要签发的行包站点在该班次线路中不存在
						throw new ServiceException("0442");
					} else {
						List<Object> tplist = packStockDao.findRoute(
								sp.getDepartdate(), sp.getId(), stationid);
						if (tplist == null || tplist.size() == 0) {
							// 要签发的行包站点在该班次线路中不存在
							throw new ServiceException("0442");
						}
						signDate = sp.getDepartdate();
					}

				}
//				if (pack.getPaymethod().equals("1")
//						&& pack.getRecyclestatus().equals("0")) {  //行包签发时，取消“该行包货款还未回收，不允许签发”限制（20180802，禅道号22616
//					throw new ServiceException("0514");
//				}
				// 判断结算状态balancestatus结算状态：0未结算 1已结算
//				if ("1".equals(pack.getBalancestatus())) {     //行包签发时，取消“该行包货款还未回收，不允许签发”限制（20180802，禅道号22616
//					throw new ServiceException("0515");
//				}

				if(DateUtils.compare(pack.getDepartdate(), signDate) != 0){
					//bug号: 95891; 小件发货日期与实际签发日期不一致，则将小件发货日期修改为签发日期
					Operationlog log = new Operationlog();
					log.setUserid(signby);
					log.setIp(global.getIpAddress());
					log.setSessionid(global.getSessionID());
					log.setModule("行包管理——>行包库存");
					log.setOperation("行包签发");
					StringBuffer content = new StringBuffer();
					content.append("此行包受理时发货日期与实际签发日期不同，签发时对发货日期执行修改。行包单号：").append(pack.getPackno()).append("，受理时原发货日期为：")
						.append(DateUtils.formatDate(pack.getDepartdate())).append(", 签发时间：").append(DateUtils.formatDatetime(updatetime));
					log.setContent(content.toString());
					log.setOperatetime(updatetime);
					packStockDao.save(log);
					
					pack.setDepartdate(signDate);
				}
				
				// 更新签发信息
				pack.setSignby(signby);
				pack.setSigntime(updatetime);
				pack.setUpdateby(signby);
				pack.setUpdatetime(updatetime);
				pack.setStatus("1");// 签发出库
				packStockDao.merge(pack);
				flag = true;
			}
		}
		return flag;
	}

	// 计划班次
	public List<Map<String, Object>> qrysendSchedulePlan(Date departdate,
			String param,boolean isfindbyreported) {
		return ListUtil.listToMap(new Object[] { "id", "starttime", "code"

		}, packStockDao.qrysendSchedulePlan(departdate, param,isfindbyreported), new Object[] {
				Long.class, String.class, String.class });
	}
}
