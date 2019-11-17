package cn.nova.bus.system.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Digitaldictionarydetail;
import cn.nova.bus.system.service.DictionaryService;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class DictionaryServiceImpl implements DictionaryService {


	private IDAO<Object> dictionaryDao = new EntityManagerDaoSurport<Object>();

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> find(String tablename, String columnname,
			String code) {
		StringBuffer sb = new StringBuffer(
				"select a.id, a.value, a.code  from Digitaldictionary t, Digitaldictionarydetail a");
		sb.append(" where t.id=a.digitaldictionary.id");
		if ((tablename != null) && (columnname != null)) {
			sb.append(" and t.tablename='" + tablename + "'");
			sb.append(" and t.columnname='" + columnname + "'");
		}

		if (code != null && !("".equals(code))) {
			sb.append(" and a.code='" + code + "'");
		}
		sb.append(" order by a.orderno");
		Object[] fileds = { "id", "value", "code" };// 初始化要查询的字段
		Object[] filedtype = { Long.class, String.class, String.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, dictionaryDao.find(sb.toString()),
				filedtype);
	}

	/*
	 * getColumndescribe方法：<br/> <br/>
	 * 
	 * @param tablename
	 * 
	 * @param columnname
	 * 
	 * @param code
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.system.service.DictionaryService#getColumndescribe(java.lang
	 * .String, java.lang.String, java.lang.String)
	 * 
	 * @exception
	 */
	@SuppressWarnings("unchecked")
	@Override
	public String getColumnValue(String tablename, String columnname,
			String code) {
		StringBuffer sql = new StringBuffer(
				"select a  from Digitaldictionary t, Digitaldictionarydetail a")
				.append(" where t.id=a.digitaldictionary.id")
				.append(" and t.tablename='" + tablename + "'")
				.append(" and t.columnname='" + columnname + "'")
				.append(" and a.code='" + code + "'");
		List<Digitaldictionarydetail> list = dictionaryDao.find(sql.toString());
		if (list != null && list.size() > 0) {
			return list.get(0).getValue();
		}
		return "";
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Map<String, Object>> getCheckcombox(String tablename,
			String columnname) {
		StringBuffer sb = new StringBuffer(
				"select a.id as code, a.value as name, a.code as id  from Digitaldictionary t, Digitaldictionarydetail a");
		sb.append(" where t.id=a.digitaldictionary.id");
		if ((tablename != null) && (columnname != null)) {
			sb.append(" and t.tablename='" + tablename + "'");
			sb.append(" and t.columnname='" + columnname + "'");
		}
		sb.append(" order by a.orderno");
		Object[] fileds = { "code", "name", "id" };// 初始化要查询的字段
		Object[] filedtype = { Long.class, String.class, String.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, dictionaryDao.find(sb.toString()),
				filedtype);
	}

}
