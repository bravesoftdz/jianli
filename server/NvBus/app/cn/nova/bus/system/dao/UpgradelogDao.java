/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.dao<br/>
 * <b>文件名：</b>UpgradelogDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-05-08<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.dao;

import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Version;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：系统升级日志</b><br/>
 * <b>类名称：</b>UpgradelogDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-5-08 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class UpgradelogDao extends EntityManagerDaoSurport {

	/**
	 * 查询系统升级日志表:Upgradelog
	 * 
	 * @param startdate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryUpgradelog(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select ul.id,ul.version,ul.needpopup,ul.upgradetime")
				.append(" from Upgradelog ul where 1 = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by ul.upgradetime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	/**
	 * 查询系统升级日志表的升级内容
	 * 
	 * @param startdate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryContextbyid(Long id) {
		StringBuffer sql = new StringBuffer(
				"select ul.id,ul.upgradecontext from Upgradelog ul where ul.id="
						+ id);
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();
	}

	/**
	 * 获得更新版本
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryversion() {
		StringBuffer sql = new StringBuffer();
		sql.append("select a.id,a.versionnum,a.updatetime from (select v.id,v.versionnum,v.updatetime from Version v order by v.updatetime desc) a  where rownum =1");
		Query query = em.createNativeQuery(sql.toString());
		play.Logger.info("sql:---------->" + sql);
		List list = query.getResultList();
		play.Logger.info("size:%s", list.size());
		return list;

	}
	
	/**
	 * 获得测试版更新版本
	 */
	@SuppressWarnings("unchecked")
	public List<Object> qryVersionVerify() {
		StringBuffer sql = new StringBuffer();
		sql.append("select a.id,a.versionnum,a.updatetime from (select v.id,v.versionnum,v.updatetime from VersionVerify v order by v.updatetime desc) a  where rownum =1");
		Query query = em.createNativeQuery(sql.toString());
		return query.getResultList();
	}
}
