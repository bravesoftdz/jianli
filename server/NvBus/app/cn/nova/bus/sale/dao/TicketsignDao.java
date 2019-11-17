package cn.nova.bus.sale.dao;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.utils.orm.PropertyFilter;


public class TicketsignDao  extends EntityManagerDaoSurport<Ticketsign>{
	
	public boolean sign(Ticketsign ticketsign){
		if(ticketsign.getId()<=0){
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!sellid",ticketsign.getSellid()));
			Ticketsign _ticketsign = null;
			_ticketsign = (Ticketsign) super.uniqueResult(Ticketsign.class, propertyFilters);
			if(_ticketsign!=null){
				ticketsign.setId(_ticketsign.getId());
			}
		}
		super.merge(ticketsign);
		return true;
	}

}
