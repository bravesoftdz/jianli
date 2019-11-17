/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.dao<br/>
 * <b>文件名：</b>UserinfoDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-28 下午02:43:56 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.model.Userrole;
import cn.nova.bus.system.model.Userticketoutlets;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>UserinfoDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-28 下午02:43:56 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class UserinfoDao extends EntityManagerDaoSurport<Userinfo> {

	@SuppressWarnings("unchecked")
	public Userinfo getUser(String code, String userpwd) {
		StringBuffer sql = new StringBuffer(
				"select u from Userinfo u where u.code=:code and u.password=:password and u.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		query.setParameter("password", userpwd);
		List<Object> list = query.getResultList();
		return (Userinfo) (list != null && list.size() > 0 ? list.get(0) : null);
	}

	@SuppressWarnings("unchecked")
	public List<Userrole> getUserRole(long userid) {
		StringBuffer sql = new StringBuffer(
				"select u from Userrole u where u.id.userid=:userid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("userid", userid);
		return query.getResultList();
	}

	public boolean isExist(String code) {
		StringBuffer sql = new StringBuffer(
				"select t from Userinfo t where t.code=:code");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	public String getPassword(long id) {
		StringBuffer sql = new StringBuffer(
				"select t.password from Userinfo t where t.id=:id");
		Query query = em.createQuery(sql.toString());
		query.setParameter("id", id);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return (String) query.getSingleResult();
		}
		return null;
	}

	public boolean isLocaldelete(String code) {
		StringBuffer sql = new StringBuffer(
				"select t from Userinfo t where t.code=:code and t.isactive=0 ");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> buildFromHttpRequest) {
		StringBuffer sql = new StringBuffer("select distinct u.id,u.cardno,u.code,u.createby,");
		sql.append(" u.createtime,u.departmentid,u.email,u.idcard,u. islock, ");
		sql.append(" u. ismultipoint,u.name,u.orgid,u.password,u.phone, ");
		sql.append(" u.ticketdiscount,u.updateby,u.updatetime,u.isactive,o.name as orgname,d.name as depname, us.name as createname, ");
		sql.append(" use.name as updatename,tt.name as ticketoutlet,tt.id as ticketoutletid from Userinfo u left join userticketoutlets uto on uto.userinfoid = u.id ");
		sql.append(" left join ticketoutlets tt on tt.id = uto.ticketoutletsid, Organization o,");
//		sql.append(" Department d, Userinfo us, Userinfo use where u.orgid=o.id and u.departmentid=d.id ");
//		sql.append(" and u.createby=us.id and u.updateby=use.id and u.isactive=1 ");
//		sql.append(" Department d, Userinfo us, Userinfo use,Role r,Userrole ur where u.orgid=o.id and u.departmentid=d.id ");
		sql.append(" Department d, Userinfo us, Userinfo use,Role r,Userrole ur where r.orgid=o.id and u.departmentid=d.id");
		sql.append(" and u.createby=us.id and u.updateby=use.id and u.isactive=1 and u.id=ur.userid and r.id=ur.roleid ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		return query.getResultList();
	}
	
	public List<Object> queryEntrypacker(List<PropertyFilter> buildFromHttpRequest) {
		StringBuffer sql = new StringBuffer(
				"select distinct u,o.name as orgname,d.name as depname, us.name as createname, ");
		sql.append(" use.name as updatename from Userinfo u, Organization o,");
		sql.append(" Department d, Userinfo us, Userinfo use,Role r,Userrole ur where r.orgid=o.id and u.departmentid=d.id");
		sql.append(" and u.createby=us.id and u.updateby=use.id and u.isactive=1 and u.id=ur.id.userid and r.id=ur.id.roleid ");
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
		List list = query.getResultList();
		
		if(list == null || list.size()<1){
			
			for(PropertyFilter pf:buildFromHttpRequest){
				String[] name = pf.getPropertyFullNames();
				if(name[0].toString().equals("r!id")){
					buildFromHttpRequest.remove(pf);
					break;
				} 
			}
			
			StringBuffer sql2 = new StringBuffer("select distinct u,o.name as orgname,d.name as depname, us.name as createname, ");
			sql2.append(" use.name as updatename from Userinfo u, Organization o,")
				.append(" Department d, Userinfo us, Userinfo use,Role r,Userrole ur where r.orgid=o.id and u.departmentid=d.id")
				.append(" and u.createby=us.id and u.updateby=use.id and u.isactive=1 and u.id=ur.id.userid and r.id=ur.id.roleid ")
				.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
			query = getEntityManager().createQuery(sql2.toString());
			JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);
			list = query.getResultList();
		}
		
		return list;
	}

	public List getResult(String name, String password) {
		String sql = "select t from Userinfo t where t.name=:name and t.password=:password";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("name", name);
		query.setParameter("password", password);
		return query.getResultList();
	}

	public Long getIdByCode(String code) {
		String sql = "select t.id from Userinfo t where t.code=:code";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("code", code);
		return (Long) query.getSingleResult();
	}

	public Userinfo getByCode(String code) {
//		String sql = "select t from Userinfo t where t.code=:code";
//		Query query = getEntityManager().createQuery(sql);
//		query.setParameter("code", code);
//		return (Userinfo) query.getSingleResult();
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("code", code);
		return (Userinfo) super.uniqueResult(Userinfo.class, map);
	}

	public List<Userticketoutlets> getUserticketoutlets(long id) {
		String sql = "select t from Userticketoutlets t where t.userinfoid=:id";
		Query query = getEntityManager().createQuery(sql);
		query.setParameter("id", id);
		return query.getResultList();
	}

	public boolean checkPermission(String permissionkey, Userinfo userinfo) {
		StringBuffer sql = new StringBuffer();
		sql.append(
				"select count(m.id) from menupermission m  left join functionpermissionreg fm on fm.id = m.functionpermissionregid ")
				.append(" left join role r on r.id = m.roleid left join userrole ur on ur.roleid = r.id left join userinfo u on u.id = ur.userid ")
				.append(" where fm.permissionkey = :permissionkey and u.id = :id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		 query.setParameter("id", userinfo.getId());
		 query.setParameter("permissionkey", permissionkey);
		 BigDecimal b = (BigDecimal) query.getResultList().get(0);
		return b.compareTo(BigDecimal.ZERO)>0?true:false;
	}

	public List<Object> checkserverVersion(){
		StringBuffer sql = new StringBuffer();
		sql.append("select a.versionnum from (select v.versionnum from Version v order by v.updatetime desc) a  where rownum =1");
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return list;
	}
	
	/**
	 * 查询测试版版本号
	 * @return
	 */
	public List<Object> checkVerifyServerVersion(){
		StringBuffer sql = new StringBuffer();
		sql.append("select a.versionnum from (select v.versionnum from VersionVerify v order by v.updatetime desc) a  where rownum =1");
		Query query = em.createNativeQuery(sql.toString());
		List list = query.getResultList();
		return list;
	}

	public Userinfo getUserByCode(String code) {
		StringBuffer sql = new StringBuffer();
		sql.append("select u from Userinfo u where u.code = :code and u.isactive=1");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		List list = query.getResultList();
		return (Userinfo) (list.size() > 0 && list.get(0) != null ? list.get(0) : null);
	}
}
