package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.service.BilldamagedService;
import cn.nova.bus.sale.service.impl.BilldamagedServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class BilldamagedAction extends BaseAction{
	private Billdamaged billdamaged;
	private List<Map<String, Object>> billdamagedmap;
	private Long recipients;

	private BilldamagedService billdamagedService;

	/**
	 * 坏票登记查询
	 * @return
	 */
	public String query() {
		try {
			billdamagedService = new BilldamagedServiceImpl();
			setBilldamagedmap(billdamagedService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 坏票登记
	 * @return
	 */
	public String save() {
		billdamagedService = new BilldamagedServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (billdamaged != null) {
				if (billdamaged.getId() > 0) {
					markSuccess();
					setMsg("修改成功");
					billdamaged.setUpdateby(global.getUserinfo().getId());
					billdamaged.setUpdatetime(new Date());
				} else {
					billdamaged.setCreateby(global.getUserinfo().getId());
					billdamaged.setCreatetime(new Date());
					billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
					billdamaged.setUpdateby(global.getUserinfo().getId());
					billdamaged.setUpdatetime(new Date());
					billdamaged.setRecordby(global.getUserinfo().getId());
					billdamaged.setRecordip(global.getIpAddress());
					billdamaged.setRecordtime(new Date());
					markSuccess();
					setMsg("登记成功");
				}
				if (!billdamagedService.save(billdamaged, recipients)) {
					setMsg("保存操作失败！");
					markSuccess();
				}
			}
		} catch (ServiceException e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
			markSuccess();
		} catch (Exception ex){
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	
	/**
	 * 单张坏票登记
	 * @return
	 */
	public String saveOnedamaged() {
		billdamagedService = new BilldamagedServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		try {
			if (billdamaged != null) {
				if (billdamaged.getId() > 0) {
					markSuccess();
					setMsg("修改成功");
					billdamaged.setUpdateby(global.getUserinfo().getId());
					billdamaged.setUpdatetime(now);
				} else {
					billdamaged.setCreateby(global.getUserinfo().getId());
					billdamaged.setCreatetime(now);
					billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
					billdamaged.setUpdateby(global.getUserinfo().getId());
					billdamaged.setUpdatetime(now);
					billdamaged.setRecordby(global.getUserinfo().getId());
					billdamaged.setRecordip(global.getIpAddress());
					billdamaged.setRecordtime(now);
					markSuccess();
					setMsg("登记成功");
				}
				MethodResult result = billdamagedService.saveOnedamaged(billdamaged, recipients);
				if (result.getResult()==0) {
					setMsg(result.getResultMsg());
					markFail();
				}
			}
		} catch (Exception ex){
			setMsg(ex.getMessage());
			markFail();
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public List<Map<String, Object>> getBilldamagedmap() {
		return billdamagedmap;
	}

	public void setBilldamagedmap(List<Map<String, Object>> billdamagedmap) {
		this.billdamagedmap = billdamagedmap;
	}

	public Billdamaged getBilldamaged() {
		return billdamaged;
	}

	public void setBilldamaged(Billdamaged billdamaged) {
		this.billdamaged = billdamaged;
	}

	public Long getRecipients() {
		return recipients;
	}

	public void setRecipients(Long recipients) {
		this.recipients = recipients;
	}

}
