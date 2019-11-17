/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.bill.action<br/>
 * <b>文件名：</b>BillinventoryAction.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.bill.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.service.BillinventoryService;
import cn.nova.bus.bill.service.BilllogService;
import cn.nova.bus.bill.service.impl.BillinventoryServiceImpl;
import cn.nova.bus.bill.service.impl.BilllogServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 入库s
 * 
 * @author 蒋伟
 * @version 4.0
 */
/**
 * <b>类描述：</b> <b>类名称：BillinventoryAction</b><br/>
 * <b>创建人：<a href="mailto:lijinhui@nova.net.cn">李金辉</a></b><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class BillinventoryAction extends BaseAction{
	private List<Map<String, Object>> billinventorymap;
	private List<Map<String, Object>> billlogmap;

	public List<Map<String, Object>> getBilllogmap() {
		return billlogmap;
	}

	public void setBilllogmap(List<Map<String, Object>> billlogmap) {
		this.billlogmap = billlogmap;
	}

	public HttpServletRequest httpServletRequest;

	private BillinventoryService billinventoryService;
	private Billinventory billinventory;

	private Long outstartno;
	private Long outendno;
	private Long id;

	public String save() {
		billinventoryService = new BillinventoryServiceImpl();
		Global global = CurrentUtil.getGlobal();

		try {
			if (billinventory != null) {
				if (billinventory.getId() > 0) {
					// 出库
					billinventory = billinventoryService.findById(billinventory
							.getId());
					if (outstartno != null && outstartno >= 0) {
						billinventory.setUpdateby(global.getUserinfo().getId());
						billinventory.setUpdatetime(new Timestamp(System
								.currentTimeMillis()));
						if (billinventory.getAvailablestartno() == outstartno
								&& billinventory.getAvailableenno() > outendno) {
							billinventory.setAvailablestartno(outendno + 1);
						} else if (billinventory.getAvailablestartno() == outstartno
								&& billinventory.getAvailableenno() == outendno) {
							billinventory.setAvailablestartno(0);
							billinventory.setAvailableenno(0);
						} else if (billinventory.getAvailablestartno() < outstartno
								&& billinventory.getAvailableenno() == outendno) {
							billinventory.setAvailableenno(outstartno - 1);
						} else if (billinventory.getAvailablestartno() < outstartno
								&& billinventory.getAvailableenno() > outendno) {
							Billinventory newbillinventory = new Billinventory();
							newbillinventory.setAdder(global.getUserinfo()
									.getId());
							newbillinventory.setCreateby(global.getUserinfo()
									.getId());
							newbillinventory.setCreatetime(new Timestamp(System
									.currentTimeMillis()));
							newbillinventory.setUpdateby(global.getUserinfo()
									.getId());
							newbillinventory.setUpdatetime(new Timestamp(System
									.currentTimeMillis()));
							newbillinventory.setAvailablestartno(outendno + 1);
							newbillinventory.setAvailableenno(billinventory
									.getAvailableenno());
							newbillinventory.setPutinstartno(outendno + 1);
							newbillinventory.setPutinendno(billinventory
									.getPutinendno());
							newbillinventory.setBilltypeid(billinventory
									.getBilltypeid());
							newbillinventory.setStorageid(billinventory
									.getStorageid());
							newbillinventory.setBatchno(billinventory
									.getBatchno());
							newbillinventory.setPutintype("0");
							newbillinventory.setIsactive(true);
							newbillinventory.setOrgid(global.getOrganization()
									.getId());
							billinventory.setPutinendno(outendno);
							billinventory.setAvailableenno(outstartno - 1);
							billinventory
									.setAdder(global.getUserinfo().getId());
							if (!billinventoryService.save(billinventory,
									newbillinventory)) {
								msg = "操作失败！";
								markFail();
							}
						}
					}
					msg = "出库成功！";
					markSuccess();
				} else {
					// 入库
					billinventory.setAdder(global.getUserinfo().getId());
					billinventory.setAvailablestartno(billinventory
							.getPutinstartno());
					billinventory.setAvailableenno(billinventory
							.getPutinendno());
					billinventory.setPutintype("0");
					billinventory.setIsactive(true);
					//billinventory.setOrgid(global.getOrganization().getId());
					billinventory.setCreateby(global.getUserinfo().getId());
					billinventory.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					billinventory.setUpdateby(global.getUserinfo().getId());
					billinventory.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					msg = "入库成功！";
					markSuccess();
				}
				billinventory = billinventoryService.save(billinventory,
						outstartno, outendno);
				setId(billinventory.getId());
			}
		} catch (ServiceException e) {
			markFail();
			setMsg(e.getMessage());
		}
		return "json";

	}

	public Long getOutstartno() {
		return outstartno;
	}

	public void setOutstartno(Long outstartno) {
		this.outstartno = outstartno;
	}

	public Long getOutendno() {
		return outendno;
	}

	public void setOutendno(Long outendno) {
		this.outendno = outendno;
	}

	public String list() {
		try {
			billinventoryService = new BillinventoryServiceImpl();
			setBillinventorymap(billinventoryService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String listbilllog() {
		try {
			billinventoryService = new BillinventoryServiceImpl();
			BilllogService billlogService = new BilllogServiceImpl();
			setBilllogmap(billlogService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getBillinventorymap() {
		return billinventorymap;
	}

	public void setBillinventorymap(List<Map<String, Object>> billinventorymap) {
		this.billinventorymap = billinventorymap;
	}

	public Billinventory getBillinventory() {
		return billinventory;
	}

	public void setBillinventory(Billinventory billinventory) {
		this.billinventory = billinventory;
	}

	public String delete() {
		billinventoryService = new BillinventoryServiceImpl();
		if (billinventory.getId() > 0) {
			boolean result = false;
			try {
				result = billinventoryService.delete(billinventory.getId());
			} catch (ServiceException ex){
				setMsg(ex.getMessage());
				markFail();
				return "json";
			} 
			if (result) {
				msg = "删除成功！";
				markSuccess();
			} else {
				msg = "删除失败！";
				markFail();
			}
		}
		return "json";
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
