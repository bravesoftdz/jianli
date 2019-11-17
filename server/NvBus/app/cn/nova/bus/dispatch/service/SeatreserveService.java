package cn.nova.bus.dispatch.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.dispatch.model.Seatreserveagent;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;

public interface SeatreserveService {

	//综合调度留位
	public MethodResult save(Seatreserve seatreserve, String seatnos) throws Exception;
	public MethodResult save(String remoteTransactionId, Seatreserve seatreserve, String seatnos) throws Exception;

	//留位销售
	public MethodResult save(List<Seatreserve> seatreserves) ;
	
	public MethodResult cancelReserve(Seatreserve seatreserve, String seatnos) throws Exception;

	public boolean delete(Seatreserve seatreserve);

	public boolean delete(Long id);

	public List<Object> querySingleTable(List<PropertyFilter> propertyFilterList);

	public Seatreserve getById(Long id);
	
	public Seatreserveagent getAgentById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean isUniqu(short seatno, String sellstate);

	public Seatreserve getSeatreserve(Long scheduleplanid, Date departdate,
			short seatno);

	public Long getId(Long scheduleplanid, short seatno);



	public List<Seatreserve> getSeatreserveno(Date date);

	public Seatreserve saveReserve(Seatreserve reserve);
	
	public int querybookunsellcount(long customerid);//按顾客查询订票未取次数

}
