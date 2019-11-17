package cn.nova.bus.archive.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：VIP订票取消时间设置</b><br/>
 * <b>类名称：</b>VipbooktimeDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class VipbooktimeDao extends EntityManagerDaoSurport{

	//会员订票时间记录
	public List<Object> find(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select o.name as orgname,vb.vipgrade,vb.booktime,uc.name as createname,")
		.append(" usp.name as updatename,vb.createtime,vb.updatetime,vb.id ,o.id as orgid,uc.id as createby")
		.append(" from Vipbooktime vb ,Organization o,Userinfo uc,Userinfo usp")
		.append(" where vb.orgid=o.id and vb.createby=uc.id and vb.updateby=usp.id ")
		.append(PropertyFilter.toJpql(propertyFilterList,true));
		sql.append(" order by o.id,vb.vipgrade ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	
	/*
	 * 查询 是否存在 机构 对应的会员等级订票时间设置
	 */
	public boolean isExist(long orgid,String vipgrade){
		String sql = "select vb.id from Vipbooktime vb where vb.orgid ="+orgid +" and vb.vipgrade = '"+vipgrade+"'";	
		Query query = getEntityManager().createQuery(sql);
		List list = query.getResultList();
		if (list.isEmpty()) {
			return  false;
		}
		return true;
	}
	
}
