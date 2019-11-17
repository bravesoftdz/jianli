package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;
import javax.servlet.http.HttpServletRequest;

import util.CurrentUtil;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.service.TickettypeService;
import cn.nova.bus.base.service.impl.TickettypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * @author lanckun
 * 
 */
public class TickettypeAction extends BaseAction{
	private List<Map<String, Object>> tickettypemap;
	public HttpServletRequest httpServletRequest;
	private String seatpic;

	private long userid;
	private long roleid;
	private Long tickettypeid;
	private long ticketoutletsid;
//	private List<Tickettype> tickettypes;

	private TickettypeService tickettypeService;
	private Tickettype tickettype;

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			tickettypeService = new TickettypeServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				// tickettype.setSoldpicture(seatpic.getBytes());
				byte[] bb = ConversionUtil.toByteArr(seatpic);
				tickettype.setSoldpicture(bb);

				// tickettype.setSoldpicture(ConversionUtil.toByteArr(seatpic));
				if (tickettype != null) {
					if (tickettype.getId() != 0) {
						tickettype.setUpdateby(global.getUserinfo().getId());
						tickettype.setUpdatetime(new Date());

					} else {
						tickettype.setCreateby(global.getUserinfo().getId());
						tickettype.setCreatetime(new Date());
						tickettype.setUpdateby(global.getUserinfo().getId());
						tickettype.setUpdatetime(new Date());
					}
					if (tickettype.getId() > 0) {
						msg = "修改成功！";
						markSuccess();
					} else {
						msg = "添加成功！";
						markSuccess();
					}
					tickettype = tickettypeService.save(tickettype);
					tickettypeid = tickettype.getId();
				}
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			if ("0059".equals(se.getExceptionCode())) {
				markFail();
			} else {
				markError();
			}
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			msg = "操作失败！";
			markFail();
		}
		return "json";

	}

	public String query() {
		try {
			tickettypeService = new TickettypeServiceImpl();
			setTickettypemap(tickettypeService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}

	public String prior() {
		tickettypeService = new TickettypeServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				boolean result = tickettypeService.prior(tickettype);
				if (result) {
					msg = "操作成功！";
					markSuccess();
				} else {
					msg = "操作失败！";
					markFail();
				}
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception ex) {
			msg = "操作失败！";
			markFail();
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	public String next() {
		tickettypeService = new TickettypeServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				boolean result = tickettypeService.next(tickettype);
				if (result) {
					msg = "操作成功！";
					markSuccess();
				} else {
					msg = "操作失败！";
					markFail();
				}
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception ex) {
			msg = "操作失败！";
			markFail();
			play.Logger.error(ex.getMessage(), ex);
		}
		return "json";
	}
	public String delete() {
		if (tickettype.getId() > 0) {
			tickettypeService = new TickettypeServiceImpl();
			boolean result = tickettypeService.delete(tickettype.getId());
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
	public String findTickettypeByPermission(){
		tickettypeService = new TickettypeServiceImpl();
		List<Tickettype> tickettypes = tickettypeService.findByPermission(userid,ticketoutletsid);
		if(tickettypes!=null&&tickettypes.size()>0){
			List<Object> objects = new ArrayList<Object>();
			objects.addAll(tickettypes);
			setTickettypemap(ListUtil.listToMap(new Object[] { Tickettype.class},objects,new Object[] {Tickettype.class}));
		}
		else{
			setTickettypemap(ListUtil.listToMap(new Object[] { Tickettype.class},null));
		}
//		setTickettypes(tickettypeService.findByPermission(userid,ticketoutletsid));
		return "json";
	}

	public String findTickettype(){
		tickettypeService = new TickettypeServiceImpl();
		setTickettypemap(tickettypeService.find(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	public Long getTickettypeid() {
		return tickettypeid;
	}

	public void setTickettypeid(Long tickettypeid) {
		this.tickettypeid = tickettypeid;
	}

	public List<Map<String, Object>> getTickettypemap() {
		return tickettypemap;
	}

	public void setTickettypemap(List<Map<String, Object>> tickettypemap) {
		this.tickettypemap = tickettypemap;
	}

	@Transient
	public Tickettype getTickettype() {
		return tickettype;
	}

	public void setTickettype(Tickettype tickettype) {
		this.tickettype = tickettype;
	}

	public String getSeatpic() {
		return seatpic;
	}

	public void setSeatpic(String seatpic) {
		this.seatpic = seatpic;
	}

	public void setUserid(long userid) {
		this.userid = userid;
	}

	public long getUserid() {
		return userid;
	}

	public void setTicketoutletsid(long ticketoutletsid) {
		this.ticketoutletsid = ticketoutletsid;
	}

	public long getTicketoutletsid() {
		return ticketoutletsid;
	}

	public void setRoleid(long roleid) {
		this.roleid = roleid;
	}

	public long getRoleid() {
		return roleid;
	}

//	public void setTickettypes(List<Tickettype> tickettypes) {
//		this.tickettypes = tickettypes;
//	}
//
//	public List<Tickettype> getTickettypes() {
//		return tickettypes;
//	}
}
