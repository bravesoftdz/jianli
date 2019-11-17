/**
 * 
 */
package bpinterface;

import java.util.List;

import cn.nova.bus.system.model.Menu;
import models.MenuTree;
import models.Result;



/**
 * 菜单管理
 * @author lin
 *
 */
public interface MenuBPInterface {
	/**
	 * 保存菜单信息
	 * @param menu  
	 * @return   
	 * @throws Exception 
	 */
	Result save(Menu menu) throws Exception;
	
	/**
	 *查询所有菜单信息
	 * @return
	 */
	List<Menu> getAll();
	
	/**
	 * 根据ID查询菜单信息
	 * @param id
	 * @return
	 */
	Menu findById(long id);
	
	/**
	 * 根据用户构建菜单树
	 * @param userid
	 * @return
	 */
	MenuTree makeTreeByUserid(long userid);
	
	/**
	 * 根据用户查询菜单信息
	 * @param userid
	 * @return
	 */
	List<Menu> getByUserid(long userid);

	/**
	 * 根据角色查询菜单信息
	 * @param roleid
	 * @return
	 */
	List<Menu> getByRoleid(long roleid);

	List<Menu> load(long id);
	
}
