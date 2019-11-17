package cn.nova.bus.base.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.Seatstatuspicture;
import cn.nova.utils.orm.PropertyFilter;

public interface SeatstatuspictureService {

	public Seatstatuspicture save(Seatstatuspicture seatstatuspicture);

	public boolean delete(Seatstatuspicture count);

	public boolean delete(Long id);

	public List<Seatstatuspicture> query();

	public Seatstatuspicture getByStatus(String status);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);
	
	public boolean isEmpty(String seatstatus);

}
