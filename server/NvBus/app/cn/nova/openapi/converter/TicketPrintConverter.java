package cn.nova.openapi.converter;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

import util.CommonUtil;
import util.JsonUtil;
import cn.nova.openapi.model.response.TicketSellInfo;
import cn.nova.openapi.model.response.TicketSellInfo.Ticket;
import cn.nova.utils.commons.TicketPrintInfo;

/**
 * 车票的转换
 * @author Mark
 *
 */
public class TicketPrintConverter extends DataConverter{

	/**
	 * 构造器，将从openapi得到的数据，填充到已经初始化好的数组中。
	 * @param ticketInfos
	 * @param ticketentrance
	 * @param buspark
	 * @return
	 */
	public List<TicketPrintInfo> converter(TicketSellInfo ticketInfos,String ticketentrance,String buspark) {
		  List<Ticket> tickets = JsonUtil.parseArray(ticketInfos.tickets, Ticket.class);
		  ArrayList<TicketPrintInfo> list = new ArrayList<TicketPrintInfo>();
		  for (int i = 0; i < tickets.size(); i++) {
			TicketPrintInfo tpi = new TicketPrintInfo();
			tpi.setDepartorgcode(ticketInfos.departorgname);
			tpi.setDepartstationcode(ticketInfos.departorgcode);
			tpi.setDepartstationname(ticketInfos.departorgname);
			tpi.setReachstationname(ticketInfos.reachstationname);
			tpi.setReachstationcode(ticketInfos.reachstationcode);
			tpi.setDepartdate(CommonUtil.parseStringToDate(ticketInfos.departdate));
			tpi.setDeparttime(ticketInfos.departtime);
			tpi.setSchedulecode(ticketInfos.schedulecode);
			tpi.setSeattype(DictConverter.parseSeatType(ticketInfos.seattype));
			tpi.setEticketid(tickets.get(i).ticketid);
			tpi.setTicketno(tickets.get(i).ticketno);
			tpi.setSeatno((short)tickets.get(i).seatno);
			tpi.setSeatnostr(String.valueOf(tickets.get(i).seatno));
			tpi.setServicefee(new BigDecimal(tickets.get(i).servicefee));
			
//			tpi.setTickettype(DictConverter.convertTicketType(tickets.get(i).tickettype));
			tpi.setTickettype(tickets.get(i).tickettype);
			tpi.setPrice(new BigDecimal(tickets.get(i).price));
			tpi.setEticketid(tickets.get(i).ticketid);
			tpi.setFullprice(new BigDecimal(0));
			tpi.setDiscountrate(new BigDecimal(0));
			tpi.setMoreprice(new BigDecimal(0));
			tpi.setToplimitprice(new BigDecimal(0));
			tpi.setFueladditionfee(new BigDecimal(0));
			tpi.setStationservicefee(new BigDecimal(tickets.get(i).stationservicefee));
			tpi.setComputefee(new BigDecimal(0));
			tpi.setCoolairfee(new BigDecimal(0));
			tpi.setAdditionfee(new BigDecimal(0));
			tpi.setWaterfee(new BigDecimal(0));
			tpi.setInsurefee(new BigDecimal(0));
			tpi.setOtherfee(new BigDecimal(0));
			tpi.setIslinework(false);
			tpi.setCarrychildnum((byte)0);
			tpi.setPaymethod("0");
			tpi.setTicketentrance(ticketentrance);
			tpi.setBuspark(buspark);
			list.add(tpi);
		  }	
		return list; 
	}

}
