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
import cn.nova.bus.system.model.Systemerrorlog;
import cn.nova.bus.system.service.SystemerrorlogService;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * 系统日志管理
 * @author huanghaoze
 *
 */
public class SystemerrorlogServiceImpl implements SystemerrorlogService ,Serializable{
	
	@PersistenceContext
	protected EntityManager em;

	private IDAO<Systemerrorlog> dao = new EntityManagerDaoSurport<Systemerrorlog>();
	
	@Override
	public boolean savelog(Systemerrorlog log) {
			return dao.save(log);
	}

	@Override
	public Boolean deleteById(Long logid){
		dao.delete(Systemerrorlog.class, logid);
		return true;
	}
	
	@Override
	public List<Systemerrorlog> findByLog(Systemerrorlog log){
		return dao.query(Systemerrorlog.class, null);
	}

	public List<Map<String, Object>> findlogByMap(Map<Object,Object> map){
		String scope = "  select s, u.name as username, org.name as orgname from Systemerrorlog s ,Userinfo u,Organization org " +
						" where u.id=s.userid and u.orgid=org.id ";
		if(map.get("orgname")!=null&&!map.get("orgname").equals("")){
			scope = scope+" and s.userid in (select r.id from Userinfo r, Organization o where r.orgid = o.id and o.id in "+map.get("orgname")+" )";
		}
		if(map.get("usernames")!=null&&!map.get("usernames").equals("")){
			scope = scope+" and s.userid in (select ur.id from Userinfo ur where ur.name like '%"+map.get("usernames")+"%' )";
		}
		if(map.get("ip")!=null&&!map.get("ip").equals("")){
			scope = scope+" and s.ip like '%"+map.get("ip")+"%'";
		}
		if(map.get("module")!=null&&!map.get("module").equals("")){
			scope = scope+" and s.module like  '%"+map.get("module")+"%' ";
		}
		ArrayList<Object> ms = new ArrayList<Object>();  
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		Date begin=new Date();
		Date end=new Date();
		try {
			begin = df.parse(map.get("begindatetime").toString());
			end= df.parse(map.get("enddatetime").toString());
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		ms.add(begin);
		ms.add(end);
		scope = scope+" and s.occurtime between ?1 and ?2 ";
		
			Query query = dao.createEntityManager().createQuery(scope);
			int parameterIndex = 1;
			if (ms != null && ms.size() > 0) {
				for (Object obj : ms) {
					query.setParameter(parameterIndex++,obj);
				}
			}
			List<Object> li = query.getResultList();
			Object[] fileds = {Systemerrorlog.class,"username","orgname"};
			return  ListUtil.listToMap(fileds, li);
	}
	
}
