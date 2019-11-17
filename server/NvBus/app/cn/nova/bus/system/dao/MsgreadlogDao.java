/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.dao<br/>
 * <b>文件名：</b>MsgreadlogDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-05-08<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;


/**
 * <b>类描述：信息阅读记录</b><br/>
 * <b>类名称：</b>UpgradelogDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-5-11  <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")

public class MsgreadlogDao extends EntityManagerDaoSurport{		
	/**
	 * 查询最后一条需要提醒的升级日志
	 * @param startdate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryUpgradelogMsg() {
		StringBuffer sql = new StringBuffer(
				"select '系统升级日志' as msgtypename,ul.id,ul.upgradecontext,")
		.append(" ul.upgradetime,ul.version from Upgradelog ul ")
		.append(" where ul.upgradetime = (select max(ul.upgradetime) from Upgradelog ul where ul.needpopup=1 ) ");
		Query query = getEntityManager().createQuery(sql.toString());
		return query.getResultList();		
	}	
	
	/**
	 * 查询升级日志表和日志读取记录表，用于判断是否需要弹窗提示
	 * @param startdate
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> isReadMsg() {
		StringBuffer sql = new StringBuffer(
				"select ul.id upgid,ml.id readid ")
		.append("  from Upgradelog ul left join Msgreadlog ml on ul.id=ml.msgid")
		.append(" where ul.needpopup = 1 order by ul.upgradetime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();		
	}	
	
	
	
	
}
