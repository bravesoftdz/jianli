package cn.nova.bus.base.dao;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Ticketprint;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.ticketprint.param.TicketPrintParam;

public class TicketPrintDao extends EntityManagerDaoSurport {
    	
    public Ticketprint getTicketprint() {
    	
    	String sql = "select t from Ticketprint t";
    	Query query = getEntityManager().createQuery(sql.toString());
    	List<Ticketprint> list = query.getResultList();
    	if(list.size() > 0) {
    		return list.get(0);
    	}	
    	return null;
    }
    
    public TicketPrintParam getPrintParam(String ticketno) {
    	
    	StringBuilder buider = new StringBuilder("select sel.ticketno,  sted.name as reachStation, r.name as route, ")
    	.append(" sel.departdate ")
		.append(" from Ticketsell sel, Scheduleplan pl, Schedule sch, Route r, Station sted ")
		.append(" where sel.ticketno=:ticketno ")
		.append(" and sel.departdate>sysdate-10 ")
		.append(" and sel.scheduleplanid=pl.id and pl.scheduleid=sch.id and sch.route.id=r.id ")
		.append(" and sel.reachstationid=sted.id ");

    	Query query = getEntityManager().createQuery(buider.toString());
    	query.setParameter("ticketno", ticketno);
    	List<Object> list = query.getResultList();
    	if(list.size() > 0) {
    		Object[] objarray = (Object[])list.get(0);
    		String reachStation = (String) objarray[1];
    		String route = (String) objarray[2];
    		Date date = (Date)objarray[3];
    		
    		TicketPrintParam param= new TicketPrintParam();
    		param.setTicketno(ticketno);
    		param.setReachStation(reachStation);
    		param.setRoute(route);
    		param.setDepartdate(date.toString());
    		return param;
    			
    	}	
    	return null;
    }
    
    
}
