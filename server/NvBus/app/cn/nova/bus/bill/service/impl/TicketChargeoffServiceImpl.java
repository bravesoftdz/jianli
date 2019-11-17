package cn.nova.bus.bill.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.dao.TicketChargeoffDao;
import cn.nova.bus.bill.model.Ticketchargeoff;
import cn.nova.bus.bill.service.TicketChargeoffService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：票据核销</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-8-19 下午	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class TicketChargeoffServiceImpl implements TicketChargeoffService {

	
	private IDAO<Ticketchargeoff> dao = new EntityManagerDaoSurport<Ticketchargeoff>();
	
	private TicketChargeoffDao ticketChargeoffdao = new TicketChargeoffDao();
	
	private ParameterService parameterService = new ParameterServiceImpl();
	
	@Override
	public List<Map<String, Object>> queryTicketChargeoff(String orgid,
			Long userid, Date begindate, Date enddate) {

		Object[] fileds = new Object[] {
				"orgname","username","userid","orgid","ticketno","tickettype",
				"actiontime","chargestatus","chargername","chargetime","fullprice","stationname"};
		Object[] filedtype = new Object[] {
				String.class,String.class,Long.class,Long.class,String.class,String.class,
				Timestamp.class, String.class,String.class,Timestamp.class,BigDecimal.class,String.class};
		//获得核销记录
		List<Map<String, Object>> ticketchargelist = ListUtil.listToMap(fileds,
				ticketChargeoffdao.queryReturnCancleticket(orgid,userid,begindate,enddate),
				filedtype);
		
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_4011, null))){
			//获得每段坏票记录
			List<Map<String, Object>> badTicket = ListUtil.listToMap(
					new Object[] {"userid","orgid","startno","endno","actiontime"},
					ticketChargeoffdao.querybilldamaged(orgid,userid,begindate,enddate),
					new Object[] {String.class,String.class,String.class,String.class,Date.class});
			//每张坏票的核销记录
			List<Map<String, Object>> badTicketChargeoff = null;
			if(badTicket!=null && badTicket.size()>1){		
				long startno = 0;
				long endno =  0;			
				for(int i = 0;i < badTicket.size()-1 ; i++){				
					Map<String, Object> ticket = badTicket.get(i);
					String a =   ticket.get("startno").toString();
					if( a != null){							
						startno = Long.parseLong(a);
						endno =   Long.parseLong(ticket.get("endno").toString());
						String uid = ticket.get("userid").toString();
						String oid = ticket.get("orgid").toString();
						Date actiontime = (Date)ticket.get("actiontime");				
						for(int j=(int) startno;j<=(int)endno;j++){					
							badTicketChargeoff = ListUtil.listToMap(fileds,
									ticketChargeoffdao.queryTicketChargeoff(oid,uid,j,actiontime),
									filedtype);
							for (int k = 0; k < badTicketChargeoff.size() ; k++) {
								Map<String, Object> map = badTicketChargeoff.get(k);
								ticketchargelist.add(map);
							}					
						}
					}
				}
			}
		}
		return ticketchargelist;
	}

	@Override
	public boolean saveTicketChargeoff(Ticketchargeoff chargeoff) {
		
		if( dao.merge(chargeoff)!=null){
			return true;
		}else{
			return false;
		}
	}

	public ParameterService getParameterService() {
		return parameterService;
	}

	public void setParameterService(ParameterService parameterService) {
		this.parameterService = parameterService;
	}
}
