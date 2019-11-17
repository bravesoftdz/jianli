package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import cn.nova.bus.system.model.GridField;
import cn.nova.bus.system.service.GridFieldService;
import cn.nova.bus.system.service.impl.GridFieldServiceImpl;

public class GridFieldAction extends BaseAction{
	private GridField gridfield;

	private String componentname;

	private Long userid;
	private List<Map<String,Object>> gridlist;

	private GridFieldService gridfieldservice;
	
	private List<GridField> gridfields;
	
	public List<GridField> getGridfields() {
		return gridfields;
	}

	public void setGridfields(List<GridField> gridfields) {
		this.gridfields = gridfields;
	}

	public String save() {
		gridfieldservice = new GridFieldServiceImpl();
		if (gridfieldservice.save(getGridfield())) {
			msg = "保存成功！";
			markSuccess();
		} else {
			msg = "保存失败！";
			markFail();
		}
		return "json";
	}
	
	public String savelist(){
		gridfieldservice = new GridFieldServiceImpl();
		if (gridfieldservice.save(getGridfields())) {
			msg = "保存成功！";
			markSuccess();
		} else {
			msg = "保存失败！";
			markFail();
		}
		return "json";		
	}

	public String query() {
		gridfieldservice = new GridFieldServiceImpl();
		setGridlist(gridfieldservice.query(userid,componentname));
		return "json";
	}

	@Transient
	public String getComponentname() {
		return componentname;
	}

	public void setComponentname(String componentname) {
		this.componentname = componentname;
	}

	@Transient
	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public List<Map<String,Object>> getGridlist() {
		return gridlist;
	}

	public void setGridlist(List<Map<String,Object>> gridlist) {
		this.gridlist = gridlist;
	}

	@Transient
	public GridField getGridfield() {
		return gridfield;
	}

	public void setGridfield(GridField gridfield) {
		this.gridfield = gridfield;
	}

}
