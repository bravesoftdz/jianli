package cn.nova.bus.base.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.TickettypeDao;
import cn.nova.bus.base.dao.TickettypepermissionDao;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Tickettypepermission;
import cn.nova.bus.base.service.TickettypeService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * @author lck
 * 
 */
public class TickettypeServiceImpl implements TickettypeService {
	
	private IDAO<Tickettype> dao = new EntityManagerDaoSurport<Tickettype>();
	
	private TickettypeDao tickettypeDao = new TickettypeDao();
	 
	private TickettypepermissionDao tickettypepermissionDao = new TickettypepermissionDao();

	@Override
	public Tickettype save(Tickettype tickettype) throws ServiceException {
		if (tickettypeDao.isExistByCode(tickettype)) {
			System.out.println("++++++++++++++++");
			throw new ServiceException("0060");
		}
		if (tickettypeDao.isExistByName(tickettype)) {
			System.out.println(".............  active same name");
			throw new ServiceException("0059");
		}
		// 若存在注销的该票种
		if (tickettypeDao.isExistDelByCode(tickettype)) {
			Tickettype obj = tickettypeDao.getTickettypeByCode(tickettype);
			obj.setCreateby(tickettype.getCreateby());
			obj.setCreateby(tickettype.getCreateby());
			obj.setCreatetime(new Date());
			obj.setIsactive(true);
			obj.setIsdefault(false);
			obj.setIslocaldelete(false);
			obj.setIsscore(tickettype.getIsscore());
			obj.setName(tickettype.getName());
			obj.setPrintname(tickettype.getPrintname());
			obj.setSoldpicture(tickettype.getSoldpicture());
			obj.setUpdateby(tickettype.getCreateby());
			obj.setUpdatetime(new Date());
//			return dao.merge(obj);
			return dao.merge((Tickettype) obj);
		} else if (tickettypeDao.isExistDelByName(tickettype)) {
			Tickettype obj = tickettypeDao.getTickettypeByName(tickettype);
			obj.setCreateby(tickettype.getCreateby());
			obj.setCreateby(tickettype.getCreateby());
			obj.setCreatetime(new Date());
			obj.setIsactive(true);
			obj.setIsdefault(false);
			obj.setIslocaldelete(false);
			obj.setIsscore(tickettype.getIsscore());
			obj.setCode(tickettype.getCode());
			obj.setPrintname(tickettype.getPrintname());
			obj.setSoldpicture(tickettype.getSoldpicture());
			obj.setUpdateby(tickettype.getCreateby());
			obj.setUpdatetime(new Date());
//			return dao.merge(obj);
			return dao.merge(obj);
		} else {
			if (tickettype.getId() == 0) {
				byte orderno = tickettypeDao.getMaxOrderno(tickettype);
				tickettype.setSynccode(null);
				tickettype.setOrderno((byte) (orderno + 1));
			}
//			return dao.merge(tickettype);
			return dao.merge((Tickettype) tickettype);
		}
	}

	public boolean delete(Long id) {
		Tickettype obj = dao.get(Tickettype.class, id);
		obj.setIsactive(false);
		obj.setIslocaldelete(true);
		dao.merge(obj);
		return true;
	}

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { Tickettype.class,
				"createname", "updatename" },
				tickettypeDao.query(propertyFilters), new Object[] {
						Tickettype.class, String.class, String.class });
	}

	@Override
	public boolean prior(Tickettype tickettype) throws ServiceException {
		return swap(tickettype, -1);
	}

	@Override
	public boolean next(Tickettype tickettype) throws ServiceException {
		return swap(tickettype, 1);
	}

	@SuppressWarnings("unused")
	private boolean swap(Tickettype tickettype, int n) throws ServiceException {
		Tickettype obj = dao.get(Tickettype.class, tickettype.getId());
		byte targetOrderno = obj.getOrderno();
		byte nearestOrderno = 0;
		
		Tickettype nearestTickettype = tickettypeDao.getNearestTickettypeByOrderno(targetOrderno, n);
		
		if (nearestTickettype != null) {
			nearestOrderno = nearestTickettype.getOrderno();
			nearestTickettype.setOrderno(targetOrderno);
			nearestTickettype.setUpdateby(tickettype.getUpdateby());
			nearestTickettype.setUpdatetime(new Date());
			dao.merge(nearestTickettype);  
		} else {
			if(n>0)
				throw new ServiceException("0062");
			else
				throw new ServiceException("0061");
		}
		obj.setOrderno(nearestOrderno);
		obj.setUpdateby(tickettype.getUpdateby());
		obj.setUpdatetime(new Date());
		dao.merge(obj);
		return true;

	}

	@Override
	public List<Tickettype> findByPermission(long userid,long ticketoutletsid) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		propertyFilters.add(new PropertyFilter("EQB_t!islocaldelete", false));
		propertyFilters.add(new PropertyFilter("GTY_t!orderno", new Byte("0")));
		List<Tickettype> allTickettype = dao.find(Tickettype.class,propertyFilters,new String[]{"t.orderno"});
		//删除没有权限的票种
		List<Tickettypepermission> tickettypepermissions = tickettypepermissionDao.findTickettypePermission(userid,ticketoutletsid);
		if(tickettypepermissions==null||tickettypepermissions.size()==0){
			allTickettype.clear();
			return allTickettype;
		}
		Iterator<Tickettype> tickettypeIterator = allTickettype.iterator();
		while (tickettypeIterator.hasNext()) {
			Tickettype tickettype = (Tickettype) tickettypeIterator.next();
			boolean haspermission = false;
			for (Tickettypepermission tickettypepermission : tickettypepermissions) {
				if(tickettypepermission.getTickettypeid()==tickettype.getId()){
					haspermission = true;
					break;
				}
			}
			if(!haspermission){
				tickettypeIterator.remove();
			}
		}
		return allTickettype;
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String,Object>> find(List<PropertyFilter> propertyFilters) {
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		propertyFilters.add(new PropertyFilter("EQB_t!islocaldelete", false));
		propertyFilters.add(new PropertyFilter("GTY_t!orderno", new Byte("0")));
		return ListUtil.listToMap(new Object[]{Tickettype.class}, tickettypeDao.find(Tickettype.class,propertyFilters)); 
	}
  
	//做测试用
	@Override
	public byte[] getImage() {
		Tickettype tickettype=new Tickettype();
		tickettype.setId(12100);		
		tickettype=dao.get(Tickettype.class,tickettype.getId());
		return tickettype.getSoldpicture();
	}

	public void setTickettypepermissionDao(TickettypepermissionDao tickettypepermissionDao) {
		this.tickettypepermissionDao = tickettypepermissionDao;
	}

	public TickettypepermissionDao getTickettypepermissionDao() {
		return tickettypepermissionDao;
	}

	@Override
	public String qryTicketname(String code) throws ServiceException {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!code", code));
		
		List<Tickettype> tickettypes=dao.find(Tickettype.class,propertyFilters);
		if(tickettypes!=null && tickettypes.size()>0){
			return tickettypes.get(0).getName();
		}else{
			return "";
		}
	}
}
