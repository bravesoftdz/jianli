/**
 * <b>项目名：</b>NvBusWeb<br/>
 * <b>包名：</b>cn.nova.bus.query.action<br/>
 * <b>文件名：</b>InsuranceQryAction.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2013-2-22 上午09:14:45<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.query.action;

import cn.nova.bus.action.BaseAction;

import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import cn.nova.bus.query.service.InsuranceQryService;
import cn.nova.bus.query.service.impl.InsuranceQryServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>InsuranceQryAction.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2013-2-22 上午09:14:45<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class InsuranceQryAction extends BaseAction{

	public InsuranceQryService insuranceService;
	public List<Map<String, Object>> insuranceMap;
	public long routeid;
	public long scheduleid;
	
	public String begindate;
	public String enddate;
	public long returnOrcanceluserid;
	public String orgids;
	public Date departbegindate;
	public Date departenddate;
	public String orderno;
	public String paymethod;   //售票员保险销售统计，增加付款方式查询条件
	

	/**
	 * 保险销售明细查询
	 * 
	 * @return
	 */
	public String queryInsurance() {
		try {
			insuranceService = new InsuranceQryServiceImpl();
			insuranceMap=insuranceService
					.queryInsurance(ServletPropertyFilterUtil.buildFromHttpRequest(), routeid, scheduleid, orderno);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	/**
	 * 险销售汇总查询
	 * 
	 * @return
	 */
	public String queryInsurancedetail() {
		try {
			insuranceService = new InsuranceQryServiceImpl();
			setInsuranceMap(insuranceService
					.queryInsurancedetail(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String insuranceReport() {
		try {
			insuranceService = new InsuranceQryServiceImpl();
			setInsuranceMap(insuranceService
					.insuranceReport(ServletPropertyFilterUtil
							.buildFromHttpRequest(), routeid,returnOrcanceluserid,begindate,
							enddate,orgids,departbegindate,departenddate, paymethod));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	/**
	 * 废保明细查询
	 * 
	 * @return
	 */
	public String queryCancelInsurance() {
		try {
			insuranceService = new InsuranceQryServiceImpl();
			insuranceMap=insuranceService
					.queryCancelInsurance(ServletPropertyFilterUtil.buildFromHttpRequest());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";	
	}

	public List<Map<String, Object>> getInsuranceMap() {
		return insuranceMap;
	}

	public void setInsuranceMap(List<Map<String, Object>> insuranceMap) {
		this.insuranceMap = insuranceMap;
	}

	public long getRouteid() {
		return routeid;
	}

	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getBegindate() {
		return begindate;
	}

	public void setBegindate(String begindate) {
		this.begindate = begindate;
	}

	public String getEnddate() {
		return enddate;
	}

	public void setEnddate(String enddate) {
		this.enddate = enddate;
	}

	public long getReturnOrcanceluserid() {
		return returnOrcanceluserid;
	}

	public void setReturnOrcanceluserid(long returnOrcanceluserid) {
		this.returnOrcanceluserid = returnOrcanceluserid;
	}

	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	public Date getDepartbegindate() {
		return departbegindate;
	}

	public void setDepartbegindate(Date departbegindate) {
		this.departbegindate = departbegindate;
	}

	public Date getDepartenddate() {
		return departenddate;
	}

	public void setDepartenddate(Date departenddate) {
		this.departenddate = departenddate;
	}

	public String getOrderno() {
		return orderno;
	}

	public void setOrderno(String orderno) {
		this.orderno = orderno;
	}

	public String getPaymethod() {
		return paymethod;
	}

	public void setPaymethod(String paymethod) {
		this.paymethod = paymethod;
	}
	
	

}
