package cn.nova.bus.sale.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.TicketpriceReturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import util.DateUtils;

public class TicketpriceReturnDao extends EntityManagerDaoSurport<Object> {
	
	private IDAO dao = new EntityManagerDaoSurport();

	/**
	 * @Title queryTicketpriceReturnBySellid
	 * @Description 根据 车票 ID  查询原路退款数据
	 * @param sellid
	 * @return TicketpriceReturn 
	 * @author tianhb
	 * @date 2018年6月13日-下午3:49:09
	 * @update 
	 * @throws
	 */
	public TicketpriceReturn queryTicketpriceReturnBySellid(Long sellid){
		TicketpriceReturn trp = null;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQL_t!sellid", sellid));
		trp = (TicketpriceReturn)dao.uniqueResult(LockModeType.NONE,TicketpriceReturn.class,propertyFilters);
		return trp;
	}
	/**
	 * @Title isExistTicketpriceReturn
	 * @Description 根据 车票 ID 判断是否存在原路退款数据
	 * @param sellid
	 * @return Boolean TRUE:存在，FALSE:不存在
	 * @author tianhb
	 * @date 2018年6月13日-下午3:50:34
	 * @update 
	 * @throws
	 */
	public Boolean isExistTicketpriceReturn(Long sellid){
		Boolean flag = false;
		if(null != queryTicketpriceReturnBySellid(sellid)){
			flag = true;
		}
		return flag;
	}
	
}
