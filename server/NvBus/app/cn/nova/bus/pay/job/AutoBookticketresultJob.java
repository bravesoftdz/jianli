package cn.nova.bus.pay.job;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.job.model.Jobconfig;
import cn.nova.bus.pay.dao.PubEPayServiceDao;
import cn.nova.bus.pay.model.Paystationway;
import cn.nova.bus.pay.param.BusParamEPaymentInfo;
import cn.nova.bus.pay.service.TicketEpayFlyingpigCMBCService;
import cn.nova.bus.pay.service.impl.TicketEpayFlyingpigCMBCImpl;
import cn.nova.bus.sale.model.Payinfo;
import cn.nova.utils.commons.MethodResult;
import play.db.jpa.JPA;
import play.jobs.Every;
import play.jobs.Job;
import util.BusJobUtil;

//本job每个订单只同步一次 若失败支付服务器有JOB处理 20分钟不给结果按出票成功处理
@Every("1min")
public class AutoBookticketresultJob extends Job {
	private PubEPayServiceDao pubdao = null;
	private TicketEpayFlyingpigCMBCService service = null;

	@Override
	public void doJob() {

		Jobconfig job = BusJobUtil.getJobConfig("AutoBookticketresult");
		if (job != null && BusJobUtil.isTimeBetween4now(job.getStarttime(), job.getEndtime()) && job.isTriggerTime()) {
			pubdao = new PubEPayServiceDao();
			Paystationway paystationway = pubdao.getPaystationway();
			if (null != paystationway) {
				if (ParamterConst.VERSION_FLAG.FALG_TWO.equals(paystationway.getVersion())) {
					service = new TicketEpayFlyingpigCMBCImpl();
					bookticket();
				}
			}
			job = job.merge();
			job.save();
		}
	}
	//
	private void bookticket() {
		StringBuilder sql = new StringBuilder();
		sql.append(" select p from Payinfo p where 1 = 1 ")
				.append("  and exists (select 1 from Ticketsell t where t.orderno = p.orderno and t.selltime >= trunc(sysdate)")
				.append(" and t.paymethod <> '0'  and t.sellway <> '7' and t.sellway <> '10' and t.sellway <> '13'  and t.paymethod = '4')")
				.append("  and exists (select 1 from Flypigorder f where f.orderno=p.orderno and f.status = '0')")
				.append("   and p.createtime > trunc(sysdate)  and p.paymethod = '4' ");
		Query query = JPA.em().createQuery(sql.toString());
		List<Payinfo> payinfos = query.getResultList();
		// MethodResult methodresult = new MethodResult();
		BusParamEPaymentInfo paraminfo = new BusParamEPaymentInfo();
		for (Payinfo payinfo : payinfos) {
			// 创建参数
			paraminfo.setOrderno(payinfo.getOrderno());
			paraminfo.setPayorderno(payinfo.getPayorderno());
			paraminfo.setBookticketsuccess(true);
			// 通知飞猪售票成功接口
			service.bookticketresult(paraminfo);
			// 查询出票结果接口
			// methodresult =
			service.queryBookticketresult(paraminfo);
		}

	}
}
