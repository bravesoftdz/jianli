package cn.nova.bus.sale.action;

import java.math.BigDecimal;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.service.TicketpriceReturnService;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.impl.TicketpriceReturnServiceImpl;
import cn.nova.bus.sale.service.impl.TicketreturnServiceImpl;
/**
 * <b>类名称：</b>TicketpriceReturnAction <br/>
 * <b>类描述：</b>原路退款 Action <br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2018年6月13日 上午9:07:22<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
  * <b>任务号：</b>2018年6月13日 上午9:07:22<br/>
 */
public class TicketpriceReturnAction extends BaseAction{
	
	private TicketpriceReturnService ticketpriceReturnService;
	
	private String ticketsellids;//原路退款车票 IDS 字符串 (,分隔) 
	private String insuranceids;//原路退款保险 IDS 字符串 (,分隔) 
	private String remark;//原路退款原因
	
	private Integer totalticketnum;//原路退款车票张数
	
	private Integer totalinsurancenum;//原路退款保险张数
	
	private BigDecimal totalticketmoney;//车票原路退款金额
	
	private BigDecimal totalinsurancemoney;//原路退款保险金额
	
	public String returnTickets(){
		try {
			if(null == ticketpriceReturnService){
				ticketpriceReturnService = new TicketpriceReturnServiceImpl();
			}
			//原路退款
			ticketpriceReturnService.returnTickets(ticketsellids,remark,totalticketnum,totalinsurancenum,totalticketmoney,totalinsurancemoney);
			markSuccess();
			setMsg("原路退款成功！");
		}catch (BusinessException e){
			markFailure();
			setMsg("原路退款失败:" + e.getMessage());
			play.Logger.error("原路退款失败", e,e.getMessage());
		} catch (Exception e) {
			markFailure();
			setMsg("原路退款失败，请稍后重试！");
			play.Logger.error("原路退款失败", e,e.getMessage());
		}
		return "json";
	}
	
	public static void main(String[] args) {
		// TODO Auto-generated method stub

	}

	public String getTicketsellids() {
		return ticketsellids;
	}

	public void setTicketsellids(String ticketsellids) {
		this.ticketsellids = ticketsellids;
	}

	public String getInsuranceids() {
		return insuranceids;
	}

	public void setInsuranceids(String insuranceids) {
		this.insuranceids = insuranceids;
	}

	public String getRemark() {
		return remark;
	}

	public void setRemark(String remark) {
		this.remark = remark;
	}

	public Integer getTotalticketnum() {
		return totalticketnum;
	}

	public void setTotalticketnum(Integer totalticketnum) {
		this.totalticketnum = totalticketnum;
	}

	public Integer getTotalinsurancenum() {
		return totalinsurancenum;
	}

	public void setTotalinsurancenum(Integer totalinsurancenum) {
		this.totalinsurancenum = totalinsurancenum;
	}

	public BigDecimal getTotalticketmoney() {
		return totalticketmoney;
	}

	public void setTotalticketmoney(BigDecimal totalticketmoney) {
		this.totalticketmoney = totalticketmoney;
	}

	public BigDecimal getTotalinsurancemoney() {
		return totalinsurancemoney;
	}

	public void setTotalinsurancemoney(BigDecimal totalinsurancemoney) {
		this.totalinsurancemoney = totalinsurancemoney;
	}
	
	
	
}
