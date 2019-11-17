package cn.nova.bus.system.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Notify;

@SuppressWarnings("rawtypes")
public class NotityDao  extends EntityManagerDaoSurport{
	@SuppressWarnings("unchecked")
	public List<Object> queryNotify(long userid) {
		StringBuffer sql = new StringBuffer("select n.id, u.name, t.lastlogintime, n.msg")
		.append(" from notify n, useronline t, userinfo u")
		.append(" where n.userid = t.userid and n.userid = u.id")
		.append(" and n.isnotify = 0  order by n.createtime");//and u.id=:userid
		Query query = getEntityManager().createNativeQuery(sql.toString());
//		query.setParameter("userid", userid);
		return query.getResultList();
	}
	public Notify getpresaleNotify()
	{
		String sql ="select t from Notify t where t.notifyfuncitem='presaleapply'";
		Query query = getEntityManager().createQuery(sql.toString());
		return (Notify)query.getResultList().get(0);
	}
	public int updatenotifystatus()
	{
		
		StringBuffer sb = new StringBuffer(" SELECT n FROM Notify n where n.notifyfuncitem='presaleapply' and n.isnotify='0' ");
		Query query = getEntityManager().createQuery(sb.toString());
		List<Notify> list  = query.getResultList();
		for(int i=0;i<list.size();i++)
		{
			Notify notify = (Notify)list.get(i);
			notify.setIsnotify(true);
			notify.setUpdatetime(new Date());
			merge(notify);
			
		}
		return list.size();
		
		
	}
}
