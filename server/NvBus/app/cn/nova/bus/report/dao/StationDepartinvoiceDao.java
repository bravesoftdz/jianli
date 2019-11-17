/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>StationDepartinvoiceDao.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-2-21 上午08:53:58 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：停靠站点运量情况汇总表</b><br/>
 * <b>类名称：</b>StationDepartinvoiceDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-2-21 上午08:53:58 <br/>
 * <b>关键修改：过滤掉除数为0 的情况，如果除数为0 则结果为0</b><br/>
 * <b>修改时间：20130521</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class StationDepartinvoiceDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
public List<Object> query(List<PropertyFilter> propertyFilter) {
		StringBuffer sql = new StringBuffer(
				"select o.name orgname,st.name stationname,")
		.append(" sn.name routename, sum(dp.ticketnum) dpticketnum,sum(d.ticketnum) dticketnum,")
		.append(" (case when sum(d.ticketnum)=0 then 0 else round(sum(dp.ticketnum)/sum(d.ticketnum)*100,2) end) || '%' percentnum,")
		.append(" sum(dp.totalamount) dpamount,sum(d.totalamount) damount,")
		.append(" (case when sum(d.totalamount)=0 then 0 else round(sum(dp.totalamount)/sum(d.totalamount)*100,2) end) || '%' percentamount,")
		.append(" sum(dp.ticketnum)*sum(dp.distance) dpdistance, sum(d.ticketnum)*sum(dp.distance) ddistance,")
		.append(" (case when (sum(d.ticketnum)*sum(dp.distance))=0 then 0 else round(sum(dp.ticketnum)*sum(dp.distance)/(sum(d.ticketnum)*sum(dp.distance))*100,2) end) || '%' percentdistance")
		.append(" from departinvoices d, departinvoicesdetail dp , organization o, station st,")
		.append(" route r, schedule s, station sn ")
		.append(" where dp.departinvoicesid=d.id and d.printorgid=o.id ")
		.append(" and s.workways <> '0' and dp.reachstationid=st.id and ")
		.append(" d.scheduleid=s.id and s.routeid=r.id and d.status <> '1' and r.endstationid=sn.id ");
		sql.append(PropertyFilter.toJpql(propertyFilter, true));
		sql.append(" group by o.name, st.name,sn.name ");		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilter);
		return query.getResultList();
	}
}
