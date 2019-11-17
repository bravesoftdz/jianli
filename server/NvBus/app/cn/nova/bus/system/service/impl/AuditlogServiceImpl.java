/**
 * 
 */
package cn.nova.bus.system.service.impl;

import java.io.Serializable;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.service.AuditlogService;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.orm.listener.Auditlog;

/**
 * 系统日志管理
 * @author huanghaoze
 *
 */

public class AuditlogServiceImpl implements AuditlogService ,Serializable{
	@PersistenceContext
	protected EntityManager em;

	private IDAO<Auditlog> dao = new EntityManagerDaoSurport<Auditlog>();
	
	@Override
	public boolean savelog(Auditlog log) {
			return dao.save(log);
	}

	public List<Map<String, Object>> findlogByMap(Map<Object,Object> map){
		String scope = "  select a, u.name as username, org.name as orgname from Auditlog a ,Userinfo u ,Organization org where u.id=a.userid and u.orgid=org.id ";
		if(map.get("orgid")!=null&&!map.get("orgid").equals("")){
			scope = scope+" and a.userid in (select r.id from Userinfo r, Organization o where r.orgid = o.id and o.id in "+map.get("orgid")+" )";
		}
		if(map.get("username")!=null&&!map.get("username").equals("")){
			scope = scope+" and a.userid in (select ur.id from Userinfo ur where ur.name like '%"+map.get("username")+"%' )";
		}
		if(map.get("ip")!=null&&!map.get("ip").equals("")){
			scope = scope+" and a.ip like '%"+map.get("ip")+"%'";
		}
		if(map.get("tablename")!=null&&!map.get("tablename").equals("")){
			scope = scope+" and a.tablename like '%" +map.get("tablename") + "%'";
		}
		if(map.get("operation")!=null&&!map.get("operation").equals("")){
			scope = scope+" and a.operation = "+map.get("operation");
		}
		ArrayList<Object> ms = new ArrayList<Object>();  
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date begin=new Date();
		Date end=new Date();
		try {
			begin = df.parse(map.get("begintime").toString());
			end= df.parse(map.get("endtime").toString());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		ms.add(begin);
		ms.add(end);
		scope = scope+" and a.occurtime between ?1 and ?2 ";
		
			Query query = dao.createEntityManager().createQuery(scope);
			int parameterIndex = 1;
			if (ms != null && ms.size() > 0) {
				for (Object obj : ms) {
					query.setParameter(parameterIndex++,obj);
				}
			}
			List<Object> li = query.getResultList();
			Object[] fileds = {Auditlog.class,"username","orgname"};
			Object[] filedtypes = {Auditlog.class,String.class,String.class};
			return  ListUtil.listToMap(fileds, li,filedtypes);
	}

}
