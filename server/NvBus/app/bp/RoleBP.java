package bp;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityTransaction;
import javax.persistence.Query;

import cn.nova.bus.system.model.Menu;
import cn.nova.bus.system.model.Menupermission;
import cn.nova.bus.system.model.Role;
import cn.nova.bus.system.service.MenupermissionService;
import cn.nova.bus.system.service.RoleService;
import cn.nova.bus.system.service.impl.MenupermissionServiceImpl;
import cn.nova.bus.system.service.impl.RoleServiceImpl;
import models.Result;
import models.RoleVO;
import play.db.jpa.JPA;
import util.CommonUtil;
import bpinterface.MenuBPInterface;
import bpinterface.RoleBPInterface;

public class RoleBP implements RoleBPInterface {
	@Override
	public Result save(Role role) throws Exception {
		RoleService rservice = new RoleServiceImpl();
		rservice.save(role);
		
		return new Result(true,"保存成功!");
	}

	@Override
	public Map<String, Object> getPage(Role role,int page,int rows) {
		StringBuilder sb = new StringBuilder("select t.*, o.name as \"orgid__display\" from role t left join organization o on t.orgid = o.id where t.isactive = 1");
		if(CommonUtil.isNotEmptyString(role.getName())){
			sb.append(" and t.name like :name");
		}
		sb.append(" order by t.id desc");
		Query query = JPA.em().createNativeQuery(sb.toString(), RoleVO.class);
		if(CommonUtil.isNotEmptyString(role.getName())){
			query.setParameter("name", "%"+role.getName()+"%");
		}
		int count = query.getResultList().size();
		query.setFirstResult((page-1)*rows);
		query.setMaxResults(rows);
		@SuppressWarnings("rawtypes")
		List list = query.getResultList();
		Map<String,Object> map = new HashMap<String, Object>();
		map.put("total", count);
		map.put("rows", list);
		return map;
	}

	@Override
	public Result deleteById(long id) {
		String hql = "update Role set isactive = 0 where id = ?";
		Query query = JPA.em().createQuery(hql);
		query.setParameter(1, id);
		query.executeUpdate();
		return new Result(true,"删除成功!");
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Role> getAll() {
		String sql = "select t.*, o.name as \"orgid__display\" from role t left join organization o on t.orgid = o.id where t.isactive = 1 order by t.id desc";
		Query query = JPA.em().createNativeQuery(sql, RoleVO.class);
		return query.getResultList();
	}

	@Override
	public Role findById(long id) {
		RoleService rservice = new RoleServiceImpl();
		List<Role> list = rservice.querybyid(id);
		return list.get(0);
	}

	@SuppressWarnings("unchecked")
	@Override
	public List<Role> getByUserid(long userid) {
		String sql = "select t.* from role t,userrole ur where t.id = ur.roleid and ur.userid = ?";
		Query query = JPA.em().createNativeQuery(sql, Role.class);
		query.setParameter(1, userid);
		return query.getResultList();
	}

	@Override
	public Result assignPermission(Long roleid, List<Long> menuids, List<Long> orgids) {
		EntityTransaction transaction = JPA.em().getTransaction();
		if(!transaction.isActive()){
			transaction.begin();
		}
		try {
			MenuBPInterface menubp = new MenuBP();
			List<Menu> list = menubp.getByRoleid(roleid);
			StringBuilder sb = new StringBuilder();
			if(!list.isEmpty()){
				for(Menu obj : list){
					sb.append(obj.getId()).append(",");
				}
				sb.deleteCharAt(sb.length() - 1);
				
				String sql = "delete from menupermission where menuid in ("+sb.toString()+")";
				Query query = JPA.em().createNativeQuery(sql);
				query.executeUpdate();
			}
			
			Menupermission menupermission = null;
			List<Menupermission> Menupermissions = new ArrayList<Menupermission>();
			MenupermissionService ms = new MenupermissionServiceImpl();
			for(Long menuid : menuids){
				menupermission = new Menupermission();
				menupermission.setRoleid(roleid);
				menupermission.setMenuid(menuid);
				menupermission.setType((byte)0);
				Menupermissions.add(menupermission);
			}
			
//			Orgpermission.delete("delete from Orgpermission where roleid = ?", roleid);
//			Orgpermission orgpermission = null; 
//			for(Long orgid : orgids){
//				orgpermission = new Orgpermission();
//				orgpermission.roleid = roleid;
//				orgpermission.orgid = orgid;
//				orgpermission.stamp();
//				orgpermission.save();
//			}
			transaction.commit();
			return new Result(true,"保存成功!");
		} catch (Exception e) {
			transaction.rollback();
			//throw new BPException("ERROR.O.MERGEROLEPERMISSION");
		}
		return null;
	}
}
