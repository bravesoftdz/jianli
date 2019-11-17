/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.archive.model.Vip;
import cn.nova.bus.archive.model.Vipcardloss;
import cn.nova.bus.archive.model.Viprecharge;
import cn.nova.bus.archive.model.Vipremainmoneytransfer;
import cn.nova.bus.archive.service.DriverService;
import cn.nova.bus.archive.service.StewardService;
import cn.nova.bus.archive.service.VipService;
import cn.nova.bus.archive.service.impl.DriverServiceImpl;
import cn.nova.bus.archive.service.impl.StewardServiceImpl;
import cn.nova.bus.archive.service.impl.VipServiceImpl;
import cn.nova.bus.base.dao.CardissueDao;
import cn.nova.bus.base.model.Cardissue;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.base.service.CardissueService;
import cn.nova.bus.base.service.UnitService;
import cn.nova.bus.base.service.VehicleService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.UserService;
import cn.nova.bus.system.service.impl.UserServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class CardissueServiceImpl implements CardissueService {
	protected final Logger log = LoggerFactory.getLogger(getClass());

	
	private CardissueDao dao = new CardissueDao();
	
	private VehicleService vehicleService = new VehicleServiceImpl();
	
	private DriverService driverService = new DriverServiceImpl();
	
	private StewardService stewardService = new StewardServiceImpl();
	
	private VipService vipService = new VipServiceImpl();
	
	private UserService userService = new UserServiceImpl();
	
	private UnitService unitService;
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();

	@Override
	public Cardissue save(Cardissue card, String ip, Vip vp)
			throws ServiceException {
		unitService = new UnitServiceImpl();
		if (getIdByCardno(card.getCardno(), card.getType(), "1") > 0) {
			Cardissue issue = getById(getIdByCardno(card.getCardno(),
					card.getType(), "1"));
			card.setId(issue.getId());
			card.setStatus("0");
			card.setBilltypeid(issue.getBilltypeid());
			card.setIssueby(issue.getIssueby());
			card.setIssueip(issue.getIssueip());
			card.setIssueorgid(issue.getIssueorgid());
			card.setIssuetime(new Timestamp(System.currentTimeMillis()));
			card.setTicketoutletsid(issue.getTicketoutletsid());
			card.setCreateby(issue.getCreateby());
			card.setCreatetime(new Timestamp(System.currentTimeMillis()));
			if (isExist(card)) {
				throw new ServiceException("0245");
			}
		}
		String result = "";// 记录发卡、退卡的一些信息
		String operation = "";// 记录操作状态
		if (card.getId() == 0) {
			operation = "发卡操作";
			String serialnumber = dao.getSerialnumber(card.getCardno(),
					card.getType());
			if (isIssue(card)) {
				throw new ServiceException(card.getCardno(), "0318");
			}
			if (dao.isExistSerialnumber(card.getSerialnumber())) {
				throw new ServiceException(card.getCardno(), "0417");
			}
			if (serialnumber == null) {
				throw new ServiceException("0236");
			} else {
				card.setSerialnumber(serialnumber);
			}
			if (isExist(card)) {
				throw new ServiceException("0245");
			}
			if ("0".equals(card.getType())) {// 得到车辆对应的票据类型ID
				Long typeid = billtypeService.getId("Vehicle");
				card.setBilltypeid(typeid);

				result = saveVehicle(card);
			} else if ("1".equals(card.getType())) {// 得到驾驶员对应的票据类型ID
				Long typeid = billtypeService.getId("Driver");
				card.setBilltypeid(typeid);
				result = saveDriver(card);// 发卡时同时把相应的对象增加卡号
			} else if ("2".equals(card.getType())) {// 得到乘务员对应的票据类型ID
				Long typeid = billtypeService.getId("Steward");
				card.setBilltypeid(typeid);
				result = saveSteward(card);// 发卡时同时把相应的对象增加卡号
			} else if ("3".equals(card.getType())) {// 得到把乘客VIP对应的票据类型ID
				Long typeid = billtypeService.getId("Vip");
				card.setBilltypeid(typeid);
				card.setTypeid(saveVip(card, vp).getId());// 发卡时同时把相应的对象增加卡号并取到VIP的ID
				Customer cus = (Customer) dao.get(Customer.class,
						vp.getCustomerid());
				result = "VIP卡：" + card.getCardno() + " 发给VIP乘客："
						+ cus.getName();

			} else if ("4".equals(card.getType())) {// 得到用户对应的票据类型ID
				Long typeid = billtypeService.getId("Userinfo");
				card.setBilltypeid(typeid);
				result = saveUser(card);// 发卡时同时把相应的对象增加卡号
			} else if ("5".equals(card.getType())) {// 得到车属单位对应的票据类型ID
				Long typeid = billtypeService.getId("Unit");
				card.setBilltypeid(typeid);
				result = saveUnit(card);// 发卡时同时把相应的对象增加卡号
			}
			return (Cardissue) dao.merge(card);
		} else {
			if ("1".equals(card.getStatus())) {
				operation = "退卡操作";
				if ("0".equals(card.getType())) {// 退卡时把车辆对应的卡号清空
					Vehicle vehicle = vehicleService.findById(card.getTypeid());
					vehicle.setCardno("");
					vehicle.setUpdateby(card.getUpdateby());
					vehicle.setUpdatetime(card.getUpdatetime());
					dao.merge(vehicle);
					result = "车辆：" + vehicle.getVehicleno() + "卡号："
							+ card.getCardno() + "已退。";
				} else if ("1".equals(card.getType())) {// 退卡时把驾驶员对应的卡号清空
					Driver driver = driverService.findbyid(card.getTypeid());
					driver.setCardno("");
					driver.setUpdateby(card.getUpdateby());
					driver.setUpdatetime(card.getUpdatetime());
					dao.merge(driver);
					result = "驾驶员：" + driver.getName() + "卡号："
							+ card.getCardno() + "已退。";
				} else if ("2".equals(card.getType())) {// 退卡时把乘务员对应的卡号清空
					Steward steward = stewardService.findbyid(card.getTypeid());
					steward.setCardno("");
					steward.setUpdateby(card.getUpdateby());
					steward.setUpdatetime(card.getUpdatetime());
					dao.merge(steward);
					result = "乘务员：" + steward.getName() + "卡号："
							+ card.getCardno() + "已退。";
				} else if ("3".equals(card.getType())) {// 退卡时把乘客VIP对应的卡号清空
					Vip vip = vipService.findById(card.getTypeid(), "0");// 待改
					vip.setStatus("1");
					vip.setUpdateby(card.getUpdateby());
					vip.setUpdatetime(card.getUpdatetime());
					dao.update(vip);
					Customer customer = (Customer) dao.get(Customer.class,
							vip.getCustomerid());
					result = "乘客：" + customer.getName() + "卡号："
							+ card.getCardno() + "已退。";
				} else if ("4".equals(card.getType())) {// 退卡时把用户对应的卡号清空
					Userinfo user = userService.findById(card.getTypeid());
					user.setCardno("");
					user.setUpdateby(card.getUpdateby());
					user.setUpdatetime(card.getUpdatetime());
					dao.merge(user);
					result = "员工：" + user.getName() + "卡号：" + card.getCardno()
							+ "已退。";
				} else if ("5".equals(card.getType())) {// 退卡时把车属单位对应的卡号清空
					Unit unit = unitService.getById(card.getTypeid());
					unit.setCardno("");
					unit.setUpdateby(card.getUpdateby());
					unit.setUpdatetime(card.getUpdatetime());
					dao.merge(unit);
					result = "车方：" + unit.getName() + "卡号：" + card.getCardno()
							+ "已退。";
				}
			} else if ("4".equals(card.getStatus())
					&& card.getValiddate().after(new Date())) {
				if ("3".equals(card.getType())) {// 乘客VIP卡过期，改卡状态
					Vip vip = (Vip) dao.get(Vip.class, card.getTypeid());
					vip.setStatus("4");
					vip.setUpdateby(card.getUpdateby());
					vip.setUpdatetime(card.getUpdatetime());
					dao.update(vip);
					Customer customer = (Customer) dao.get(Customer.class,
							vip.getCustomerid());
					result = "乘客：" + customer.getName() + "卡号："
							+ card.getCardno() + "已过期。";
				} else {
					result = card.getCardno() + "由正常状态变为过期状态";
				}
				operation = "修改卡状态";
			} else if ("4".equals(card.getStatus())     
					&& card.getValiddate().before(new Date())) {
				//如果不判断且此条件符合，会发生无法将null直插入"OPERATIONLOG"."OPERATION"的错误
				operation = "过期状态";
			} else if ("0".equals(card.getStatus())) {
				operation = "发卡、恢复卡状态";
				if (vp.getId() <= 0 && isExist(card)) {
					throw new ServiceException("0245");
				}
				if ("0".equals(card.getType())) {// 发卡时把车辆对应的卡号添加进去
					result = saveVehicle(card);
				} else if ("1".equals(card.getType())) {// 发卡时把驾驶员对应的卡号添加进去
					result = saveDriver(card);
				} else if ("2".equals(card.getType())) {// 发卡时把乘务员对应的卡号添加进去
					result = saveSteward(card);
				} else if ("3".equals(card.getType())) {// 发卡时把乘客VIP对应的卡号添加进去
					if (vp.getId() > 0) {
						saveVip(card, vp);
						cardloss(card, vp);// 卡恢复添明细记录
						result = "VIP卡：" + card.getCardno() + " 恢复正常.";
					} else {
						vp = saveVip(card, vp);
						card.setTypeid(vp.getId());// 发卡时同时把相应的对象增加卡号并取到VIP的ID
						Customer cus = (Customer) dao.get(Customer.class,
								vp.getCustomerid());
						result = "VIP卡：" + card.getCardno() + " 发给VIP乘客："
								+ cus.getName();
					}
				} else if ("4".equals(card.getType())) {// 发卡时把用户对应的卡号添加进去
					result = saveUser(card);
				} else if ("5".equals(card.getType())) {// 发卡时把车属单位对应的卡号添加进去
					result = saveUnit(card);
				}
			} else if ("2".equals(card.getStatus())) {
				if ("3".equals(card.getType())) {// 乘客VIP卡挂失
					Vip v = vipService.findById(card.getTypeid(), "2");// 查询该乘客挂失前还有没有已经挂失的记录
					if (v != null) {
						v.setStatus("3");
						v.setUpdateby(card.getUpdateby());
						v.setUpdatetime(card.getUpdatetime());
						dao.update(v);
					}
					Vip vip = (Vip) dao.get(Vip.class, vp.getId());
					vip.setStatus("2");
					vip.setUpdateby(card.getUpdateby());
					vip.setUpdatetime(card.getUpdatetime());
					dao.update(vip);

					cardloss(card, vp);// 添加卡的挂失记录

					Customer customer = (Customer) dao.get(Customer.class,
							vip.getCustomerid());
					result = "乘客：" + customer.getName() + "卡号："
							+ card.getCardno() + "已挂失。";
				} else {
					result = "卡号：" + card.getCardno() + " 挂失。";
				}
				operation = "挂失操作";
			} else if ("3".equals(card.getStatus())) {
				if ("3".equals(card.getType())) {// 注销卡时把乘客VIP对应卡给注销
					Vip vip = (Vip) dao.get(Vip.class, vp.getId());
					if (vip != null) {
						vip.setStatus("3");
						vip.setUpdateby(card.getUpdateby());
						vip.setUpdatetime(card.getUpdatetime());
						dao.update(vip);
					}
					Customer customer = (Customer) dao.get(Customer.class,
							vip.getCustomerid());
					result = "乘客：" + customer.getName() + "卡号："
							+ card.getCardno() + "已注销。";
				} else {
					result = "卡号：" + card.getCardno() + " 注销。";
				}
				operation = "注销";
			}

			Operationlog operationLog = new Operationlog();
			operationLog.setIp(ip);
			operationLog.setContent(result);
			operationLog.setModule("业务管理->智能卡管理");
			operationLog.setOperatetime(new Date());
			operationLog.setOperation(operation);
			operationLog.setSessionid("无session");
			operationLog.setUserid(card.getUpdateby());
			dao.merge(operationLog);
			return (Cardissue) dao.merge(card);
		}
	}

	private void cardloss(Cardissue card, Vip vp) {
		Vipcardloss viploss = new Vipcardloss();// 挂失记录
		viploss.setCreateby(card.getCreateby());
		viploss.setCreatetime(card.getCreatetime());
		viploss.setUpdateby(card.getUpdateby());
		viploss.setUpdatetime(card.getUpdatetime());
		viploss.setVipid(vp.getId());
		viploss.setLosstime(new Date());
		viploss.setLossby(card.getUpdateby());
		viploss.setRemarks(vp.getRemarks());
		dao.merge(viploss);
	}

	private boolean isIssue(Cardissue card) {// 判断该卡是否已发
		@SuppressWarnings("rawtypes")
		List list = dao.isIssue(card);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	private String saveUnit(Cardissue card) throws ServiceException {
		unitService = new UnitServiceImpl();
		Unit unit = unitService.getById(card.getTypeid());
		unit.setCardno(card.getCardno());
		unit.setUpdateby(card.getUpdateby());
		unit.setUpdatetime(card.getUpdatetime());
		dao.merge(unit);
		return "车方卡：" + card.getCardno() + " 发给车属单位：" + unit.getName();
	}

	private String saveUser(Cardissue card) throws ServiceException {
		Userinfo user = userService.findById(card.getTypeid());
		user.setCardno(card.getCardno());
		user.setUpdateby(card.getUpdateby());
		user.setUpdatetime(card.getUpdatetime());
		dao.merge(user);
		return "员工卡：" + card.getCardno() + " 发给用户：" + user.getName();
	}

	private Vip saveVip(Cardissue card, Vip vip) throws ServiceException {
		return saveVip(card,vip,false);
	}

	/**
	 * 
	 * @param card
	 * @param vip
	 * @param isrepair 是否补卡
	 * @return
	 * @throws ServiceException
	 */
	private Vip saveVip(Cardissue card, Vip vip,boolean isrepair) throws ServiceException {
		if (vip.getId() > 0) {
			Vip vp = (Vip) dao.get(Vip.class, vip.getId());
			if (dao.isExistCustomer(vp.getCustomerid(), "(0)")) {//"(0,5)"
				throw new ServiceException("0245");
			}
			vp.setCreatetime(new Date());
			vp.setStatus(card.getStatus());
			vp.setRemarks(vip.getRemarks());
			vp.setUpdateby(card.getUpdateby());
			vp.setUpdatetime(card.getUpdatetime());
			
			return (Vip) dao.merge(vp);
		} else {
			// vip.setCustomerid(card.getTypeid());
			vip.setVipcardno(card.getCardno());
			Vip v = dao.getVipBycardno(vip.getVipcardno());
			if (v != null) {
				throw new ServiceException("0415");
			}
			if (!isrepair&&dao.isExistCustomer(vip.getCustomerid(), "(0,2,5)")) {
				throw new ServiceException("0245");
			}
			vip.setSerialnumber(card.getSerialnumber());
			vip.setIssueorgid(card.getIssueorgid());
			vip.setIssueticketoutletsid(card.getTicketoutletsid());
			vip.setIssuedate(new Date());
			vip.setIssueby(card.getIssueby());
			vip.setValiddate(card.getValiddate());
			vip.setStatus("0");
			vip.setVipgrade(vip.getVipgradefirst());
			// BigDecimal big = new BigDecimal(0);
			// vip.setMoney(big);
			// vip.setVipamount(big);
			vip.setIsturnover(false);
			vip.setIsactive(true);
			vip.setCreateby(card.getCreateby());
			vip.setCreatetime(card.getCreatetime());
			vip.setUpdateby(card.getUpdateby());
			vip.setUpdatetime(card.getUpdatetime());
			return (Vip) dao.merge(vip);
		}
	}

	private String saveSteward(Cardissue card) throws ServiceException {
		Steward steward = stewardService.findbyid(card.getTypeid());
		steward.setCardno(card.getCardno());
		steward.setUpdateby(card.getUpdateby());
		steward.setUpdatetime(card.getUpdatetime());
		dao.merge(steward);
		return "乘务员卡：" + card.getCardno() + " 发给乘务员：" + steward.getName();
	}

	private String saveDriver(Cardissue card) throws ServiceException {
		Driver driver = driverService.findbyid(card.getTypeid());
		driver.setCardno(card.getCardno());
		driver.setUpdateby(card.getUpdateby());
		driver.setUpdatetime(card.getUpdatetime());
		dao.merge(driver);
		return "驾驶员卡：" + card.getCardno() + " 发给驾驶员：" + driver.getName();
	}

	private String saveVehicle(Cardissue card) throws ServiceException {
		Vehicle vehicle = vehicleService.findById(card.getTypeid());
		vehicle.setCardno(card.getCardno());
		vehicle.setUpdateby(card.getUpdateby());
		vehicle.setUpdatetime(card.getUpdatetime());
		dao.merge(vehicle);
		return "报到卡：" + card.getCardno() + " 发给车辆：" + vehicle.getVehicleno();
	}

	private Long getIdByCardno(String cardno, String type, String status) {
		return dao.getidByCardno(cardno, type, status);
	}

	@Override
	public boolean delete(Cardissue card) {
		if (card != null) {
			return dao.del(card);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Cardissue.class, id);
	}

	@Override
	public List<Cardissue> query(Date date) {
		return dao.query(date);
	}

	@Override
	public Cardissue getById(Long id) {
		return (Cardissue) dao.get(Cardissue.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "issueby", "id",
				"serialnumber", "cardno", "type", "typeid", "validdate",
				"issuetime", "issueip", "status", "createtime", "updatetime",
				"billtypeid", "issueorgid", "ticketoutletsid", "createname",
				"outletsname", "billname", "issuename", "issueorgname",
				"updatename", "typename", "createby", "updateby","certificateno","mobilephone", "money",
				"vipamount", "vipid", "cardcost", "customerid", "grade" },
				dao.query(propertyFilterList), new Object[] { Long.class,Long.class
						, String.class, String.class, String.class,Long.class, Timestamp.class
						, Timestamp.class,String.class, String.class, Timestamp.class,Timestamp.class
						, Long.class, Long.class, Long.class,String.class
						, String.class, String.class, String.class,String.class
						, String.class, String.class, Long.class,Long.class, String.class, String.class, BigDecimal.class
						, BigDecimal.class,Long.class, BigDecimal.class, Long.class, String.class
						});
	}

	// @SuppressWarnings("rawtypes")
	// @Override
	@SuppressWarnings("rawtypes")
	public boolean isExist(Cardissue card) {
		List list = dao.getResult(card);
		if (list.isEmpty()) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public Long getId(String tablename) {
		if ("unit".equals(tablename)) {
			return dao.getId("Unit");
		} else if ("driver".equals(tablename)) {
			return dao.getId("Driver");
		} else if ("steward".equals(tablename)) {
			return dao.getId("Steward");
		} else if ("vip".equals(tablename)) {
			return dao.getId("Vip");
		} else if ("userinfo".equals(tablename)) {
			return dao.getId("Userinfo");
		} else if ("unit".equals(tablename)) {
			return dao.getId("Unit");
		}
		return (long) 0;
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.base.service.CardissueService#replaceCard(cn.nova.bus.base
	 * .model.Cardissue, java.lang.String, cn.nova.bus.archive.model.Vip)
	 */
	@Override
	public Cardissue replaceCard(Cardissue cardissue, String ipAddress, Vip vip)
			throws ServiceException {
		if(dao.isExistSerialnumber(cardissue.getSerialnumber())){
			throw new ServiceException("0427");//该卡已经被使用过，不能再次使用！
		}		
		Vip vp = vipService.findById(vip.getCustomerid(), "2");
		Cardissue card = getById(dao.getidByCardno(vp.getVipcardno(), "3", "2"));// 3代表乘客，
																					// 0为状态

		vip.setMoney(vp.getMoney());
		vip.setVipamount(vp.getVipamount());
		vip.setCustomerid(vp.getCustomerid());

		vp.setMoney(new BigDecimal(0));
		vp.setVipamount(new BigDecimal(0));
		vp.setUpdateby(cardissue.getUpdateby());
		vp.setUpdatetime(cardissue.getUpdatetime());
		vp.setStatus("5");
		dao.merge(vp);

		card.setUpdateby(cardissue.getUpdateby());
		card.setUpdatetime(cardissue.getUpdatetime());
		card.setStatus("5");
		dao.merge(card);

		Customer cus = (Customer) dao.get(Customer.class, vp.getCustomerid());
		String result = "VIP卡：" + card.getCardno() + " 发给VIP乘客："
				+ cus.getName();

		cardissue.setTypeid(saveVip(cardissue, vip,true).getId());// 取VIP的ID
		
		Vipremainmoneytransfer vremain = new Vipremainmoneytransfer();//用来保存换卡后余额跟积分的记录
		vremain.setOldvipid(vp.getId());
		vremain.setNewvipid(cardissue.getTypeid());//上面已经给setTypeid赋值了
		vremain.setCreateby(vp.getUpdateby());
		vremain.setCreatetime(new Date());
		vremain.setUpdateby(vp.getUpdateby());
		vremain.setUpdatetime(new Date());
		vremain.setMoney(vip.getMoney());
		vremain.setVipamount(vip.getVipamount());
		dao.merge(vremain);
		
		
		
		Operationlog operationLog = new Operationlog();
		operationLog.setIp(ipAddress);
		operationLog.setContent(result);
		operationLog.setModule("业务管理->智能卡管理");
		operationLog.setOperatetime(new Date());
		operationLog.setOperation("挂失补卡");
		operationLog.setSessionid("无session");
		operationLog.setUserid(card.getUpdateby());
		dao.merge(operationLog);

		Long typeid = billtypeService.getId("Vip");// 取票据类型ID
		cardissue.setBilltypeid(typeid);
		return (Cardissue) dao.merge(cardissue);
	}

	/*
	 * (non-Javadoc) VIP卡充值
	 * 
	 * @see
	 * cn.nova.bus.base.service.CardissueService#saveCardRecharge(java.lang.
	 * String, java.math.BigDecimal, cn.nova.bus.security.Global)
	 */
	@Override
	public Cardissue saveCardRecharge(String cardno, BigDecimal money,
			Long activityid,// 优惠活动ID
			Global global, BigDecimal balancemoney, BigDecimal amount) {
		Vip vip = vipService.findByCardNo(cardno, "0");// 取充值卡的VIP对象
		vip.setMoney(balancemoney.add(money));
		vip.setVipamount(amount);
		vip.setUpdateby(global.getUserinfo().getId());
		vip.setUpdatetime(new Date());
		dao.merge(vip);
		
		Viprecharge recharge = new Viprecharge();
		recharge.setVipid(vip.getId());
		recharge.setMoney(money);
		recharge.setCreateby(global.getUserinfo().getId());
		recharge.setCreatetime(new Date());
		recharge.setUpdateby(global.getUserinfo().getId());
		recharge.setUpdatetime(new Date());
		recharge.setRechargeby(global.getUserinfo().getId());
		recharge.setRechargetime(new Date());
		recharge.setIsturnover(false);
		recharge.setTurnoverid(new Long(0));
		if (activityid != null) {
			recharge.setRechargepromotionactivityid(activityid);
		} else {
			recharge.setRechargepromotionactivityid(null);
		}
		dao.merge(recharge);// 保存充值记录

		Cardissue card = (Cardissue) dao.get(Cardissue.class,
				dao.getidByCardno(cardno, "3", "0"));
		return card;
	}
	
	/**
	 * 激活卡有效期(只有正常卡，和过期卡才能激活)
	 */
	@Override
	public Cardissue cardActive(Cardissue card){
		Cardissue updatecard = (Cardissue) dao.get(Cardissue.class, card.getId());
		updatecard.setValiddate(card.getValiddate());
		updatecard.setStatus("0");
		updatecard.setUpdatetime(new Date());
		updatecard.setUpdateby(card.getUpdateby());
		Cardissue results = (Cardissue) dao.merge(updatecard);
		return results;
	}
}