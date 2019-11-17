/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>QueryBalanceitemDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-1 上午09:56:46<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>QueryBalanceitemDao.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-1 上午09:56:46<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class QueryBalanceitemDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> getBalancedeductitemName(String orgid) {
		StringBuffer sql = new StringBuffer(
				"select t.name from balancedeductitem t ");
		sql.append(" where t.isactive=1 and t.isdeductbeforebalance=0  and t.isticketpriceitem=0 and t.orgid in "+orgid+" order by t.id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	public List<Object> genDelphiField(String orgid) {
		StringBuffer sql = new StringBuffer(
				"select t.name,'deduct'||t.id as code from balancedeductitem t ");
		sql.append(" where t.isactive=1 and t.isdeductbeforebalance=0  and t.isticketpriceitem=0 and t.orgid in "+orgid+" order by t.id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> getBalancedeductdetail(String orgid, Date startdate,
			Date enddate, Long unitid, String vehicleno,String routename,String balanceno) {
		List<Object> list = genDelphiField(orgid);
		StringBuffer sql = new StringBuffer(" select b.balanceid ");
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			sql.append(", sum(decode(bd.name,'" + obj[0].toString()
					+ "',b.deductmoney)) " + obj[1].toString());
		}
		sql.append(" from balancedeductdetail b, balancedeductitem bd, balance ba ");
		sql.append(" where b.balanceid=ba.id and b.status=0 and b.balancedeductitemid=bd.id and ba.status=0 ");
		if (unitid != null && !"".equals(unitid)) {
			sql.append(" and ba.objectid=" + unitid);
		}
		if (vehicleno != null && !"".equals(vehicleno)) {
			sql.append(" and ba.vehicleno like '%" + vehicleno + "%' ");
		}
		if (balanceno != null && !"".equals(balanceno)) {
			sql.append(" and ba.balanceno like '%" + balanceno + "%' ");
		}
		if (routename != null && !"".equals(routename)) {
			sql.append(" and ba.routename like '%" + routename + "%' ");
		}
		sql.append(" and ba.createtime between :startdate and :enddate and b.orgid in "+orgid+" group by b.balanceid ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}

	@SuppressWarnings("unchecked")
	public List<Object> getBalance(String orgid, Date startdate, Date enddate,
			Long unitid, String vehicleno,String routename,String balanceno) {
		StringBuffer sql = new StringBuffer(
				"select b.id,b.balanceno, b.routename, b.vehicleno, u.name, ");
//		sql.append(" (b.ditotalmoney-b.distationservicefee-b.diotherpredeductifee-b.fueladditionfee-b.debit+b.backmoney-nvl((select sum(d.balancemoney) from departinvoicesother d  where d.balanceid = b.id and d.status = 2 and d.datafrom <>'8' group by b.id ),0)),") // 减去手工补录中的票款，因为结算的时候已经计入balance
		sql.append(" (b.ditotalmoney-b.distationservicefee-b.diotherpredeductifee-b.fueladditionfee-b.debit+b.backmoney-nvl((select sum(d.balancemoney) from departinvoicesother d  where d.balanceid = b.id and d.status = 2 and d.datafrom <>'10' group by b.id ),0)) as cargoticket,") //修改上句：【配载金额|客运收入】取微机结算单+sg手工票（票根）的结算金额，即【配载金额|客运收入】 = 微机结算单 + 补录单中来源是手工的，sql实现为结算总金额-扣费-补录单中除了来源是手工外的
		.append(" b.packprice, b.rentmoney, ")
				.append(" decode((select t.money from vehicleturnover t where t.balanceid=b.id and t.isbalance=1) ,null,0,")
				.append("(select t.money from vehicleturnover t where t.balanceid=b.id and t.isbalance=1)) vehicleturnover,")
//				.append("decode((select sum(d.balancemoney) from departinvoicesother d where d.balanceid=b.id and d.status=2 group by b.id), null,0,")
				.append("nvl((select sum(d.balancemoney) from departinvoicesother d where d.balanceid=b.id and d.status=2 ")
				.append(" and not exists (select tdd.id from digitaldictionary td, digitaldictionarydetail tdd where td.id = tdd.digitaldictionaryid ")
				.append("  and td.tablename = 'departinvoicesother' and td.columnname = 'datafrom' and tdd.code in ('8', '9', '10') and d.datafrom = tdd.code)  ")//增加查询条件：补录中运量单总金额  = 应结算给车方的 - (手工单中来源是  9包车 + 8货物  + 10手工)
				.append(" group by b.id),0) as cargodepartinvoicesother, ")
				.append(" round(b.dibalancemoney * b.divide,2) dividemoney, b.diagentfee,(b.packprice-b.packmoney) packmoney, ")
				.append(" 0 as price, b.additionfee, b.balancemoney,b.packamount as packfee,b.goodsagent ") //(b.rentmoney-b.rentprice)
				.append(" from balance b,unit u where b.status=0 and b.objectid=u.id ")
				.append(" and b.createtime between :startdate and :enddate and b.orgid in "+orgid );
		if (unitid != null && !"".equals(unitid)) {
			sql.append(" and b.objectid=" + unitid);
		}
		if (vehicleno != null && !"".equals(vehicleno)) {
			sql.append(" and b.vehicleno like '%" + vehicleno + "%' ");
		}
		if (balanceno != null && !"".equals(balanceno)) {
			sql.append(" and b.balanceno like '%" + balanceno + "%' ");
		}
		if (routename != null && !"".equals(routename)) {
			sql.append(" and b.routename like '%" + routename + "%' ");
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	
}
