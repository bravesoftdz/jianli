package cn.nova.bus.archive.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Onecardschedule;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Schedule;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：</b>一卡通参与班次<br/>
 * <b>类名称：</b>OnecardscheduleDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2012-12-12 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class OnecardscheduleDao extends EntityManagerDaoSurport {

	public IDAO<Onecardschedule> onecadscheduledao = new EntityManagerDaoSurport<Onecardschedule>();

	/**
	 * 查找所有一卡通参与班次信息
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findOnecardschedule(
			List<PropertyFilter> propertyFilterList, Date startdate,
			Date enddate) {
		StringBuilder sql = new StringBuilder(
				"select spd.id,o.id orgid,o.name orgname,case when spd.type=1 then '线路'")
				.append(" when spd.type=2 then '班次' when spd.type=0 then '全部班次' end typename,spd.type typecode ,")
				.append("case when spd.type =1 then r.name when spd.type = 2 then s.code else '全部' end typeidname,")
				.append("spd.startdate,spd.enddate,cu.name createname,up.name updatename,spd.createtime,")
				.append(" spd.updatetime,spd.typeid,cu.id createby,spd.remarks")
				.append(" from Onecardschedule spd left join route r on spd.type = 1 and spd.typeid = r.id")
				.append(" left join schedule s on spd.type = 2 and spd.typeid = s.id,")
				.append(" organization o,userinfo cu,userinfo up")
				.append(" where spd.orgid = o.id and spd.createby= cu.id ")
				.append(" and spd.updateby= up.id and spd.isactive = 1")
				.append(" and (( :startdate >= spd.startdate and :startdate <= spd.enddate ")
				.append(" or :enddate >= spd.startdate and :enddate <= spd.enddate ) ")
				.append(" or (spd.startdate > :startdate and spd.enddate < :enddate) ) ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by spd.updatetime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	/**
	 * 根据 机构，类型，类型ID 获取已经存在的信息， 用于修改
	 * 
	 * @param orgid
	 * @param type
	 * @param typeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Onecardschedule> qryOnecardschedule(long orgid, long type,
			long typeid, Date startdate, Date enddate) {
		String sql = "select s from Onecardschedule s " + " where s.orgid = "
				+ orgid + " and s.type = " + type + " and s.typeid =" + typeid;
		if (startdate != null) {
			sql = sql
					+ " and not (s.startdate>:enddate  or s.enddate<:startdate ) ";
		}
		Query query = getEntityManager().createQuery(sql.toString());
		if (startdate != null) {
			query.setParameter("enddate", enddate);
			query.setParameter("startdate", startdate);
		}
		// List<Onecardschedule> list = query.getResultList();
		// if (list!=null && list.size()>0){
		// return (Onecardschedule) list.get(0);
		// }else{
		// return null;
		// }
		return query.getResultList();
	}

	/**
	 * 添加/修改一卡通参与班次
	 * 
	 * @param Onecardschedule
	 * @param typeids
	 * @return
	 * @throws ServiceException
	 */
	public Onecardschedule saveOnecardschedule(Onecardschedule entity) {
		return onecadscheduledao.merge(entity);
	}

	/**
	 * 查找指定机构的线路或者班次
	 * 
	 * @param orgid
	 * @param type
	 * @param isupdate
	 * @param id
	 *            线路或者班次ID
	 * @param routeid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findscheduleOrRoute(Long orgid, String type,
			boolean isupdate, long id, long routeid) {
		String sql = "";
		if (type.equals("1")) {
			sql = "select r.id,r.name,'' as code,'' as starttime,";
			if (isupdate) {
				sql = sql
						+ " ( case when r.id = "
						+ id
						+ " then 1 else 0 end ) as checked from Route r, Onecardschedule spd "
						+ " where spd.typeid = r.id and r.isactive=1 and r.orgid = "
						+ orgid + " and r.id=" + id;
				if (routeid != 0) {
					sql = sql + " and r.id = " + routeid;
				}
				sql = sql + " group by r.id,r.name order by r.name ";
			} else {
				sql = sql
						+ " 0 as checked from Route r where r.isactive=1 and r.orgid = "
						+ orgid;
				if (routeid != 0) {
					sql = sql + " and r.id = " + routeid;
				}
				sql = sql + " order by r.name ";
			}

		} else if (type.equals("2")) {
			sql = "select s.id,r.name,s.code,trim(s.starttime), ";
			if (isupdate) {
				sql = sql
						+ " ( case when s.id = "
						+ id
						+ " then 1 else 0 end ) as checked from Schedule s,Route r, Onecardschedule spd "
						+ " where spd.typeid = s.id and s.routeid=r.id and s.isactive=1 and s.orgid ="
						+ orgid + " and s.id=" + id;
				if (routeid != 0) {
					sql = sql + " and r.id = " + routeid;
				}
				sql = sql
						+ " group by s.id,r.name,s.code,s.starttime order by r.name ";
			} else {
				sql = sql
						+ " 0 as checked from Schedule s,Route r where s.routeid=r.id and s.isactive=1 and s.orgid ="
						+ orgid;
				if (routeid != 0) {
					sql = sql + " and r.id = " + routeid;
				}
				sql = sql + " order by r.name ";
			}

		}
		Query query = getEntityManager().createNativeQuery(sql);
		return query.getResultList();
	}
}