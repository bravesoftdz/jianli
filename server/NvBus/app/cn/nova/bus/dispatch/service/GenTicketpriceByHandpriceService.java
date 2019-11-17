package cn.nova.bus.dispatch.service;

import java.util.List;

import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.price.model.Handprice;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Ticketprice;
import cn.nova.bus.security.Global;

public interface GenTicketpriceByHandpriceService {
	public List<Ticketprice> genTicketprice(List<Handprice> handpricelist,Scheduleplan scheduleplan,Global global,Schedule schedule,long vehicletypeid,short seatnum);
}
