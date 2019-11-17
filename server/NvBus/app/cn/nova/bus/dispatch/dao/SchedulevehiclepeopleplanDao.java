/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.dispatch.dao<br/>
 * <b>文件名：</b>SchedulevehiclepeopleplanDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-12-26 下午03:20:34 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.dispatch.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.price.model.Handholidayprice;
import cn.nova.bus.price.model.Handprice;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>SchedulevehiclepeopleplanDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-12-26 下午03:20:34	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class SchedulevehiclepeopleplanDao extends EntityManagerDaoSurport{
	
	@SuppressWarnings("unchecked")
	public List<Handholidayprice> queryHandholidayprice(Long scheduleid, Long vehicletypeid, Date departdate){
		StringBuffer sql = new StringBuffer("select hp from Handholidayprice hp ");
		sql.append(" where hp.scheduleid=:scheduleid and hp.vehicletypeid=:vehicletypeid ");
		sql.append(" and hp.startdate<=:departdate and hp.enddate>=:departdate and ");
		sql.append(" hp.id=(select max(p.id) from Handholidayprice p where ");
		sql.append(" p.startdate<=:departdate and p.enddate>=:departdate and p.seattype=hp.seattype ");
		sql.append(" and p.scheduleid=hp.scheduleid and p.vehicletypeid=hp.vehicletypeid ");
		sql.append(" and p.reachstationid=hp.reachstationid)");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		query.setParameter("departdate", departdate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Handprice> queryHandprice(Long scheduleid, Long vehicletypeid, Date departdate){
		StringBuffer sql = new StringBuffer("select hp from Handprice hp ");
		sql.append(" where hp.scheduleid=:scheduleid and hp.vehicletypeid=:vehicletypeid ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("vehicletypeid", vehicletypeid);
		return query.getResultList();
	}

}
