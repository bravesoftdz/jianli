package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.sale.service.TakeTicketService;
import cn.nova.bus.sale.service.impl.TakeTicketServiceImpl;
import cn.nova.bus.security.Global;

@SuppressWarnings("unused")
public class TakeTicketAction extends BaseAction{
	private TakeTicketService takeTicketService;
	//取票方式
	private String takeway;
	//要打印的物理票号
	private String ticketno;
	//电子票号
	private String eticketno;
	//电子票验证码
	private String epassword;
	//班次查询结果
	private List<Map<String,Object>> eticketinfo;
	//售票ID，取票后返回
	private long ticketsellid;
	
	public String findETicket(){
		Global global = CurrentUtil.getGlobal();
		takeTicketService = new TakeTicketServiceImpl();
		setEticketinfo(takeTicketService.findETicketInfo(eticketno,epassword));
		setMsg("");
		markSuccess();
		return "json";
	}

	private String idcardno;//身份证号码
	private String orderno;//订单号
	private String mobilephone;//手机号码
	public String findETicketByCustomer(){
		takeTicketService = new TakeTicketServiceImpl();
		if((eticketno!=null&&!"".equals(eticketno))
			||(epassword!=null&&!"".equals(epassword))){
			setEticketinfo(takeTicketService.findETicketInfo(eticketno,epassword));
		}else{
			setEticketinfo(takeTicketService.findETicketInfoByCustomer(getIdcardno(),getOrderno(),getMobilephone()));
		}
		setMsg("");
		markSuccess();
		return "json";
	}

	private Long tsoid;
	public String sellTicket(){
		try {
			takeTicketService = new TakeTicketServiceImpl();
			Global global = CurrentUtil.getGlobal();
			ticketsellid = takeTicketService.takeTicket(getTicketno(), tsoid, global.getUserinfo().getId(),takeway);
			markSuccess();
			setMsg("");
		} catch (Exception e) {
			markFailure();
			setMsg("取票失败:"+e.getMessage());
		}
		return "json";
	}
	
	@Transient
	public String getEticketno() {
		return eticketno;
	}

	public void setEticketno(String eticketno) {
		this.eticketno = eticketno;
	}

	@Transient
	public String getEpassword() {
		return epassword;
	}

	public void setEpassword(String epassword) {
		this.epassword = epassword;
	}

	public List<Map<String,Object>> getEticketinfo() {
		return eticketinfo;
	}

	public void setEticketinfo(List<Map<String,Object>> eticketinfo) {
		this.eticketinfo = eticketinfo;
	}

	public long getTicketsellid() {
		return ticketsellid;
	}

	public void setTicketsellid(long ticketsellid) {
		this.ticketsellid = ticketsellid;
	}

	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getTakeway() {
		return takeway;
	}

	public void setTakeway(String takeway) {
		this.takeway = takeway;
	}

	public String getIdcardno() {
		return idcardno;
	}

	public void setIdcardno(String idcardno) {
		this.idcardno = idcardno;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getMobilephone() {
		return mobilephone;
	}

	public void setMobilephone(String mobilephone) {
		this.mobilephone = mobilephone;
	}

	public Long getTsoid() {
		return tsoid;
	}

	public void setTsoid(Long tsoid) {
		this.tsoid = tsoid;
	}

}
