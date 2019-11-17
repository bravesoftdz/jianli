package cn.nova.bus.balance.action;

import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import play.data.binding.As;

import util.CurrentUtil;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.balance.model.Ticketturnoverdifadjust;
import cn.nova.bus.balance.service.TicketturnoverdifadjustService;
import cn.nova.bus.balance.service.impl.ComplexfeeServiceImpl;
import cn.nova.bus.balance.service.impl.TicketturnoverdifadjustServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;
/**
 * <b>类描述：差错调整</b><br/>
 * <b>类名称：</b>TicketturnoverdifadjustAction.java<br/>
 * <b>创建人：</b>lck</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class TicketturnoverdifadjustAction extends BaseAction {
	private Long id;
	private List<Map<String, Object>> datamap;

	private Ticketturnoverdifadjust tdifadjusts;

	private Date createtime;


	private TicketturnoverdifadjustService ticketturnoverdifadjustService;

	public String query() {
		ticketturnoverdifadjustService = new TicketturnoverdifadjustServiceImpl();
		datamap = ticketturnoverdifadjustService
				.query((ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String save() {
		ticketturnoverdifadjustService = new TicketturnoverdifadjustServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		if (tdifadjusts != null) {
			if (tdifadjusts.getId() > 0) {
				msg = "修改成功！";
				tdifadjusts.setCreatetime(createtime);
				tdifadjusts.setUpdateby(global.getUserinfo().getId());
				tdifadjusts.setUpdatetime(now);
			} else {
				msg = "添加成功！";
				tdifadjusts.setCreateby(global.getUserinfo().getId());
				tdifadjusts.setUpdateby(global.getUserinfo().getId());
				tdifadjusts.setUpdatetime(now);
				tdifadjusts.setCreatetime(now);
			}
			tdifadjusts = ticketturnoverdifadjustService.save(tdifadjusts);
			if (tdifadjusts != null) {
				setId(tdifadjusts.getId());
				markSuccess();
			} else {
				markFail();
				msg = "操作失败！";
			}
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		ticketturnoverdifadjustService = new TicketturnoverdifadjustServiceImpl();
		if (ticketturnoverdifadjustService.delete(tdifadjusts,global)) {
			msg = "删除成功！";
			markSuccess();
		} else {
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public List<Map<String, Object>> getDatamap() {
		return datamap;
	}

	public void setDatamap(List<Map<String, Object>> datamap) {
		this.datamap = datamap;
	}

	public Ticketturnoverdifadjust getTdifadjusts() {
		return tdifadjusts;
	}
	

	public void setTdifadjusts(Ticketturnoverdifadjust tdifadjusts) {
		this.tdifadjusts = tdifadjusts;
	}
	
	public Date getCreatetime() {
		return createtime;
	}
	@As("yyyy-MM-dd HH:mm:ss")
	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}
}
