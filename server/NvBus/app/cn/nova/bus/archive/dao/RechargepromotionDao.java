package cn.nova.bus.archive.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Rechargeactivitydetail;
import cn.nova.bus.archive.model.Rechargepromotionactivity;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.jpa.IDAO;

/**
 * 充值优惠活动
 * 
 * @author Administrator
 * 
 */
@SuppressWarnings("rawtypes")
public class RechargepromotionDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> queryRechargepromotion(Date startdate, Date enddate,
			String vipgrade) {
		StringBuilder sql = new StringBuilder(
				" select wm_concat( distinct dd.value) as vipgradename,wm_concat( distinct rd.vipgrade) vipgrade,r.id,r.name,r.rechargeamount,")
				.append(" r.presentvoucher,r.presentoncepercard,r.startdate,r.enddate,r.remarks,")
				.append(" r.createtime,r.updatetime,cu.name createname,uu.name updatename,cu.id as createby")
				.append("  from rechargePromotionActivity r, rechargeActivitydetail rd,digitaldictionary d,")
				.append("  digitaldictionarydetail dd,userinfo cu,userinfo uu")
				.append(" where r.id = rd.rechargepromotionactivityid  and d.columnname = 'grade'")
				.append(" and r.isactive = 1 and rd.vipgrade = dd.code and d.tablename = 'vip' ")
				.append(" and r.createby=cu.id and r.updateby=uu.id ")
				.append(" and d.id = dd.digitaldictionaryid ")
				.append(" and ( ( :startdate >= r.startdate and :startdate <= r.enddate ")
				.append(" or :enddate >= r.startdate and :enddate <= r.enddate ) ")
				.append(" or (r.startdate > :startdate and r.enddate < :enddate) ) ");
		if (vipgrade != null) {
			String grade = "'";
			char[] b = new char[vipgrade.length() - 2];
			for (int j = 1; j < vipgrade.length() - 1; j++) {
				b[j - 1] = vipgrade.charAt(j);
			}
			String types = new String(b);
			String[] objects = types.split(",");
			for (int i = 0; i < objects.length; i++) {
				String vipgradeid = objects[i];
				grade = grade + vipgradeid + "'";
				if (i + 1 != objects.length) {
					grade = grade + ",'";
				} else {
					break;
				}
			}
			sql.append(" and rd.vipgrade in (" + grade + ")");
		}
		sql.append(" group by r.id,r.name,r.rechargeamount,r.presentvoucher,r.presentoncepercard ,"
				+ " r.startdate,r.enddate,r.remarks,r.createtime,r.updatetime,cu.name ,uu.name,cu.id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public Rechargepromotionactivity existrechargepromotion(String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("name", name);
		// map.put("isactive", true);
		List<Rechargepromotionactivity> rechargepromotion = find(
				Rechargepromotionactivity.class, map);
		return rechargepromotion != null && rechargepromotion.size() > 0 ? rechargepromotion
				.get(0) : null;
	}

	/**
	 * 如果是修改，则先把原来添加的明细都删除，再重新添加一次
	 * 
	 * @param vipgrade
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Rechargeactivitydetail> existRechargeactivitydetail(
			String vipgrade, long id) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("rechargepromotionactivityid", id);
		if (vipgrade != null) {
			map.put("vipgrade", vipgrade);
		}
		return find(Rechargeactivitydetail.class, map);
	}

	/**
	 * 删除已经添加的明细
	 * 
	 * @param detail
	 * @return
	 */
	public boolean deldetail(long rechargeid) {
		// return detaildao.delete(detail);
		String sql = "delete Rechargeactivitydetail r  where r.rechargepromotionactivityid = "
				+ rechargeid;
		int resultnum = execute(sql);
		if (resultnum > 0) {
			return true;
		} else {
			return false;
		}
	}

	/**
	 * 根据充值优惠活动ID查询会员充值表,查看是否有活动被会员充值享受到
	 * 
	 * @param Rechargepromotionactivityid
	 * @return
	 */
	public boolean isExitViprecharge(long Rechargepromotionactivityid) {
		StringBuilder sql = new StringBuilder(
				"select v.* from Viprecharge v where v.rechargepromotionactivityid="
						+ Rechargepromotionactivityid);
		Query query = getEntityManager().createNativeQuery(sql.toString());
		if (query.getResultList() != null && query.getResultList().size() > 0) {
			return query.getResultList().get(0) != null ? true : false;
		} else {
			return false;
		}
	}

	/**
	 * 通过充值的金额与日期，查询对应的充值活动
	 */
	@SuppressWarnings("unchecked")
	public List<Rechargepromotionactivity> getRechargepromo(BigDecimal money,
			Date date) {
		StringBuilder sql = new StringBuilder("select r from ");
		sql.append(
				" Rechargepromotionactivity r where r.isactive=1 and r.rechargeamount<=:money ")
				.append(" and r.startdate<=:date and r.enddate>=:date ")
				.append(" order by r.rechargeamount desc ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("money", money);
		query.setParameter("date", date);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> getViprecharge(Long activityid, String cardno) {
		StringBuilder sql = new StringBuilder(
				"select vr.* from Viprecharge vr, Vip v ");
		sql.append(" where v.status=0 and v.vipcardno=:cardno and vr.rechargepromotionactivityid=:activityid ");
		sql.append(" and vr.vipid=v.id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("activityid", activityid);
		query.setParameter("cardno", cardno);
		return (query.getResultList().size() > 0 ? query.getResultList() : null);
	}

}
