/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.dao.VehiclespacesoldpictureDao;
import cn.nova.bus.base.model.Vehiclespacesoldpicture;
import cn.nova.bus.base.service.VehiclespacesoldpictureService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("unchecked")
public class VehiclespacesoldpictureServiceImpl implements
		VehiclespacesoldpictureService {


	private VehiclespacesoldpictureDao dao = new VehiclespacesoldpictureDao();

	@Override
	public Vehiclespacesoldpicture save(Vehiclespacesoldpicture picture) {
		if (picture.getId() == 0) {
			return (Vehiclespacesoldpicture) dao.merge(picture);
		} else {
			Vehiclespacesoldpicture oldpicture = (Vehiclespacesoldpicture) dao.get(Vehiclespacesoldpicture.class, picture.getId());
			picture.setSynccode(oldpicture.getSynccode());
			return (Vehiclespacesoldpicture) dao.merge(picture);
		}
	}

	@Override
	public boolean delete(Vehiclespacesoldpicture insurer) {
		if (insurer != null) {
			return dao.del(insurer);
		} else {
			return false;
		}
	}

	@Override
	public boolean delete(Long id) {
		return dao.delete(Vehiclespacesoldpicture.class, id);
	}

	@Override
	public List<Vehiclespacesoldpicture> query() {
		return dao.query(Vehiclespacesoldpicture.class, null);
	}

	@Override
	public Vehiclespacesoldpicture getById(Long id) {
		return (Vehiclespacesoldpicture) dao.get(Vehiclespacesoldpicture.class,
				id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Vehiclespacesoldpicture.class,
				"createname", "updatename", "spacename", "typename","tickettypecode" },
				dao.query(propertyFilterList), new Object[] {
						Vehiclespacesoldpicture.class, String.class,
						String.class, String.class, String.class, String.class });

	}

	@SuppressWarnings("rawtypes")
	@Override
	public boolean isExist(Long vehiclespaceid, Long ticktypeid) {
		List list = dao.getList(vehiclespaceid, ticktypeid);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public Long getId(Long vehiclespaceid, Long ticktypeid) {
		Vehiclespacesoldpicture picture = dao.getVehiclespace(vehiclespaceid,
				ticktypeid);
		if (picture == null) {
			return (long) 0;
		}
		return picture.getId();
	}

}
