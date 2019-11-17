package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.GridField;

public interface GridFieldService {
	public boolean save(GridField gridfield);
	public boolean save(List<GridField> gridfields);

	public List<Map<String,Object>> query(Long userid, String componentname) ;
}
