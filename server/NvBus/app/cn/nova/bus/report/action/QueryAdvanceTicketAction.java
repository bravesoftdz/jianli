/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2012-3-21 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import play.data.binding.As;
import cn.nova.bus.report.service.QueryAdvanceTicketService;
import cn.nova.bus.report.service.impl.QueryAdvanceTicketServiceImpl;
/**
 * <b>类描述：</b> 预售票情况查询月报表<br/>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-3-21 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class QueryAdvanceTicketAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private Long sellid;
	private String orgid;
	private Long routeid;
	private Long tosid;
	private Boolean groupbyroute;
	private Date dptstartdate;
	private Date dptenddate;
	
	public String queryBillinuse() {
		try {
			QueryAdvanceTicketService queryAdvanceTicketService = new QueryAdvanceTicketServiceImpl();
			setResultmap(queryAdvanceTicketService
					.queryAdvanceTicket( orgid,sellid,startdate, enddate,routeid,tosid,groupbyroute,dptstartdate,dptenddate));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}
	
	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	@As("yyyy-MM-dd HH:mm:ss")
	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Long getSellid() {
		return sellid;
	}

	public void setSellid(Long sellid) {
		this.sellid = sellid;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Long getTosid() {
		return tosid;
	}

	public void setTosid(Long tosid) {
		this.tosid = tosid;
	}

	public Boolean getGroupbyroute() {
		return groupbyroute;
	}

	public void setGroupbyroute(Boolean groupbyroute) {
		this.groupbyroute = groupbyroute;
	}

	public Date getDptstartdate() {
		return dptstartdate;
	}

	public void setDptstartdate(Date dptstartdate) {
		this.dptstartdate = dptstartdate;
	}

	public Date getDptenddate() {
		return dptenddate;
	}

	public void setDptenddate(Date dptenddate) {
		this.dptenddate = dptenddate;
	}

}
