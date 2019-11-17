package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.CustomerCache;
import cn.nova.bus.archive.service.CustomerService;
import cn.nova.bus.archive.service.impl.CustomerServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class CustomerAction extends BaseAction{
	CustomerService customerService;
	
	private Customer customer;
	private List<Customer> customerlist; //批量操作
	//返回结果
	private List<Map<String,Object>> customermap;
	private List<Map<String,Object>> ticketdetailmap;
	private long customerid;
	private String showfullidno;
	private String inputtype;
	private int scount;
	private int fcount;
	private List<Map<String,Object>> customerCachemap;
	//参数
	private Long delid;
	
	private String c_info;
	private String computercode;
	private Integer icSize;
	/**
	 * 批量导入顾客信息
	 * @return
	 */
	public String savecustomerlistfromexcel() {
		try {
			customerService = new CustomerServiceImpl();
			MethodResult mr = customerService.savecustomerlistfromexcel(c_info,inputtype);
			scount = Integer.valueOf(mr.getResultMsg());
			fcount = (Integer) mr.getObject();
		} catch (Exception ex) {
			setMsg("导入失败,详情请查看日志!");
			ex.printStackTrace();
		}
		return "json";
	}
	
	public String saveCustomer(){
		customerService = new CustomerServiceImpl();
		String show ="";
		Customer c = null;
		Global global = CurrentUtil.getGlobal();
		try{
			customer.setIsactive(true);
			if(customer.getId()!=0){
				customer.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				customer.setUpdateby(global.getUserinfo().getId());
				show="修改顾客档案";
			}else{
				customer.setCreateby(global.getUserinfo().getId());
				customer.setCreatetime(new Timestamp(System.currentTimeMillis()));	
				customer.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				customer.setLastbuytickettime(new Timestamp(System.currentTimeMillis()));
				customer.setUpdateby(global.getUserinfo().getId());
				show="添加顾客档案";
			}
			c = customerService.saveCustomer(customer);
			if(c!=null){
				customerid = c.getId();
				setMsg(show+"成功");
				markSuccess();
			}
			else{
				setMsg(show+"失败");
				markFailure();
			}
		}catch(ServiceException ex){
			setMsg(show+"失败;" +ex.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String saveCustomerlist(){
		customerService = new CustomerServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date datetime = new Date(); 
		try {
			for(int i =0;i<customerlist.size();i++){
				Customer customers = customerlist.get(i);
				customers.setUpdateby(global.getUserinfo().getId());
				customers.setUpdatetime(datetime);
				if(customers.getId()<=0){
					customers.setCreateby(global.getUserinfo().getId());
					customers.setCreatetime(datetime);
				}
			}
			//去除重复，进行保存
			for(int i=0;i<customerlist.size();i++){
				int size =customerlist.size();
				for(int j=size-1;j>=i+1;j--){
					if((customerlist.get(i).getCertificatetype().toString()+customerlist.get(i).getCertificateno().toString()).equals(
							customerlist.get(j).getCertificatetype().toString()+customerlist.get(j).getCertificateno().toString()) && j!=i){
						customerlist.remove(j);
					}
				}
			}
			customerService.saveCustomerlist(customerlist);
			for (Customer c : customerlist) {//黑名单用户不能售票
				if(c.isIsblack()){
					throw new ServiceException("6221");
				}
			}
			//保存之后，将id赋值给重复的客户，返回给前台界面。
//			for(int i=0;i<incustomerlist.size();i++){
//				for(int j=0;j<customerlist.size();j++){
//					if((incustomerlist.get(i).getCertificatetype().toString()+incustomerlist.get(i).getCertificateno().toString()).equals(
//							customerlist.get(j).getCertificatetype().toString()+customerlist.get(j).getCertificateno().toString())){
//						incustomerlist.get(i).setId(customerlist.get(j).getId());
//					}
//				}
//			}
			
			setMsg("批量保存顾客档案成功");
			markSuccess();
			} catch (ServiceException e) {
				setMsg(e.getExceptionMessage());
				markFail();
			}
		List<Object> results =new ArrayList<Object>(customerlist);  
		setCustomermap(ListUtil.listToMap(new Object[]{Customer.class}, results));
		return "json";
	}
	
	public String findCustomer(){
		customerService = new CustomerServiceImpl();
		try{
			 setCustomermap(customerService.queryCustomer(ServletPropertyFilterUtil.buildFromHttpRequest(),showfullidno));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
	
	//售票用查询默认客户信息
	public String findDefaultCustomer(){
		customerService = new CustomerServiceImpl();
		try{
			 setCustomermap(customerService.queryDefaultCustomer(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}	
	/**
	 * 根据窗口唯一标识获取蓝山app接口的身份证信息
	 * @return
	 */
	public String queryIdentityCard(){
		customerService = new CustomerServiceImpl();
		try{
			 setCustomerCachemap(customerService.queryIdentityCard(icSize,computercode));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}		
		return "json";
	}
//	@Action(value="findTicketDetail")
//	public String findTicketDetail(){		
//		try{
//			 setTicketdetailmap(customerService.queryBuyTickets(ServletPropertyFilterUtil.buildFromHttpRequest(Struts2Utils.getRequest())));			
//		} catch (Exception e) {
//				play.Logger.error(e.getMessage(), e);
//		}		
//		return "json";
//	}
	
	public String delCustomer(){
		customerService = new CustomerServiceImpl();
		if(customerService.delCustomer(delid)){
			setMsg("删除顾客档案成功");
			markSuccess();
		}else{
			setMsg("删除顾客档案失败");
			markFail();
		}
		return "json";
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public List<Map<String, Object>> getCustomermap() {
		return customermap;
	}

	public void setCustomermap(List<Map<String, Object>> customermap) {
		this.customermap = customermap;
	}

	public Long getDelid() {
		return delid;
	}

	public void setDelid(Long delid) {
		this.delid = delid;
	}

	public List<Map<String, Object>> getTicketdetailmap() {
		return ticketdetailmap;
	}

	public void setTicketdetailmap(List<Map<String, Object>> ticketdetailmap) {
		this.ticketdetailmap = ticketdetailmap;
	}

	public List<Customer> getCustomerlist() {
		return customerlist;
	}

	public void setCustomerlist(List<Customer> customerlist) {
		this.customerlist = customerlist;
	}

	public long getCustomerid() {
		return customerid;
	}

	public void setCustomerid(long customerid) {
		this.customerid = customerid;
	}

	public String getShowfullidno() {
		return showfullidno;
	}

	public void setShowfullidno(String showfullidno) {
		this.showfullidno = showfullidno;
	}

	public String getC_info() {
		return c_info;
	}

	public void setC_info(String c_info) {
		this.c_info = c_info;
	}

	public String getInputtype() {
		return inputtype;
	}

	public void setInputtype(String inputtype) {
		this.inputtype = inputtype;
	}

	public int getScount() {
		return scount;
	}

	public void setScount(int scount) {
		this.scount = scount;
	}

	public int getFcount() {
		return fcount;
	}

	public void setFcount(int fcount) {
		this.fcount = fcount;
	}

	public List<Map<String, Object>> getCustomerCachemap() {
		return customerCachemap;
	}

	public void setCustomerCachemap(List<Map<String, Object>> customerCachemap) {
		this.customerCachemap = customerCachemap;
	}

	public String getComputercode() {
		return computercode;
	}

	public void setComputercode(String computercode) {
		this.computercode = computercode;
	}

	public Integer getIcSize() {
		return icSize;
	}

	public void setIcSize(Integer icSize) {
		this.icSize = icSize;
	}

}
