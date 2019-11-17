package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Vehiclespacesoldpicture;
import cn.nova.utils.orm.PropertyFilter;

public interface VehiclespacesoldpictureService {

	public Vehiclespacesoldpicture save(Vehiclespacesoldpicture seatstatuspicture);

	public boolean delete(Vehiclespacesoldpicture count);

	public boolean delete(Long id);

	public List<Vehiclespacesoldpicture> query();

	public Vehiclespacesoldpicture getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean isExist(Long vehiclespaceid, Long ticktypeid);

	public Long getId(Long vehiclespaceid, Long ticktypeid);

}
