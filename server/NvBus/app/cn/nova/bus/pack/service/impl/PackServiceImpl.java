package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import play.db.jpa.JPA;
import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinventoryService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinventoryServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.impl.DispatchServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PackDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.model.PackIntegraterPay;
import cn.nova.bus.pack.model.Packarriver;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packrecyle;
import cn.nova.bus.pack.service.ClientService;
import cn.nova.bus.pack.service.PackIntegraterPayService;
import cn.nova.bus.pack.service.PackService;
import cn.nova.bus.pack.service.PacktturnoverdetailService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.DigitaldictionarydetailDao;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.service.DictionaryService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.DictionaryServiceImpl;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.bus.pack.dao.PacktturnoverdetailDao;
import cn.nova.bus.pack.model.Packtturnoverdetail;

public class PackServiceImpl implements PackService {

	private PackDao packDao = new PackDao();

	private PacktturnoverdetailDao packturnoverdetaildao = new PacktturnoverdetailDao();
	private PacktturnoverdetailService service= new PacktturnoverdetailServiceImpl() ;
	
	private UserTransaction usertransaction = new UserTransaction();

	private ParameterService parameterService = new ParameterServiceImpl();
	private BilltypeService billtypeService = new BilltypeServiceImpl();

	private BillinventoryService billinventoryService = new BillinventoryServiceImpl();

	public List<Map<String, Object>> saveNewPackType(Global global,
			String newPackType) {
		DigitaldictionarydetailDao ddDao = new DigitaldictionarydetailDao();

		List list = ddDao.isExistPackType(newPackType.trim());// 查询是否已存在该类别

		if (list == null || list.size() < 1) {
			list = ddDao.findLastPackType();
			if (list != null && list.size() > 0) {
				Digitaldictionarydetail ddt = new Digitaldictionarydetail();
				ddt = (Digitaldictionarydetail) list.get(0);

				Digitaldictionarydetail ddtNew = new Digitaldictionarydetail();
				ddtNew.setId(ddt.getId() + 1);
				ddtNew.setDigitaldictionary(ddt.getDigitaldictionary());
				ddtNew.setOrderno((short) (ddt.getOrderno() + 1));
				ddtNew.setCode(Long.toString(ddt.getOrderno() + 1));
				ddtNew.setValue(newPackType);
				ddtNew.setDescribe(ddt.getDescribe());
				ddtNew.setCreatetime(new Date());
				ddtNew.setCreateby(global.getUserinfo().getId());
				ddtNew.setUpdatetime(new Date());
				ddtNew.setUpdateby(global.getUserinfo().getId());

				ddtNew = ddDao.merge(ddtNew);
				list.add(ddtNew);
			}
		}
		return list;
	}

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {

		List<Map<String, Object>> result = ListUtil
				.listToMap(new Object[] { "ischoose", "id", "packtype",
						"goodtype", "sendstationid", "tostationid", "name",
						"scheduleid", "vehicleid", "departdate", "packno",
						"invoiceno", "sellby", "pieces", "weight", "volume",
						"packed", "shipprice", "packfee", "handfee",
						"unloadfee", "custodial", "transitfee",
						"insuredamount", "insurancefee", "insurance",
						"deliveryfee", "otherfee", "totalfee", "location",
						"packprice", "sender", "senderphone", "senderaddress",
						"consignee", "consigneephone", "consigneeaddress",
						"certificatetype", "certificateno", "shiptype",
						"paymethod", "valuables", "status", "packtturnoverid",
						"remak", "orgid", "createtime", "createby",
						"updatetime", "updateby", "integraterprice",
						"servicefee",

						"sendstationname", "tostationname", "schedulecode",
						"departtime", "vehiclecode", "sellbyname",
						"updatebyname", "signby", "signbyname", "signtime",
						"onlycode", "synccode", "orgname", "clientid",
						"mobilephone", "clientname", "clientaddress",
						"clientcode", "clientintegrater", "clienttype",
						"singbillno", "zhuanyuntostationid",
						"zhuanyuntostationname", "takename",
						"takecertificateno", "vcstatus", "balancestatus",
						"collectstatus", "recyclestatus", "goodsstatus",
						"packedname" ,"locationname","sendercertificatetype","sendercertificateno" },
						packDao.query(propertyFilters),
						new Object[] { Boolean.class, Long.class, String.class,
								String.class, Long.class, Long.class,
								String.class, Long.class, Long.class,
								Timestamp.class, String.class, String.class,
								Long.class, Short.class, BigDecimal.class,
								BigDecimal.class, String.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, BigDecimal.class,
								BigDecimal.class, String.class,
								BigDecimal.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, Boolean.class,
								String.class, Long.class, String.class,
								Long.class, Timestamp.class, Long.class,
								Timestamp.class, Long.class, BigDecimal.class,
								BigDecimal.class,

								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, Long.class, String.class,
								Timestamp.class, String.class, String.class,
								String.class, Long.class, String.class,
								String.class, String.class, String.class,
								Long.class, String.class, String.class,
								Long.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class,
								String.class, String.class, String.class, String.class });
		return result;

	}

	@SuppressWarnings("unchecked")
	@Override
	public Pack savePack(Pack pack) throws ServiceException {
		// if(pack.getPacktype().equals("2")){
		// //到货入仓 验证单号是否存在
		// }

		if (pack.getPacktype().equals("0")) {
			// Billtype billtype = billtypeService
			// .findByCode(ConstDefiniens.PackBill);
			//
			// Billinuse billinuse =
			// billinuseService.getBilluse(billtype.getId(),
			// pack.getSellby(), new Long(pack.getPackno()));
			// if (billinuse == null || "2".equals(billinuse.getStatus())) {
			// // 您的票据已经用完
			// throw new ServiceException("0143");
			// }
		}

		try {
			usertransaction.begin();
			if (pack.getId() == 0) {
				pack.setOnlycode(createOnlycode(pack.getOrgid()));
				packDao.save(pack);
			} else {
				if (pack.getSynccode() == null) {
					Pack pack2 = packDao.getEntityManager().find(Pack.class,
							pack.getId());
					pack.setSynccode(pack2.getSynccode());
				}
				packDao.getEntityManager().merge(pack);
			}
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				// TODO Auto-generated catch block
				e1.printStackTrace();
			}
			play.Logger.error(e.getMessage(), e);
		}
		return pack;
	}

	@Override
	public boolean wastePack(Pack pack, long userid) throws ServiceException {
		// 更新行包状态
		boolean bol = packDao.wastePack(pack, userid);
		// 修改营收
		Pack p = (Pack) packDao.get(Pack.class, pack.getId());
		PacktturnoverdetailService packtturnoverdetailService = new PacktturnoverdetailServiceImpl();
		boolean b = packtturnoverdetailService.wastePackcanclepacktturnoverdetail(p, userid );
		return bol && b;
	}

	@Override
	public int queryDistance(List<PropertyFilter> propertyFilters) {
		int result = Integer.parseInt(packDao.queryDistance(propertyFilters)
				.toString());
		return result;
	}

	@Override
	public Map<String, Float> getShipprice(long orgid, int distance,
			float weight, long pieces) {
		Map<String, Float> packfees = new HashMap<String, Float>();
		List<Packfee> plist = packDao.getShipprice(orgid, "TYF", distance);
		if (plist != null && plist.size() > 0) {
			float result = 0;
			Packfee packfee = (Packfee) plist.get(0);
			// float piecesmoney = (float) pieces *
			// packfee.getFee().floatValue();件数*最低价
			float piecesmoney = (float) packfee.getFee().floatValue();// 最低价
			// 判断里程数是不是在范围内
			float weightmoney = 0;
			if (weight > packfee.getToweight().floatValue()) {
				weightmoney = (weight - packfee.getToweight().floatValue())
						* packfee.getFeekg().floatValue();
				if (weightmoney > Math.round(weightmoney)) {
					weightmoney = Math.round(weightmoney) + 1;
				} else {
					weightmoney = Math.round(weightmoney);
				}
			}

			result = piecesmoney + weightmoney;
			packfees.put("TYF", result);

		}
		plist = packDao.getShipprice(orgid, "ZXF", distance);
		if (plist != null && plist.size() > 0) {
			float result = 0;
			Packfee packfee = (Packfee) plist.get(0);
			// float piecesmoney = (float) pieces *
			// packfee.getFee().floatValue();件数*最低价
			float piecesmoney = (float) packfee.getFee().floatValue();// 最低价
			// 判断里程数是不是在范围内
			float weightmoney = 0;
			if (weight > packfee.getToweight().floatValue()) {
				weightmoney = (float) (weight - packfee.getToweight()
						.floatValue()) * packfee.getFeekg().floatValue();
				if (weightmoney > Math.round(weightmoney)) {
					weightmoney = Math.round(weightmoney) + 1;
				} else {
					weightmoney = Math.round(weightmoney);
				}
			}
			result = piecesmoney + weightmoney;
			packfees.put("ZXF", result);
		}

		return packfees;
	}

	@Override
	public List<Map<String, Object>> queryschedule(String param,
			List<PropertyFilter> propertyFilters) {
		// return ListUtil.listToMap(new Object[] { "id", "name", "code",
		// "starttime", "departtime", "isdeparted", "status", "vehicleid",
		// "vehicleno", "vehportid", "schstatusid" },
		// packDao.queryschedule(param, propertyFilters), new Object[] {
		// Long.class, String.class, String.class,
		// Timestamp.class, String.class, String.class,
		// String.class, Long.class, String.class, Long.class,
		// Long.class });
//		return ListUtil.listToMap(new Object[] { "id", "name", "code",
//				"departtime" }, packDao.queryschedule(param, propertyFilters),
//				new Object[] { Long.class, String.class, String.class,
//						String.class });
		return ListUtil.listToMap(new Object[] { "id", "name", "code",
				"departtime","vehicleid","vehicleno","stationid","stationname","routeid","routename" }, packDao.queryschedule(param, propertyFilters),
				new Object[] { Long.class, String.class, String.class,
						String.class,Long.class, String.class ,Long.class, String.class,Long.class,String.class});
	}

	@Override
	public List<Map<String, Object>> querystation(String param, long stationid,long routeid) {
		Object[] fileds = { "id", "code", "name", "helpcode", "jianpin",
				"isdepart", "grade" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class,
				String.class, String.class, String.class, String.class };// 初始化要查询的字段

		return ListUtil.listToMap(fileds,
				packDao.querystation(param, stationid, routeid), filedtypes);
	}

	@Override
	public boolean updateBillinuse(long recipients, String billtypecode,
			String status, long nextno, long nextform) throws ServiceException {
		return packDao.updateBillinuse(recipients, billtypecode, status,
				nextno, nextform);
	}

	@SuppressWarnings("unchecked")
	@Override
	public Pack whackpack(Pack pack) throws ServiceException {
		// StringBuffer sb = new
		// StringBuffer("select p from Pack p where p.id=:packid");
		// Query query = packDao.getEntityManager().createQuery(sb.toString());
		// query.setParameter("packid", pack.getId());
		// Pack p =null;
		// try {
		// p = (Pack) query.getSingleResult();
		// } catch (EntityNotFoundException e) {
		// //重打的对象不存在
		// throw new ServiceException("0443");
		// }
		//
		// long id=p.getId();
		//
		// p.setId(0);
		// p.setStatus("0");
		// p.setPackno(pack.getPackno());
		// p.setSellby(pack.getSellby());
		// p.setCreateby(pack.getSellby());
		// p.setCreatetime(new Date());
		// p.setUpdateby(pack.getSellby());
		// p.setUpdatetime(new Date());
		//
		// packDao.save(p);
		//
		// sb = new StringBuffer("update Pack set status=3 where id=:packid");
		// query = packDao.getEntityManager().createQuery(sb.toString());
		// query.setParameter("packid", id);
		//
		// query.executeUpdate();

		// Billtype billtype =
		// billtypeService.findByCode(ConstDefiniens.PackBill);
		//
		// Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
		// pack.getSellby(), new Long(pack.getPackno()));
		// if (billinuse == null || "2".equals(billinuse.getStatus())) {
		// // 您的票据已经用完
		// throw new ServiceException("0143");
		// }

		Pack p = (Pack) packDao.get(Pack.class, pack.getId());
		Pack p2 = null;

		p2 = (Pack) p.clone();

		String status = p.getStatus();
		p.setStatus("3");
		p.setUpdatetime(pack.getUpdatetime());
		p.setUpdateby(pack.getUpdateby());
		packDao.getEntityManager().merge(p);

		p2.setId(0);
		p2.setStatus(status);
		p2.setPackno(pack.getPackno());
		p2.setSellby(pack.getSellby());
		p2.setCreateby(pack.getSellby());
		p2.setCreatetime(new Date());
		p2.setUpdateby(pack.getSellby());
		p2.setUpdatetime(new Date());
		p2.setSynccode(null);
		p2.setOnlycode(createOnlycode(p.getOrgid()));
		packDao.save(p2);
		
		
		if (p.getPacktype().equals("0")) { // 发货--更新营收缴款明细
		
			packturnoverdetaildao.updatePacktturnoverdetail(pack.getSellby(), pack.getPackno(), p.getPackno()); 
		
		}

		return p2;
	}

	@Override
	public List<Map<String, Object>> queryclient(String param,
			List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code",
				"mobilephone", "contacter", "address", "type", "integrater" },
				packDao.queryclient(param, propertyFilters), new Object[] {
						Long.class, String.class, String.class, String.class,
						String.class, String.class, String.class, Long.class });
	}

	/**
	 * 创建onlycode值
	 * 
	 * @param orgid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	private String createOnlycode(long orgid) {
		String result = "NULL";
		StringBuffer sb = new StringBuffer(
				"select org.code from Organization org where org.id=:orgid");
		Query query = packDao.getEntityManager().createQuery(sb.toString());
		query.setParameter("orgid", orgid);
		List<String> list = query.getResultList();
		if (list != null && list.size() > 0) {
			result = list.get(0).toString();
		}

		SimpleDateFormat format = new SimpleDateFormat("yyyyMMddHHmmssss");
		result = result + format.format(new Date());

		return result;
	}

	@Override
	public Pack savePack(Pack pack, PackIntegraterPay packIntegraterPay)
			throws ServiceException {
		//			usertransaction.begin();
		
		DigitaldictionarydetailDao ddDao = new DigitaldictionarydetailDao();
		Global global = CurrentUtil.getGlobal();
		PackIntegraterPayService packIntegraterPayService = new PackIntegraterPayServiceImpl();
		ClientService clientService = new ClientServiceImpl();
		if (pack.getId() == 0) {
			List list2 = ddDao.checkpackno(pack.getPackno().trim()); // 查询是否已存在该订单号
			if (list2 != null && list2.size() > 0) {
				throw new ServiceException("0444");
			}
			pack.setOnlycode(createOnlycode(pack.getOrgid()));
			if (pack.getPacktype().equals("0")) { // 发货
				DispatchServiceImpl dsi = new DispatchServiceImpl();
				Vehiclereport vehiclereport = new Vehiclereport();
				vehiclereport.setReportorgid(pack.getSendstationid());
				vehiclereport.setScheduleid(pack.getScheduleid());
				vehiclereport.setDepartdate(new Date());
				List<Map<String, Object>> list = dsi
						.qryVehiclereport(vehiclereport);
				if (list != null && list.size() > 1) {
					Map<String, Object> map = list.get(0);
					long vid = (Long) map.get("vehicleid");
					pack.setVehicleid(vid);
				}
			}
			// packDao.save(pack);
			// 插入积分流水
			if (pack.getClientid() != null && pack.getClientid() > 0) {
				if (packIntegraterPay.getIntegrater() > 0) {
					packIntegraterPay.setPackid(pack.getId());
					packIntegraterPay.setCreateby(pack.getCreateby());
					packIntegraterPay.setCreatetime(new Date());
					packIntegraterPay.setUpdateby(pack.getUpdateby());
					packIntegraterPay.setUpdatetime(new Date());
					packIntegraterPay.setPaydate(new Date());
					packIntegraterPayService
							.savePackIntegraterPay(packIntegraterPay);
					clientService.updateClientIntegrater(pack.getClientid(),
							packIntegraterPay.getIntegrater());
				} else {
					clientService.updateClientIntegrater(pack.getClientid(),
							pack.getTotalfee());
				}
			}
			if (pack.getPacktype().equals("0")) { // 发货
				// 插入行包缴款明细表

				Packtturnoverdetail packtturnoverdetail = getService()
						.getCurPackturnoverdetail(global.getUserinfo().getId(),
								pack);
				pack.setPacktturnoverid(packtturnoverdetail.getId());

				// Packtturnoverdetail packtturnoverdetail = new
				// Packtturnoverdetail();
				// packtturnoverdetail.setMoneydate(pack.getDepartdate());
				// packtturnoverdetail.setSellby(pack.getSellby());
				//
				// packtturnoverdetail.setTicketstartno(pack.getPackno());
				//
				// packtturnoverdetail.setTicketendno(pack.getPackno());
				// packtturnoverdetail.setSendpacks(pack.getPieces());
				// packtturnoverdetail.setSendpackamount(pack.getTotalfee());
				// packtturnoverdetail.setMoneypayable(pack.getTotalfee());
				// packtturnoverdetail.setIsturnover(false);
				// packtturnoverdetail.setIsaudit(false);
				// packtturnoverdetail.setShipprice(pack.getShipprice());
				// packtturnoverdetail.setPackfee(pack.getPackfee());
				// packtturnoverdetail.setUnloadfee(pack.getUnloadfee());
				// packtturnoverdetail.setHandfee(pack.getHandfee());
				// packtturnoverdetail.setCustodial(pack.getCustodial());
				// packtturnoverdetail.setTransitfee(pack.getTransitfee());
				// packtturnoverdetail.setInsuredamount(pack
				// .getInsuredamount());
				// packtturnoverdetail.setInsurancefee(pack.getInsurancefee());
				// packtturnoverdetail.setInsurance(pack.getInsurance());
				// packtturnoverdetail.setDeliveryfee(pack.getDeliveryfee());
				// packtturnoverdetail.setServicefee(pack.getServicefee());
				// packtturnoverdetail.setOtherfee(pack.getOtherfee());
				// packtturnoverdetail.setPackprice(pack.getPackprice());
				// packtturnoverdetail.setOrgid(pack.getOrgid());
				// packtturnoverdetail.setDatafrom("0");
				// packtturnoverdetail.setCreateby(pack.getCreateby());
				// packtturnoverdetail.setCreatetime(pack.getCreatetime());
				// packtturnoverdetail.setUpdateby(pack.getUpdateby());
				// packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
				//
				// packturnoverdetaildao.merge(packtturnoverdetail);
			}
			packDao.save(pack);
		} else {
			if (pack.getSynccode() == null) {
				Pack pack2 = packDao.getEntityManager().find(Pack.class,
						pack.getId());
				pack.setSynccode(pack2.getSynccode());
			}
			packDao.getEntityManager().merge(pack);
		}
		return pack;
	}

	public Pack savepaymentrecycle(Global global, Pack pack)
			throws ServiceException {
		//			usertransaction.begin();
		if (pack.getId() > 0) {
			pack = packDao.getEntityManager()
					.find(Pack.class, pack.getId());
			pack.setRecycleby(global.getUserinfo().getId());
			pack.setRecycledate(new Date());
			pack.setRecyclestatus("1");
			packDao.getEntityManager().merge(pack);
			
			play.Logger.info("对付款回收营收缴款开始————————————————————————————————————————————————————————————");
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
			propertyFilters.add(new PropertyFilter("EQD_t!moneydate",new Date()));
			propertyFilters.add(new PropertyFilter("EQL_t!sellby",global.getUserinfo().getId()));
			PacktturnoverdetailDao packtturnoverdetailDao = new PacktturnoverdetailDao();
			List<Packtturnoverdetail> list =  packtturnoverdetailDao.qryPacktturnoverdetailBypackno(propertyFilters, false);//对付款回收的营收缴款并到行包受理的营收缴款上 谁回收的加在谁的营收上
			Packtturnoverdetail packtturnoverdetail = null;		
			if(list != null && list.size()>0){//存在营收缴款
					packtturnoverdetail = list.get(0);//今天已存在营收缴款
			        if(pack.getPackprice() == null ){
			        	pack.setPackprice(BigDecimal.valueOf(0));//避免空指针
			        }
			        if(pack.getServicefee() == null ){
			        	pack.setServicefee(BigDecimal.valueOf(0));
			        }
				
					 if (pack.getTotalfee() != null) {
			        	  packtturnoverdetail.setSendpackamount(  packtturnoverdetail.getSendpackamount().add(pack.getTotalfee().add(pack.getPackprice())));//合计金额  合计= 合计+代收货款 
				          packtturnoverdetail.setMoneypayable(    packtturnoverdetail.getMoneypayable().  add(pack.getTotalfee().add(pack.getPackprice())));//合计金额 
				          packtturnoverdetail.setShipprice(packtturnoverdetail.getShipprice().add(pack.getTotalfee().subtract(pack.getServicefee())));//代收运费  (合计-服务费=代收运费)
			          	}
			         if (pack.getServicefee()!= null ) {
			        	 packtturnoverdetail.setServicefee(pack.getServicefee().add(packtturnoverdetail.getServicefee()));//服务费
						}
			       
			         if (pack.getPackprice()!= null ) {
			        	 packtturnoverdetail.setPackprice(pack.getPackprice().add(packtturnoverdetail.getPackprice()));//-代收货款 	
						}
			          packtturnoverdetail.setUpdateby(global.getUserinfo().getId());
			          packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
			          packtturnoverdetailDao.merge(packtturnoverdetail);
				
			}else{
				/**
				 * 对付款回收值添加代收运费，服务费，代收货款和合计
				 */
				  packtturnoverdetail = new Packtturnoverdetail();//今天还未存在营收缴款
				  packtturnoverdetail.setMoneydate(new Date()); //行包缴款日期 
				  packtturnoverdetail.setSellby(global.getUserinfo().getId());//办理员 
				  packtturnoverdetail.setTicketstartno("0");//行包单号 
				  packtturnoverdetail.setTicketendno("0");//行包单号 
				  packtturnoverdetail.setSendpacks(0);//件数 
				  if (pack.getPackprice()==null) {
					  packtturnoverdetail.setSendpackamount(BigDecimal.valueOf(0));
					  packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));
				  }else{
					  packtturnoverdetail.setSendpackamount(pack.getTotalfee().add(pack.getPackprice()));//合计金额   (合计= 合计+代收货款)
					  packtturnoverdetail.setMoneypayable(pack.getTotalfee().add(pack.getPackprice()));//合计金额 
				  }
				  if (pack.getServicefee()==null) {
					  packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
				  }else{
					  packtturnoverdetail.setShipprice(pack.getTotalfee().subtract(pack.getServicefee()));//代收运费  (合计-服务费=代收运费)
				  }
				  if(pack.getServicefee()==null){
					  packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));
				  }else{
					  packtturnoverdetail.setServicefee(pack.getServicefee());//服务费  
				  }
				  if(pack.getPackprice() == null){
						  packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));
				  }else{
				      packtturnoverdetail.setPackprice(pack.getPackprice());//代收货款 
					  }
				  packtturnoverdetail.setPackfee(BigDecimal.valueOf(0));
				  packtturnoverdetail.setHandfee(BigDecimal.valueOf(0));  
	        	  packtturnoverdetail.setUnloadfee(BigDecimal.valueOf(0));	//如果不存在货装卸费，则设置为0
	        	  packtturnoverdetail.setCustodial(BigDecimal.valueOf(0));//保管费   
	        	  packtturnoverdetail.setTransitfee(BigDecimal.valueOf(0));//中转费   
	        	  packtturnoverdetail.setInsuredamount(BigDecimal.valueOf(0));//保价金额   
	        	  packtturnoverdetail.setInsurancefee(BigDecimal.valueOf(0));//保价费   
	        	  packtturnoverdetail.setInsurance(BigDecimal.valueOf(0));//保险费   
				  packtturnoverdetail.setDeliveryfee(BigDecimal.valueOf(0));//送货费   
				  packtturnoverdetail.setOtherfee(BigDecimal.valueOf(0));//其他费 
				  packtturnoverdetail.setIsturnover(false);
				  packtturnoverdetail.setIsaudit(false);
				  packtturnoverdetail.setReturnnum(0);
				  packtturnoverdetail.setReturnhandcharge(BigDecimal.valueOf(0));
				  packtturnoverdetail.setReturnmoney(BigDecimal.valueOf(0));
				  packtturnoverdetail.setCancelnum(0);
				  packtturnoverdetail.setOrgid(pack.getOrgid());
				  packtturnoverdetail.setDatafrom("0");
				  packtturnoverdetail.setCreateby(global.getUserinfo().getId());
				  packtturnoverdetail.setCreatetime(pack.getCreatetime());
				  packtturnoverdetail.setUpdateby(global.getUserinfo().getId());
				  packtturnoverdetail.setUpdatetime(pack.getUpdatetime());
				  packtturnoverdetailDao.merge(packtturnoverdetail);
			}
			play.Logger.info("对付款回收营收缴款结束———————————————————————————————————————————————————————————");
		
			//插入packrecycle表	
//			Packrecyle packrecyle = new Packrecyle();
//			packrecyle.setPackid(pack.getId());
//			packrecyle.setPacktturnoverid(packtturnoverdetail.getId());
//			packrecyle.setRecycleby(global.getUserinfo().getId());
//			packrecyle.setTostationid(pack.getTostationid());
//			packrecyle.setRecyletime(new Date());
//			packrecyle.setOrgid(pack.getOrgid());
//			packrecyle.setShipprice(pack.getTotalfee().subtract(pack.getServicefee()));//代收运费
//			packrecyle.setServicefee(pack.getServicefee());//服务费
//			packrecyle.setPackprice(pack.getPackprice());//代收货款
//			packrecyle.setCreateby(global.getUserinfo().getId());
//			packrecyle.setUpdateby(global.getUserinfo().getId());
//			packrecyle.setCreatetime(new Date());
//			packrecyle.setUpdatetime(new Date());
//			packrecyle.setTotalfee(packrecyle.getPackprice().add(packrecyle.getServicefee().add(packrecyle.getShipprice())));//合计
//			 packtturnoverdetailDao.getEntityManager().merge(packrecyle);
		}
//			usertransaction.commit();
		return pack;
	}

	@Override
	public int updatePackStatus(String packids, String status) {
		// TODO Auto-generated method stub
		String sql = "update pack p set p.status=" + status
				+ " where p.id in (" + packids + ")";
		Query query = null;
		int count = 0;
		try {
			usertransaction.begin();
			query = JPA.em().createNativeQuery(sql);
			count = query.executeUpdate();
			usertransaction.commit();
		} catch (SystemException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return count;
	}

	@Override
	public List<Map<String, Object>> queryTotal(Global global, Date startdate,
			Date enddate, long scheduleid, String isbukai) {
		// TODO Auto-generated method stub
		String balancefeerate = parameterService.findParamValue(ParamterConst.Param_8099, global
				.getUserinfo().getOrgid());
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"tostationid", "tostationname", "packno", "sendstationname",
				"pieces", "shipprice", "packfee", "handfee", "transitfee",
				"insuredamount", "insurancefee", "insurance", "deliveryfee",
				"otherfee", "totalfee", "packprice", "balancefeecountmoney",
				"sendstationid", "packid", "custodial", "servicefee" }, packDao
				.queryTotal(Float.parseFloat(balancefeerate), startdate,
						enddate, scheduleid, isbukai), new Object[] {
				Long.class, String.class, String.class, String.class,
				Short.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, Long.class, Long.class, BigDecimal.class,
				BigDecimal.class });
		return result;
	}

	public List<Map<String, Object>> qryPackArrive(String packarriverno,
			Date arriverdate, long vehicleid, String status,
			Date arriverenddate, String ids) {
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"packarriverno", "routename", "packfee", "packprice", "pieces",
				"servicefee", "id", "balancemoney", "status", "balancetime",
				"balanceby", "packstatus" }, packDao.qryPackArrive(
				packarriverno, arriverdate, vehicleid, arriverenddate, ids,
				status), new Object[] { String.class, String.class,
				BigDecimal.class, BigDecimal.class, long.class,
				BigDecimal.class, long.class, BigDecimal.class, String.class,
				String.class, String.class, String.class });
		return result;
	}

	public PackBalance savePackBalance(Global global, PackBalance packbalance)
			throws ServiceException {
		long updateby = global.getUserinfo().getId();
		Date now = new Date();
		Billtype billtype = billtypeService
				.findByCode(ConstDefiniens.PackBalanceBill);
		Billinventory bt = billinventoryService.qryBillinventory(global
				.getOrganization().getId(), ConstDefiniens.PackBalanceBill);
		if (bt == null) {
			// 您的票据已经用完
			throw new ServiceException("0143");
		}
		if (bt.getAvailableenno() < bt.getAvailablestartno()) {
			// 您的票据已经用完
			throw new ServiceException("0143");
		}
		String balanceno = bt.getAvailablestartno() + "";
		// 取号后直接提交，避免并发
		if (bt.getAvailablestartno() <= bt.getAvailableenno()) {
			bt.setAvailablestartno(bt.getAvailablestartno() + 1);
			bt.setUpdateby(global.getUserinfo().getId());
			bt.setUpdatetime(now);
			packDao.getEntityManager().merge(bt);
		}

		// 补零操作
		if (billtype.getTicketnolength() != balanceno.length()) {
			balanceno = StringUtils.strPad(balanceno,
					(int) billtype.getTicketnolength(), "0");
		}
		if (packDao.isExistBalancedeNo(balanceno)) {
			// 该结算通知单号已经存在
			throw new ServiceException(balanceno, "0392");
		}
		if (packbalance.getDatatype().equals("0")) {
			List<Packarriver> plist = packDao.qryPackArriveById(packbalance
					.getIds());
			BigDecimal packfee = new BigDecimal(0);
			BigDecimal packprice = new BigDecimal(0);
			for (Packarriver p : plist) {
				if (!p.getStatus().equals("0")) {
					throw new ServiceException(p.getPackarriverno(), "0502");
				}
				packfee = packfee.add(p.getPackfee() == null ? new BigDecimal(0): p.getPackfee());
//				packfee = packfee.add(
//						p.getPackfee() == null ? new BigDecimal(0)
//						: p.getPackfee()).add(p.getServicefee() == null ? new BigDecimal(0) : p.getServicefee());
				packprice = packprice
						.add(p.getPackprice() == null ? new BigDecimal(0) : p.getPackprice());
			}
			// 判断金额是否与系统查询出来一致
			if (packfee.compareTo(packbalance.getPackmoney()) != 0
					|| packprice.compareTo(packbalance.getPackprice()) != 0) {

				throw new ServiceException("结算金额错误", "0503");
			}

			// 插入结算数据
			packbalance.setBalancby(updateby);
			packbalance.setBalancetime(now);
			packbalance.setCreateby(updateby);
			packbalance.setCreatetime(now);
			packbalance.setUpdateby(updateby);
			packbalance.setUpdatetime(now);
			packbalance.setPackbalanceno(balanceno);
			PackBalance pb = (PackBalance) packDao.merge(packbalance);
			// 更新到货数据
			for (Packarriver p : plist) {
				p.setPackbalanceid(pb.getId());
				p.setStatus("2");
				p.setUpdateby(updateby);
				p.setUpdatetime(now);
				packDao.merge(p);
			}
			return pb;
		} else {
			List<Packdepartinvoices> plist = packDao
					.qryPackdepartinvoicesById(packbalance.getIds());
			BigDecimal packfee = new BigDecimal(0);
			BigDecimal packprice = new BigDecimal(0);
			for (Packdepartinvoices p : plist) {
				if (!p.getStatus().equals("0")) {
					throw new ServiceException(p.getDepartinvoicesno(), "0502");
				}
				packfee = packfee.add(p.getShipprice()==null? new BigDecimal(0) : p.getShipprice()); // 运费
				packprice = packprice.add(p.getPackprice()==null? new BigDecimal(0) : p.getPackprice()); // 货款
			}
			// 判断金额是否与系统查询出来一致
			if (packfee.compareTo(packbalance.getPackmoney()) != 0
					|| packprice.compareTo(packbalance.getPackprice()) != 0) {

				throw new ServiceException("结算金额错误", "0503");
			}

			// 插入结算数据
			packbalance.setBalancby(updateby);
			packbalance.setBalancetime(now);
			packbalance.setCreateby(updateby);
			packbalance.setCreatetime(now);
			packbalance.setUpdateby(updateby);
			packbalance.setUpdatetime(now);
			packbalance.setPackbalanceno(balanceno);
			PackBalance pb = (PackBalance) packDao.merge(packbalance);
			
			
			for (Packdepartinvoices p : plist) {
				p.setPackbalanceid(pb.getId());
				p.setStatus("2");
				p.setUpdateby(updateby);
				p.setUpdatetime(now);
				packDao.merge(p);
				long departinvoiceid = p.getId();
				List<Object> list = packDao.findPackinfoByid(departinvoiceid);
				if(list != null && list.size()>0){
					for(Object obj:list){
						Pack pack = (Pack)obj;
						pack.setBalanceby(pb.getBalancby());
						pack.setBalancedate(pb.getBalancetime());
						pack.setBalanceid(pb.getId());
						pack.setBalanceorgid(pb.getOrgid());
						pack.setBalancestatus("1");
						packDao.merge(pack);
					}
				}
			}			
			return pb;
		}

	}

	public List<Map<String, Object>> qryPackBalance(String departinvoicesno,
			Date senddepartdate, Date sendenddate, String status, String ids, long vehicleid,long orgid) {
		List<Map<String, Object>> result = ListUtil
				.listToMap(new Object[] { "departdate", "departinvoicesno",
						"vehicleno", "pieces", "packmoney", "totalfee",
						"balanceamount","balanceableamount","agentrate","agent", "balancetime", "balanceby", 
						"status","id", "packprice","orgname" }, packDao.qryPackBalance(
						departinvoicesno, senddepartdate, sendenddate, status,
						ids,vehicleid,orgid), new Object[] { Date.class, String.class,
						String.class, long.class, BigDecimal.class,BigDecimal.class,BigDecimal.class,
						BigDecimal.class, BigDecimal.class,BigDecimal.class,
						String.class,String.class, String.class, long.class,
						BigDecimal.class,String.class });
		return result;
	}

	public int transferPack(Global global, Pack pack) throws ServiceException {
		// String sql =
		// "update pack p set p.consignee='"+pack.getConsignee()+"',p.tostationid='"+pack.getTostationid()+"',p.transitfee='"+pack.getTransitfee()+"' where p.id = "+pack.getId()+"";
		int count = 0;
		try {
			usertransaction.begin();
			if (pack.getSynccode() == null) {
				Pack pack2 = packDao.getEntityManager().find(Pack.class,
						pack.getId());
				if (pack2 != null) {
					StringBuffer sql = new StringBuffer(
							"update pack p set p.consignee='");
					sql.append(pack.getConsignee())
							.append("',p.zhuanyuntostationid='")
							.append(pack.getZhuanyuntostationid())
							.append("',p.transitfee='")
							.append(pack.getTransitfee())
							.append("',p.status='7").append("', p.updateby='")
							.append(pack.getUpdateby())
							.append("', p.updatetime = sysdate ")
							.append(" where p.id = ").append(pack.getId());
					Query query = JPA.em().createNativeQuery(sql.toString());
					count = query.executeUpdate();
				}
			}
			usertransaction.commit();
		} catch (SystemException e) {
			try {
				usertransaction.rollback();
			} catch (SystemException e1) {
				e1.printStackTrace();
			}
			play.Logger.error(e.getMessage(), e);
		}
		return count;
	}

	@Override
	public String qryBalanceByNo(String departinvoicesno, int tflag) {
		if (tflag == 1) {
			Packdepartinvoices ba = (Packdepartinvoices) packDao
					.qryBalanceByNo(departinvoicesno, tflag);
			if (ba == null) {
				return "没有该结算单信息！";
			} else {
				PackBalance pb = packDao.qryPackBalanceByid(ba
						.getPackbalanceid());
				return "该结算单已经结算，结账日期为:" + pb.getBalancetime() + ",单号为："
						+ pb.getPackbalanceno();
			}
		} else {
			Packarriver ba = (Packarriver) packDao.qryBalanceByNo(
					departinvoicesno, tflag);
			if (ba == null) {
				return "没有该结算单信息！";
			} else {
				PackBalance pb = packDao.qryPackBalanceByid(ba
						.getPackbalanceid());
				/*
				 * Packdepartinvoices pdi =
				 * packDao.qryPackdepartinvoicesByNo(departinvoicesno);
				 * pdi.setStatus("3"); packDao.merge(pdi); try {
				 * usertransaction.commit(); } catch (SystemException e) {
				 * e.printStackTrace(); }
				 */
				return "该结算单已经结算，结账日期为:" + pb.getBalancetime() + ",单号为："
						+ pb.getPackbalanceno();
			}
		}
	}

	/**
	 * 注销
	 */
	public boolean canclePackBalance(long packarriverid, int tflag, long packdepartinvoiceid, Global global) {
		Date now = new Date();
		if (tflag == 0) {
			List<Packarriver> list = packDao.qryPackArriveById(packarriverid+"");
			Packarriver p  =  list.get(0);
			PackBalance pb = packDao.qryPackBalanceByid(p
					.getPackbalanceid());
			pb.setStatus("1");
			p.setStatus("1");
			p.setUpdateby(global.getUserinfo().getId());
			p.setUpdatetime(now);
			packDao.merge(p);
			packDao.merge(pb);
			
			return true;
		}else{
			List<Packdepartinvoices> list = packDao.qryPackdepartinvoicesById(packdepartinvoiceid+"");
			Packdepartinvoices p  =  list.get(0);
			PackBalance pb = packDao.qryPackBalanceByid(p
					.getPackbalanceid());
			pb.setStatus("1");
			p.setStatus("1");
			p.setUpdateby(global.getUserinfo().getId());
			p.setUpdatetime(now);
			packDao.merge(p);
			packDao.merge(pb);
			return true;
		}
	}

	@Override
	public List<Map<String, Object>> adjustPackinfo(Global global,Date startdate, Date enddate, long scheduleid) {
		// TODO Auto-generated method stub		
		List<Object> packlist = packDao.findPackInfoByscheduleid(startdate,enddate,scheduleid);
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String daystr = parameterService.findParamValue(ParamterConst.Param_9044, global.getUserinfo().getOrgid());
		List list = new ArrayList();
		if (packlist != null) {
			for(Object objpack:packlist){
				Object[] obj = (Object[])objpack; 
				String status = obj[0].toString();			
				try {
					Date signdate = sf.parse(obj[1].toString());
					Date nowDate = new Date(System.currentTimeMillis() -Integer.parseInt(daystr)*24* 60 * 60 * 1000); //7代表回收款天数					
					if(nowDate.compareTo(signdate)>0&& !(status.equals("3")||status.equals("5"))){//超过回收款天数并且又没有作废或退票
						list.add(1);
						return ListUtil.listToMap(new Object[] { "result" },list, new Object[] { int.class});
					}								
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}			
			}		
		}
		list.add(0);
		return ListUtil.listToMap(new Object[] { "result" },list, new Object[] { int.class});
	}

	public List<Map<String, Object>> queryPackBalanced(Date senddepartdate,
			Date sendenddate, String status, String packbalanceno, String datatype, String unitid) {
		List<Map<String, Object>> result = ListUtil
				.listToMap(new Object[] { "packbalanceno","datatype","pieces","packnos","packmoney",
						"packprice","packbalancemoney","balancby" ,"balancetime", "cancelby","cleartime","status","id"						
				}, packDao.queryPackBalanced
						(senddepartdate,sendenddate,status,packbalanceno,datatype,unitid), 
						new Object[] {String.class, String.class,long.class,long.class,BigDecimal.class,
					BigDecimal.class,BigDecimal.class,String.class,Date.class,String.class,Date.class,String.class,long.class
				});
		return result;
	}
	
	public List<Map<String, Object>> qryDetail(Long packbalanceid) {
		List<Map<String, Object>> result = ListUtil
				.listToMap(new Object[] {
						"pdate","pno","station","pieces","packfee","packprice","balanceamount","datatype"
				}, packDao.qryDetail(packbalanceid), 
						new Object[] {
					Date.class,String.class,String.class,long.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,String.class
				});
		return result;
	}
	
	public boolean cancelPackBalanced(Long packbalanceid, Global global) {
		Date now = new Date();
		PackBalance packbalance = packDao.qryPackBalanceByid(packbalanceid);
		packbalance.setStatus("1");
		packbalance.setCancelby(global.getUserinfo().getId());
		packbalance.setCleartime(now);
		packbalance.setCancelip(global.getIpAddress());
		if(packbalance.getDatatype().equals("0")){
			List<Packarriver> list = packDao.qryPackarriverByPackbalanceid(packbalanceid);
			for (Packarriver pa : list) {
				pa.setStatus("0");
				pa.setUpdateby(global.getUserinfo().getId());
				pa.setUpdatetime(now);
				pa.setPackbalanceid(0);
				packDao.merge(pa);
			}
		}else{
			List<Packdepartinvoices> list = packDao.qryPackdepartinvoicesByPackbalanceid(packbalanceid);
			for (Packdepartinvoices pa : list) {
				pa.setStatus("0");
				pa.setUpdateby(global.getUserinfo().getId());
				pa.setUpdatetime(now);
				pa.setPackbalanceid(0);
				packDao.merge(pa);
			}
		}
		PackBalance merge = (PackBalance) packDao.merge(packbalance);
			
		return true;
	}
	
	public List<Map<String, Object>> qryPackMonthBalance(List<PropertyFilter> buildFromHttpRequest){
		List<Map<String, Object>> result = ListUtil
		.listToMap(new Object[] { "departdate","packdepartinvoicesother","packdepartinvoices","totalfee"}, 
				packDao.qryPackMonthBalance(buildFromHttpRequest),
				new Object[] {Date.class,BigDecimal.class,BigDecimal.class,BigDecimal.class  });
		return result;

		
	}
	
	@Override
	public List<Map<String, Object>> qryPackDayBalance(
			List<PropertyFilter> propertyFilters) {
	
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"datatype", "departinvoicesno", "balanceamount", "shenhejine",
				"isaudit"},
				packDao.qryPackDayBalance(propertyFilters),
				new Object[] {String.class,String.class, BigDecimal.class, BigDecimal.class,Boolean.class });
		
		return result;
	}

	public Packdepartinvoices qryPackDayBalancequery(Packdepartinvoices packdepartinvoices) {
				packdepartinvoices=packDao.qryPackdepartinvoicesByNo(packdepartinvoices.getDepartinvoicesno());
		return packdepartinvoices;
	}

	@Override
	public boolean packDayBalanceaudit(Global global,
			Packdepartinvoices packdepartinvoices) {
		if(packdepartinvoices != null){
			packdepartinvoices.setIsaudit(true);
			packdepartinvoices.setUpdateby(global.getUserinfo().getId());
			packdepartinvoices.setUpdatetime(new Date());
			packdepartinvoices.setSellby(global.getUserinfo().getId());
			packdepartinvoices.setAudittime(new Date());
		}
		packdepartinvoices=(Packdepartinvoices) packDao.merge(packdepartinvoices);
		return packdepartinvoices.isIsaudit();
	}

	public PacktturnoverdetailService getService() {
		return service;
	}

	public void setService(PacktturnoverdetailService service) {
		this.service = service;
	}
}
