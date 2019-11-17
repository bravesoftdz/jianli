/**
 * 
 */
package bpinterface;

import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Role;
import models.Result;





/**
 * 角色管理
 * @author lin
 *
 */
public interface RoleBPInterface {
	/**
	 * 保存角色信息
	 * @param role  
	 * @return   
	 * @throws Exception 
	 */
	Result save(Role role) throws Exception;
	
	/**
	 * 分页查询角色信息
	 * @param role
	 * @param page
	 * @param rows
	 * @return
	 */
	Map<String,Object> getPage(Role role,int page,int rows);
	
	/**
	 * 根据ID删除角色信息
	 * @param id
	 * @return
	 */
	Result deleteById(long id);
	
	/**
	 *查询所有角色信息
	 * @return
	 */
	List<Role> getAll();
	
	/**
	 * 根据ID查询角色信息
	 * @param id
	 * @return
	 */
	Role findById(long id);

	/**
	 * 根据用户ID查询角色信息
	 * @param userid
	 * @return
	 */
	List<Role> getByUserid(long userid);

	/**
	 * 保存角色菜单,角色机构关联信息
	 * @param roleid
	 * @param menuids
	 * @param orgids 
	 * @return
	 * @throws BPException 
	 */
	Result assignPermission(Long roleid, List<Long> menuids, List<Long> orgids);
	
}
