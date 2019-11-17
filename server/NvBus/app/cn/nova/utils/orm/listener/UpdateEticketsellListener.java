package cn.nova.utils.orm.listener;

import java.util.List;

import javax.persistence.PostUpdate;
import javax.persistence.Query;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import bus365.et.EticketService;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.utils.orm.jpa.IDAO;
import models.BaseResponse;
import models.EticketStatusRequest;
import play.db.jpa.JPAPlugin;

/**
 * 同步电子票到接口
 * 
 * @author Mr.Jiang
 *
 */
public final class UpdateEticketsellListener {
	static private final Logger log = LoggerFactory.getLogger(UpdateEticketsellListener.class);

	@SuppressWarnings("rawtypes")
	private IDAO dao = null;

	@SuppressWarnings("rawtypes")
	public IDAO getDao() {
		if (dao == null)
			JPAPlugin.startTx(false);
		dao = new EntityManagerDaoSurport();
		return dao;
	}

	@PostUpdate
	public void PostUpdate(Ticketsell ticket) {
		try {
			// 得到原始的数据 如果为空则说明是新增
			Ticketsell s = (Ticketsell) getDao().getNoCache(Ticketsell.class, ticket.getId());
			if (s != null) {//不是新增说明是修改车票状态.检票状态,取票状态
				if (ticket.isIseticketsell()) {// 说明要传给接口
					EticketService ser = new EticketService();
					EticketStatusRequest request = new EticketStatusRequest();
					request.eticketNo = ticket.getEticketno();
					request.ticketStatus = ticket.getTicketstatus();
					request.checkedTicketStatus = ticket.getIschecked() ? "1" : "0";
					Ticketsellother other = getOther(ticket.getId());
					if(null != other ){
						request.pickTicketStatus = other.getIstaked()?"1":"0";	
					}
					if (ticket.getTicketno().length() <= 20) {
						request.setPhysicalTicketNo(ticket.getTicketno());
					}
					if (ticket.getTicketno().length() <= 20) {
						request.setInvoiceCode(ticket.getTicketno());
					}
					BaseResponse response = ser.updateETicketStatus(request);
					if (!"0000".equals(response.getResultCode())) {
						play.Logger.error("更新电子票状态时 推送数据错误:"+ response.getMessage()+" 电子票号  :" +ticket.getEticketno());
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error("更新电子票状态时 推送数据错误 电子票号  :" +ticket.getEticketno());
			play.Logger.error("更新电子票状态时 推送数据错误  error " + e.getMessage());
		}
	}

	private Ticketsellother getOther(long id) {
		StringBuffer sql =  new StringBuffer();
		sql.append("select t from Ticketsellother t where t.ticketsellid =:id");
		Query q=  getDao().getEntityManager().createQuery(sql.toString());
		q.setParameter("id", id);
		List<Ticketsellother> list = q.getResultList();
		return (list!= null && list.size()>0) ?list.get(0):null;
	}

}
