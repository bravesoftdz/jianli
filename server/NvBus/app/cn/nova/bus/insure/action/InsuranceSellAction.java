package cn.nova.bus.insure.action;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.insure.model.InsuranceOrder;
import cn.nova.bus.insure.model.InsurancePrintInfo;
import cn.nova.bus.insure.service.InsuranceSellService;
import cn.nova.bus.insure.service.impl.InsuranceSellServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class InsuranceSellAction extends BaseAction{
	private InsuranceSellService insuranceSellService;
	private List<InsurancePrintInfo> insurancePrintInfolist;
	private List<Map<String,Object>> insurancePrintInfos;
	private List<Map<String,Object>> tickets;
	private InsuranceOrder insuranceOrder;
	
	private long insuranceid;


	private int isnet;//是否请求联网票 0不联网，1本集团联网
	
	public String findEmptyInsurance(){
		insuranceSellService = new InsuranceSellServiceImpl();
		setInsurancePrintInfos(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, null));
		return "json";
	}	

	public String findTicket(){
		insuranceSellService = new InsuranceSellServiceImpl();
		setTickets(insuranceSellService.findTicket(ServletPropertyFilterUtil.buildFromHttpRequest(),isnet));
		return "json";
	}	

	public String sell(){
		insuranceSellService = new InsuranceSellServiceImpl();
		try {
			if(insurancePrintInfolist!=null){
				Iterator iterator = insurancePrintInfolist.iterator();
				while(iterator.hasNext()){
					InsurancePrintInfo insurancePrintInfo = (InsurancePrintInfo) iterator.next();
					if(!insurancePrintInfo.getIssell()){
						iterator.remove();
					}
				}
			}
			insuranceOrder.setInsurances(insurancePrintInfolist);
			Global global = CurrentUtil.getGlobal();
			insuranceOrder.setSeller(global.getUserinfo().getId());
			insuranceOrder.setOrgid(global.getOrganization().getId());
			MethodResult result=insuranceSellService.sell(insuranceOrder,isnet);
			if (result.getResult()==1){
				markSuccess();
				setMsg(result.getResultMsg());
				setInsurancePrintInfos(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, (List<Object>) result.getObject()));
			}
			else{
				markFailure();
				setMsg("售保险票失败:"+result.getResultMsg());
				setInsurancePrintInfos(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, null));
			}
		} catch (Exception e) {
			markFailure();
			setMsg("售保险票失败:"+e.getMessage());
			setInsurancePrintInfos(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, null));
		}
		return "json";
	}
	
	private String ticketno;
	private String certificateno;
	private String customername;
	private String insuranceno;
	private String insuretypecode;
	
	private long insureid;

	public String JJPreSell(){
		insuranceSellService = new InsuranceSellServiceImpl();
		try {
			MethodResult result=insuranceSellService.JJPreSell(ticketno, certificateno, customername, insuranceno, insuretypecode);
			if (result.getResult()==1){
				markSuccess();
				setMsg(result.getResultMsg());
				Insurance insurance = (Insurance) result.getObject();
				insureid = insurance.getId();
			}
			else{
				markFailure();
				setMsg("售保险票失败:"+result.getResultMsg());
			}
		} catch (Exception e) {
			markFailure();
			setMsg("售保险票失败:"+e.getMessage());
		}
		return "json";
	}

	private String polnumber;
	private String bkserial;
	private String validatecode;
	//九江模式打印保单成功，更新保单号
	public String JJSellCommit(){
		insuranceSellService = new InsuranceSellServiceImpl();
		try {
			MethodResult result=insuranceSellService.JJSellCommit(insuranceno, polnumber,bkserial,validatecode);

			if (result.getResult()==1){
				markSuccess();
				setMsg(result.getResultMsg());
			}
			else{
				markFailure();
				setMsg("确认售保险票失败:"+result.getResultMsg());
			}
		} catch (Exception e) {
			markFailure();
			setMsg("确认售保险票失败:"+e.getMessage());
		}
		return "json";
	}
	
	//九江模式打印保单失败，取消售保险
	public String JJSellRollback(){
		insuranceSellService = new InsuranceSellServiceImpl();
		try {
			MethodResult result=insuranceSellService.JJSellRollback(insuranceno);
			if (result.getResult()==1){
				markSuccess();
				setMsg(result.getResultMsg());
			}
			else{
				markFailure();
				setMsg("回滚售保险票失败:"+result.getResultMsg());
			}
		} catch (Exception e) {
			markFailure();
			setMsg("回滚售保险票失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String changenoreprint(){
		try {
			Global global = CurrentUtil.getGlobal();
			insuranceSellService = new InsuranceSellServiceImpl();
			if (insuranceSellService.changenoreprint(insuranceid,insuranceno,global)){
				markSuccess();
				setMsg("重打成功！");
				List<PropertyFilter> _propertyFilters = new ArrayList<PropertyFilter>();
				_propertyFilters.add(new PropertyFilter("EQL_isr!id",insuranceid));
				setTickets(insuranceSellService.findTicket(_propertyFilters,isnet));
			}else{
				markFailure();
				setMsg("重打失败！");
				setTickets(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, null));
			}
		}catch(ServiceException se){
			markFailure();
			setMsg(se.getMessage());
			setTickets(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, null));		
		 }catch (Exception e) {
			markFailure();
			setMsg("重打失败:"+e.getMessage());
			setTickets(ListUtil.listToMap(new Object[]{InsurancePrintInfo.class}, null));
		}
		return "json";
	}
	
	public List<InsurancePrintInfo> getInsurancePrintInfolist() {
		return insurancePrintInfolist;
	}
	public void setInsurancePrintInfolist(
			List<InsurancePrintInfo> insurancePrintInfolist) {
		this.insurancePrintInfolist = insurancePrintInfolist;
	}
	public List<Map<String, Object>> getInsurancePrintInfos() {
		return insurancePrintInfos;
	}
	public void setInsurancePrintInfos(List<Map<String, Object>> insurancePrintInfos) {
		this.insurancePrintInfos = insurancePrintInfos;
	}
	public InsuranceOrder getInsuranceOrder() {
		return insuranceOrder;
	}
	public void setInsuranceOrder(InsuranceOrder insuranceOrder) {
		this.insuranceOrder = insuranceOrder;
	}

	public void setTickets(List<Map<String,Object>> tickets) {
		this.tickets = tickets;
	}

	public List<Map<String,Object>> getTickets() {
		return tickets;
	}
	
	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}

	public String getCertificateno() {
		return certificateno;
	}

	public void setCertificateno(String certificateno) {
		this.certificateno = certificateno;
	}

	public String getCustomername() {
		return customername;
	}

	public void setCustomername(String customername) {
		this.customername = customername;
	}

	public String getInsuranceno() {
		return insuranceno;
	}

	public void setInsuranceno(String insuranceno) {
		this.insuranceno = insuranceno;
	}

	public String getInsuretypecode() {
		return insuretypecode;
	}

	public void setInsuretypecode(String insuretypecode) {
		this.insuretypecode = insuretypecode;
	}

	public String getPolnumber() {
		return polnumber;
	}

	public void setPolnumber(String polnumber) {
		this.polnumber = polnumber;
	}

	public long getInsureid() {
		return insureid;
	}

	public void setInsureid(long insureid) {
		this.insureid = insureid;
	}

	public String getValidatecode() {
		return validatecode;
	}

	public void setValidatecode(String validatecode) {
		this.validatecode = validatecode;
	}

	public String getBkserial() {
		return bkserial;
	}

	public void setBkserial(String bkserial) {
		this.bkserial = bkserial;
	}

	public int getIsnet() {
		return isnet;
	}

	public void setIsnet(int isnet) {
		this.isnet = isnet;
	}

	public long getInsuranceid() {
		return insuranceid;
	}

	public void setInsuranceid(long insuranceid) {
		this.insuranceid = insuranceid;
	}
}
