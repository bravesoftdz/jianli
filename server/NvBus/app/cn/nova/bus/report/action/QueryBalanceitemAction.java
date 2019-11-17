/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.report.action<br/>
 * <b>文件名：</b>QueryBalanceitemAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-1 下午03:45:07<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.QueryBalanceitemService;
import cn.nova.bus.report.service.impl.QueryBalanceitemServiceImpl;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>QueryBalanceitemAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-1 下午03:45:07<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class QueryBalanceitemAction extends BaseAction{

	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private String orgid;
	private String vehicleno;
	private Long unitid;
	private String routename;
	private String balanceno;
	private String delphiField;

	/**
	 * 运费结算明细表
	 * 
	 * @return
	 */
	public String query() {
		try {
			QueryBalanceitemService itemService = new QueryBalanceitemServiceImpl();
			setDelphiField(itemService.genDelphiField(orgid));	
			setResultmap(itemService.queryBalanceitem(orgid, startdate, enddate,
					unitid, vehicleno,routename,balanceno,delphiField));
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

	public Long getUnitid() {
		return unitid;
	}

	public void setUnitid(Long unitid) {
		this.unitid = unitid;
	}

	public String getVehicleno() {
		return vehicleno;
	}

	public void setVehicleno(String vehicleno) {
		this.vehicleno = vehicleno;
	}

	public String getRoutename() {
		return routename;
	}

	public void setRoutename(String routename) {
		this.routename = routename;
	}

	public String getBalanceno() {
		return balanceno;
	}

	public void setBalanceno(String balanceno) {
		this.balanceno = balanceno;
	}

	public String getDelphiField() {
		return delphiField;
	}

	public void setDelphiField(String delphiField) {
		this.delphiField = delphiField;
	}
	
}
