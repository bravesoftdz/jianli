package cn.nova.bus.system.service;

import java.math.BigDecimal;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Carrycontrol;

public interface CarrycontrolService {

	boolean save(Carrycontrol carr);

	boolean delete(Carrycontrol carr);

	boolean delete(Long id);

	List<Carrycontrol> query();

	Carrycontrol getByModulecode(String modulecode);
	
	Carrycontrol getById(long id);
	
	List<Map<String, Object>> query(String describe);
	
	boolean equals(String code, String name);
	
	Long getValue(Long id, String value,String value2);
	
	Long findModulecode(String modulecode);
	
	Long findDescribe(String describe);
	
	BigDecimal carryControl(String formula,String modulecode);
}
