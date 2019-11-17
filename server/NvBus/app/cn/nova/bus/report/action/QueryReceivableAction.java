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

import cn.nova.bus.query.param.Qryparam;
import cn.nova.bus.report.service.QueryReceivableService;
import cn.nova.bus.report.service.impl.QueryReceivableServiceImpl;

/**
 * <b>类描述：</b> 网购对账报表<br/>
 * 
 */
public class QueryReceivableAction extends BaseAction{

	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private String orgid;
	private Qryparam qp;
	private String orgordate;//标识判断是按机构汇总还是日期
	private String sellway;//判断售票方式，新增自助机售票
	public String getSellway() {
		return sellway;
	}

	public void setSellway(String sellway) {
		this.sellway = sellway;
	}

	public String getOrgordate() {
		return orgordate;
	}

	public void setOrgordate(String orgordate) {
		this.orgordate = orgordate;
	}

	public String queryBillinuse() {
		try {
			QueryReceivableService queryReceivableService = new QueryReceivableServiceImpl();
			setResultmap(queryReceivableService.queryReceivable(orgid,
					startdate, enddate, orgordate,sellway, qp));
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

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public Qryparam getQp() {
		return qp;
	}

	public void setQp(Qryparam qp) {
		this.qp = qp;
	}
	
	

}
