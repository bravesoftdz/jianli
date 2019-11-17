/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.dao<br/>
 * <b>文件名：</b>DepartmentDao.java<br/>
 * <b>版本信息：</b><br/>
 * <b>日期：</b>2011-8-7-下午05:06:37<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>DepartmentDao<br/>
 * <b>创建人：</b><a href="mailto:lanchengkun@nova.net.cn">兰成坤</a><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 * 
 */
@SuppressWarnings("rawtypes")
public class DepartmentDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(long prentid) {
		StringBuffer sql = new StringBuffer("select d.id,")
		.append(" d.code,d.contactperson,d.contactphone,d.createby,")
		.append(" d.createtime,d.describe,d.name,d.parentid,d.supervisorid,")
		.append(" d.updateby,d.updatetime,org.name as orgname,")
		.append(" u1.name as createname,u2.name as updatename,")
		.append(" case when u3.isactive =1 then u3.name else null end as supervisor ")
	//	.append(" u3.name supervisor")
		.append(" from Department d left join Userinfo u3")
		.append(" on d.supervisorid = u3.id, Userinfo u1,")
		.append(" Organization org, Userinfo u2")
		.append(" where d.createby = u1.id  and d.parentid = org.ID")
		.append(" and d.isactive =1")
		.append("  and d.updateby = u2.id and d.parentid =:prentid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("prentid",prentid);
		return query.getResultList();
	}

	public boolean qryUserByOrgId(Long departmentid, Long orgid) {
		StringBuffer sql=new StringBuffer(
				"select distinct u.id from userinfo u,userrole ur,role r")
		.append(" where ur.roleid=r.id and  u.id=ur.userid and u.isactive =1 ")
		.append(" and u.departmentid =:departmentid and r.orgid=:orgid");
		Query query=getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departmentid", departmentid);
		query.setParameter("orgid", orgid);
		if(query.getResultList().size()>0){
			return false;
		}
		return true;
	}
}
