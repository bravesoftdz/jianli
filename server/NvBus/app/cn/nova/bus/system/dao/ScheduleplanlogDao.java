/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.system.dao<br/>
 * <b>文件名：</b>ScheduleplanlogDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-3-8 下午01:37:45<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>ScheduleplanlogDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-3-8 下午01:37:45<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class ScheduleplanlogDao extends EntityManagerDaoSurport {

	/**
	 * @param buildFromHttpRequest
	 * @param type
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryScheduleplanlog(
			List<PropertyFilter> buildFromHttpRequest, String type) {
		StringBuffer sql = new StringBuffer("select o.name orgname, ");
		sql.append(" trim(case sl.operationtype when 'C' then '生成计划' ")
				.append("  when 'D' then '删除计划' end) operation, ")
				.append(" trim(case sl.type when '0' then '全部班次' when '1' then '线路' when '2' then '班次' end) selecttype, ");
		if ("0".equals(type)) {
			sql.append(" '' typename, ");
		} else if ("1".equals(type)) {
			sql.append(" t.name typename, ");
		} else if ("2".equals(type)) {
			sql.append(" t.code typename, ");
		}
		sql.append(
				" sl.startdate, sl.enddate, sl.ip, sl.result, sl.createtime, u.name createname, us.name username")
				.append(" from Scheduleplanlog sl left join Userinfo us on sl.userid=us.id, Organization o, Userinfo u ");
		if ("1".equals(type)) {
			sql.append(" , Route t ");
		} else if ("2".equals(type)) {
			sql.append(" , Schedule t ");
		}
//		sql.append(" where sl.orgid=o.id and sl.createby=u.id and sl.type=:type ");
		sql.append(" where sl.orgid=o.id and sl.createby=u.id ");
		if ("1".equals(type)) {
			sql.append(" and sl.typeid=t.id and sl.type='1' ");
			sql.append(" and t.id in (select t.id from Route t where 1=1 )");						
		} else if("2".equals(type)){
			sql.append(" and sl.typeid=t.id and sl.type='2' ");
		} else if("0".equals(type) ){
			sql.append(" and sl.type='0' ");
		}		
		if(!"1".equals(type)){//如果type类型不为1，即线路时，删除线路参数
			for(int i=0;i<buildFromHttpRequest.size();i++){								
				String[] str = buildFromHttpRequest.get(i).getPropertyFullNames();
				if(str[0].equals("t!name")){
				  buildFromHttpRequest.remove(i);
				}  
			}						
		}		
		sql.append(PropertyFilter.toJpql(buildFromHttpRequest, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, buildFromHttpRequest);		
//		query.setParameter("type", type);
		return query.getResultList();
	}

}
