package cn.nova.bus.balance.dao;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
/**
 * <b>类描述：票款对付表</b><br/>
 * <b>类名称：</b>TicketFundsCheckDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class TicketFundsCheckDao extends EntityManagerDaoSurport {
	
	//票款对付表信息
	public List<Object> find(String vehicleno, Date balanceStartdate,Date balanceEnddate) {
		StringBuilder sql = new StringBuilder("select ")
		.append(" vv.contactperson, vv.vehicleno, vv.ditotalnum, vv.ditotalmoney-vv.distationservicefee as ditotalmoney, vv.diagentfee,vv.balancemoney, rr.parkfee,rr.healthfee,rr.otherfee,rr.packagefee, '' signature ")
		.append(" from (select ")
		.append(" v.contactperson,v.vehicleno,b.ditotalnum,b.distationservicefee,b.ditotalmoney,b.diagentfee,b.balancemoney,b.objectid,b.id ")
		.append(" from vehicle v, balance b ")
		.append(" where b.balanceobject = 1 and   b.objectid =v.id ");
		if (vehicleno != null && vehicleno.trim().length() > 0) {
			sql.append(" and   v.vehicleno='"+vehicleno+"' ");
		}
		if (balanceStartdate != null && balanceEnddate != null) {
			sql.append(" and b.balancetime between trunc(to_timestamp('"+new SimpleDateFormat("yyyy-MM-dd").format(balanceStartdate)+"','yyyy-MM-dd')) "
					+" and trunc(to_timestamp('"+new SimpleDateFormat("yyyy-MM-dd").format(balanceEnddate)+"','yyyy-MM-dd')) ");
		}
		sql.append(" ) vv ")
		.append(" left join ")
		.append(" (select ")
		.append(" r.balanceid, ")
		.append(" sum(case when r.name='停车费' then r.deductmoney else 0 end) as parkfee,")
		.append(" sum(case when r.name='卫生费' then r.deductmoney else 0 end) as healthfee,")
		.append(" sum (case when r.name= '其他' then r.deductmoney else 0 end) as otherfee,")
		.append(" sum (case when r.name= '行包费' then r.deductmoney else 0 end) as packagefee")
		.append(" from (")
		.append(" select bt.name,bd.deductmoney,bd.balanceid ")
		.append(" from  balancedeductitem bt , balancedeductdetail bd ")
		.append(" where bt.id= bd.balancedeductitemid ")
		.append(" ) r ")
		.append(" group by r.balanceid ")
		.append(" ) rr ")
		.append(" on vv.id = rr.balanceid");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
}
