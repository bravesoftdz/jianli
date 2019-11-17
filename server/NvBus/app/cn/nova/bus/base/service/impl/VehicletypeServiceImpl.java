package cn.nova.bus.base.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.VehicletypeDao;
import cn.nova.bus.base.model.Vehicletype;
import cn.nova.bus.base.service.VehicletypeService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>车型相关业务的实现EJB<br/>
 * <b>类名称：</b>VehicletypeServiceImpl<br/>
 * <b>创建人：</b><br/>
 * <b>关键修改：</b>增加与联网票务中心同步的逻辑<br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("unchecked")
public class VehicletypeServiceImpl implements VehicletypeService {

	private VehicletypeDao dao = new VehicletypeDao();

	/*
	 * save方法：<br/> 将车型数据与联网售票中心同步后持久化到数据库。<br/>
	 * 
	 * @param vehicle 需要持久化的车型实体类
	 * 
	 * @return 方法调用结果类，其中标识码为1标识成功调用，0表示调用失败。
	 * 
	 * @see
	 * cn.nova.bus.base.service.VehicletypeService#save(cn.nova.bus.base.model
	 * .Vehicletype)
	 * 
	 * @exception NamingException,EJBException
	 */
	@Override
	public MethodResult save(Vehicletype vehicle) throws ServiceException {
		if (vehicle.getId() == 0) {
			if (isExistCode(vehicle.getCode(), null) > 0) {
				long id = isExistCode(vehicle.getCode(), "0");
				if (id > 0) {
					getVehicletype(vehicle, id);
				} else {
					throw new ServiceException("0276");
				}
			} else if (isExistName(vehicle.getName(), null) > 0) {
				long id = isExistName(vehicle.getName(), "0");
				if (id > 0) {
					getVehicletype(vehicle, id);
				} else {
					throw new ServiceException("0277");
				}
			} else if (isExistType(vehicle.getType(), vehicle.getGrade(), null,
					vehicle.getRationseatnum()) > 0) {
				long id = isExistType(vehicle.getType(), vehicle.getGrade(),
						"0", vehicle.getRationseatnum());
				if (id > 0) {
					getVehicletype(vehicle, id);
				} else {
					throw new ServiceException("0278");
				}
			}
		}
		if (vehicle.getId() == 0) {
			if ( dao.save(vehicle) ) {
			  return new MethodResult(MethodResult.SUCCESS,"",vehicle);
			} else {
			  return new MethodResult(MethodResult.FAILURE,"",vehicle);
			}
		} else {
			if ( dao.update(vehicle) ) {
			  return new MethodResult(MethodResult.SUCCESS,"",vehicle);
			} else {
			  return new MethodResult(MethodResult.FAILURE,"",vehicle);
			}
		}
	}

	private Long isExistType(String type, String grade, String value, short num) {
		return dao.getIdByType(type, grade, value, num);
	}

	private void getVehicletype(Vehicletype vehicle, long id) {
		Vehicletype type = getById(id);
		vehicle.setIsactive(true);
		vehicle.setIslocaldelete(false);
		vehicle.setId(type.getId());
//		vehicle.setName(type.getName());
//		vehicle.setType(type.getType());
//		vehicle.setGrade(type.getGrade());
//		vehicle.setCreateby(vehicle.getCreateby());
		vehicle.setSynccode(type.getSynccode());
	}

	private Long isExistName(String name, String value) {
		return dao.getIdByName(name, value);
	}

	private Long isExistCode(String code, String value) {
		return dao.getIdByCode(code, value);
	}

	@Override
	public boolean delete(Vehicletype vehicle) {
		if (vehicle != null) {
			return dao.del(vehicle);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Vehicletype.class, id);
	}

	@Override
	public List<Vehicletype> query() {
		return dao.query(Vehicletype.class, null);
	}

	@Override
	public Vehicletype getById(Long id) {
		return (Vehicletype) dao.get(Vehicletype.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Vehicletype.class,
				"createname", "updatename" }, dao.query(propertyFilterList),
				new Object[] { Vehicletype.class, String.class, String.class });
	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean isApply(long id) {
		List list = dao.getVehicle(id);
		List brandmodel = dao.getBrandmodel(id);
		if (list.isEmpty() || brandmodel.isEmpty()) {
			return false;
		}
		return true;
	}

}
