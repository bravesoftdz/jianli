package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.LockModeType;

import org.jasypt.commons.CommonUtils;

import cn.nova.bus.common.TicketInsuranceConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.insure.model.Insurance;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.sale.dao.TicketpriceReturnDao;
import cn.nova.bus.sale.model.TicketpriceReturn;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.bus.sale.service.TicketpriceReturnService;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import util.CurrentUtil;
import util.DateUtils;
/**
 * <b>类名称：</b>TicketpriceReturnServiceImpl <br/>
 * <b>类描述：</b>原路退款 ServiceImpl<br/>
 * <b>创建人：</b>tianhb<br/>
 * <b>修改人：</b><br/>
 * <b>修改时间：</b>2018年6月13日 上午9:07:12<br/>
 * <b>修改备注：</b><br/>
 * <b>版本信息：</b>v1.0.0<br/>
  * <b>任务号：</b>2018年6月13日 上午9:07:12<br/>
 */
public class TicketpriceReturnServiceImpl implements TicketpriceReturnService {

	private TicketpriceReturnDao ticketpriceReturnDao;
	
	private IDAO dao = new EntityManagerDaoSurport();
	
	public static final Integer DEPARTDATE_BEFORE_TODAY_RETURNBACK = 3;//N 天(发车日期、不含当天)之前的符合条件的过期车票可以原路退款 (目前 N = 3)
	
	/**
	 * @Title returnTickets
	 * @Description 原路退款(不更改车票状态、营收...仅在 TicketpriceReturn 增加数据供线上退款使用)
	 * @param ticketsellids 原路退款车票 IDS 字符串 (,分隔) 
	 * @param remark 原路退款原因
	 * @param totalticketnum 原路退款车票张数
	 * @param totalinsurancenum 原路退款保险张数
	 * @param totalticketmoney 原路退款车票金额
	 * @param totalinsurancemoney 原路退款保险金额
	 * void 
	 * @author tianhb
	 * @date 2018年6月13日-下午2:22:37
	 * @update 
	 * @throws
	 */
	@Override
	public void returnTickets(String ticketsellids, String remark, Integer totalticketnum,
			Integer totalinsurancenum, BigDecimal totalticketmoney, BigDecimal totalinsurancemoney) throws BusinessException{
		if(null == ticketpriceReturnDao){
			ticketpriceReturnDao = new TicketpriceReturnDao();
		}
		Global global = CurrentUtil.getGlobal();
		Long userId = global.getUserinfo().getId();
		Date now = new Date();
		TicketpriceReturn ticketpriceReturn = new TicketpriceReturn();
		ticketpriceReturn.setRemarks(remark);
		ticketpriceReturn.setCreateby(userId);
		ticketpriceReturn.setUpdateby(userId);
		ticketpriceReturn.setReturnby(userId);
		ticketpriceReturn.setReturnip(global.getIpAddress());
		ticketpriceReturn.setCreatetime(now);
		ticketpriceReturn.setUpdatetime(now);
		ticketpriceReturn.setReturntime(now);
		ticketpriceReturn.setRate(BigDecimal.ZERO);
		ticketpriceReturn.setCharges(BigDecimal.ZERO);
//		ticketpriceReturn.setBilltypeid(null);
//		ticketpriceReturn.setReturnvoucherno(null);
		ticketpriceReturn.setTicketoutletsid(global.getTicketoutlets().getId());
		
		//先将退保险设置为 0 ，因有些车票未售保险，或者保险不是和车票一起售出(本次未退保险)
		ticketpriceReturn.setInsurefee(BigDecimal.ZERO);
		
		String tsids[] = null;
		if(CommonUtils.isNotEmpty(ticketsellids)){
			tsids = ticketsellids.split(",");
		}else{
			throw new BusinessException("请选择要原路退款的车票！");
		}
//		String inids[] = null;
//		if(CommonUtils.isNotEmpty(insuranceids)){
//			inids = ticketsellids.split(insuranceids, ',');
//		}
//		Long insuranceid = null;
		Long ticketsellid = null;
		Ticketsell ticketsell = null;
		TicketpriceReturn trp = null;
		Insurance ir = null;
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		String ticketno = "";
		Organization org = null;
		Ticketsellother tso = null;
		Calendar calendar = Calendar.getInstance();  //得到日历
		calendar.setTime(DateUtils.strToDate(DateUtils.DateToStr(now)));//把当前时间赋给日历(时间：00:00:00)
        calendar.add(Calendar.DAY_OF_MONTH, - DEPARTDATE_BEFORE_TODAY_RETURNBACK);
        Date before3days = calendar.getTime();
        Operationlog operationlog = new Operationlog();
        operationlog.setIp(global.getIpAddress());
        operationlog.setUserid(userId);
        operationlog.setOperatetime(now);
        operationlog.setOperation("添加");
        operationlog.setModule("退票->原路退款");
        operationlog.setSessionid(global.getSessionID());
        String content = "" ;
        String msg = "";
		for(int i = 0; i < tsids.length ; i ++){
			ticketsellid = Long.valueOf(tsids[i]);
			content = "本次退票数:" + totalticketnum + ",本次退票金额：" + totalticketmoney
	        		+ ",保险数:" + totalinsurancenum + ",保险金额:" + totalinsurancemoney + ",操作顺序号:" ;
			ticketsell = (Ticketsell)dao.get(LockModeType.NONE,Ticketsell.class, ticketsellid);
			if(null == ticketsell){
				msg = "原路退款车票查询出错，请稍后重试！";
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			ticketno = ticketsell.getTicketno();
//			propertyFilters.clear();
//			propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
//			trp = (TicketpriceReturn)dao.find(LockModeType.NONE,TicketpriceReturn.class,propertyFilters);
			trp = ticketpriceReturnDao.queryTicketpriceReturnBySellid(ticketsell.getId());
			if(null != trp){
				msg = "该车票已经退款，不允许再次退款操作:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			//原路退款 车票必须为 自助机 或者 网售 sellway: 10、7
			if(!TicketInsuranceConst.TICKETSELL_SELLWAY.TICKETSELL_WEBSALE.equalsIgnoreCase(ticketsell.getSellway())
					&& !TicketInsuranceConst.TICKETSELL_SELLWAY.TICKETSELL_SELFSALE.equalsIgnoreCase(ticketsell.getSellway())){
				msg = "该车票非网售或者自助机售票，不能进行原路退款:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			//原路退款 车票必须为原路返还(即 RETURNFEEMODE = 1) RETURNFEEMODE：车票退票返还标识:0 车站垫付,1 原路返还
			if(!TicketInsuranceConst.TICKETSELL_RETURNFEEMODE_YES.equalsIgnoreCase(ticketsell.getReturnfeemode())){
				msg = "该车票返还模式不是原路返还，不能进行原路退款:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			//发车日期 为过去 3 天之内 (不含当天)
			if(ticketsell.getDepartdate().getTime() >= DateUtils.strToDate(DateUtils.DateToStr(now)).getTime() ){
				msg = "该车票未超过退票日期限制，不允许使用【原路退款】功能进行退款操作-票号:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			//过去 3 天判断【发车日期距离当天日期之前3天已内，不包含当天】
			if(before3days.after(ticketsell.getDepartdate())){
				msg = "该车票发车日期距离当前日期超过3天【不包含当天】，不允许原路退款-票号:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			
			//正常票、未检票
			if(!TicketInsuranceConst.TICKETSELL_STATUS.TICKETSELL_SALE.equalsIgnoreCase(ticketsell.getTicketstatus())){
				msg = "该车票已退票或者已废票，不能进行原路退款-票号:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			//未检票
			if(ticketsell.getIschecked()){
				msg = "该车票已经检票，不能进行原路退款-票号:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			//车票允许原路退款、设置车票ID、订单号、退款金额、售票机构编码、售票机构名称、电子票 ID
			operationlog.setId(0L);
			ticketpriceReturn.setId(0L);
			ticketpriceReturn.setSellid(ticketsell.getId());
			ticketpriceReturn.setOrderno(ticketsell.getOrderno());
			ticketpriceReturn.setTicketprice(ticketsell.getPrice());
			ticketpriceReturn.setReturnamount(ticketsell.getPrice());
			content += i+1 + ",原路退款-车票号:" + ticketno + ",退款金额:" + ticketsell.getPrice();
			org = (Organization)dao.get(LockModeType.NONE,Organization.class, ticketsell.getOrgid());
			if(null != org){
				ticketpriceReturn.setSellorgcode(org.getCode());
				ticketpriceReturn.setSellorgname(org.getName());
			}
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!ticketsellid", ticketsell.getId()));
			tso = (Ticketsellother)dao.uniqueResult(LockModeType.NONE,Ticketsellother.class,propertyFilters);
			if(null != tso){
				ticketpriceReturn.setNetticketid(tso.getEticketid());
			}else{
				msg = "该车票非网售或者自助机售票，不允许原路退款-票号:" + ticketno;
				play.Logger.info(msg);
				throw new BusinessException(msg);
			}
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQL_t!sellid", ticketsell.getId()));
			ir = (Insurance)dao.uniqueResult(LockModeType.NONE,Insurance.class,propertyFilters);
			if(null != ir){
				//该车票已售保险、否则不操作保险
				if(TicketInsuranceConst.INSURANCE_SELLWAY.INSURANCE_WEBSALE.equalsIgnoreCase(ir.getSellway()) || TicketInsuranceConst.INSURANCE_SELLWAY.INSURANCE_SELFSALE.equalsIgnoreCase(ir.getSellway())){
					//可以退保险、否则不进行退保险操作(判断保险是否已经提前单独退)
					if(TicketInsuranceConst.INSURANCE_STATUS.INSURANCE_SALE.equalsIgnoreCase(ir.getInsurancestatus())){
						ticketpriceReturn.setInsurefee(ir.getPremium());
						content += ",车票对应保险号:" + ir.getInsuranceno() + ",退保险金额:" + ir.getPremium();
					}else{
						ticketpriceReturn.setInsurefee(BigDecimal.ZERO);
						play.Logger.info("车票对应保险号:" + ir.getInsuranceno() + ",保险已退【废】，本次退保险金额:0！");
						content += ",车票对应保险号:" + ir.getInsuranceno() + ",保险已退【废】，本次退保险金额:0！";
					}
				}
			}
			operationlog.setContent(content);
			dao.getEntityManager().merge(ticketpriceReturn);
			dao.getEntityManager().merge(operationlog);
			dao.getEntityManager().flush();
			//dao.getEntityManager().clear();
			play.Logger.info("原路退款数据保存成功-sellid:" + ticketsellid + ",ticketno:" + ticketno);
		}
		
	}
	
	public static void main(String args[]){
		
		
		
	}
	
	/**
	 * @Title isCanReturnBack
	 * @Description 根据车票判断该车票是否可以执行原路退款操作(不判断 3 天之内，供退票使用)
	 * @param ts
	 * @return Boolean 
	 * @author tianhb
	 * @date 2018年6月14日-上午10:30:17
	 * @update 
	 * @throws
	 */
	@Override
	public Boolean isCanReturnBack(Ticketsell ts) {
		if(null == ts){
			return false;
		}
		/*
		if(null == ticketpriceReturnDao){
			ticketpriceReturnDao = new TicketpriceReturnDao();
		}
		*/
		Boolean flag = false;
		Date today = DateUtils.strToDate(DateUtils.DateToStr(new Date()));
		//三种条件限制：发车日期未超过今天(不含今天)、网售：7、10  返还模式：1
		if(ts.getDepartdate().getTime() < today.getTime()
				&& (TicketInsuranceConst.TICKETSELL_SELLWAY.TICKETSELL_WEBSALE.equalsIgnoreCase(ts.getSellway())
						|| TicketInsuranceConst.TICKETSELL_SELLWAY.TICKETSELL_SELFSALE.equalsIgnoreCase(ts.getSellway()))
				&& TicketInsuranceConst.TICKETSELL_RETURNFEEMODE_YES.equalsIgnoreCase(ts.getReturnfeemode())){
			flag = true;
		}
		return flag;
	}
	
	/**
	 * @Title isExistTicketpriceReturn
	 * @Description 根据 车票 ID 判断是否存在原路退款数据
	 * @param sellid
	 * @return Boolean TRUE:存在，FALSE:不存在
	 * @author tianhb
	 * @date 2018年6月13日-下午3:50:34
	 * @update 
	 * @throws
	 */
	@Override
	public Boolean isExistTicketpriceReturn(Long sellid) {
		if(null == sellid){
			return false;
		}
		if(null == ticketpriceReturnDao){
			ticketpriceReturnDao = new TicketpriceReturnDao();
		}
		return ticketpriceReturnDao.isExistTicketpriceReturn(sellid);
	}
	
}
