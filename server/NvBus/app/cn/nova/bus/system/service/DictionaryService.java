package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

public interface DictionaryService {
	public List<Map<String, Object>> find(String tablename, String columnname,
			String code);

	// 获取字段对应的字典解释 add by lck
	public String getColumnValue(String tablename, String columnname,
			String code);

	public List<Map<String, Object>> getCheckcombox(String tablename,
			String columnname);
}
