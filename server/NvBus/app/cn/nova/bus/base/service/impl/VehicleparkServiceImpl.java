package cn.nova.bus.base.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.VehicleparkDao;
import cn.nova.bus.base.model.Vehiclepark;
import cn.nova.bus.base.service.VehicleparkService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.Page;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
/**
 * 上车卡位管理
 * @author huanghaoze
 *
 */

public class VehicleparkServiceImpl implements VehicleparkService {

	private IDAO<Vehiclepark> dao = new EntityManagerDaoSurport<Vehiclepark>();
	

	private VehicleparkDao vehicleparkdao = new VehicleparkDao();
	
	@Override
	public Boolean saveVehiclepark(Vehiclepark vehiclepark,String oldname) throws ServiceException {
		
		if(oldname.equals(vehiclepark.getName())){
			if(vehicleparkdao.isExistPark(vehiclepark.getOrgid(), vehiclepark.getName(), false)!=null){
				Vehiclepark park  = vehicleparkdao.isExistPark(vehiclepark.getOrgid(), vehiclepark.getName(), false);
				park.setIsactive(true);		//如果存在相同的车站，上车卡位且未激活，则修改激活状态
				park.setCreateby(vehiclepark.getCreateby());
				park.setCreatetime(vehiclepark.getCreatetime());
				park.setUpdateby(vehiclepark.getUpdateby());
				park.setUpdatetime(vehiclepark.getUpdatetime());
				park.setName(vehiclepark.getName());
				park.setPrintname(vehiclepark.getPrintname());
				return dao.update(park);
			}else{
				if(vehiclepark.getId()!=0){
					return dao.update(vehiclepark);
				}else{
					return dao.save(vehiclepark); //否则，新建一条记录		
				}
			}
		}else{
			if(vehicleparkdao.isExistPark(vehiclepark.getOrgid(), vehiclepark.getName(), true)!=null){
				throw new ServiceException("0393");	//该车站的上车卡位已经存在
			}else if(vehicleparkdao.isExistPark(vehiclepark.getOrgid(), vehiclepark.getName(), false)!=null){
				Vehiclepark park  = vehicleparkdao.isExistPark(vehiclepark.getOrgid(), vehiclepark.getName(), false);
				park.setIsactive(true);		//如果存在相同的车站，上车卡位且未激活，则修改激活状态
				park.setCreateby(vehiclepark.getCreateby());
				park.setCreatetime(vehiclepark.getCreatetime());
				park.setUpdateby(vehiclepark.getUpdateby());
				park.setUpdatetime(vehiclepark.getUpdatetime());
				park.setName(vehiclepark.getName());
				park.setPrintname(vehiclepark.getPrintname());
				return dao.update(park);
			}else{
				if(vehiclepark.getId()!=0){
					return dao.update(vehiclepark);
				}else{
					return dao.save(vehiclepark); //否则，新建一条记录		
				}
			}
		}
				
		
	}

	@Override
	public Boolean delVehiclepark(long id) {
		return dao.delete(Vehiclepark.class, id);
	}
	
	@Override
	public Boolean delVehiclepark(Vehiclepark vehiclepark)throws ServiceException{
		
		if(vehicleparkdao.isExistSchedulePark(vehiclepark.getId(),true)!=null){
			throw new ServiceException("0015");			
		}else{
			Vehiclepark v = findbyid(vehiclepark.getId());
			v.setIsactive(false);
			return dao.update(v);			
		}
	}

	@Override
	public Vehiclepark findbyid(Long id){
		return dao.get(Vehiclepark.class, id);
	}
	
	@Override
	public List<Map<String, Object>>  query(List<PropertyFilter> propertyFilterList) {
//		String sql = "select v, o.name as orgname,u.name as createname,u.name as updatename " +
//						" from Vehiclepark v ,Organization o,Userinfo u " +
//						" where u.id=v.createby and v.orgid = o.id and v.isactive = 1 ";
//		if(where.get("org")!=null && where.get("org")!=""){
//			sql = sql+" and o.name like '%"+where.get("org")+"%'";
//		}
//		if(where.get("name")!=null&&where.get("name")!=""){
//			sql = sql+" and v.name like '%"+where.get("name")+"%'";
//		} 
//		Object[] fileds = {Vehiclepark.class,"orgname","createname","updatename"};
//		System.out.println("查找语句；"+sql);
//		List<Map<String, Object>> list = dao.query(fileds, sql);
//		return list;
		return ListUtil.listToMap(new Object[]{Vehiclepark.class,"orgname","createname","updatename"}, vehicleparkdao.query(propertyFilterList));
		
	}

	@Override
	public Page<Vehiclepark> findPage(Page<Vehiclepark> entrace,
			Map<Object, Object> map) {
		return null;
	}

}
