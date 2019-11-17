package cn.nova.bus.checkticket.action;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.checkticket.dao.DepartinvoicesManagerDao;
import cn.nova.bus.checkticket.model.Departinvoices;
import cn.nova.bus.checkticket.model.Departinvoicesdeductdetail;
import cn.nova.bus.checkticket.model.Departinvoicesdetail;
import cn.nova.bus.checkticket.service.DepartinvoiceService;
import cn.nova.bus.checkticket.service.DepartinvoicesManagerService;
import cn.nova.bus.checkticket.service.DepartinvoicesdetailService;
import cn.nova.bus.checkticket.service.PackDepartinvoicesService;
import cn.nova.bus.checkticket.service.impl.DepartinvoiceServiceImpl;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesManagerServiceImpl;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesdetailServiceImpl;
import cn.nova.bus.checkticket.service.impl.PackDepartinvoicesServiceImpl;
import cn.nova.bus.checkticket.vo.DepartinvoicesVo;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackDepartinvoiceManagerAction extends BaseAction {

	private List<Map<String, Object>> departinvoicesMap;
	private List<Map<String, Object>> departDetailMap;
	private List<Map<String, Object>> packdepartNumMap;
	private Packdepartinvoices departinvoices;
	
	private PackDepartinvoicesService packdepartinvoicesService;

	private Date departdate;
	private long scheduleplanid;
    private long scheduleid;
	
	/**
	 * 查询结算单信息
	 * 
	 * @return
	 */
	public String query() {
		packdepartinvoicesService = new PackDepartinvoicesServiceImpl();
		try {
			setDepartinvoicesMap(packdepartinvoicesService
					.query(ServletPropertyFilterUtil.buildFromHttpRequest()));
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
//	public String queryDepartinvoices() {
//		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
//		try {
//			setDepartinvoicesMap(departinvoicesManagerService.queryResult(
//					isdepartinvoices, scheduleplanid, departinvoicesid,
//					vehiclereportid));
//		} catch (Exception e) {
//			play.Logger.error(e.getMessage(), e);
//		}
//		return "json";
//	}

	/**
	 * 补开时，获取打印的信息
	 * 
	 * @return
	 */
//	public String printDepartinvoies() {
//		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
//		Global global = CurrentUtil.getGlobal();
//		try {
//			DepartinvoiceService invoicesService = new DepartinvoiceServiceImpl();
//			departinvoicesMap = invoicesService.printDepartinvoices(global,
//					scheduleplanid, vehiclereportid, ip, departinvoicesno);
//			markSuccess();
//			setMsg("补开成功！");
//		} catch (ServiceException e) {
//			markFail();
//			setMsg(e.getMessage());
//			departinvoicesMap = ListUtil.listToMap(
//					new Object[] { DepartinvoicesVo.class }, null,
//					new Object[] { DepartinvoicesVo.class });
//			;
//		} catch (Exception e) {
//			play.Logger.error(e.getMessage(), e);
//			markFail();
//			setMsg(e.getMessage());
//			departinvoicesMap = ListUtil.listToMap(
//					new Object[] { DepartinvoicesVo.class }, null,
//					new Object[] { DepartinvoicesVo.class });
//			;
//		}
//		return "json";
//	}

	/**
	 * 注销行包结算单
	 * 
	 * @return
	 */
	public String cancel() {
		packdepartinvoicesService = new PackDepartinvoicesServiceImpl();
		try {
			if (departinvoices != null) {
				Packdepartinvoices invoices = null;
				if (departinvoices.getId() > 0) {
					invoices = packdepartinvoicesService
							.getById(departinvoices.getId());
					invoices.setCancelby(departinvoices.getCancelby());					
					invoices.setCancelstationid(departinvoices.getCancelstationid());
					invoices.setCanceltime(new Date());
					invoices.setStatus("1");
					invoices.setUpdateby(departinvoices.getCancelby());
					invoices.setUpdatetime(new Date());
				} else {
					setMsg("请选择一条记录！");
					markFail();
					return "json";
				}
				packdepartinvoicesService.cancel(invoices);
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

	/**
	 * 补开结算单时，判断是否已经结算
	 * 
	 * @return
	 */
//	public String isdepart() {
//		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
//		if (departinvoices != null) {
//			try {
//				departinvoicesManagerService.isDepartinvoices(departinvoices
//						.getScheduleplanid());
//				markSuccess();
//			} catch (ServiceException ex) {
//				setMsg(ex.getMessage());
//				markFail();
//			} catch (Exception e) {
//				play.Logger.error(e.getMessage(), e);
//				setMsg(e.getMessage());
//				markFail();
//			}
//		}
//		return "json";
//	}

	

	/**
	 * 查询车号未开的车票信息 用于补开结算单
	 * 
	 * @return
	 */
//	public String qryunchecktickets() {
//		departinvoicesManagerService = new DepartinvoicesManagerServiceImpl();
//		try {
//			List<PropertyFilter> propertyList = ServletPropertyFilterUtil
//					.buildFromHttpRequest();
//			setDepartinvoicesMap(departinvoicesManagerService
//					.qryunchecktickets(propertyList));
//		} catch (Exception e) {
//			play.Logger.error(e.getMessage(), e);
//		}
//		return "json";
//	}

	public String FindPackDepNum() {
		try {
			packdepartinvoicesService = new PackDepartinvoicesServiceImpl();			
			setPackdepartNumMap(packdepartinvoicesService
					.FindPackDepNum(departdate,scheduleplanid,scheduleid));
		} catch (Exception e) {
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	

	/**
	 * 结算单明细
	 * 
	 * @return
	 */
	public String qryPackDepartDetail() {
		try {
			packdepartinvoicesService = new PackDepartinvoicesServiceImpl();
			List<PropertyFilter> propertyList = ServletPropertyFilterUtil
					.buildFromHttpRequest();
			setDepartDetailMap(packdepartinvoicesService
					.qryDepartDetail(propertyList));
		} catch (Exception e) {
			e.printStackTrace();
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	
	public List<Map<String, Object>> getDepartinvoicesMap() {
		return departinvoicesMap;
	}

	public void setDepartinvoicesMap(List<Map<String, Object>> departinvoicesMap) {
		this.departinvoicesMap = departinvoicesMap;
	}
	

	public List<Map<String, Object>> getDepartDetailMap() {
		return departDetailMap;
	}

	public void setDepartDetailMap(List<Map<String, Object>> departDetailMap) {
		this.departDetailMap = departDetailMap;
	}

	public Packdepartinvoices getDepartinvoices() {
		return departinvoices;
	}

	public void setDepartinvoices(Packdepartinvoices departinvoices) {
		this.departinvoices = departinvoices;
	}

	public List<Map<String, Object>> getPackdepartNumMap() {
		return packdepartNumMap;
	}

	public void setPackdepartNumMap(List<Map<String, Object>> packdepartNumMap) {
		this.packdepartNumMap = packdepartNumMap;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}
	

}
