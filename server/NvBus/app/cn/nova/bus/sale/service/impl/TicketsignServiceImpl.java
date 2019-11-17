package cn.nova.bus.sale.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.dao.TicketsignDao;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.bus.sale.service.TicketpriceReturnService;
import cn.nova.bus.sale.service.TicketsignService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;


public class TicketsignServiceImpl implements TicketsignService {

	
	private TicketsignDao ticketsignDao = new TicketsignDao();
	//原路退款
	private TicketpriceReturnService ticketpriceReturnService;
	
	private IDAO dao = new EntityManagerDaoSurport();	
	@Override
	public boolean sign(List<Ticketsign> ticketsigns) throws ServiceException{
		for (Ticketsign ticketsign : ticketsigns) {
			sign(ticketsign);
		}
		return true;
	}

	public void setTicketsignDao(TicketsignDao ticketsignDao) {
		this.ticketsignDao = ticketsignDao;
	}

	public TicketsignDao getTicketsignDao() {
		return ticketsignDao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

	public IDAO getDao() {
		return dao;
	}

	@Override
	public boolean sign(Ticketsign ticketsign) throws ServiceException {
		if(ticketsign.getIsselfschedule()){
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!id",ticketsign.getSellid()));
			Ticketsell ticketsell = (Ticketsell) dao.uniqueResult(Ticketsell.class, propertyFilters);
			if(ticketsell==null){
				throw new ServiceException("0167");  //你要签手续费率的车票不存在
			}
			else if ("1".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0168");  //你要签手续费率的车票已经退票
			}
			else if ("2".equals(ticketsell.getTicketstatus())){
				throw new ServiceException("0169");  //你要签手续费率的车票已经废票
			}
			//符合原路退款的车票不允许签手续费、否则提示：该车票已超过退票日期限制，请使用【原路退款】功能进行退款操作！ add by tianhb 2018年6月14日 BEGIN
			if(null == ticketpriceReturnService){
				ticketpriceReturnService = new TicketpriceReturnServiceImpl();
			}
			String msg = "该车票已经【原路退款】、不允许签手续费-票号:" + ticketsell.getTicketno();
			if(ticketpriceReturnService.isCanReturnBack(ticketsell)){
				if(ticketpriceReturnService.isExistTicketpriceReturn(ticketsell.getId())){
					play.Logger.info(msg);
					throw new BusinessException(msg);
				}else{
					msg = "该车票已超过退票日期限制，请使用【原路退款】功能进行退款操作-票号:" + ticketsell.getTicketno();
					play.Logger.info(msg);
					throw new BusinessException(msg);
				}
			}
			//符合原路退款的车票不允许签手续费、否则提示：该车票已超过退票日期限制，请使用【原路退款】功能进行退款操作！ add by tianhb 2018年6月14日 END
			ticketsignDao.sign(ticketsign);
		}
		else{
			ticketsignDao.sign(ticketsign);
		}
		
		return true;
	}
}
