/**
 * 
 */
package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Printtemplate;
import cn.nova.bus.system.model.Printtemplateitem;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * @author ice
 *
 */

public class PrinttemplateDao extends EntityManagerDaoSurport {
	
	public List<Object> query(List<PropertyFilter> propertyFilters){
		StringBuilder sql = new StringBuilder("select pt,ptt.name as printtemplatetypename,uc.name as createbyname,uu.name as updatebyname ")
				.append(" from Printtemplate pt,Printtemplatetype ptt,Userinfo uc,Userinfo uu")
				.append(" where pt.printtemplatetypeid=ptt.id ")
				.append(" and pt.createby=uc.id ")
				.append(" and pt.updateby=uu.id ")
				.append(PropertyFilter.toJpql(propertyFilters, true))
				;
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}
	
	public List<Object> queryItem(List<PropertyFilter> propertyFilters){
		StringBuilder sql = new StringBuilder("select pti,ptti.islist,ptti.itemname,ptti.itemcode,ptti.itemtype,")
		.append(" uc.name as createbyname,uu.name as updatebyname,'' as picture ")
		.append(" from Printtemplateitem pti,Printtemplatetypeitem ptti,Userinfo uc,Userinfo uu")
		.append(" where pti.printtemplatetypeitem.id=ptti.id ")
				.append(" and pti.createby=uc.id ")
				.append(" and pti.updateby=uu.id ")
				.append(PropertyFilter.toJpql(propertyFilters, true))
		;
		sql.append(" order by pti.top");
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		return query.getResultList();
	}
	
	public boolean deleteInVisibleItem(Printtemplate printtemplate) {
		Query query = getEntityManager().createQuery("delete Printtemplateitem pti where pti.printtemplate=:printtemplate and pti.isprint=:isprint");
		query.setParameter("printtemplate", printtemplate);
		query.setParameter("isprint", false);
		query.executeUpdate();
		return true;
	}
	
	/**
	 * 通过打印模板类型，得到模板类型名和同模板类型的模板个数，供复制模板功能给新模板取名使用
	 * @param printtemplatetypeId
	 * @return
	 */
	public List<Object> getPrinttemplatetypeName(Long printtemplatetypeId){
		StringBuffer sql = new StringBuffer("select ptt.name as typename, pt.name as templatename from printtemplate pt left join printtemplatetype ptt on pt.printtemplatetypeid = ptt.id ");
		sql.append(" where pt.printtemplatetypeid = :printtemplatetypeId");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("printtemplatetypeId", printtemplatetypeId);
		return query.getResultList();
	}
	
	/**
	 * 通过打印模板id得到对应的打印项，供复制模板功能使用
	 * @param printtemplateId
	 * @return
	 */
	public List<Printtemplateitem> getItemByTemplateId(Long printtemplateId){
		StringBuffer sql = new StringBuffer("select ti from Printtemplateitem ti, Printtemplate t ");
		sql.append(" where ti.printtemplate.id = t.id and t.id = :printtemplateId");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("printtemplateId", printtemplateId);
		return query.getResultList();
	}

}
