package cn.nova.bus.report.action;

import cn.nova.bus.action.BaseAction;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import cn.nova.bus.report.service.BillinuseBalanceReportService;
import cn.nova.bus.report.service.impl.BillinuseBalanceReportServiceImpl;

public class BillinuseBalanceReportAction extends BaseAction{
	private List<Map<String, Object>> result;

	private String orgids;
	private Date startdate;
	private Date enddate;
	private Long salerid;
	private boolean check;

	public String reportBillinuseBalance() {
		BillinuseBalanceReportService billinuseBalanceReportService = new BillinuseBalanceReportServiceImpl();
		setResult(billinuseBalanceReportService.reportBillinuseBalance(
				getOrgids(), getStartdate(), getEnddate(), getSalerid(), check));
		setMsg("");
		markSuccess();
		return "json";
	}

	public List<Map<String, Object>> getResult() {
		return result;
	}

	public void setResult(List<Map<String, Object>> result) {
		this.result = result;
	}

	@Transient
	public String getOrgids() {
		return orgids;
	}

	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}

	@Transient
	public Date getStartdate() {
		return startdate;
	}

	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}

	@Transient
	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	@Transient
	public Long getSalerid() {
		return salerid;
	}

	public void setSalerid(Long salerid) {
		this.salerid = salerid;
	}

	public boolean isCheck() {
		return check;
	}

	public void setCheck(boolean check) {
		this.check = check;
	}

}
