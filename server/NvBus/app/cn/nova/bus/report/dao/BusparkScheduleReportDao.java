/**
 * 车库发车时刻表
 */
package cn.nova.bus.report.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author ice
 *
 */
public class BusparkScheduleReportDao extends EntityManagerDaoSurport{
	public List<Object> query(long orgid,Date departdate){
		Organization org = (Organization) super.get(Organization.class, orgid);
		StringBuilder sql = new StringBuilder();
		sql.append("select ss.buspark,ss.departtime,st.name")
		.append(" from Schedulestatus ss ,Station st,Scheduleplan sp")
		.append(" where ss.scheduleplan.id=sp.id")
		.append("  and sp.endstationid=st.id");
//		.append(" order by length(ss.buspark),ss.buspark,ss.departtime");
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_ss!departstationid", org.getStation().getId()));
		propertyFilters.add(new PropertyFilter("EQD_sp.departdate", departdate));
		propertyFilters.add(new PropertyFilter("EQD_ss.departdate", departdate));
		return super.find(sql.toString(),propertyFilters,new String[]{"length(ss.buspark)","ss.buspark","ss.departtime"});
	}
}
