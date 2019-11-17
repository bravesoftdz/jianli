package bp;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.persistence.Query;

import org.hibernate.Session;

import cn.nova.bus.system.model.Menu;
import cn.nova.bus.system.model.Role;
import cn.nova.bus.system.service.MenuService;
import cn.nova.bus.system.service.RoleService;
import cn.nova.bus.system.service.impl.MenuServiceImpl;
import cn.nova.bus.system.service.impl.RoleServiceImpl;
import models.MenuTree;
import models.Result;
import play.db.jpa.JPA;
import bpinterface.MenuBPInterface;
import bpinterface.RoleBPInterface;


public class MenuBP implements MenuBPInterface {
	@Override
	public Result save(Menu menu) throws Exception {
//		menu.updateStamp();
		MenuService mnservice = new MenuServiceImpl();
		mnservice.add(menu);
		return new Result(true,"保存成功!");
	}

	@Override
	public List<Menu> getAll() {
		MenuService mnservice = new MenuServiceImpl();
		return mnservice.getAll();
	}

	@Override
	public Menu findById(long id) {
		//return Menu.find("from Menu where systype = '2' and id = ?", id).first();
		return null;
	}

	@Override
	public MenuTree makeTreeByUserid(long userid){
		MenuTree menutree = new MenuTree();
		List<Menu> menus = getByUserid(userid);
		if(menus.isEmpty()){
			return menutree;
		}
		List<Menu> nodes = new ArrayList<Menu>();
		List<Menu> childs = new ArrayList<Menu>();
		for(Menu obj : menus){
			if(obj.getGrade() == 1){
				nodes.add(obj);
			}else{
				childs.add(obj);
			}
		}
		
		for(Menu obj : nodes){
			MenuTree item = new MenuTree(obj);
			menutree.nodes.add(item);
			appendChild(item,childs);
		}
		return menutree;
	}
	
	//添加子节点，递归调用
	private void appendChild(MenuTree node, List<Menu> childs){
		for(Menu child : childs) {
			if(child.getParentid() == node.id) {
				MenuTree item = new MenuTree(child);
				node.nodes.add(item);
				appendChild(item,childs);
			}
		}
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Menu> getByUserid(long userid) {
		RoleService rolebp = new RoleServiceImpl();
		List<Role> roles = rolebp.query(userid);
		if(roles.isEmpty()) {
			return new ArrayList<Menu>();
		}
		
		StringBuilder sb = new StringBuilder();
		for(Role obj : roles) {
			sb.append(obj.getId()).append(",");
		}
		sb.deleteCharAt(sb.length()-1);
		
		String sql = "select distinct m.* from menu m, menupermission p where m.id = p.menuid and p.roleid in ("+sb.toString()+")  order by orderno";
		Query query = JPA.em().createNativeQuery(sql, Menu.class);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Menu> getByRoleid(long roleid) {
		String sql = "select t.* from menu t,menupermission mp where t.id = mp.menuid and m.clazz is not null and mp.roleid = ? order by m.clicknum";
		Query query = JPA.em().createNativeQuery(sql, Menu.class);
		query.setParameter(1, roleid);
		return query.getResultList();
	}

	@Override
	public List<Menu> load(long id) {
		String sql = "select t.* from menu t where t.clazz is not null order by clicknum";
		Query query = JPA.em().createNativeQuery(sql, Menu.class);
		List<Menu> list = query.getResultList();
		return list;
	}

}
