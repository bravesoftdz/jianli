/**
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.VehicleseatplanDao;
import cn.nova.bus.base.model.Vehicleseatplan;
import cn.nova.bus.base.model.Vehicleseatplandetail;
import cn.nova.bus.base.service.VehicleseatplanService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */

public class VehicleseatplanServiceImpl implements VehicleseatplanService {

	private VehicleseatplanDao vehicleseatplanDao = new VehicleseatplanDao();

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehicleseatplanService#find(java.util.List)
	 */
	@Override
	public List<Map<String, Object>> find(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[]{"id","brandname","modelcode","rationseatnum","orgid","vehiclebrandmodelid","createtime","createby","updatetime","updateby","createbyname","updatebyname"}, 
				vehicleseatplanDao.find(propertyFilterList),
				new Object[]{Long.class,String.class,String.class,Short.class,Long.class,Long.class,String.class,Long.class,String.class,Long.class,String.class,String.class});
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehicleseatplanService#finddetail(long)
	 */
	@Override
	public List<Map<String, Object>> finddetail(long id) {
		Vehicleseatplan vehicleseatplan = new Vehicleseatplan();
		vehicleseatplan.setVehiclebrandmodelid(id);
		return ListUtil.listToMap(new Object[]{Vehicleseatplandetail.class,"name","picture","ispassengerseat"}, 
				vehicleseatplanDao.finddetail(vehicleseatplan),
				new Object[]{Vehicleseatplandetail.class,String.class,String.class,String.class});
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehicleseatplanService#save(cn.nova.bus.base.model.Vehicleseatplan, long)
	 */
	@Override
	public boolean save(Vehicleseatplan vehicleseatplan, long userid)
			throws ServiceException {
		if (vehicleseatplan.getVehicleseatplandetails()==null||vehicleseatplan.getVehicleseatplandetails().size()<=0){
			throw new ServiceException("0011");
		}
		else{
			vehicleseatplan.setCreateby(userid);
			vehicleseatplan.setCreatetime(new Date());
			vehicleseatplan.setUpdateby(userid);
			vehicleseatplan.setUpdatetime(new Date());
			vehicleseatplan.setIsactive(true);
			vehicleseatplan.setIslocaldelete(false);
			for (Vehicleseatplandetail vehicleseatplandetail : vehicleseatplan.getVehicleseatplandetails()) {
				vehicleseatplandetail.setVehicleseatplan(vehicleseatplan);
				vehicleseatplandetail.setCreateby(userid);
				vehicleseatplandetail.setCreatetime(new Date());
				vehicleseatplandetail.setUpdateby(userid);
				vehicleseatplandetail.setUpdatetime(new Date());
			}
		}
		Vehicleseatplan vehicleseatplan_old = (Vehicleseatplan) vehicleseatplanDao.get(Vehicleseatplan.class, vehicleseatplan.getVehiclebrandmodelid());
		if(vehicleseatplan_old!=null){
			vehicleseatplan.setCreateby(vehicleseatplan_old.getCreateby());
			vehicleseatplan.setCreatetime(vehicleseatplan_old.getCreatetime());
			vehicleseatplan.setSynccode(vehicleseatplan_old.getSynccode());
			for (Vehicleseatplandetail vehicleseatplandetail_old : vehicleseatplan_old.getVehicleseatplandetails()) {
				boolean needdelete = true;
				for (Vehicleseatplandetail vehicleseatplandetail : vehicleseatplan.getVehicleseatplandetails()) {
					if (vehicleseatplandetail.getId()==vehicleseatplandetail_old.getId()){
						needdelete = false;
						vehicleseatplandetail.setCreateby(vehicleseatplandetail_old.getCreateby());
						vehicleseatplandetail.setCreatetime(vehicleseatplandetail_old.getCreatetime());
						vehicleseatplandetail.setSynccode(vehicleseatplandetail_old.getSynccode());
						break;
					}
				}
				if(needdelete){
					vehicleseatplanDao.del(vehicleseatplandetail_old);
				}
			}
		}
		vehicleseatplanDao.merge(vehicleseatplan);
		return true;
	}

	/* (non-Javadoc)
	 * @see cn.nova.bus.base.service.VehicleseatplanService#delete(long, long)
	 */
	@Override
	public boolean delete(long vehicleseatplanid, long userid)
			throws ServiceException {
		Vehicleseatplan vehicleseatplan = (Vehicleseatplan) vehicleseatplanDao.get(Vehicleseatplan.class, vehicleseatplanid);
		vehicleseatplan.setUpdateby(userid);
		vehicleseatplan.setUpdatetime(new Date());
		vehicleseatplan.setIsactive(false);
		vehicleseatplan.setIslocaldelete(true);
		vehicleseatplanDao.merge(vehicleseatplan);
		vehicleseatplanDao.deleteByVehiclebrandmodelid(vehicleseatplanid);
		return false;
	}

	public void setVehicleseatplanDao(VehicleseatplanDao vehicleseatplanDao) {
		this.vehicleseatplanDao = vehicleseatplanDao;
	}

	public VehicleseatplanDao getVehicleseatplanDao() {
		return vehicleseatplanDao;
	}

	@Override
	public String getSeatnoRemark(long vehiclebrandmodelid, short seatno) {
		return vehicleseatplanDao.getSeatnoRemark(vehiclebrandmodelid,seatno);
	}

}
