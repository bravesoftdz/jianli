package cn.nova.bus.onecard.action;

import cn.nova.bus.action.BaseAction;
import java.math.BigDecimal;
import java.util.Arrays;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.onecard.service.OneCardService;
import cn.nova.bus.onecard.service.impl.OneCardServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;

public class OneCardAction extends BaseAction{
	private OneCardService oneCardService;
	
	private long scheduleplanid;
	private long vehiclereportid;
	private long checkstationid;
	
	private String vipcardno;
	private String ticketentrance;
	private boolean carrychild;
	
	private List<Map<String,Object>> scheduleinfo;
	public String findScheduleinfo(){
		oneCardService = new OneCardServiceImpl();
		setScheduleinfo(oneCardService.findScheduleinfo(getScheduleplanid(),getCheckstationid(),vehiclereportid));
		return "json";
	}
	
	private String vipgrade;//VIP当前等级
	private BigDecimal vipmoney;//VIP当前余额
	private BigDecimal vippoint;//VIP当前积分
	public String sellandcheck(){
		oneCardService = new OneCardServiceImpl();
		try {
			Global global = CurrentUtil.getGlobal();
			MethodResult methodResult = oneCardService.sellandcheck(global, vipcardno, vehiclereportid, scheduleplanid, checkstationid, ticketentrance, carrychild,vipgrade,vipmoney,vippoint);
			if(methodResult.getResult()==MethodResult.SUCCESS){
				markSuccess();
			}else{
				markFlag(methodResult.getResult());
			}
			setMsg(methodResult.getResultMsg());
		} catch (Exception e) {
			markFailure();
			setMsg("刷卡上车失败:"+e.getMessage());
		}
		return "json";
	}
	
	private List<Map<String,Object>> ticketinfo;
	public String findTicketinfo(){
		oneCardService = new OneCardServiceImpl();
		setTicketinfo(oneCardService.findTicketinfo(vipcardno));
		return "json";
	}

	private String ticketnos;
	public String returncheckandsell(){
		try {
			oneCardService = new OneCardServiceImpl();
			Global global = CurrentUtil.getGlobal();
			List<String> _ticketnos = Arrays.asList(ticketnos.split(","));
			MethodResult methodResult = oneCardService.returncheckandsell(global, checkstationid, _ticketnos,vipcardno,vipgrade,vipmoney,vippoint);
			if(methodResult.getResult()==MethodResult.SUCCESS){
				markSuccess();
			}else{
				markFlag(methodResult.getResult());
			}
			setMsg(methodResult.getResultMsg());
		} catch (Exception e) {
			markFailure();
			setMsg("退检退票失败:"+e.getMessage());
		}
		return "json";
	}
	
	public String getVipcardno() {
		return vipcardno;
	}

	public void setVipcardno(String vipcardno) {
		this.vipcardno = vipcardno;
	}

	public long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public String getTicketentrance() {
		return ticketentrance;
	}

	public void setTicketentrance(String ticketentrance) {
		this.ticketentrance = ticketentrance;
	}

	public boolean isCarrychild() {
		return carrychild;
	}

	public void setCarrychild(boolean carrychild) {
		this.carrychild = carrychild;
	}

	public List<Map<String,Object>> getScheduleinfo() {
		return scheduleinfo;
	}

	public void setScheduleinfo(List<Map<String,Object>> scheduleinfo) {
		this.scheduleinfo = scheduleinfo;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public long getCheckstationid() {
		return checkstationid;
	}

	public void setCheckstationid(long checkstationid) {
		this.checkstationid = checkstationid;
	}

	public String getTicketnos() {
		return ticketnos;
	}

	public void setTicketnos(String ticketnos) {
		this.ticketnos = ticketnos;
	}

	public List<Map<String,Object>> getTicketinfo() {
		return ticketinfo;
	}

	public void setTicketinfo(List<Map<String,Object>> ticketinfo) {
		this.ticketinfo = ticketinfo;
	}

	public String getVipgrade() {
		return vipgrade;
	}

	public void setVipgrade(String vipgrade) {
		this.vipgrade = vipgrade;
	}

	public BigDecimal getVipmoney() {
		return vipmoney;
	}

	public void setVipmoney(BigDecimal vipmoney) {
		this.vipmoney = vipmoney;
	}

	public BigDecimal getVippoint() {
		return vippoint;
	}

	public void setVippoint(BigDecimal vippoint) {
		this.vippoint = vippoint;
	}

}
