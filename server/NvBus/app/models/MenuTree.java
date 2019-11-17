package models;

import java.util.ArrayList;
import java.util.List;

import cn.nova.bus.system.model.Menu;


public class MenuTree {
	public Long id;
	public String name;
	public String parameter;
	public Long functionregid;
	public String url;
	public String ico;
	public Long parentid;
	public Integer count;
	public List<MenuTree> nodes = new ArrayList<MenuTree>();
	
	public MenuTree() {};
	public MenuTree(Menu menu) {
		this.id = menu.getId();
		this.name = menu.getName();
		this.url = menu.getUrl();
		this.ico = menu.getIcon();
		this.parameter = menu.getParameter();
		this.functionregid = menu.getFunctionregid();
		this.parentid = menu.getParentid();
	};
}
