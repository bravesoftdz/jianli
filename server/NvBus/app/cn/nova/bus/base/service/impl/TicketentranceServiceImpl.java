package cn.nova.bus.base.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.TicketentranceDao;
import cn.nova.bus.base.model.Ticketentrance;
import cn.nova.bus.base.service.TicketentranceService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class TicketentranceServiceImpl implements TicketentranceService{
	
	
	private IDAO<Ticketentrance> dao = new EntityManagerDaoSurport<Ticketentrance>();
	
	private TicketentranceDao ticketentrancedao = new TicketentranceDao();
	@Override
	public Ticketentrance saveTicketentrance(Ticketentrance ticketentrance) throws ServiceException {
		Ticketentrance resultEnty = null;
		//添加
		if(ticketentrance.getId()==0){
			if( ticketentrancedao.getEntrance(ticketentrance.getOrgid(), ticketentrance.getName(), true)!=null){
				throw new ServiceException("0014");	//如果存在相同的车站，检票口 且已激活，则抛出错误
			}
		}else{ //修改
			Ticketentrance oldentrance = dao.get(Ticketentrance.class,ticketentrance.getId());
			Ticketentrance newentrance =ticketentrancedao.getEntrance(ticketentrance.getOrgid(), ticketentrance.getName(), true);
			if(newentrance!=null && newentrance.getId()!=oldentrance.getId()){
				throw new ServiceException("0014");	
			}
		}
		resultEnty = (Ticketentrance) dao.merge(ticketentrance); 	
		return resultEnty;
	}

	@Override
	public Boolean delTicketentrance(Ticketentrance ticketentrance) throws ServiceException{
		if(ticketentrancedao.isExistScheduleEntrance(ticketentrance.getId(),true)){
			throw new ServiceException("0013");			
		}else{
			if(ticketentrancedao.update(ticketentrance.getId())){
				return true;
			}else{
				return false;
			}
			 			
		}
	}
	@Override
	public Ticketentrance updTicketentrance(Ticketentrance ticketentrance) {
//		if(ticketentrancedao.isExistScheduleEntrance(ticketentrance.getId(),true)){
//			throw new ServiceException("0013");			
//		}else{
//			if(dao.merge(ticketentrance)!=null){
//				return true;
//			}else{
//				return false;
//			}
//			 			
//		}
		return dao.merge(ticketentrance);
	}
	
	@Override
	public Ticketentrance findbyid(long id){
		return (Ticketentrance) dao.get(Ticketentrance.class, id);
	}
	
	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[]{Ticketentrance.class,"orgname","createname","updatename"},
				ticketentrancedao.query(propertyFilterList),
				new Object[]{Ticketentrance.class,String.class,String.class,String.class});
	}

	@Override
	public Page<Ticketentrance> findPage(Page<Ticketentrance> entrace,
			Map<Object, Object> map) {
		return null;
	}

}
