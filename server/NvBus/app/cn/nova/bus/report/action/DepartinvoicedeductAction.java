/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.report.action<br/>
 * <b>文件名：</b>DepartinvoicedeductAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2012-4-25 下午16:33:31 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.service.DepartinvoicedeductService;
import cn.nova.bus.report.service.impl.DepartinvoicedeductServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：固定扣费项目表</b><br/>
 * <b>类名称：</b>DepartinvoicedeductAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-4-25 下午16:33:58 <br/>
 * <b>关键修改：机构ID修改为String 类型</b><br/>
 * <b>修改时间：2012-4-19</b><br/>
 * <b>修改人：</b><br/>
 */
public class DepartinvoicedeductAction extends BaseAction{

	private DepartinvoicedeductService deductService;
	// 返回结果
	private List<Map<String, Object>> resultmap;
	private Date startdate;
	private Date enddate;
	private String orgid;// 所属机构
	private Long printorgid;// 开运量机构
	private Long routeid;
	private Long vehicleid;
	private String balancetypeflag;

	/**
	 * 固定扣费项目
	 * 
	 * @return
	 */
	public String query() {
		try {
			deductService = new DepartinvoicedeductServiceImpl();
			setResultmap(deductService.queryDeduct(startdate, enddate, orgid,
					printorgid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}

	/**
	 * 车辆结算汇总查询
	 * 
	 * @return
	 */
	public String queryVehicleDepartinvoices() {
		deductService = new DepartinvoicedeductServiceImpl();
		setResultmap(deductService
				.queryVehicleDepartinvoices(ServletPropertyFilterUtil
						.buildFromHttpRequest(),balancetypeflag,orgid));
		return "json";
	}
	/**
	 * 线路结算汇总表
	 */
	public String routebalancereport() {
		deductService = new DepartinvoicedeductServiceImpl();
		setResultmap(deductService
				.routebalancereport(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}
	/**
	 * 客运结算统计表
	 * @return
	 */
	public String queryDepartinvoices() {
		try {
			deductService = new DepartinvoicedeductServiceImpl();
			setResultmap(deductService.queryDepartinvoices(orgid, routeid,
					vehicleid, new Date(112,3,5), new Date(112,4,4)));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			System.out.println(e.getMessage());
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

	public Long getPrintorgid() {
		return printorgid;
	}

	public void setPrintorgid(Long printorgid) {
		this.printorgid = printorgid;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getBalancetypeflag() {
		return balancetypeflag;
	}

	public void setBalancetypeflag(String balancetypeflag) {
		this.balancetypeflag = balancetypeflag;
	}
	
}
