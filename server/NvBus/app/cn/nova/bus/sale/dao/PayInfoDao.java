package cn.nova.bus.sale.dao;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;
import javax.persistence.Query;

import util.DateUtils;

import com.ning.http.util.DateUtil;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.bus.sale.model.Payinfodetail;
import cn.nova.bus.sale.model.Ticketcancel;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

public class PayInfoDao extends EntityManagerDaoSurport<Payinfo>{
	/**
	 * 查询支付订单接口
	 * @param propertyFilters
	 * @return
	 */
	public List<Object>  queryEPayInfo(
			List<PropertyFilter> propertyFilters) {
		Date sellDate = null;
		PropertyFilter p = null;
		for (PropertyFilter propertyFilter : propertyFilters) {
			if("createtime".equals(propertyFilter.getPropertyName())){
				sellDate = (Date) propertyFilter.getMatchValue();
				p = propertyFilter;
			}
		}
		propertyFilters.remove(p);
		StringBuilder sql = new StringBuilder();
		sql.append("select p.id,p.orderno,p.payno,p.totalprice,")
		.append(" decode(p.isreturnmoney,1,p.refundmoney,p.totalprice-nvl(p.returnmoneytotal,0)) returnmoney, ")
		.append("ddt.value,decode(p.returnstatus,'1','原路返还','') returnmethod,")
		.append(" decode(p.paystatus,'0','待付款','1','付款成功','退款成功') paystatus,p.createtime,p.updatetime,ui.name updateby,p.isbus365pay")
		.append(" ,p.paydate,p.payorderno,p.lrc,p.paymethod,p.paygateway, ")
		//新增明细数据
		.append(" decode(p.isreturnmoney, 1,  pdd.tickets,  p.tickets) tickets,")
		.append(" decode(p.isreturnmoney, 1,  pdd.ticketprice,  p.ticketprice) ticketprice, ")
		.append(" decode(p.isreturnmoney, 1, pdd.insures, p.insures) insures,  ")
		.append(" decode(p.isreturnmoney, 1, pdd.insurefee, p.insurefee) insurefee, ")
		.append(" decode(p.isreturnmoney, 1, pdd.ids ,'' ) ids,p.merchantpayorderno as merchantpayorderno")
		
		.append(" from payinfo p")
		.append(" left join gateway g on p.gatewayid=g.id ")
//		.append(" left join userinfo ui on p.updateby=ui.id,digitaldictionary dd,digitaldictionarydetail ddt  where p.paystatus=1 and ")
		.append(" left join userinfo ui on p.updateby=ui.id ")
		//新增明细数据
		.append("   left join (select pd.payinfoid, sum(pd.tickets) as tickets ,sum(pd.ticketprice) as ticketprice,sum(pd.insures) as insures,")
		.append(" sum(pd.insurefee) as insurefee, to_char(wm_concat(pd.id)) as ids from payinfodetail pd  where pd.returnstatus = '0' group by pd.payinfoid")
		.append("   ) pdd on pdd.payinfoid = p.id,")
		
		.append(" digitaldictionary dd,digitaldictionarydetail ddt  where p.paystatus=1 and")
		.append(" dd.id=ddt.digitaldictionaryid and ddt.code=p.paymethod and dd.columnname='paymethod' and dd.tablename='ticketsell' and ")
		.append("( p.isreturnmoney=1 or not exists(select * from ticketsell ts where ts.selltime>").append("to_date('")
		.append(DateUtils.formatDate(sellDate)).append("','yyyy-MM-dd')")
		.append(" and ts.orderno=p.orderno  )) and trim(p.createtime)=to_date('")
		.append(DateUtils.formatDate(sellDate)).append("','yyyy-MM-dd')");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		sql.append(" order by p.createtime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		//query.setParameter("sellDate",sellDate );
		return query.getResultList();
	}
	/**
	 * 电子票退款详情信息
	 * @param id
	 * @return
	 */
	public List<Object> queryEPayDetail(long id) {
		if(id>0){
			StringBuffer sb = new StringBuffer();
			sb.append(" select p.orderno,pd.returntime, ")
			.append(" decode(pd.returnstatus,'1','退款成功','退款失败') returnstatus,ui.name returnby,pd.ip,pd.returnprice ")
			.append("  from payinfodetail pd ")
			.append(" left join payinfo p on p.id=pd.payinfoid ")
			.append(" left join userinfo ui on pd.returnby=ui.id ")
			.append(" where p.id=:id ");
			Query query = getEntityManager().createNativeQuery(sb.toString());
			query.setParameter("id",id );
			return query.getResultList();
			
		}
		return null;
	}
	/**
	 * 查询出售票售保险的流水信息
	 * @param propertyFilters
	 * @return
	 */
	public List<Object> queryInsuranceOrder(Date sellDate, Date enddate) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select tt.orderno,nvl(totalprice-ticketprice,0) refundmoney from  ")
		.append(" (select ts.orderno,sum(ts.price+ts.servicefee) ticketprice, ")
		.append(" max(p.totalprice) totalprice from payinfo p  ")
		.append(" left join ticketsell ts on p.orderno=ts.orderno ")
		.append(" where p.paystatus='1' and p.createtime between :sellDate and :enddate and  p.insurancestatus<>'1' ")
		.append(" and ts.selltime between :sellDate and :enddate ")
		.append("  group by ts.orderno)tt where tt.totalprice>tt.ticketprice ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("sellDate",sellDate );
		query.setParameter("enddate", enddate);
		return query.getResultList();
	}
	public List<Payinfodetail> findPayinfodetails(String ids) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t from Payinfodetail t where t.id in(");
		sql.append(ids).append(")");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setLockMode(LockModeType.PESSIMISTIC_READ);
		return query.getResultList();
	}

}
