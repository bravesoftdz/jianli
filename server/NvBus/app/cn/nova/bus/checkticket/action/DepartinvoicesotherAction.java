package cn.nova.bus.checkticket.action;

import cn.nova.bus.action.BaseAction;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.checkticket.model.Departinvoicesother;
import cn.nova.bus.checkticket.model.Departinvoicesotherdetail;
import cn.nova.bus.checkticket.service.DepartinvoicesotherService;
import cn.nova.bus.checkticket.service.impl.DepartinvoicesotherServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class DepartinvoicesotherAction extends BaseAction{
	private Departinvoicesother departinvoicesother;
	private List<Map<String, Object>> invoicesMap;
	private List<Map<String, Object>> sumMap;
	private Long id;
	private Long orgid;
	private Long createby;
	private Date createtime;
	private Date departdate;
	private String param;
	private Long routeid;
	
	private String departinvoiceotherid;//待审批的手工单ID
	private String departinvoiceotherid_cancel;//取消审核的ID
	private String departinvoiceotherid_del;
	private String departinvoiceno;
	
	private String ticketsellids ;
	
	public String getDepartinvoiceotherid_del() {
		return departinvoiceotherid_del;
	}

	public void setDepartinvoiceotherid_del(String departinvoiceotherid_del) {
		this.departinvoiceotherid_del = departinvoiceotherid_del;
	}

	public String getDepartinvoiceotherid_cancel() {
		return departinvoiceotherid_cancel;
	}

	public void setDepartinvoiceotherid_cancel(String departinvoiceotherid_cancel) {
		this.departinvoiceotherid_cancel = departinvoiceotherid_cancel;
	}

	public String getDepartinvoiceotherid() {
		return departinvoiceotherid;
	}

	public void setDepartinvoiceotherid(String departinvoiceotherid) {
		this.departinvoiceotherid = departinvoiceotherid;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}
	

	public List<Map<String, Object>> getSumMap() {
		return sumMap;
	}

	public void setSumMap(List<Map<String, Object>> sumMap) {
		this.sumMap = sumMap;
	}
	
	
	public String getTicketsellids() {
		return ticketsellids;
	}

	public void setTicketsellids(String ticketsellids) {
		this.ticketsellids = ticketsellids;
	}



	private DepartinvoicesotherService departinvoicesotherService;
	
	/**
	 * 查询结算补录单单号是否存在
	 * @return
	 */
	public String departinvoiceisexsit(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setInvoicesMap(departinvoicesotherService
					.departinvoiceisexsit(departinvoiceno));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//售票员手工单营收汇总表
	public String querySum() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setSumMap(departinvoicesotherService
					.querySum(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String query() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setInvoicesMap(departinvoicesotherService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//新增手工单审批功能  20150901 by liyi 
	public String audit()
	{
		boolean auditresult = false;
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try{
			auditresult = departinvoicesotherService.audit(departinvoiceotherid);
			if(auditresult)
			{
				setMsg("审核成功！");
				markSuccess();
			}
			else
			{
				markFail();
				setMsg("审核失败！");
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//取消审核功能
	public String cancelaudit()
	{
		boolean auditresult = false;
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try{
			auditresult = departinvoicesotherService.cancelaudit(departinvoiceotherid_cancel);
			if(auditresult)
			{
				setMsg("取消审核成功！");
				markSuccess();
			}
			else
			{
				markFail();
				setMsg("取消审核失败！");
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		
		
		return "json";
	}
	
public String save() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (departinvoicesother != null) {
				if (departinvoicesother.getId() > 0) {
					departinvoicesother.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesother.setUpdatetime(new Date());
					setMsg("修改成功！");
				} else {
					departinvoicesother.setCreateby(global.getUserinfo()
							.getId());
					departinvoicesother.setCreatetime(new Date());
					departinvoicesother.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesother.setUpdatetime(new Date());
					//departinvoicesother.setTotalmoney(bigdecimal);
					//departinvoicesother.setStationfee(bigdecimal);
					//departinvoicesother.setAgentfee(bigdecimal);
					departinvoicesother.setOrgid(global.getOrganization()
							.getId());
					departinvoicesother.setRecordip(global.getIpAddress());
					departinvoicesother.setStatus("0");
					//departinvoicesother.setTicketnum(0);
					setMsg("添加成功！");
				}
				departinvoicesother = departinvoicesotherService.save(departinvoicesother);
				setId(departinvoicesother.getId());
				departinvoicesother=null;
				//setOrgid(departinvoicesother.getOrgid());
				//setCreateby(departinvoicesother.getCreateby());
				//setCreatetime(departinvoicesother.getCreatetime());
				markSuccess();
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			setMsg("操作失败：" + e.getMessage());
			markFail();
		}
		return "json";
	}
	
	public String deleteall() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			if (departinvoiceotherid_del != null) {
				String[] sourceStrArray = departinvoiceotherid_del.split(",");
				for (int i = 0; i < sourceStrArray.length; i++){
					departinvoicesotherService.delete(Integer.parseInt(sourceStrArray[i]));
				}
					
						setMsg("删除成功！");
						markSuccess();
					} else {
						setMsg("删除操作失败！");
						markFail();
					}
			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常" + e.getMessage());
			markFail();
		}
		return "json";
	}
	
	public String delete() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			if (departinvoicesother != null) {
				if (departinvoicesother.getId() > 0) {
					if (departinvoicesotherService.delete(departinvoicesother
							.getId())) {
						setMsg("删除成功！");
						markSuccess();
					} else {
						setMsg("删除操作失败！");
						markFail();
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常" + e.getMessage());
			markFail();
		}
		return "json";
	}

	
	public String qrySchHelp(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setInvoicesMap(departinvoicesotherService.qrySchHelp(departdate,param));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String qryUnitHelp(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setInvoicesMap(departinvoicesotherService.qryUnitHelp(id));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//查询  结算单补录（精简）
	public String queryDepartinvoicesotherSimple(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setInvoicesMap(departinvoicesotherService.queryDepartinvoicesotherSimple(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
		
	//保存  结算单补录（精简）
	public String savedepartinvoicesotherSimple(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (departinvoicesother != null) {
				if (departinvoicesother.getId() > 0) {
					departinvoicesother.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesother.setUpdatetime(new Date());
					setMsg("修改成功！");
					markSuccess();
				} else {
					departinvoicesother.setDepartstationid(global.getOrganization().getStation().getId());//当前站点id
					departinvoicesother.setRecordip(global.getIpAddress());
					
					departinvoicesother.setOrgid(global.getOrganization()
							.getId());
					departinvoicesother.setCreateby(global.getUserinfo()
							.getId());
					departinvoicesother.setCreatetime(new Date());
					departinvoicesother.setUpdateby(global.getUserinfo()
							.getId());
					departinvoicesother.setUpdatetime(new Date());
					
					setMsg("添加成功！");
					markSuccess();
				}
				departinvoicesother = departinvoicesotherService.saveSimple(routeid, departinvoicesother);
				if (departinvoicesother.getId() == 0) {
					setMsg("保存操作失败！");
					markFail();
				}
			}
		}catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();
		} catch (Exception e) {
			setMsg("操作失败：" + e.getMessage());
			markFail();
		}
		return "json";
	}
	
	//删除  结算单补录（精简）
	public String deletedepartinvoicesotherSimple() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			if (departinvoicesother != null) {
				if (departinvoicesother.getId() > 0) {
					if (departinvoicesotherService.deletedepartinvoicesotherSimple(departinvoicesother
							.getId())) {
						setMsg("删除成功！");
						markSuccess();
					} else {
						setMsg("删除操作失败！");
						markFail();
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常" + e.getMessage());
			markFail();
		}
		return "json";
	}
	
	//查询  结算单补录(票号)
	public String queryDepartinvoicesotherTicketno(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			setInvoicesMap(departinvoicesotherService.queryDepartinvoicesotherTicketno(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//保存  结算单补录(票号)
	public String savedepartinvoicesotherTicketno(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		Global global = CurrentUtil.getGlobal();
		Date now = new Date();
		try {
			Long userId = global.getUserinfo().getId();
			if (departinvoicesother != null) {
				if(departinvoicesotherService.getById(departinvoicesother.getId())==null){
					departinvoicesother.setId(0);
				}
				if (departinvoicesother.getId() > 0) {
					departinvoicesother.setCreateby(userId);
					departinvoicesother.setCreatetime(now);
					departinvoicesother.setUpdateby(userId);
					departinvoicesother.setUpdatetime(now);
					setMsg("修改成功！");
					markSuccess();
				} else {
					departinvoicesother.setDepartstationid(global.getOrganization().getStation().getId());//当前站点id
					departinvoicesother.setRecordip(global.getIpAddress());
					departinvoicesother.setOrgid(global.getOrganization().getId());
					departinvoicesother.setCreateby(userId);
					departinvoicesother.setBalanceby(userId);
					departinvoicesother.setCreatetime(now);
					departinvoicesother.setUpdateby(global.getUserinfo().getId());
					departinvoicesother.setUpdatetime(now);
					setMsg("添加成功！");
					markSuccess();
				}
				if(ticketsellids.equals("")){
					departinvoicesotherService.deletedepartinvoicesotherSimple(departinvoicesother.getId());
				}else{
					departinvoicesother = departinvoicesotherService.saveTicketno(departinvoicesother,ticketsellids);
					if (departinvoicesother.getId() == 0) {
						setMsg("保存操作失败！");
						markFail();
					}
					setId(departinvoicesother.getId());
				}
			}
		}catch (ServiceException se) {
			if(!se.getMessage().equals("")){
				setMsg(se.getMessage());
			}
			markFail();
		} catch (Exception e) {
			play.Logger.info(e.getMessage());
			setMsg("操作失败：" + e.getMessage());
			markFail();
		}
		return "json";
	}
	//删除  结算单补录(票号)
	public String deletedepartinvoicesotherTicketno() {
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try {
			if (departinvoicesother != null) {
				Long departinvoicesid = departinvoicesother.getId();
				if (departinvoicesid > 0) {
					if (departinvoicesotherService.deletedepartinvoicesotherTicketno(departinvoicesid)) {
						setMsg("删除成功！");
						markSuccess();
					} else {
						setMsg("删除操作失败！");
						markFail();
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常" + e.getMessage());
			markFail();
		}
		return "json";
	}
	
	/**
	 * 根据售票Id和手工单明细id删除票号
	 * @return
	 */
	public Long departinvoicesotherid;
	public Long getDepartinvoicesotherid() {
		return departinvoicesotherid;
	}

	public void setDepartinvoicesotherid(Long departinvoicesotherid) {
		this.departinvoicesotherid = departinvoicesotherid;
	}

	public String deleteByticketidAndDepartinvoicesdeatilid(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		try{	
			departinvoicesotherService.deleteByticketidAndDepartinvoicesdeatilid(departinvoicesotherid);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("删除异常" + e.getMessage());
			markFail();
		}
		return "json";
	}
	private List<Map<String, Object>> ishavesell;
	public List<Map<String, Object>> getIshavesell() {
		return ishavesell;
	}

	public void setIshavesell(List<Map<String, Object>> ishavesell) {
		this.ishavesell = ishavesell;
	}

	public String checkdepartinvoicesell(){
		departinvoicesotherService = new DepartinvoicesotherServiceImpl();
		ishavesell = departinvoicesotherService.checkdepartinvoicesell(departinvoicesotherid);
		return "json";
	}
	
	public Departinvoicesother getDepartinvoicesother() {
		return departinvoicesother;
	}

	public void setDepartinvoicesother(Departinvoicesother departinvoicesother) {
		this.departinvoicesother = departinvoicesother;
	}

	public List<Map<String, Object>> getInvoicesMap() {
		return invoicesMap;
	}

	public void setInvoicesMap(List<Map<String, Object>> invoicesMap) {
		this.invoicesMap = invoicesMap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public Long getCreateby() {
		return createby;
	}

	public void setCreateby(Long createby) {
		this.createby = createby;
	}

	public Date getCreatetime() {
		return createtime;
	}

	public void setCreatetime(Date createtime) {
		this.createtime = createtime;
	}

	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public String getDepartinvoiceno() {
		return departinvoiceno;
	}

	public void setDepartinvoiceno(String departinvoiceno) {
		this.departinvoiceno = departinvoiceno;
	}
     
}
