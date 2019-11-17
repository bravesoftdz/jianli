package cn.nova.bus.insure.service.impl;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import play.db.jpa.JPA;
import util.AppConstant;
import util.JsonUtil;
import util.RpcUtil;
import util.SecretClientUtil;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.base.dao.InsuretypeDao;
import cn.nova.bus.base.model.Insurancetypefares;
import cn.nova.bus.base.model.Insurers;
import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.base.model.Insuretypedetail;
import cn.nova.bus.base.model.Insuretypedistance;
import cn.nova.bus.base.model.Platforminsurancetype;
import cn.nova.bus.base.model.Platforminsureorder;
import cn.nova.bus.base.model.Platforminsureorderdetail;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.dao.InsuranceDao;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.model.InsuranceOrder;
import cn.nova.bus.insure.model.InsurancePrintInfo;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsuranceSellService;
import cn.nova.bus.insure.vo.InsuranceAppntMan;
import cn.nova.bus.insure.vo.InsuranceInfoVO;
import cn.nova.bus.insure.vo.InsuredMan;
import cn.nova.bus.insure.vo.Insureno;
import cn.nova.bus.insure.vo.InsurenoStatus;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.log.service.OperationLogService;
import cn.nova.bus.log.service.impl.OperationLogServiceImpl;
import cn.nova.bus.sale.dao.TicketDao;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.service.impl.Insureinfo;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;


public class InsuranceSellServiceImpl implements InsuranceSellService {

	private IDAO dao = new EntityManagerDaoSurport();	// @EJB
	// private ParameterService parameterService;
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private InsuranceDao insuranceDao = new InsuranceDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();

	private OperationLogService operationLogService = new OperationLogServiceImpl();

	private static final String JJINSURANCEBATCHNO = "777";
	
	private static final String sellorgcode = AppConstant.getValue("insurance.orgcode");
	private static final String callorgcode = AppConstant.getValue("insurance.callorgcode");
	private static final String url = AppConstant.getValue("insurance.url");
	private static final String privatekey = AppConstant.getValue("insurance.privatekey");
	private static final String md5key = AppConstant.getValue("insurance.md5key");

	private static String PARAM2626 = null;
	@Override
	public List<Map<String, Object>> findTicket(
			List<PropertyFilter> propertyFilters,int isnet) {
		return insuranceDao.findTicket(propertyFilters,isnet);
	}

	@Override
	public MethodResult sell(InsuranceOrder order,int isnet) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		Long insuranceno = new Long(order.getStartTicketNO());
		try {
			Billinuse billinuse = billinuseService.jumpBillinuse(
					order.getSeller(), "Insure", order.getStartTicketNO(),
					order.getInsurances().size());
			Billinventory billinventory = (Billinventory) dao.get(
					Billinventory.class, billinuse.getBillinventoryid());
			// 插入或修改应缴款表
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(now);
			calendar.set(calendar.get(Calendar.YEAR),
					calendar.get(Calendar.MONTH),
					calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
			propertyFilters.add(new PropertyFilter("EQD_t!moneydate", calendar
					.getTime()));
			propertyFilters.add(new PropertyFilter("EQL_t!seller", order
					.getSeller()));
			List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(
					Insuranceturnoverdetail.class, propertyFilters);
			boolean neednew = true;
			Insuranceturnoverdetail insuranceturnoverdetail = null;
			if (insuranceturnoverdetails != null
					&& insuranceturnoverdetails.size() > 0) {
				for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
					if (new Long(_ticketturnoverdetail.getTicketendno())
							.longValue() + 1L == new Long(
							order.getStartTicketNO()).longValue()) {
						insuranceturnoverdetail = _ticketturnoverdetail;
						neednew = false;
						break;
					}
				}
				if (neednew) {
					for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
						if ("0".equals(_ticketturnoverdetail.getTicketstartno())) {
							insuranceturnoverdetail = _ticketturnoverdetail;
							neednew = false;
							break;
						}
					}
				}
			}
			if (neednew) {
				insuranceturnoverdetail = new Insuranceturnoverdetail();
				insuranceturnoverdetail.setMoneypayable(new BigDecimal(0));
				insuranceturnoverdetail.setSellmoney(new BigDecimal(0));
				insuranceturnoverdetail.setSellnum(0);
				insuranceturnoverdetail.setUpdateby(order.getSeller());
				insuranceturnoverdetail.setUpdatetime(now);
				insuranceturnoverdetail.setCancelnum(0);
				insuranceturnoverdetail.setCancelmoney(new BigDecimal(0));
				insuranceturnoverdetail
						.setNonvouchermoneypayable(new BigDecimal(0));
				insuranceturnoverdetail.setNoncashmoney(new BigDecimal(0));
				insuranceturnoverdetail.setNoncashnum(0);
				insuranceturnoverdetail.setCreateby(order.getSeller());
				insuranceturnoverdetail.setCreatetime(now);
				insuranceturnoverdetail.setEticketnum(0);
				insuranceturnoverdetail.setMoneydate(now);
				insuranceturnoverdetail.setReturnhandcharge(new BigDecimal(0));
				insuranceturnoverdetail.setReturnmoney(new BigDecimal(0));
				insuranceturnoverdetail.setReturnnum(0);
				insuranceturnoverdetail.setSeller(order.getSeller());
				insuranceturnoverdetail.setTicketstartno(order
						.getStartTicketNO());
				insuranceturnoverdetail.setTicketturnover(null);
				insuranceturnoverdetail.setTurnovertime(null);
				insuranceturnoverdetail.setIsturnover(false);
				insuranceturnoverdetail.setEreturncharge(new BigDecimal(0));//电子退保险手续费
				insuranceturnoverdetail.setEreturnmoney(new BigDecimal(0));//电子退保险手续费
				insuranceturnoverdetail.setEreturnnum(0);//电子退保险数
				insuranceturnoverdetail.setEreturnbackmoney(new BigDecimal(0));
				insuranceturnoverdetail.setEreturnbacknum(0);
				insuranceturnoverdetail.setNoncashmoneypayable(BigDecimal.ZERO);
				insuranceturnoverdetail.setMoney(BigDecimal.ZERO);
				insuranceturnoverdetail.setLost(BigDecimal.ZERO);
			}
			if ("0".equals(insuranceturnoverdetail.getTicketstartno())) {
				insuranceturnoverdetail.setTicketstartno(order
						.getStartTicketNO());
			}
			insuranceturnoverdetail.setTicketendno(StringUtils.strPad(new Long(
					insuranceno + order.getInsurances().size() - 1).toString(),
					order.getStartTicketNO().length(), "0"));
			insuranceturnoverdetail.setUpdateby(order.getSeller());
			insuranceturnoverdetail.setUpdatetime(now);
			insuranceturnoverdetail = (Insuranceturnoverdetail) dao
					.merge(insuranceturnoverdetail);

			Map<InsurancePrintInfo, Insurance> insurances = new HashMap<InsurancePrintInfo, Insurance>();
			insuranceno = insuranceno - 1;
			//根据系统参数2626判断取客运站合作保险票种或者是保险服务器保险产品
			String param2626 = parameterService.findParamValue(ParamterConst.Param_2626,order.getOrgid());
			String departCode = "";
			String reacheCode = "";
			Date sellTime = null;
			String orderNo = "";
			long insureorderid = 0l;
			Date currentTime = new Date();
			boolean isPlatform = true;  
			Ticketsell ticketsell = null;
			Ticketsellagent ticketsellagent=null;
			for (InsurancePrintInfo detail : order.getInsurances()) {
				if (!detail.getIssell()) {
					continue;
				}
								
				// 检查售票记录
				System.out.println("detail.getSellid()="+detail.getSellid());
				TicketDao ticketDao = new TicketDao();
				if(isnet==0){  //0不联网
					//通过 scheduleplanid和seatno 查询该车票是否为改签车票，若是改签车票则获取改签后新票对象
					ticketsell = ticketDao.qryChangeTicketsell(detail.getScheduleplanid(), detail.getSeatno());
					
					if(ticketsell == null){
						ticketsell = (Ticketsell) dao.get(Ticketsell.class,
								detail.getSellid());
					}
					
					if (ticketsell != null) {
						if (!"0".equals(ticketsell.getTicketstatus())) {
							if ("1".equals(ticketsell.getTicketstatus())) {
								throw new BusinessException("对应车票已经退票,不能售保险");
							} else if ("2".equals(ticketsell.getTicketstatus())) {
								throw new BusinessException("对应车票已经废票,不能售保险");
							} else {
								throw new BusinessException("对应车票状态未知,不能售保险");
							}
						}
						if (ticketsell.getIschecked()) {
							throw new BusinessException("该车票已检票，不能再售保险");
						}
					} else {
						throw new BusinessException("对应车票不存在,不能售保险");
					}
				}else if(isnet==1){  //1本集团联网
					ticketsellagent = (Ticketsellagent) dao.get(Ticketsellagent.class,
							detail.getSellid());
					if (ticketsellagent != null) {
						if (!"0".equals(ticketsellagent.getTicketstatus())) {
							if ("1".equals(ticketsellagent.getTicketstatus())) {
								throw new BusinessException("对应车票已经退票,不能售保险");
							} else if ("2".equals(ticketsellagent.getTicketstatus())) {
								throw new BusinessException("对应车票已经废票,不能售保险");
							} else {
								throw new BusinessException("对应车票状态未知,不能售保险");
							}
						}
						
					} else {
						throw new BusinessException("对应车票不存在,不能售保险");
					}
				}				
				// 检查是否已经售保险
				propertyFilters.clear();
				propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule",
						detail.getIsselfschedule()));
				propertyFilters.add(new PropertyFilter("EQL_t!sellid", detail
						.getSellid()));
				Insurance insurance = (Insurance) dao.uniqueResult(
						LockModeType.PESSIMISTIC_READ, Insurance.class,
						propertyFilters);
				if (insurance != null) {
					if ("0".equals(insurance.getInsurancestatus())) {
						throw new BusinessException("对应车票已经售出保险,不允许重复销售保险");
					}
				}
				//平台售票信息获取
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626) && isPlatform){
					List<Object[]> platforminfoList = insuranceDao.getPlatformInfo(detail.getSellid());
					if(platforminfoList.size()>0){
						Object[] platformin = platforminfoList.get(0);
						departCode =  (String) platformin[2];
						reacheCode = (String)  platformin[3];
						sellTime =  (Date)  platformin[1];
						orderNo = (String) platformin[0];
					}
				}
				insuranceturnoverdetail.setSellnum(insuranceturnoverdetail
						.getSellnum() + 1);
				insuranceturnoverdetail.setMoneypayable(insuranceturnoverdetail
						.getMoneypayable().add(detail.getPremium()));
				insuranceturnoverdetail.setSellmoney(insuranceturnoverdetail
						.getSellmoney().add(detail.getPremium()));
				// 0现金、1银联卡、2贵客卡余额、3贵客卡积分、4支付宝、5微信
				if ("1".equals(detail.getPaymethod()) || "4".equals(detail.getPaymethod()) || "5".equals(detail.getPaymethod())
						 || "10".equals(detail.getPaymethod()) || "11".equals(detail.getPaymethod())) {
					insuranceturnoverdetail
							.setNoncashmoney(insuranceturnoverdetail
									.getNoncashmoney().add(detail.getPremium()));
					insuranceturnoverdetail
							.setNoncashnum(insuranceturnoverdetail
									.getNoncashnum() + 1);
					insuranceturnoverdetail.setNoncashmoneypayable(insuranceturnoverdetail.getNoncashmoneypayable().add(detail.getPremium()));
				}
				if ("2".equals(detail.getPaymethod())
						|| "3".equals(detail.getPaymethod())) {
					insuranceturnoverdetail
							.setNonvouchermoneypayable(insuranceturnoverdetail
									.getNonvouchermoneypayable().add(
											detail.getPremium()));
				}
				Customer customer=null;
				insurance = new Insurance();
				insurance.setCreateby(order.getSeller());
				insurance.setCreatetime(now);
				if(detail.getCustomerid()==null || detail.getCustomerid()==0){
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!certificateno",
							detail.getCertificateno()));
					propertyFilters.add(new PropertyFilter("EQS_t!certificatetype", detail
							.getCertificatetype()));
					customer = (Customer) dao.uniqueResult(Customer.class,propertyFilters);
					if(customer!=null){
						insurance.setCustomerid(customer.getId());
					}
				}else{
					insurance.setCustomerid(detail.getCustomerid());
					customer = (Customer) dao.get(Customer.class,detail.getCustomerid());
				}
				if(customer!=null){
					if(isnet==0){
						if(ticketsell!=null){
							ticketsell.setCustomer(customer);
							ticketsell = (Ticketsell) dao.merge(ticketsell);
						}
					}else if(isnet==1){
						if(ticketsellagent!=null){
							ticketsellagent.setCustomer(customer);
							ticketsellagent = (Ticketsellagent) dao.merge(ticketsellagent);
						}
					}
				}					
				insuranceno = insuranceno + 1;
				insurance.setInsuranceno(StringUtils.strPad(insuranceno
						.toString(), order.getStartTicketNO().length(), "0"));
				detail.setInsuranceno(insurance.getInsuranceno());
				insurance.setInsurancestatus("0");
				insurance.setInsureamount(detail.getInsureamount());
				insurance.setInsurersid(detail.getInsurersid());
				insurance.setInsuretypeid(detail.getInsuretypeid());
				
				if(isnet==0){
					insurance.setIsselfschedule(detail.getIsselfschedule());
				}else if(isnet==1){
					insurance.setIsselfschedule(false);
				}				
				
				insurance.setOrgid(order.getOrgid());
				insurance.setOrderno(order.getOrderno());
				insurance.setPaymethod(detail.getPaymethod());
				insurance.setPremium(detail.getPremium());
				insurance.setSellid(detail.getSellid());
				insurance.setSellby(order.getSeller());
				insurance.setSellip(order.getIp());
				insurance.setSelltime(now);
				detail.setSelltime(now);
				insurance.setSellway(order.getSellway());
				insurance.setTicketoutletsid(order.getTicketoutletsid());
				insurance.setUpdateby(order.getSeller());
				insurance.setUpdatetime(now);
				insurance.setBatchno(billinventory.getBatchno());
				insurance.setTurnoverdetailid(insuranceturnoverdetail.getId());
				insurance = (Insurance) dao.merge(insurance);
				detail.setId(insurance.getId());
				//查询险种表信息
				InsuretypeDao insuretypedao = new InsuretypeDao();
				if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
					Insuretype insuretype = (Insuretype) dao.get(Insuretype.class, detail.getInsuretypeid());
					propertyFilters.clear();
					propertyFilters.add(new PropertyFilter("EQS_t!varcode",insuretype.getCode()));
					Platforminsurancetype platforminsurancetype = (Platforminsurancetype) dao.uniqueResult(Platforminsurancetype.class,propertyFilters);
					if(platforminsurancetype!=null){
						detail.setEmmoney(platforminsurancetype.getDieinsureamount());
						detail.setEmmoney(platforminsurancetype.getMedicalinsureamount());
					}
					//创建平台保险订单以及订单详情
					if(isPlatform){
						Platforminsureorder iorder = new Platforminsureorder();
						iorder.setOrderno(orderNo);
						iorder.setCreatetime(currentTime);
						iorder.setCreateby(order.getSeller());
						iorder.setUpdatetime(currentTime);
						iorder.setUpdateby(order.getSeller());
						iorder.setStatus(1);//1-申请售保2-投保成功3-投保失败
						
						iorder.setIssuingtype(2);//出单方式1-电子 2-纸质  站务平台默认为纸质类型
						iorder.setSellorgcode(sellorgcode);//售保机构代码
						iorder=(Platforminsureorder) dao.merge(iorder);
						insureorderid = iorder.getId();
						isPlatform = false;
					}
					Platforminsureorderdetail idetail = new Platforminsureorderdetail();
					idetail.setInsureorderid(insureorderid);
					idetail.setInsuranceid(insurance.getId());
					idetail.setDepartcode(departCode);
					idetail.setReachcode(reacheCode);
					idetail.setSelltickettime(sellTime);
					//idetail.setInsureno(detail.getInsuranceno());
					idetail.setInsureticketno(detail.getInsuranceno());
					idetail.setDepartname(detail.getDepartstationname());
					idetail.setReachname(detail.getReachstationname());
					idetail.setTicketno(detail.getTicketno());
					idetail.setInsureid(platforminsurancetype.getId());
					idetail.setRangkm(new BigDecimal(detail.getDistance()));
					idetail.setPremium(detail.getPremium());
					idetail.setDepartdate(DateUtils.formatDate(detail.getDepartdate()));
					idetail.setDeparttime(detail.getDeparttime()+":00");
					idetail.setSchedulecode(detail.getSchedulecode());
					idetail.setSeatno(new Short(detail.getSeatno()).toString());
					idetail.setPassengername(detail.getCustomername());
					//票价
					Ticketsell ts = (Ticketsell) dao.get(Ticketsell.class,detail.getSellid() );
					if(ts!=null && ts.getPrice()!=null){
						idetail.setPrice(ts.getPrice());
					}
					if("0".equals(detail.getCertificatetype())){
						idetail.setIdtype(1);
					}else if("1".equals(detail.getCertificatetype())){
						idetail.setIdtype(3);
					}else if("2".equals(detail.getCertificatetype())){
						idetail.setIdtype(2);
					}else if("2".equals(detail.getCertificatetype())){
						idetail.setIdtype(2);
					}
					idetail.setIdnum(detail.getCertificateno());
					idetail.setStatus(1);//售保状态1-申请售保2-售保成功4-退保申请5-退保成功
					dao.merge(idetail);
				}else{
					Insuretype insuretype = insuretypedao.getInsuretype(detail.getInsuretypeid());
					detail.setEmoney(insuretype.getEmoney());  //打印模板InsurancePrintInfo的意外伤害保险金额
					detail.setEmmoney(insuretype.getEmmoney()); //打印模板InsurancePrintInfo的意外伤害保险金额
				}
				SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				detail.setReprintdatetime(  sf.format(insurance.getCreatetime())  ); //打印模板InsurancePrintInfo的保险票出票时间
				insurances.put(detail, insurance);
			}
			insuranceturnoverdetail = (Insuranceturnoverdetail) dao
					.merge(insuranceturnoverdetail);
			
			methodResult.setResult(MethodResult.SUCCESS);
			methodResult.setObject(order.getInsurances());
		} catch (Exception e) {
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
			//context.setRollbackOnly();
			JPA.em().getTransaction().rollback();
			play.Logger.error(e.getMessage(), e);
		}
		return methodResult;
	}

	/**
	 * 
	 * uploadInsurance方法：上报保险销售数据<br/>
	 * <br/>
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public void uploadInsurance() {
		SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
		Date selldate = new Date();
	//	Date fromdate = new Date();		
		//Date todate = new Date();
		try {
			//selldate = sf.parse(sf.format(new Date()));//sf.parse("2013-02-20");
			selldate = sf.parse("2013-02-20");
		//	todate = sf.parse("2013-03-29");
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		//selldate=DateUtils.add(selldate,-3);
		//while (fromdate.before(todate)) {
			//selldate = fromdate;

			System.out.println("selldate>=" + selldate);
			List<Object> inlist = insuranceDao.qryInsurance(selldate);
			int upcount = 0;
			int noupcount = 0;
			for (Object obj : inlist) {
				Object[] insr = (Object[]) obj;
				String planname = insr[0].toString();
				String bankCode = insr[1].toString();
				String productCode = insr[2].toString();
				String fullname = insr[3].toString();
				String govtID = insr[4].toString();
				String departdate = insr[5].toString();
				String selladdress = insr[6].toString();
				String retureaddress = insr[7].toString();
				long insuranceid = new Long(insr[8].toString());
				Insureinfo info = new Insureinfo(planname, bankCode,
						productCode, fullname, govtID, departdate, selladdress,
						retureaddress);
				if (!info.request(info.toRequestXML())){
					// 保存操作日志
					Operationlog operationLog = new Operationlog();
					operationLog.setIp("127.0.0.1");
					String content = "保险上传连接超时";
					operationLog.setContent(content);
					operationLog.setModule("上报保险数据合计信息");
					operationLog.setOperatetime(new Date());
					operationLog.setOperation("上报数据");
					operationLog.setSessionid("无session");
					operationLog.setUserid(new Long(0));
					operationLogService.savelog(operationLog);					
					break;
				}
				if (info.getResultCode().equals("1")) {
					Insurance ins = insuranceDao.get(Insurance.class,
							insuranceid);
					ins.setPolnumber(info.getPolNumber());
					ins.setUpdatetime(new Date());
					dao.merge(ins);
					upcount++;
				} else {
					Insurance ins = insuranceDao.get(Insurance.class,
							insuranceid);
					ins.setPolnumber("-1");
					ins.setUpdatetime(new Date());
					dao.merge(ins);
					// 保存操作日志
					Operationlog operationLog = new Operationlog();
					operationLog.setIp("127.0.0.1");
					String content = "售保险表的id=" + insuranceid + "调用保险上传时失败:"
							+ info.getResultInfoDesc();
					operationLog.setContent(content);
					operationLog.setModule("上报保险数据");
					operationLog.setOperatetime(new Date());
					operationLog.setOperation("上报数据");
					operationLog.setSessionid("无session");
					operationLog.setUserid(new Long(0));
					operationLogService.savelog(operationLog);
					noupcount++;
				}

			}
			// 保存操作日志
			Operationlog operationLog = new Operationlog();
			operationLog.setIp("127.0.0.1");
			String content = "销售日期:" + selldate + ",本次总共上报保险数据:"
					+ inlist.size() + "条记录,成功上报:" + upcount + "条记录,失败:"
					+ noupcount + "条记录";
			operationLog.setContent(content);
			operationLog.setModule("上报保险数据合计信息");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation("上报数据");
			operationLog.setSessionid("无session");
			operationLog.setUserid(new Long(0));
			operationLogService.savelog(operationLog);
			//fromdate = DateUtils.add(fromdate, 1);
		//}
	}

	public void setInsuranceDao(InsuranceDao insuranceDao) {
		this.insuranceDao = insuranceDao;
	}

	public InsuranceDao getInsuranceDao() {
		return insuranceDao;
	}



	@Override
	public MethodResult JJPreSell(String ticketno, String certificateno,
			String customername, String insuranceno, String insuretypecode) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		// 九江模式的售保人就是售票人 根据票号取出售票信息
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!ticketno", ticketno));
		propertyFilters.add(new PropertyFilter("GED_t!departdate", DateUtils
				.add(now, -2)));
		Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class,
				propertyFilters);
		if (ticketsell != null) {
			if (!"0".equals(ticketsell.getTicketstatus())) {
				if ("1".equals(ticketsell.getTicketstatus())) {
					throw new BusinessException("对应车票已经退票,不能售保险");
				} else if ("2".equals(ticketsell.getTicketstatus())) {
					throw new BusinessException("对应车票已经废票,不能售保险");
				} else {
					throw new BusinessException("对应车票状态未知,不能售保险");
				}
			}
			if (ticketsell.getIschecked()) {
				throw new BusinessException("该车票已检票，不能再售保险");
			}
		} else {
			throw new BusinessException("对应车票不存在,不能售保险");
		}
		// 检查是否已经售保险
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isselfschedule", true));
		propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell
				.getId()));
		Insurance insurance = (Insurance) dao
				.uniqueResult(LockModeType.PESSIMISTIC_READ, Insurance.class,
						propertyFilters);
		if (insurance != null) {
			if ("0".equals(insurance.getInsurancestatus())) {
				throw new BusinessException("对应车票已经售出保险,不允许重复销售保险");
			}
		}
		// 取出险种类型
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!code", insuretypecode));
		Insuretype insuretype = (Insuretype) dao.uniqueResult(Insuretype.class,
				propertyFilters);
		if (insuretype == null) {
			throw new BusinessException("找不到险种：" + insuretypecode);
		}

		Customer customer = null;
		if (certificateno != null && !certificateno.trim().equals("")
				&& customername != null && !customername.trim().equals("")) {
			// 取出或保存乘客信息
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQS_t!certificateno",
					certificateno));
			propertyFilters
					.add(new PropertyFilter("EQS_t!certificatetype", "0"));
			customer = (Customer) dao.uniqueResult(Customer.class,
					propertyFilters);
			if (customer == null) {
				customer = new Customer();
				try {
					Calendar birthdaycal = Calendar.getInstance();
					if (certificateno.length() == 15) {
						birthdaycal.set(Integer.parseInt("19"
								+ certificateno.substring(6, 8)), Integer
								.parseInt(certificateno.substring(8, 10)),
								Integer.parseInt(certificateno
										.substring(10, 12)));
						if (Integer.parseInt(certificateno.substring(14, 15)) % 2 == 0) {
							customer.setSex("男");
						} else {
							customer.setSex("女");
						}
					} else if (certificateno.length() == 18) {
						birthdaycal.set(Integer.parseInt(certificateno
								.substring(6, 10)), Integer
								.parseInt(certificateno.substring(10, 12)),
								Integer.parseInt(certificateno
										.substring(12, 14)));
						if (Integer.parseInt(certificateno.substring(16, 17)) % 2 == 0) {
							customer.setSex("男");
						} else {
							customer.setSex("女");
						}
					}
					customer.setBirthday(DateUtils.trunc(birthdaycal.getTime()));
				} catch (Exception e) {
					customer.setBirthday(null);
					customer.setSex("女");
				}

				customer.setCertificateno(certificateno);
				customer.setCertificatetype("0");
				customer.setCreateby(ticketsell.getSellby());
				customer.setCreatetime(now);
				customer.setEducation(null);
				customer.setEmail(null);
				customer.setFamilyaddress(null);
				customer.setFamilyphone(null);
				customer.setInputway("0");
				customer.setIsactive(true);
				customer.setIslocaldelete(false);
				customer.setLastbuytickettime(now);
				customer.setMobilephone(null);
				customer.setName(customername);
				customer.setOrgid(ticketsell.getOrgid());
				customer.setRemarks(null);
				customer.setSynccode(null);
				customer.setTicketoutletsid(ticketsell.getTicketoutletsid());
				customer.setUpdateby(ticketsell.getSellby());
				customer.setUpdatetime(now);
			} else if (!customer.getName().equals(customername)) {
				customer.setName(customername);
			}
			customer = (Customer) dao.merge(customer);
		} else {
			customer = (Customer) dao.get(Customer.class, 1L); // 取默认顾客
		}

		try {
			// 插入或修改应缴款表
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
			Calendar calendar = Calendar.getInstance();
			calendar.setTime(now);
			calendar.set(calendar.get(Calendar.YEAR),
					calendar.get(Calendar.MONTH),
					calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
			propertyFilters.add(new PropertyFilter("EQD_t!moneydate", calendar
					.getTime()));
			propertyFilters.add(new PropertyFilter("EQL_t!seller", ticketsell
					.getSellby()));
			List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(
					Insuranceturnoverdetail.class, propertyFilters);
			boolean neednew = true;
			Insuranceturnoverdetail insuranceturnoverdetail = null;
			if (insuranceturnoverdetails != null
					&& insuranceturnoverdetails.size() > 0) {
				for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
					if (new Long(_ticketturnoverdetail.getTicketendno())
							.longValue() + 1L == Long.parseLong(insuranceno)) {
						insuranceturnoverdetail = _ticketturnoverdetail;
						neednew = false;
						break;
					}
				}
				if (neednew) {
					for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
						if ("0".equals(_ticketturnoverdetail.getTicketstartno())) {
							insuranceturnoverdetail = _ticketturnoverdetail;
							neednew = false;
							break;
						}
					}
				}
			}
			if (neednew) {
				insuranceturnoverdetail = new Insuranceturnoverdetail();
				insuranceturnoverdetail.setMoneypayable(new BigDecimal(0));
				insuranceturnoverdetail.setSellmoney(new BigDecimal(0));
				insuranceturnoverdetail.setSellnum(0);
				insuranceturnoverdetail.setUpdateby(ticketsell.getSellby());
				insuranceturnoverdetail.setUpdatetime(now);
				insuranceturnoverdetail.setCancelnum(0);
				insuranceturnoverdetail.setCancelmoney(new BigDecimal(0));
				insuranceturnoverdetail
						.setNonvouchermoneypayable(new BigDecimal(0));
				insuranceturnoverdetail.setNoncashmoney(new BigDecimal(0));
				insuranceturnoverdetail.setNoncashnum(0);
				insuranceturnoverdetail.setCreateby(ticketsell.getSellby());
				insuranceturnoverdetail.setCreatetime(now);
				insuranceturnoverdetail.setEticketnum(0);
				insuranceturnoverdetail.setMoneydate(now);
				insuranceturnoverdetail.setReturnhandcharge(new BigDecimal(0));
				insuranceturnoverdetail.setReturnmoney(new BigDecimal(0));
				insuranceturnoverdetail.setReturnnum(0);
				insuranceturnoverdetail.setSeller(ticketsell.getSellby());
				insuranceturnoverdetail.setTicketstartno(insuranceno);
				insuranceturnoverdetail.setTicketturnover(null);
				insuranceturnoverdetail.setTurnovertime(null);
				insuranceturnoverdetail.setIsturnover(false);
			}
			if ("0".equals(insuranceturnoverdetail.getTicketstartno())) {
				insuranceturnoverdetail.setTicketstartno(insuranceno);
			}
			insuranceturnoverdetail.setTicketendno(insuranceno);
			insuranceturnoverdetail.setUpdateby(ticketsell.getSellby());
			insuranceturnoverdetail.setUpdatetime(now);
			insuranceturnoverdetail = (Insuranceturnoverdetail) dao
					.merge(insuranceturnoverdetail);

			insuranceturnoverdetail.setSellnum(insuranceturnoverdetail
					.getSellnum() + 1);
			insuranceturnoverdetail.setMoneypayable(insuranceturnoverdetail
					.getMoneypayable().add(insuretype.getPremium()));
			insuranceturnoverdetail.setSellmoney(insuranceturnoverdetail
					.getSellmoney().add(insuretype.getPremium()));
			// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
			if ("1".equals(ticketsell.getPaymethod())) {
				insuranceturnoverdetail.setNoncashmoney(insuranceturnoverdetail
						.getNoncashmoney().add(insuretype.getPremium()));
				insuranceturnoverdetail.setNoncashnum(insuranceturnoverdetail
						.getNoncashnum() + 1);
			}
			if ("2".equals(ticketsell.getPaymethod())
					|| "3".equals(ticketsell.getPaymethod())) {
				insuranceturnoverdetail
						.setNonvouchermoneypayable(insuranceturnoverdetail
								.getNonvouchermoneypayable().add(
										insuretype.getPremium()));
			}

			insurance = new Insurance();
			insurance.setCreateby(ticketsell.getSellby());
			insurance.setCreatetime(now);
			insurance.setCustomerid(customer.getId());
			insurance.setInsuranceno(insuranceno);
			insurance.setInsurancestatus("0");
			insurance.setInsureamount(insuretype.getMaxinsureamount());
			insurance.setInsurersid(insuretype.getInsurersid());
			insurance.setInsuretypeid(insuretype.getId());
			insurance.setIsselfschedule(true);
			insurance.setOrgid(ticketsell.getOrgid());
			insurance.setPaymethod(ticketsell.getPaymethod());
			insurance.setPremium(insuretype.getPremium());
			insurance.setSellid(ticketsell.getId());
			insurance.setSellby(ticketsell.getSellby());
			insurance.setSellip(ticketsell.getSellip());
			insurance.setSelltime(now);
			insurance.setSellway(ticketsell.getSellway());
			insurance.setTicketoutletsid(ticketsell.getTicketoutletsid());
			insurance.setUpdateby(ticketsell.getSellby());
			insurance.setUpdatetime(now);
			insurance.setBatchno(JJINSURANCEBATCHNO);
			insurance.setTurnoverdetailid(insuranceturnoverdetail.getId());
			insurance = (Insurance) dao.merge(insurance);

			insuranceturnoverdetail = (Insuranceturnoverdetail) dao
					.merge(insuranceturnoverdetail);
			methodResult.setResult(MethodResult.SUCCESS);
			methodResult.setObject(insurance);
		} catch (BusinessException e) {
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
			JPA.em().getTransaction().setRollbackOnly();
			//context.setRollbackOnly();
			play.Logger.error(e.getMessage(), e);
		} catch (Exception e) {
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
			JPA.em().getTransaction().setRollbackOnly();
			//context.setRollbackOnly();
			play.Logger.error(e.getMessage(), e);
		}
		return methodResult;
	}

	@Override
	public MethodResult JJSellCommit(String insuranceno, String polnumber,
									 String bkserial,String validatecode) {
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!batchno",
				JJINSURANCEBATCHNO));
		propertyFilters
				.add(new PropertyFilter("EQS_t!insuranceno", insuranceno));
		Insurance insurance = (Insurance) dao
				.uniqueResult(LockModeType.PESSIMISTIC_READ, Insurance.class,
						propertyFilters);
		if (insurance == null) {
			methodResult.setResultMsg("打不到保单：" + insuranceno);
			return methodResult;
		}
		insurance.setPolnumber(polnumber);
		insurance.setBkserial(bkserial);
		insurance.setValidatecode(validatecode);
		insurance = (Insurance) dao.merge(insurance);
		methodResult.setResult(MethodResult.SUCCESS);
		return methodResult;
	}

	@Override
	public MethodResult JJSellRollback(String insuranceno) {
		// 还原数据
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!batchno",
				JJINSURANCEBATCHNO));
		propertyFilters
				.add(new PropertyFilter("EQS_t!insuranceno", insuranceno));
		Insurance insurance = (Insurance) dao
				.uniqueResult(LockModeType.PESSIMISTIC_READ, Insurance.class,
						propertyFilters);
		if (insurance == null) {
			methodResult.setResultMsg("打不到保单：" + insuranceno);
			return methodResult;
		}

		Insuranceturnoverdetail insuranceturnoverdetail = (Insuranceturnoverdetail) dao
				.get(Insuranceturnoverdetail.class,
						insurance.getTurnoverdetailid());

		try {
			// 插入或修改应缴款表
			if (insuranceno.equals(insuranceturnoverdetail.getTicketendno())) {
				if (insuranceturnoverdetail.getSellnum() == 1) {
					insuranceturnoverdetail.setTicketstartno("0");
					insuranceturnoverdetail.setTicketendno("0");
				} else {
					insuranceturnoverdetail.setTicketendno(StringUtils.strPad(
							new Long(new Long(insuranceno) - 1).toString(),
							insuranceno.length(), "0"));
				}
			}

			insuranceturnoverdetail.setSellnum(insuranceturnoverdetail
					.getSellnum() - 1);
			insuranceturnoverdetail.setMoneypayable(insuranceturnoverdetail
					.getMoneypayable().subtract(insurance.getPremium()));
			insuranceturnoverdetail.setSellmoney(insuranceturnoverdetail
					.getSellmoney().subtract(insurance.getPremium()));
			// 0现金、1银联卡、2贵客卡余额、3贵客卡积分
			if ("1".equals(insurance.getPaymethod())) {
				insuranceturnoverdetail.setNoncashmoney(insuranceturnoverdetail
						.getNoncashmoney().subtract(insurance.getPremium()));
				insuranceturnoverdetail.setNoncashnum(insuranceturnoverdetail
						.getNoncashnum() - 1);
			}
			if ("2".equals(insurance.getPaymethod())
					|| "3".equals(insurance.getPaymethod())) {
				insuranceturnoverdetail
						.setNonvouchermoneypayable(insuranceturnoverdetail
								.getNonvouchermoneypayable().subtract(
										insurance.getPremium()));
			}

			dao.delete(insurance);

			insuranceturnoverdetail = (Insuranceturnoverdetail) dao
					.merge(insuranceturnoverdetail);
			methodResult.setResult(MethodResult.SUCCESS);
		} catch (BusinessException e) {
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
			JPA.em().getTransaction().setRollbackOnly();
			//context.setRollbackOnly();
			play.Logger.error(e.getMessage(), e);
		} catch (Exception e) {
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setResultMsg(e.getMessage());
			JPA.em().getTransaction().setRollbackOnly();
			//context.setRollbackOnly();
			play.Logger.error(e.getMessage(), e);
		}
		return methodResult;
	}
	/**
	 * 查询保险服务器售保险订单号
	 */
	public void autoPlatformSellInsurance(){
		//一：查询保险订单表
		List<Platforminsureorder> orderList = insuranceDao.queryPlatformInsuranceOrder();
		if(orderList.size()>0){
			//二：根据车票订单号向保险服务器获取保险订单号
			for (Platforminsureorder platforminsureorder : orderList) {
				String insuranceno = null;//保险订单号
				Map<String,String> param = new HashMap<String,String>();
				String orderno = platforminsureorder.getOrderno(); 
				if(sellorgcode!=null){
					param.put("sellorgcode", sellorgcode);
				}else{
					play.Logger.error("获取保险订单号时，机构不存在，请配置保险机构:"+",orderno:"+orderno);
					continue;
				}
				param.put("orderno", orderno);
				String data = JsonUtil.parseObject(param);
				Map<String, String> params = new HashMap<String, String>();
				try {
					params = SecretClientUtil.encryptData(privatekey,
							md5key, data);
					params.put("callorgcode", callorgcode);
					//String result = RpcUtil.remoteCall(AppConstant.getValue("insurance.url"), "/getInsuranceno", params);
					String result = RpcUtil.httpPost(url + "/getInsuranceno", 10000, params);
					//如果调用成功
					if(null != result && result.indexOf("<html>") == -1){
						//TODO
						Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
							//JSONUtil.deserialize();
						if(null != resultMap){
							String resultData = resultMap.get("data").toString();
							String resultMd5 = resultMap.get("md5").toString();
							
							SecretClientUtil secretClientUtil = new SecretClientUtil();
							Boolean success = secretClientUtil.decryptData(privatekey,
									md5key, resultData, resultMd5);
							//如果解密成功
							if(success){
								Map<String, Object> dataMap = secretClientUtil.getData();
								String status = (String) dataMap.get("status");
								String message = (String) dataMap.get("message");
								//如果获取成功
								if("0000".equals(status)){
									insuranceno = (String) dataMap.get("insuranceno");//保险订单号
									if(insuranceno!=null && !"".equals(insuranceno)){
										platforminsureorder.setInsuranceno(insuranceno);
										//三 保险服务器售保
										boolean flag = sellplatfromInsurance(platforminsureorder,sellorgcode);
										if(flag){
											platforminsureorder.setStatus(2);//售保成功
											dao.merge(platforminsureorder);
										}
									}else{
										continue;
									}
								}else{
									play.Logger.error("获取保险订单号时，调用保险服务器的获取保险订单号接口获取失败，orgcode:"+sellorgcode+",orderno:"+orderno);
								}
							}else{
								play.Logger.error("获取保险订单号时解密失败，orgcode:"+sellorgcode+",orderno:"+orderno);
							}
						}
					}
					
					
				} catch (Exception e) {
					play.Logger.error(e.getMessage(), e);
					continue;
				}
			}
		}
	}
	/**
	 * 保险服务器售保险
	 * @param platforminsureorder
	 * @param orgcode
	 * @return 
	 * @throws Exception
	 */
	private boolean sellplatfromInsurance(Platforminsureorder platforminsureorder, String orgcode) throws Exception {
		List<Platforminsureorderdetail> detailList = insuranceDao.queryPlatformInsuranceDetail(platforminsureorder.getId());
		String orderno = platforminsureorder.getOrderno();
		if(detailList.size()>0){
			InsuranceAppntMan insuranceAppntMan = new InsuranceAppntMan();
			Platforminsureorderdetail p = detailList.get(0);
			insuranceAppntMan.setOrderno(orderno);
			insuranceAppntMan.setPassengername(p.getPassengername());
			insuranceAppntMan.setIdtype(p.getIdtype());
			insuranceAppntMan.setIdnum(p.getIdnum());
			insuranceAppntMan.setSellorgcode(orgcode);
			insuranceAppntMan.setSellorgname(orgcode);
			insuranceAppntMan.setIssuingtype(platforminsureorder.getIssuingtype());
			insuranceAppntMan.setSelltickettime(util.DateUtils.formatDatetime(p.getSelltickettime()));
			List<InsuredMan> manList = new ArrayList<InsuredMan>();
			for (Platforminsureorderdetail platforminsureorderdetail : detailList) {
				InsuredMan insuredMan = new InsuredMan();
				//insuredMan.setInsureno(platforminsureorderdetail.getInsureno()!=null?platforminsureorderdetail.getInsureno():"");
				insuredMan.setTicketno(platforminsureorderdetail.getTicketno());
				insuredMan.setSeatno(platforminsureorderdetail.getSeatno());
				insuredMan.setInsureid(platforminsureorderdetail.getInsureid());
				insuredMan.setPremium(platforminsureorderdetail.getPremium().doubleValue());
				insuredMan.setDepartdate(platforminsureorderdetail.getDepartdate());
				insuredMan.setDeparttime(platforminsureorderdetail.getDeparttime());
				insuredMan.setSchedulecode(platforminsureorderdetail.getSchedulecode());
				insuredMan.setPassengername(platforminsureorderdetail.getPassengername());
				insuredMan.setIdtype(platforminsureorderdetail.getIdtype());
				insuredMan.setIdnum(platforminsureorderdetail.getIdnum());
				insuredMan.setDepartcode(platforminsureorderdetail.getDepartcode());
				insuredMan.setDepartname(platforminsureorderdetail.getDepartname());
				insuredMan.setReachcode(platforminsureorderdetail.getReachcode());
				insuredMan.setReachname(platforminsureorderdetail.getReachname());
				insuredMan.setSelltickettime(util.DateUtils.formatDatetime(platforminsureorderdetail.getSelltickettime()));
				insuredMan.setInsureticketno(platforminsureorderdetail.getInsureticketno());
				manList.add(insuredMan);
			}
			
			//调用保险服务器售保接口
			Map<String,String> param = new HashMap<String,String>();
			param.put("insuranceno", platforminsureorder.getInsuranceno());
			param.put("insuranceappntman", cn.nova.openapi.util.JsonUtil.parseObject(insuranceAppntMan));
			param.put("insuredmanlist", JsonUtil.parseObject(manList));
			String data = JsonUtil.parseObject(param);
			Map<String, String> params = null;
			params = SecretClientUtil.encryptData(privatekey,
					md5key, data);
			params.put("callorgcode", callorgcode);
			//String result = RpcUtil.remoteCall(AppConstant.getValue("insurance.url"),"/sellInsurance", params);
			String result = RpcUtil.httpPost(url + "/sellInsurance", 10000, params);
			
			//如果调用成功
			if(null != result && result.indexOf("<html>") == -1){
				Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
				if(null != resultMap){
					String resultData = resultMap.get("data").toString();
					String resultMd5 = resultMap.get("md5").toString();
					
					SecretClientUtil secretClientUtil = new SecretClientUtil();
					Boolean success = secretClientUtil.decryptData(privatekey,
							md5key, resultData, resultMd5);
					//如果解密成功
					if(success){
						Map<String, Object> dataMap = secretClientUtil.getData();
						String status = (String) dataMap.get("status");
						String message = (String) dataMap.get("message");
						//如果售保成功
						if("0000".equals(status)){
							manList = (List<InsuredMan>) cn.nova.openapi.util.JsonUtil.paseJson2Collection(cn.nova.openapi.util.JsonUtil.parseObject(dataMap.get("insuredmanlists")), InsuredMan.class);
							for (InsuredMan insuredMan : manList) {
								for (Platforminsureorderdetail platforminsureorderdetail : detailList) {
									if(insuredMan.getTicketno()!=null && insuredMan.getTicketno().equals(platforminsureorderdetail.getTicketno())){
										platforminsureorderdetail.setInsureno(insuredMan.getInsureno());
										platforminsureorderdetail.setEtinsureno(insuredMan.getEtinsureno());
										platforminsureorderdetail.setStatus(2);
										dao.merge(platforminsureorderdetail);
										//售完保险，将保险订单号、保险电子号回写
										Insurance insurance = (Insurance) dao.get(Insurance.class, platforminsureorderdetail.getInsuranceid());
										insurance.setPolnumber(insuredMan.getInsureno());
										insurance.setPlatforminsuranceno(platforminsureorder.getInsuranceno());
										dao.merge(insurance);
										break;
									}
								}
							}
						}else{
							play.Logger.error("同步保险服务器保险产品:"+message);
							return false;
						}
					}	
				}
			}
		}
		return true;
	}
	/**
	 * 同步保险服务器产品
	 */
	@Override
	public void syncPlatformInsureType() {
		InsuranceInfoVO insuranceInfoVO = null; 
		//调用保险服务器保险产品信息查询接口
		Map<String,String> param = new HashMap<String,String>();
		param.put("sellorgcode", sellorgcode);
		param.put("price", "1");
		//param.put("rangkm", rangekm.toString());
		String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
		
		Map<String, String> params = null;
		try {
			params = SecretClientUtil.encryptData(privatekey,
					md5key, data);
			params.put("callorgcode", callorgcode);
			//String result = RpcUtil.remoteCall(AppConstant.getValue("insurance.url"),"/queryInsuranceInfo", params);
			String result = RpcUtil.httpPost(url + "/queryInsuranceInfo", 10000, params);
			play.Logger.info("同步保险产品", result);
			//如果调用成功
			if(null != result && result.indexOf("<html>") == -1){
				Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
				//如果返回结果不为空
				if(null != resultMap){
					String resultData = resultMap.get("data").toString();
					String resultMd5 = resultMap.get("md5").toString();
					
					//解密返回结果
					SecretClientUtil secretClientUtil = new SecretClientUtil();
					Boolean success = secretClientUtil.decryptData(privatekey,
							md5key, resultData, resultMd5);
					//如果解密成功
					if(success){
						Map<String, Object> dataMap = secretClientUtil.getData();
						String status = (String) dataMap.get("status");//查询状态
						String message = (String) dataMap.get("message");//状态信息
						
						//如果查询成功
						if("0000".equals(status)){
							String insuranceinfovo = cn.nova.openapi.util.JsonUtil.parseObject(dataMap.get("insuranceinfovo"));
							try {
								Date currenttime = new Date();
								insuranceInfoVO = (InsuranceInfoVO) cn.nova.openapi.util.JsonUtil.readJson2Entity(insuranceinfovo, InsuranceInfoVO.class);
								if(insuranceInfoVO!=null){
									//将保险产品保存入站务系统
									Long id = insuranceInfoVO.getId();
									Platforminsurancetype platforminsurancetype = (Platforminsurancetype) dao.get(Platforminsurancetype.class, id);
									boolean isEdit = false;
									boolean isNew = false;
									Platforminsurancetype type = new Platforminsurancetype();
									if(platforminsurancetype!=null && insuranceInfoVO.getId()==platforminsurancetype.getId()){
										if(insuranceInfoVO.getDieinsureamount().compareTo(platforminsurancetype.getDieinsureamount())!=0){
											platforminsurancetype.setDieinsureamount(insuranceInfoVO.getDieinsureamount());
											isEdit = true;
										}
										if(!insuranceInfoVO.getInsurecompanycode().equals(platforminsurancetype.getInsurecompanycode())){
											platforminsurancetype.setInsurecompanycode(insuranceInfoVO.getInsurecompanycode());
											isEdit = true;
										}
										if(!insuranceInfoVO.getInsurecompanyname().equals(platforminsurancetype.getInsurecompanyname())){
											platforminsurancetype.setInsurecompanyname(insuranceInfoVO.getInsurecompanyname());
											isEdit = true;
										}
										if(insuranceInfoVO.getInsuretype()!=platforminsurancetype.getInsuretype()){
											platforminsurancetype.setInsuretype(insuranceInfoVO.getInsuretype());
											isEdit = true;
										}
										if(insuranceInfoVO.getMedicalinsureamount().compareTo(platforminsurancetype.getMedicalinsureamount())!=0){
											platforminsurancetype.setMedicalinsureamount(insuranceInfoVO.getMedicalinsureamount());
											isEdit = true;
										}
										if(insuranceInfoVO.getPremium().compareTo(platforminsurancetype.getPremium())!=0){
											platforminsurancetype.setPremium(insuranceInfoVO.getPremium());
											isEdit = true;
										}
										if(!insuranceInfoVO.getProductcode().equals(platforminsurancetype.getProductcode())){
											platforminsurancetype.setProductcode(insuranceInfoVO.getProductcode());
											isEdit = true;
										}
										if(!insuranceInfoVO.getVarcode().equals(platforminsurancetype.getVarcode())){
											platforminsurancetype.setVarcode(insuranceInfoVO.getVarcode());
											isEdit = true;
										}
										if(!insuranceInfoVO.getVarname().equals(platforminsurancetype.getVarname())){
											platforminsurancetype.setVarname(insuranceInfoVO.getVarname());
											isEdit = true;
										}
									}else{
										isNew = true;
									}
									if(isNew){
										type.setId(insuranceInfoVO.getId());
										type.setCreateby(0l);
										type.setCreatetime(currenttime);
										type.setUpdateby(0l);
										type.setUpdatetime(currenttime);
										type.setDieinsureamount(insuranceInfoVO.getDieinsureamount());
										type.setExplanation(insuranceInfoVO.getExplanation());
										type.setInsurecompanycode(insuranceInfoVO.getInsurecompanycode());
										type.setInsurecompanyname(insuranceInfoVO.getInsurecompanyname());
										type.setInsuretype(insuranceInfoVO.getInsuretype());
										type.setMedicalinsureamount(insuranceInfoVO.getMedicalinsureamount());
										type.setPremium(insuranceInfoVO.getPremium());
										type.setProductcode(insuranceInfoVO.getProductcode());
										type.setVarcode(insuranceInfoVO.getVarcode());
										type.setVarname(insuranceInfoVO.getVarname());
									}
									if(isNew || isEdit){
										dao.merge(type);
										List<PropertyFilter> propertyfilter = new ArrayList<PropertyFilter>();
										propertyfilter.add(new PropertyFilter("EQB_t!islocal",true));
										propertyfilter.add(new PropertyFilter("EQB_t!isactive",true));
										List<Organization> orgList = dao.find(Organization.class, propertyfilter);
										Long orgid = 0L;
										if(orgList.size()>0){
											orgid = orgList.get(0).getId();
											//result = parameterService.findParamValue(ParamterConst.Param_2626, id);
										}
										//一：同步保险公司
										Insurers insurers = null;
										try {
											if(isNew){//新增保险公司
												insurers = this.sysnInsurers(type,orgid);
											}
											if(isEdit){//修改保险公司
												propertyfilter.clear();
												propertyfilter.add(new PropertyFilter("EQS_t!name",type.getInsurecompanyname()));
												propertyfilter.add(new PropertyFilter("EQS_t!bankcode",type.getInsurecompanycode()));
												insurers =  (Insurers) dao.uniqueResult(Insurers.class, propertyfilter);
												if(insurers!=null){
													insurers.setName(type.getInsurecompanyname());
													insurers.setBankcode(type.getInsurecompanycode());
													insurers.setUpdatetime(new Date());
													dao.merge(insurers);
												}
											}
										} catch (Exception e) {
											play.Logger.error("同步保险服务器保险产品保存保险公司报错！", e);
											return;
										}
										//二：同步保险类型
										Insuretype insuretype = null;
										try {
											if(isNew){
												insuretype = this.sysnInsureType(type,insurers,orgid);
											}
											if(isEdit){
												propertyfilter.clear();
												propertyfilter.add(new PropertyFilter("EQL_t!insurersid",insurers.getId()));
												propertyfilter.add(new PropertyFilter("EQS_t!code",type.getVarcode()));
												insuretype =  (Insuretype) dao.uniqueResult(Insuretype.class, propertyfilter);
												insuretype.setPremium(type.getPremium());
												dao.merge(insuretype);
											}
										} catch (Exception e) {
											play.Logger.error("同步保险服务器保险产品保存保险类型报错！", e);
											return;
										}
										//三：同步保险类型里程相关
										try {
											this.sysnInsureTypeDistance(type,insuretype,orgid);
										} catch (Exception e) {
											play.Logger.error("同步保险服务器保险产品保存保险类型里程相关报错！", e);
											return;
										}
										//四：同步保险票价相关
										this.sysnInsuranceTypeFares(type,insuretype,orgid);
									}
								}
								
							} catch (Exception e1) {
								play.Logger.error("同步保险服务器保险产品解析产品对象报错！", e1);
							}
						}else{
							play.Logger.error("同步保险服务器保险产品:"+message);
						}
					}else{
						play.Logger.error("同步保险服务器保险产品解密失败！");
					}
				}
			}	
		} catch (Exception e) {
			play.Logger.error("同步保险服务器保险产品失败", e);
		}
		
	}
	/**
	 * 保存保险票价相关信息
	 * @param platforminsurancetype
	 * @param insuretype
	 * @param orgid 
	 */
	private void sysnInsuranceTypeFares(
			Platforminsurancetype platforminsurancetype,
			Insuretype insuretype, Long orgid) {
		if(insuretype!=null){
			Date currentTime = new Date();
			Insurancetypefares insurancetypefares = new Insurancetypefares();
			insurancetypefares.setOrgid(orgid);
			insurancetypefares.setFromprice(0L);
			insurancetypefares.setEndprice(100000);
			insurancetypefares.setInsuretypeid(insuretype.getId());
			insurancetypefares.setCreateby(0L);
			insurancetypefares.setCreatetime(currentTime);
			insurancetypefares.setUpdateby(0L);
			insurancetypefares.setUpdatetime(currentTime);
			dao.merge(insurancetypefares);
		}
	}

	/**
	 * 保存保险里程相关信息
	 * @param platforminsurancetype
	 * @param insuretype
	 * @param orgid 
	 */
	private void sysnInsureTypeDistance(
			Platforminsurancetype platforminsurancetype,
			Insuretype insuretype, Long orgid) {
		if(insuretype!=null){
			Date currentTime = new Date();
			Insuretypedistance insuretypedistance = new Insuretypedistance();
			insuretypedistance.setOrgid(orgid);
			insuretypedistance.setInsuretypeid(insuretype.getId());
			insuretypedistance.setFromdistance(0L);
			insuretypedistance.setEnddistance(100000L);
			insuretypedistance.setCreateby(0L);
			insuretypedistance.setCreatetime(currentTime);
			insuretypedistance.setUpdateby(0L);
			insuretypedistance.setUpdatetime(currentTime);
			dao.merge(insuretypedistance);
		}
	}

	/**
	 * 保存保险类型信息
	 * @param platforminsurancetype
	 * @param insurers 
	 * @param orgid 
	 * @return 
	 */
	private Insuretype sysnInsureType(Platforminsurancetype platforminsurancetype, Insurers insurers, Long orgid) {
		Date currentTime = new Date();
		Insuretype insuretype = new Insuretype();
		insuretype.setOrgid(orgid);
		insuretype.setInsurersid(insurers.getId());
		insuretype.setCode(platforminsurancetype.getVarcode());
		insuretype.setName(platforminsurancetype.getVarname());
		insuretype.setPremium(platforminsurancetype.getPremium());
		insuretype.setMaxinsureamount(platforminsurancetype.getDieinsureamount());
		insuretype.setDividedrate(new BigDecimal(0));
		insuretype.setCreateby(0L);
		insuretype.setCreatetime(currentTime);
		insuretype.setUpdateby(0L);
		insuretype.setUpdatetime(currentTime);
		insuretype = (Insuretype)dao.merge(insuretype);
		Insuretypedetail insuretypedetail = new Insuretypedetail();
		insuretypedetail.setCode(platforminsurancetype.getVarcode());
		insuretypedetail.setName(platforminsurancetype.getVarname());
		insuretypedetail.setInsureamount(platforminsurancetype.getDieinsureamount());
		insuretypedetail.setCreatetime(currentTime);
		insuretypedetail.setCreateby(0L);
		insuretypedetail.setUpdatetime(currentTime);
		insuretypedetail.setUpdateby(0L);
		insuretypedetail.setInsuretype(insuretype);
		dao.merge(insuretypedetail);
		return insuretype;
	}	
	/**
	 * 保存保险公司信息
	 * @param platforminsurancetype
	 * @param orgid 
	 * @return 
	 */
	private Insurers sysnInsurers(Platforminsurancetype platforminsurancetype, Long orgid) {
		Date currentTime = new Date();
		Insurers insruers = new Insurers();
		insruers.setOrgid(orgid);
		insruers.setName(platforminsurancetype.getInsurecompanyname());
		insruers.setCreateby(0L);
		insruers.setCreatetime(currentTime);
		insruers.setUpdateby(0L);
		insruers.setUpdatetime(currentTime);
		insruers.setBankcode(platforminsurancetype.getInsurecompanycode());
		return (Insurers)dao.merge(insruers);
	}

	/**
	 * bus365保险服务器退保险
	 */
	@Override
	public void autoPlatformReturnInsurance() { 
		List<Object[]> list = insuranceDao.queryPlatformReturnInsurance();
		if(list.size()>0){
			for (Object[] objects : list) {
				String insuranceno = (String) objects[0];
				String orderno = (String) objects[1];
				Integer surrendertype = 1;//退保类型:1-退票退保 2-第三态退保
				
				String insureno = (String) objects[2];
				String etinsureno = (String) objects[3];
				Long id = ((BigDecimal) objects[4]).longValue();
				Integer issuingtype = ((BigDecimal)objects[5]).intValue();//出单方式1-电子 2-纸质
				Insureno in = new Insureno();
				in.setEtinsureno(etinsureno);
				in.setInsureno(insureno);
				//调用保险服务器退保接口
				Map<String,String> param = new HashMap<String,String>();
				param.put("sellorgcode", sellorgcode);
				param.put("insuranceno", insuranceno);
				param.put("orderno", orderno);
				param.put("issuingtype", issuingtype + "");
				param.put("surrendertype", surrendertype + "");
				List<Insureno> insurenosList = new ArrayList<Insureno>();
				insurenosList.add(in);
				String insurenos = cn.nova.openapi.util.JsonUtil.parseObject(insurenosList);
				param.put("insurenos",insurenos );
				String data = cn.nova.openapi.util.JsonUtil.parseObject(param);
				Map<String, String> params = null;
				try {
					params = SecretClientUtil.encryptData(privatekey,
							md5key, data);
					params.put("callorgcode", callorgcode);
					//String result = RpcUtil.remoteCall(AppConstant.getValue("insurance.url"),"/queryInsuranceInfo", params);
					String result = RpcUtil.httpPost(url + "/returnInsurance", 10000, params);
					//如果调用成功
					if(null != result && result.indexOf("<html>") == -1){
						Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(result);
						//如果返回结果不为空
						if(null != resultMap){
							String resultData = resultMap.get("data").toString();
							String resultMd5 = resultMap.get("md5").toString();
							
							//解密返回结果
							SecretClientUtil secretClientUtil = new SecretClientUtil();
							Boolean success = secretClientUtil.decryptData(privatekey,
									md5key, resultData, resultMd5);
							//如果解密成功
							if(success){
								List<InsurenoStatus> returnInsuranceVOResponseList = new ArrayList<InsurenoStatus>();
								
								Map<String, Object> dataMap = secretClientUtil.getData();
								String status = (String) dataMap.get("status");//查询状态
								String message = (String) dataMap.get("message");//状态信息
								
								//如果查询成功
								if("0000".equals(status)){
									String insurenostatuslist = cn.nova.openapi.util.JsonUtil.parseObject(dataMap.get("insurenostatuslist"));
									try {
										Date currenttime = new Date();
										returnInsuranceVOResponseList = (List<InsurenoStatus>) cn.nova.openapi.util.JsonUtil.paseJson2Collection(insurenostatuslist, InsurenoStatus.class);
										for (InsurenoStatus insurenoStatus : returnInsuranceVOResponseList) {
											String stu = insurenoStatus.getStatus();
											String msg = insurenoStatus.getMessage();
											if("0000".equals(stu)){//退保成功
												Platforminsureorderdetail platforminsureorderdetail = (Platforminsureorderdetail) dao.get(Platforminsureorderdetail.class, id);
												platforminsureorderdetail.setStatus(5);//服务器退保成功
												dao.merge(platforminsureorderdetail);
											}else{
												play.Logger.error("同步保险服务器退保时，调用保险服务器的退保接口退保成功，服务器退保状态为0000:insuranceid="+id+message);
												continue;
											}
										}
									} catch (Exception e1) {
										play.Logger.error("同步保险服务器退保时，调用保险服务器的退保接口退保成功，但返回的数据不对:insuranceid="+id+message, e1);
										continue;
									}
								}else{
									play.Logger.error("保险服务器退保时，调用保险服务器的退保接口退保失败:insuranceid="+id);
									continue;
								}
							}else{
								play.Logger.error("保险服务器退保解密失败:insuranceid="+id);
								continue;
							}
						}
					}
					
				} catch (Exception e) {
					play.Logger.error("保险服务器退保失败:insuranceid="+id, e);
					continue;
				}
			}
		}
	}
	/**
	 * 查看机构是否能否售平台保险
	 */
	@Override
	public  String findParamValue(String param2626) {
		if(PARAM2626==null){
			String result = "0";
			List<PropertyFilter> propertyfilter = new ArrayList<PropertyFilter>();
			propertyfilter.add(new PropertyFilter("EQB_t!islocal",true));
			propertyfilter.add(new PropertyFilter("EQB_t!isactive",true));
			List<Organization> orgList = dao.find(Organization.class, propertyfilter);
			if(orgList.size()>0){
				Long id = orgList.get(0).getId();
				result = parameterService.findParamValue(ParamterConst.Param_2626, id);
			}
			PARAM2626 = result;
		}
		return PARAM2626;
	}
	
	public static String checkPlateformCanSellInsrance(){
		String result = "0";
		try {
			String value = RpcUtil.httpGet(url, null, 10000, null);
			//如果调用成功
			Map<String,Object> resultMap = cn.nova.openapi.util.JsonUtil.paseJson2Map(value);
			String status = (String) resultMap.get("status");//查询状态
			String message = (String) resultMap.get("message");//状态信息
			if("0000".equals(status)){
				result = "1";
			}
		} catch (Exception e) {
			play.Logger.error("平台售保险服务器没有启动", e);
		}
		return result;
	}
	
	@Override
	public boolean changenoreprint(long oldinsuranceid, String insuranceno,
			Global global) throws ServiceException {
		Date now = new Date();
		// 只有售票人或者换票人才允许重打
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!id", oldinsuranceid));
		Insurance insurance = (Insurance) dao.uniqueResult(Insurance.class,
				propertyFilters);
		// 判断售票人
		if (insurance.getSellby() != 0
				&& insurance.getSellby() != global.getUserinfo().getId()) {
			// 换票号重打车票不允许重打他人售出的车票
			throw new ServiceException("0344");
		} else if (insurance.getSellby() == 0) {
			// 换票号重打车票不允许重打他人售出的车票
			throw new ServiceException("0344");
		}
		if(insurance.getInsurancestatus().equals("0")){
			
		}
		// 校验当前票号
		Billinuse billinuse = billinuseService.jumpBillinuse(global
				.getUserinfo().getId(), "Insure", insuranceno, 1);
		Billinventory billinventory = (Billinventory) dao.get(
				Billinventory.class, billinuse.getBillinventoryid());
		// Schedule schedule = (Schedule) dao.get(Schedule.class, ticketsell.getScheduleid());

		// 插入或修改应缴款表
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), calendar.get(Calendar.MONTH),
				calendar.get(Calendar.DAY_OF_MONTH), 0, 0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate", calendar
				.getTime()));
		propertyFilters.add(new PropertyFilter("EQL_t!seller", global
				.getUserinfo().getId()));
		List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(
				Insuranceturnoverdetail.class, propertyFilters);
		boolean neednew = true;
		Insuranceturnoverdetail insuranceturnoverdetail = null;
		if (insuranceturnoverdetails != null
				&& insuranceturnoverdetails.size() > 0) {
			for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
				if (new Long(_ticketturnoverdetail.getTicketendno())
						.longValue() + 1L == Long.parseLong(insuranceno)) {
					insuranceturnoverdetail = _ticketturnoverdetail;
					neednew = false;
					break;
				}
			}
			if (neednew) {
				for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
					if ("0".equals(_ticketturnoverdetail.getTicketstartno())) {
						insuranceturnoverdetail = _ticketturnoverdetail;
						neednew = false;
						break;
					}
				}
			}
		}
		if (neednew) {
			insuranceturnoverdetail = new Insuranceturnoverdetail();
			insuranceturnoverdetail.setMoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setSellmoney(new BigDecimal(0));
			insuranceturnoverdetail.setSellnum(0);
			insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
			insuranceturnoverdetail.setUpdatetime(now);
			insuranceturnoverdetail.setCancelnum(0);
			insuranceturnoverdetail.setCancelmoney(new BigDecimal(0));
			insuranceturnoverdetail
					.setNonvouchermoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashmoney(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashnum(0);
			insuranceturnoverdetail.setCreateby(global.getUserinfo().getId());
			insuranceturnoverdetail.setCreatetime(now);
			insuranceturnoverdetail.setEticketnum(0);
			insuranceturnoverdetail.setMoneydate(now);
			insuranceturnoverdetail.setReturnhandcharge(new BigDecimal(0));
			insuranceturnoverdetail.setReturnmoney(new BigDecimal(0));
			insuranceturnoverdetail.setReturnnum(0);
			insuranceturnoverdetail.setSeller(global.getUserinfo().getId());
			insuranceturnoverdetail.setTicketstartno(insuranceno);
			insuranceturnoverdetail.setTicketturnover(null);
			insuranceturnoverdetail.setTurnovertime(null);
			insuranceturnoverdetail.setIsturnover(false);
		}
		if ("0".equals(insuranceturnoverdetail.getTicketstartno())) {
			insuranceturnoverdetail.setTicketstartno(insuranceno);
		}
		insuranceturnoverdetail.setCancelnum(insuranceturnoverdetail.getCancelnum()+1);
		insuranceturnoverdetail.setCancelmoney(insuranceturnoverdetail.getCancelmoney().add(insurance.getPremium()));
		insuranceturnoverdetail.setTicketendno(insuranceno);
		insuranceturnoverdetail.setUpdateby(global.getUserinfo().getId());
		insuranceturnoverdetail.setUpdatetime(now);
		insuranceturnoverdetail = (Insuranceturnoverdetail) dao
				.merge(insuranceturnoverdetail);

		// 原售票号生成坏票登记记录
		Billdamaged billdamaged = new Billdamaged();
		billdamaged.setAmount(1);
		billdamaged.setBillinuseid(billinuse.getId());
		billdamaged.setBilltypeid(billinuse.getBilltypeid());
		billdamaged.setCreateby(global.getUserinfo().getId());
		billdamaged.setCreatetime(now);
		billdamaged.setDamageddscribe("换票号重打车票做废原票号！");
		billdamaged.setEndno(new Long(insurance.getInsuranceno()));
		billdamaged.setRecordby(global.getUserinfo().getId());
		billdamaged.setRecordip(global.getIpAddress());
		billdamaged.setRecordtime(billdamaged.getCreatetime());
		billdamaged.setStartno(new Long(insurance.getInsuranceno()));
		billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
		billdamaged.setUpdateby(global.getUserinfo().getId());
		billdamaged.setUpdatetime(now);
		billdamaged.setTurnoverdetailid(insuranceturnoverdetail.getId());
		dao.merge(billdamaged);
		// 修改票号
		insurance.setInsuranceno(insuranceno);
		insurance.setBatchno(billinventory.getBatchno());
		insurance.setUpdateby(global.getUserinfo().getId());
		insurance.setUpdatetime(now);
		dao.merge(insurance);

		// 返回打印信息
		//propertyFilters.clear();
		//propertyFilters.add(new PropertyFilter("EQL_t!id", insurance.getId()));
		return true;

	}
}
