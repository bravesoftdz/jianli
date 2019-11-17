/**
 * 
 */
package cn.nova.bus.sale.param;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.sale.remote.param.ParamLockseatIn;


/**
 * @author ice
 * 售票参数类
 */
public class ParamSellTicketsIn extends cn.nova.bus.sale.remote.param.ParamSellTicketsIn {

//	private long departorgid;

	private static final long serialVersionUID = 1173372403187179678L;
	private long sellOrgId;//调用者机构
	private long sellerId;//用户id 

	private long ticketoutletsid;

	public ParamSellTicketsIn(cn.nova.bus.sale.remote.param.ParamSellTicketsIn paramSellTicketsIn){
		setSellOrgCode(paramSellTicketsIn.getSellOrgCode());  
		setSellIp(paramSellTicketsIn.getSellIp());  
		setSellerCode(paramSellTicketsIn.getSellerCode()); 
		setBatchno(paramSellTicketsIn.getBatchno());
		setStartTicketNO(paramSellTicketsIn.getStartTicketNO());  
		setTicketoutletsCode(paramSellTicketsIn.getTicketoutletsCode());
		setSellway(paramSellTicketsIn.getSellway());  
		setPaymethod(paramSellTicketsIn.getPaymethod()); 
		setOrderno(paramSellTicketsIn.getOrderno());  
		setBillCustomManage(paramSellTicketsIn.getBillCustomManage());
		List<cn.nova.bus.sale.remote.param.ParamSellTicketIn> paramSellTicketIn = new ArrayList<cn.nova.bus.sale.remote.param.ParamSellTicketIn>();
		for (cn.nova.bus.sale.remote.param.ParamSellTicketIn paramLockseatIn : paramSellTicketsIn.getSellseats()) {
			paramSellTicketIn.add(new ParamSellTicketIn(paramLockseatIn));
		}
		setSellseats(paramSellTicketIn);
	}
	
	public long getSellOrgId() {
		return sellOrgId;
	}

	public void setSellOrgId(long sellOrgId) {
		this.sellOrgId = sellOrgId;
	}

	public long getSellerId() {
		return sellerId;
	}

	public void setSellerId(long sellerId) {
		this.sellerId = sellerId;
	}

	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

}
