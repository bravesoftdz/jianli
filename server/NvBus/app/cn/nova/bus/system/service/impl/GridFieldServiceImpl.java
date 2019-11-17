package cn.nova.bus.system.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.GridField;
import cn.nova.bus.system.service.GridFieldService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;


public class GridFieldServiceImpl implements GridFieldService {

	private IDAO dao = new EntityManagerDaoSurport();
	@Override
	public boolean save(GridField gridfield) {
		if (gridfield != null) {
			GridField curgrid = query(gridfield.getUserid(),
					gridfield.getComponentname(), gridfield.getFieldname());
			if (curgrid != null) {
				curgrid.setFieldno(gridfield.getFieldno());
				curgrid.setIsvisible(gridfield.getIsvisible());
				curgrid.setWidth(gridfield.getWidth());
				getDao().merge(curgrid);
			} else {
				getDao().merge(gridfield);
			}
		}
		return true;
	}

	@Override
	public boolean save(List<GridField> gridfields) {
		for (int i = 0; i < gridfields.size(); i++) {
			GridField gridfield = gridfields.get(i);
			if (gridfield != null) {
				GridField curgrid = query(gridfield.getUserid(),
						gridfield.getComponentname(), gridfield.getFieldname());
				if (curgrid != null) {
					curgrid.setFieldno(gridfield.getFieldno());
					curgrid.setIsvisible(gridfield.getIsvisible());
					curgrid.setWidth(gridfield.getWidth());
					getDao().merge(curgrid);
				} else {
					getDao().merge(gridfield);
				}
			}
		}
		return true;
	}
	
	private GridField query(Long userid, String componentname,
			String fieldname) {
		String sql = "select t from GridField  t where t.componentname='"
				+ componentname + "' and t.fieldname='" + fieldname
				+ "' and t.userid=" + userid;
		List<Object> list = getDao().find(sql);
		if (list == null || list.size() == 0) {
			return null;
		}
		return (GridField) list.get(0);
	}
	

	@Override
	public List<Map<String,Object>> query(Long userid, String componentname) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!componentname", componentname));
		propertyFilters.add(new PropertyFilter("EQL_t!userid", (new Long(userid)).toString()));
		return ListUtil.listToMap(new Object[]{GridField.class}, getDao().find(GridField.class, propertyFilters,new String[]{"fieldno"}));
	}

	public IDAO getDao() {
		return dao;
	}

	public void setDao(IDAO dao) {
		this.dao = dao;
	}

}
