package cn.nova.bus.checkticket.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.service.DepartinvoicesotherService;
import cn.nova.bus.checkticket.service.DepartinvoicesotherdetailService;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesotherServiceImpl;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesotherdetailServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;
import util.CurrentUtil;

public class DepartinvoicesotherdetailAction extends BaseAction{
	private Departinvoicesotherdetail departinvoicesotherdetail;
	private List<Map<String, Object>> otherdetailMap;
	private Long id;
	private Long otherid;
	
	private DepartinvoicesotherdetailService otherdetailService;
	
	public String query() {
		otherdetailService = new DepartinvoicesotherdetailServiceImpl();
		try {
			setOtherdetailMap(otherdetailService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		otherdetailService = new DepartinvoicesotherdetailServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (departinvoicesotherdetail != null) {
				if (departinvoicesotherdetail.getId() > 0) {
					if (departinvoicesotherdetail.getSchedule().getId() == 0) {
						departinvoicesotherdetail.setSchedule(null);
					}
					departinvoicesotherdetail.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesotherdetail.setUpdatetime(new Date());
					setMsg("修改成功！");
				} else {

					departinvoicesotherdetail.setCreateby(global.getUserinfo()
							.getId());
					departinvoicesotherdetail.setCreatetime(new Date());
					departinvoicesotherdetail.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesotherdetail.setUpdatetime(new Date());
					setMsg("添加成功！");
				}
				id=otherdetailService.save(departinvoicesotherdetail);
				markSuccess();
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("操作失败：" + e.getMessage());
			markFail();
		}
		return "json";
	}

	public String delete() {
		otherdetailService = new DepartinvoicesotherdetailServiceImpl();
		try {
			if (departinvoicesotherdetail != null) {
				if (departinvoicesotherdetail.getId() > 0) {
					setMsg("删除成功！");
					markSuccess();
					if (!otherdetailService.delete(departinvoicesotherdetail
							.getId())) {
						setMsg("删除操作失败！");
						markSuccess();
					}
				} else {
					setMsg("没有得该数据，删除失败！");
					markFail();
				}
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常：" + e.getMessage());
		}
		return "json";
	}
	/**
	 * @Title delete
	 * @Description 删除结算单补录(票号) 明细数据
	 * @return 
	 * String 
	 * @author tianhb
	 * @date 2016年6月28日-下午9:04:55
	 * @update 
	 * @throws
	 */
	public String ticketnoDelete() {
		otherdetailService = new DepartinvoicesotherdetailServiceImpl();
		try {
			if (departinvoicesotherdetail != null) {
				if (departinvoicesotherdetail.getId() > 0) {
					setMsg("删除成功！");
					markSuccess();
					Long departinvoicesotherdetailId = departinvoicesotherdetail.getId();
					Long departinvoicesotherId = departinvoicesotherdetail.getDepartinvoicesotherid();
					Integer n = otherdetailService.ticketnoDelete(departinvoicesotherdetailId,departinvoicesotherId);
					if (n==0) {
						setMsg("删除操作失败！");
						markSuccess();
					}else{
						setFlag((long)n);
					}
				} else {
					setMsg("没有得该数据，删除失败！");
					markFail();
				}
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常：" + e.getMessage());
		}
		return "json";
	}
	
	public String queryByotherticketno() {
		otherdetailService = new DepartinvoicesotherdetailServiceImpl();
		try {
			setOtherdetailMap(otherdetailService
					.queryByotherticketno(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public Departinvoicesotherdetail getDepartinvoicesotherdetail() {
		return departinvoicesotherdetail;
	}

	public void setDepartinvoicesotherdetail(
			Departinvoicesotherdetail departinvoicesotherdetail) {
		this.departinvoicesotherdetail = departinvoicesotherdetail;
	}

	public List<Map<String, Object>> getOtherdetailMap() {
		return otherdetailMap;
	}

	public void setOtherdetailMap(List<Map<String, Object>> otherdetailMap) {
		this.otherdetailMap = otherdetailMap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getOtherid() {
		return otherid;
	}

	public void setOtherid(Long otherid) {
		this.otherid = otherid;
	}

}
