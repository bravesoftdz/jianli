package cn.nova.bus.archive.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.lang.StringUtils;

import cn.nova.bus.archive.dao.CustomerDao;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.CustomerCache;
import cn.nova.bus.archive.model.CustomerUpdateVo;
import cn.nova.bus.archive.service.CustomerService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
import play.Play;
import play.db.jpa.JPA;
import util.CommonUtil;
import util.CurrentUtil;
import util.RpcUtil;

public class CustomerServiceImpl implements CustomerService {

	private IDAO<Customer> dao = new EntityManagerDaoSurport<Customer>();

	private CustomerDao customerdao = new CustomerDao();

	@Override
	public Customer saveCustomer(Customer customer) throws ServiceException {

		if (customer.getId() != 0) {
			if (customerdao.isExistCustomer(customer.getCertificatetype(), customer.getCertificateno(), null) != 0
					&& customerdao.isExistCustomer(customer.getCertificatetype(), customer.getCertificateno(),
							null) != customer.getId()) {
				throw new ServiceException("0112");
			}
			if (customer.getMobilephone() != null
					&& customerdao.isExistCustomer(null, null, customer.getMobilephone()) != 0
					&& customerdao.isExistCustomer(null, null, customer.getMobilephone()) != customer.getId()) {
				throw new ServiceException("0038");
			}
			Customer n = dao.get(Customer.class, customer.getId());
			customer.setSynccode(n.getSynccode());
			customer.setLastbuytickettime(n.getLastbuytickettime());
			return dao.merge(customer);
		} else {
			if (customerdao.isExistCustomer(customer.getCertificatetype(), customer.getCertificateno(), null) != 0) {
				throw new ServiceException("0112");
			}
			if (customer.getMobilephone() != null
					&& customerdao.isExistCustomer(null, null, customer.getMobilephone()) != 0) {
				throw new ServiceException("0038");
			}
			return dao.merge(customer);
		}
	}

	@Override
	public boolean saveCustomerlist(List<Customer> customerlist) throws ServiceException {
		for (Customer customer : customerlist) {
			Customer cus = customerdao.findCustomer(customer.getCertificatetype(), customer.getCertificateno(), null,
					customer.getName());

			if (cus != null && (customer.getId() <= 0 || (customer.getId() > 0 && cus.getId() != customer.getId()))) {
				customer.setId(cus.getId());
				if(cus.getId()>1){
					customer.setIsblack(cus.isIsblack());
					customer.setIsred(cus.isIsred());
					cus.setName(customer.getName());
					cus.setIsactive(true);
					cus.setLastbuytickettime(new Date());
					 if(CommonUtil.isNotEmptyString(customer.getMobilephone())){
						 cus.setMobilephone(customer.getMobilephone());
					 }
					dao.merge(cus);	
				}
			} else {
				customer.setIsactive(true);
				customer.setId(dao.merge(customer).getId());
				JPA.em().flush();
			}
		}
		return true;
	}

	@Override
	public Boolean delCustomer(long id) {
		return customerdao.update(id);
	}

	@Override
	public List<Map<String, Object>> queryCustomer(List<PropertyFilter> propertyFilterList, String showfullidno) {
		Object[] fileds = { "id", "orgid", "createby", "education", "familyaddress", "familyphone", "mobilephone",
				"name", "sex", "updateby", "certificateno", "certificatetype", "inputway", "remarks", "createtime",
				"updatetime", "birthday", "email", "ticketoutletsid", "lastbuytickettime", "orgname", "createname",
				"updatename", "vipgrade", "vipcardno", "money", "vipamount", "status", "vipgradename",
				"departstationname", "reachstationname", "endstationname", "ticketno", "schcode", "departdate",
				"tsdeparttime", "planvehicleno", "nation", "isblack", "isblackcheck", "isred", "isredstring",
				"ticketstatus","seatno" };  //车票状态，座位号
		Object[] filedtypes = { long.class, long.class, long.class, String.class, String.class, String.class,
				String.class, String.class, String.class, long.class, String.class, String.class, String.class,
				String.class, Timestamp.class, Timestamp.class, Date.class, String.class, Long.class, Timestamp.class,
				String.class, String.class, String.class, String.class, String.class, BigDecimal.class,
				BigDecimal.class, String.class, String.class, String.class, String.class, String.class, String.class,
				String.class, Date.class, String.class, String.class, String.class, String.class, Boolean.class,
				Boolean.class, String.class,String.class,BigDecimal.class };
		return ListUtil.listToMap(fileds, customerdao.queryCustomer(propertyFilterList, showfullidno), filedtypes);
	}

	@Override
	public List<Map<String, Object>> queryBuyTickets(List<PropertyFilter> propertyFilterList) {
		Object[] fileds = { "selltime", "departdate", "departtime", "fullprice", "seatno", "ticketentrance",
				"ischecked", "schedulename", "reachname", "ticketoutname" };// 初始化要查询的字段
		Object[] filedtypes = { String.class, String.class, String.class, String.class, String.class, String.class,
				boolean.class, String.class, String.class, String.class };// 初始化要查询的字段 类型
		return ListUtil.listToMap(fileds, customerdao.queryBuyTicket(propertyFilterList), filedtypes);

	}

	/**
	 * 批量操作时，先查询操作对象是否满足保存需求
	 * 
	 * @param customer
	 * @return
	 */
	@Override
	public boolean canBeSave(Customer customer) {
		if (customer.getName() == null) {
			return false;
		} else if (customer.getSex() == null) {
			return false;
		} else if (customer.getCertificatetype() == null) {
			return false;
		} else if (customer.getCertificateno() == null) {
			return false;
		} else if (customer.getOrgid() == null) {
			return false;
		} else if (customer.getInputway() == null) {
			return false;
		} else if (customer.getLastbuytickettime() == null) {
			return false;
		}
		if (customerdao.isExistCustomer(customer.getCertificatetype(), customer.getCertificateno(), null) != 0) {
			return false;
		}
		if (customerdao.isExistCustomer(null, null, customer.getMobilephone()) != 0) {
			return false;
		}
		return true;
	}

	@SuppressWarnings("unchecked")
	@Override
	public Customer fineById(Long id) {
		return (Customer) customerdao.get(Customer.class, id);
	}

	@Override
	public List<Map<String, Object>> queryDefaultCustomer(List<PropertyFilter> propertyFilterList) {
		if(propertyFilterList.size()==0){
			play.Logger.info("queryDefaultCustomer propertyFilterList.size()==0");
			PropertyFilter propertyFilter =new PropertyFilter("EQL_t!id",new Long(1));
			propertyFilterList.add(propertyFilter);
		}	
		List clist = customerdao.find(Customer.class, propertyFilterList);
		// TODO Auto-generated method stub
		return ListUtil.listToMap(new Object[] { Customer.class }, clist, new Object[] { Customer.class });
	}

	@Override
	public MethodResult savecustomerlistfromexcel(String customerlist, String inputtype) {
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		MethodResult result = new MethodResult();
		result.setResult(1);
		int scount = 0;
		int fcount = 0;
		customerlist = customerlist.substring(0, customerlist.length() - 1);
		String[] c_infolist = customerlist.split("#");
		for (String c_info : c_infolist) {
			try {
				String[] customerinfo = c_info.split(";");
				String name = customerinfo[0].trim();
				String cerno = customerinfo[1].trim();
				String email = "";
				String phone = "";
				String address = "";
				if(customerinfo.length > 2) {
					email = customerinfo[2].trim();
					phone = customerinfo[3].trim();
					address = customerinfo[4].trim();
				}
				play.Logger.info("=============================================");
				play.Logger.info("传入数据:" + name + "------------" + cerno);
				Customer customer = customerdao.findCustomer("0", cerno, null, null);
				if (customer != null) {
					customer.setIsred("red".equals(inputtype)?true:false);
					customer.setIsblack("black".equals(inputtype)?true:false);
					customer.setIsactive(true);
					customer.setUpdateby(global.getUserinfo().getId());
					customer.setUpdatetime(now);
					customerdao.merge(customer);
					play.Logger.info("更新用户:" + customer.getName() + "------------" + customer.getCertificateno());
				} else {
					customer = new Customer();
					customer.setSex("男");
					customer.setIsred("red".equals(inputtype)?true:false);
					customer.setIsblack("black".equals(inputtype)?true:false);
					customer.setUpdateby(global.getUserinfo().getId());
					customer.setUpdatetime(now);
					customer.setCreateby(global.getUserinfo().getId());
					customer.setCreatetime(now);
					customer.setLastbuytickettime(DateUtils.add(now, -10));
					customer.setOrgid(global.getUserinfo().getOrgid());
					customer.setInputway("导入");
					customer.setIsactive(true);
					customer.setIslocaldelete(false);
					customer.setCertificateno(cerno);
					customer.setCertificatetype("0");
					customer.setName(name);
					customer.setEmail(email);
					customer.setMobilephone(phone);
					customer.setFamilyaddress(address);
					try {
						calCustomerinfo(customer);
					} catch (ParseException e) {
						play.Logger.error("身份证号计算有误:" + e.getMessage());
						e.printStackTrace();
						fcount += 1;
						continue;
					}
					customerdao.merge(customer);
					play.Logger.info("新增用户:" + customer.getName() + "------------" + customer.getCertificateno());
				}
				scount += 1;
				play.Logger.info("=============================================");
			} catch (Exception e) {
				play.Logger.error("导入有误:" + e.getMessage());
				e.printStackTrace();
				fcount += 1;
			}
		}
		result.setResultMsg(scount+"");
		result.setObject(fcount);
		return result;
	}

	public void calCustomerinfo(Customer customer) throws ParseException {
		String cardno = customer.getCertificateno();
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		String year;
		String month;
		String day;
		String sex;
		switch (cardno.length()) {
		case 18:
			year = cardno.substring(6).substring(0, 4);// 得到年份
			month = cardno.substring(10).substring(0, 2);// 得到月份
			day = cardno.substring(12).substring(0, 2);// 得到日
			if (Integer.parseInt(cardno.substring(16).substring(0, 1)) % 2 == 0) {// 判断性别
				sex = "女";
			} else {
				sex = "男";
			}
			customer.setBirthday(format.parse(year + "-" + month + "-" + day));
			customer.setSex(sex);
			break;
		case 15:
			year = "19" + cardno.substring(6, 8);// 年份
			month = cardno.substring(8, 10);// 月份
			day = cardno.substring(10, 12);// 日
			if (Integer.parseInt(cardno.substring(14, 15)) % 2 == 0) {
				sex = "女";
			} else {
				sex = "男";
			}
			customer.setBirthday(format.parse(year + "-" + month + "-" + day));
			customer.setSex(sex);
			break;
		default:
			break;
		}

	}
	/**
	 * 根据窗口唯一标识获取蓝山app接口的身份证信息
	 * @throws Exception 
	 */
	@Override
	public  List<Map<String, Object>>  queryIdentityCard(Integer icSize,
			String computercode) throws Exception {
		List clist = new ArrayList<Map>();
//		return ListUtil.listToMap(new Object[] { CustomerCache.class }, clist, new Object[] { CustomerCache.class });
		String eidIp = Play.configuration.getProperty("eidIp");
		if(icSize>0 && StringUtils.isNotEmpty(computercode) && StringUtils.isNotEmpty(eidIp)){
			eidIp = eidIp + computercode;
			for (int i = 0; i < icSize; i++) {
				String value = RpcUtil.httpGet(eidIp, null, 10000, null);
				play.Logger.info(computercode+"请求获取中证宝身份证信息："+value);
				// 如果调用成功
				Map<String, Object> resultMap = cn.nova.openapi.util.JsonUtil
						.paseJson2Map(value);
				play.Logger.info("resultMap:"+resultMap);
				LinkedHashMap bodyMap = (LinkedHashMap) resultMap.get("body"); // json中body
				//{"success":false,"errorCode":"-1","msg":"error:用户不存在"}  返还报文样例
				play.Logger.info("bodyMap:"+bodyMap);
				boolean success = (Boolean) resultMap.get("success");
				//调整逻辑，先判断再取值
				if (success) {
					Map dataMap = (Map) bodyMap.get("data");
					play.Logger.info("dataMap:"+dataMap);				
					Map<String, Object> map = new HashMap<String, Object>();
					if (dataMap.containsKey("cardNo")) {
						map.put("cardno", dataMap.get("cardNo"));
						play.Logger.info("cardno"+dataMap.get("cardNo"));
					}
					if (dataMap.containsKey("address")) {
						map.put("address", dataMap.get("address"));
						play.Logger.info("address"+dataMap.get("address"));
					}
					if (dataMap.containsKey("mobile")) {
						map.put("mobile", dataMap.get("mobile"));
						play.Logger.info("mobile"+dataMap.get("mobile"));
					}
					if (dataMap.containsKey("realname")) {
						map.put("realname", dataMap.get("realname"));
						play.Logger.info("realname"+dataMap.get("realname"));
					}
					clist.add(map);
				}
			}
		}
		return clist;
		/*return ListUtil.listToMap(new Object[] { "cardno","address","mobile","realname" }, clist,
				new Object[] {String.class,String.class,String.class,String.class});*/
	}

	/**
	 * 更新customer表中的冗余字段
	 */
	@Override
	public void updateCustomer() {
		//查询总共有多少个班次运行计划ID
		List<Object> listScheduleplanid = customerdao.queryTicketsell();
		if (listScheduleplanid == null || listScheduleplanid.size() == 0 ) {
			return;
		}
		for (int i= 0; i < listScheduleplanid.size(); i++) {
			//查询售票表和客户表的关联信息
			List<Ticketsell> listTicketsellAndCustomer = customerdao.queryTicketsellAndCustomer(((BigDecimal)listScheduleplanid.get(i)).longValue());
			for (Ticketsell ticketsellAndCustomer : listTicketsellAndCustomer) {
				//查询客户表
				Customer customer = (Customer)customerdao.get(Customer.class, ticketsellAndCustomer.getCustomer().getId());
				if (customer.getLastbuytickettime().compareTo(ticketsellAndCustomer.getSelltime()) >= 0) {
					continue;
				}
				//查询要更新到customer表中的信息
				List<CustomerUpdateVo> listCustomerUpdateVo = customerdao.queryTicketsellInfo(ticketsellAndCustomer.getScheduleplanid(),customer.getId());
				if (listCustomerUpdateVo != null && listCustomerUpdateVo.size() > 0) {
					//向customer里更新数据
					CustomerUpdateVo customerUpdateVo = listCustomerUpdateVo.get(0);
					customer.setDepartstationname(customerUpdateVo.getDepartstationname());
					customer.setReachstationname(customerUpdateVo.getReachstationname());
					customer.setEndstationname(customerUpdateVo.getEndstationname());
					customer.setSchcode(customerUpdateVo.getSchcode());
					customer.setPlanvehicleno(customerUpdateVo.getPlanvehicleno());
					customer.setTicketno(ticketsellAndCustomer.getTicketno());
					customer.setDepartdate(ticketsellAndCustomer.getDepartdate());
					customer.setDeparttime(ticketsellAndCustomer.getDeparttime());
					customer.setTicketstatus(ticketsellAndCustomer.getTicketstatus());
					customer.setSeatno(((Short)ticketsellAndCustomer.getSeatno()).longValue());
					customer.setLastbuytickettime(ticketsellAndCustomer.getSelltime());
					customerdao.merge(customer);
				}
			}
		}
	}
}
