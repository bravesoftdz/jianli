/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.checkticket.action<br/>
 * <b>文件名：</b>DepartinvoiceManagerAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.checkticket.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.DepartinvoicesManagerService;
import cn.nova.bus.checkticket.service.impl.DepartinvoiceServiceImpl;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesManagerServiceImpl;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.dispatch.dao.SchedulestatusDao;
import cn.nova.bus.dispatch.service.impl.ScheduleplanServiceImpl;
import cn.nova.bus.dispatch.service.impl.SchedulestatusServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.price.model.Scheduleplan;
import cn.nova.bus.price.model.Schedulestatus;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class DepartinvoiceManagerAction extends BaseAction{

	private Departinvoices departinvoices;
	private List<Map<String, Object>> departinvoicesMap;
	private String departinvoicesno;
	private String ip;
	private Long departstationid;
	private Long scheduleplanid;
	private Long vehiclereportid;
	private Long departinvoicesid;
	private Long newvehicleid;
	private String isdepartinvoices;
	private DepartinvoicesVo dnv;
	private Date departdate;
	private Long scheduleid;
	private long vehicleid;
	private String batchno;  //批次号
	private String ticketids;
	private List<Map<String, Object>> vehicleReportMap;  //根据车辆id查询车辆的报到情况

	private boolean iscomputeno;
	private DepartinvoicesManagerService departinvoicesManagerService;

	/**
	 * 查询结算单信息
	 * 
	 * @return
	 */
	public String query() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 补开结算单时、获取未开运量的信息
	 * 
	 * @return
	 */
	public String queryDepartinvoices() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.queryResult(
					isdepartinvoices, scheduleplanid, departinvoicesid,
					vehiclereportid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 补开时，获取打印的信息
	 * 
	 * @return
	 */
	public String printDepartinvoies() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			DepartinvoiceService invoicesService = new DepartinvoiceServiceImpl();
			departinvoicesMap = invoicesService.printDepartinvoices(global
					, scheduleplanid, vehiclereportid, ip, departinvoicesno);
			markSuccess();
			setMsg("补开成功！");
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
			departinvoicesMap= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});;			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg(e.getMessage());
			departinvoicesMap= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});;			
		}
		return "json";
	}
	private Date departdateend;
	private Long printorgid;
	
	public Date getDepartdateend() {
		return departdateend;
	}

	public void setDepartdateend(Date departdateend) {
		this.departdateend = departdateend;
	}

	public Long getPrintorgid() {
		return printorgid;
	}

	public void setPrintorgid(Long printorgid) {
		this.printorgid = printorgid;
	}
	public String qryReportSchs() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.qryReportSchs(departdate,
					vehicleid, printorgid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryDepartinvoicesByorg() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.qryDepartinvoices(departdate,
					vehicleid, printorgid,departdateend));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryNonomalSch() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.qryNonomalSch(departstationid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryNonomalSchadd() {
		Global global = CurrentUtil.getGlobal();
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.qryNonomalSchadd(global));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryTicketsellsByVehicle() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.qryTicketsellsByVehicle(departdate,
					vehiclereportid, scheduleplanid,departinvoicesno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 注销结算单
	 * 
	 * @return
	 */
	public String cancel() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (departinvoices != null) {
				Departinvoices invoices = null;
				if (departinvoices.getId() > 0) {
					invoices = departinvoicesManagerService
							.getById(departinvoices.getId());
					invoices.setCancel(departinvoices.getCancel());
					invoices.getCancel().setId(
							departinvoices.getCancel().getId());
					invoices.setCancelstation(departinvoices.getCancelstation());
					invoices.getCancelstation().setId(
							departinvoices.getCancelstation().getId());
					invoices.setCanceltime(new Date());
					invoices.setStatus("1");
					invoices.setUpdateby(departinvoices.getCancel().getId());
					invoices.setUpdatetime(new Date());
					//将此结算单关联的违规罚金表中的结算单ID更新为空
					departinvoicesManagerService.updateVehicleviolation(departinvoices.getId());
					//一个班次多张结算单全部注销才能再次售票	
					List<Departinvoices> departList = departinvoicesManagerService.queryDepartInvoicesBySchedulePlanId(departinvoices.getScheduleplanid());
					if(departList!=null && departList.size()==1){
						if(invoices.getScheduleplanid() >0 ){
							List<Schedulestatus> list = new SchedulestatusServiceImpl().getSchedulestatus(invoices.getScheduleplanid());
							if(list != null){
								Schedulestatus ss = list.get(0);
								ss.setIsdeparted(false);
								new  SchedulestatusDao().getEntityManager().merge(ss); 
							}							
						}
					}
					
				} else {
					setMsg("请选择一条记录！");
					markFail();
					return "json";
				}
				departinvoicesManagerService.cancel(invoices,global);
				setMsg("注销成功！");
				markSuccess();
				
			}
		} catch (ServiceException ex) {
			markFail();
			setMsg(ex.getMessage());
		} catch (Exception e) {
			markFail();
			play.Logger.error(e.getMessage(), e);
			setMsg("注销异常：" + e.getMessage());
		}
		return "json";
	}

	public String recover() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (departinvoices != null) {
				Departinvoices invoices = null;
				if (departinvoices.getId() > 0) {
					invoices = departinvoicesManagerService
							.getById(departinvoices.getId());
					invoices.setUpdateby(global.getUserinfo().getId());
					invoices.setUpdatetime(new Date());
					invoices.setStatus("0");
					invoices.setCancel(null);
					invoices.setCancelstation(null);
					invoices.setCanceltime(null);
					setMsg("恢复成功！");
					markSuccess();
				} else {
					setMsg("请选择一条记录！");
					markSuccess();
					return "json";
				}
				if (!departinvoicesManagerService.save(invoices)) {
					setMsg("恢复失败！");
					markSuccess();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("恢复异常：" + e.getMessage());
		}
		return "json";
	}

	/**
	 * 补开结算单时，判断是否已经结算
	 * 
	 * @return
	 */
	public String isdepart() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		if (departinvoices != null) {
			try {
				departinvoicesManagerService.isDepartinvoices(departinvoices
						.getScheduleplanid());
				markSuccess();
			} catch (ServiceException ex) {
				setMsg(ex.getMessage());
				markFail();
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				setMsg(e.getMessage());
				markFail();
			}
		}
		return "json";
	}

	/**
	 * 换车重打功能
	 * 
	 * @return
	 */
	public String chanageDepartinvoices() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				iscomputeno=true;
				departinvoicesMap = departinvoicesManagerService.chanageDepartinvoices(global,
						 scheduleplanid, vehiclereportid,
						newvehicleid, ip, departinvoicesno, iscomputeno);
				markSuccess();
				setMsg("换车成功！");
			}
		} catch (ServiceException se) {
			markFail();
			setMsg(se.getMessage());
			departinvoicesMap= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});			
		} catch (Exception e) {
			markFail();
			setMsg("换车失败！");
			play.Logger.error(e.getMessage(), e);
			departinvoicesMap= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});				
		}
		return "json";

	}
	
	private String ticketno;
	
	private String schedulecode;
	
	private String departtime;
	public String getTicketno() {
		return ticketno;
	}

	public void setTicketno(String ticketno) {
		this.ticketno = ticketno;
	}
	public String getSchedulecode() {
		return schedulecode;
	}

	public void setSchedulecode(String schedulecode) {
		this.schedulecode = schedulecode;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	/**
	 * 查询车号未开的车票信息
	 * 用于补开结算单
	 * @return
	 */
	public String qryunchecktickets() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		try {
			setDepartinvoicesMap(departinvoicesManagerService.qryunchecktickets(departdate,vehicleid,batchno,ticketno,schedulecode,departtime));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	
	/**
	 * 补开稽查结算单
	 * 
	 * @return
	 */
	public String printjcDepartinvoies() {
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			departinvoicesMap = departinvoicesManagerService.printDepartinvoices(global
					, scheduleplanid, vehiclereportid, ticketids, departinvoicesno);
			markSuccess();
			setMsg("补开成功！");
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
			departinvoicesMap= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});;			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			markFail();
			setMsg(e.getMessage());
			departinvoicesMap= ListUtil.listToMap( new Object[]{DepartinvoicesVo.class},null, new Object[]{DepartinvoicesVo.class});;			
		}
		return "json";
	}
	
//	qryvehisecuresult
	
	public String qryvehisecuresult(){
		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
		
		try {
			String result = departinvoicesManagerService.qryvehisecuresult(vehiclereportid);
			setMsg(result);
			markSuccess();
		} catch (Exception e) {
			setMsg(null);
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 根据车辆id,查询车辆的报到记录
	 * @return
	 */
	public String qryVehicleReport() {
		try {
			departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
			setVehicleReportMap(departinvoicesManagerService.qryVehicleReport(vehicleid,departdate,scheduleplanid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public Departinvoices getDepartinvoices() {
		return departinvoices;
	}

	public void setDepartinvoices(Departinvoices departinvoices) {
		this.departinvoices = departinvoices;
	}

	public List<Map<String, Object>> getDepartinvoicesMap() {
		return departinvoicesMap;
	}

	public void setDepartinvoicesMap(List<Map<String, Object>> departinvoicesMap) {
		this.departinvoicesMap = departinvoicesMap;
	}

	public String getDepartinvoicesno() {
		return departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}

	public Long getDepartstationid() {
		return departstationid;
	}

	public void setDepartstationid(Long departstationid) {
		this.departstationid = departstationid;
	}

	public Long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(Long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public Long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(Long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public Long getDepartinvoicesid() {
		return departinvoicesid;
	}

	public void setDepartinvoicesid(Long departinvoicesid) {
		this.departinvoicesid = departinvoicesid;
	}

	public String getIsdepartinvoices() {
		return isdepartinvoices;
	}

	public void setIsdepartinvoices(String isdepartinvoices) {
		this.isdepartinvoices = isdepartinvoices;
	}

	public DepartinvoicesVo getDnv() {
		return dnv;
	}

	public void setDnv(DepartinvoicesVo dnv) {
		this.dnv = dnv;
	}

	public Long getNewvehicleid() {
		return newvehicleid;
	}

	public void setNewvehicleid(Long newvehicleid) {
		this.newvehicleid = newvehicleid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(Long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public boolean isIscomputeno() {
		return iscomputeno;
	}

	public void setIscomputeno(boolean iscomputeno) {
		this.iscomputeno = iscomputeno;
	}
	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public String getTicketids() {
		return ticketids;
	}

	public void setTicketids(String ticketids) {
		this.ticketids = ticketids;
	}

	public String getBatchno() {
		return batchno;
	}

	public void setBatchno(String batchno) {
		this.batchno = batchno;
	}

	public List<Map<String, Object>> getVehicleReportMap() {
		return vehicleReportMap;
	}

	public void setVehicleReportMap(List<Map<String, Object>> vehicleReportMap) {
		this.vehicleReportMap = vehicleReportMap;
	}

}
