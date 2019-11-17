package cn.nova.bus.bill.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Ticketchargeoff;
import cn.nova.bus.bill.service.TicketChargeoffService;
import cn.nova.bus.bill.service.impl.TicketChargeoffServiceImpl;

/**
 * <b>类描述：票据核销</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-8-19 下午	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketChargeoffAction extends BaseAction{

	private List<Map<String, Object>> resultmap;
	private Ticketchargeoff ticketchargeoff;
	private String orgid;
	private Long userid;
	private Date begindate;
	private Date enddate;
	private long delid;

	private TicketChargeoffService chargeoffservice;

	/**
	 * 查询票据核销情况
	 * @return
	 */
	public String queryTicketChargeoff() {
		try {
			chargeoffservice = new TicketChargeoffServiceImpl();
			setResultmap(chargeoffservice.queryTicketChargeoff(
					orgid, userid, begindate, enddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 保存票据核销
	 * @return
	 */
	public String saveticketchargeoff(){
		chargeoffservice = new TicketChargeoffServiceImpl();
		ticketchargeoff.setChargetime(new Timestamp(System.currentTimeMillis()));
		boolean s = chargeoffservice.saveTicketChargeoff(ticketchargeoff);
		if(s){
			setMsg("核销成功");
			markSuccess();
		}else{
			setMsg("核销失败");
			markFailure();
		}
		return "json";
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public Date getBegindate() {
		return begindate;
	}

	public void setBegindate(Date begindate) {
		this.begindate = begindate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public Ticketchargeoff getTicketchargeoff() {
		return ticketchargeoff;
	}

	public void setTicketchargeoff(Ticketchargeoff ticketchargeoff) {
		this.ticketchargeoff = ticketchargeoff;
	}

	public long getDelid() {
		return delid;
	}

	public void setDelid(long delid) {
		this.delid = delid;
	}

}
