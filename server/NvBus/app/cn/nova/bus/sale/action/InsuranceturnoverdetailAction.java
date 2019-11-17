package cn.nova.bus.sale.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsuranceturnoverdetailService;
import cn.nova.bus.insure.service.impl.InsuranceturnoverdetailServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class InsuranceturnoverdetailAction extends BaseAction{
	private Insuranceturnoverdetail insuranceturnoverdetail;
	private List<Map<String, Object>> insuranceMap;
	private List<Map<String, Object>> returnTicketnoMap;
	private List<Map<String, Object>> cancelTicketnoMap;
	private List<Map<String, Object>> billTicketnoMap;

	private InsuranceturnoverdetailService insuranceService;

	public String query() {
		try {
			insuranceService = new InsuranceturnoverdetailServiceImpl();
			setInsuranceMap(insuranceService
					.query(ServletPropertyFilterUtil
							.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String queryReturnTicketno() {
		insuranceService = new InsuranceturnoverdetailServiceImpl();
		setReturnTicketnoMap(insuranceService
				.queryReturnInsuranceno(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}

	public String queryCancelTicketno() {
		insuranceService = new InsuranceturnoverdetailServiceImpl();
		setCancelTicketnoMap(insuranceService
				.queryCancelInsuranceno(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}
	
	public String queryBillTicketno() {
		insuranceService = new InsuranceturnoverdetailServiceImpl();
		setBillTicketnoMap(insuranceService
				.queryBillInsuranceno(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}
	
	public Insuranceturnoverdetail getInsuranceturnoverdetail() {
		return insuranceturnoverdetail;
	}

	public void setInsuranceturnoverdetail(
			Insuranceturnoverdetail insuranceturnoverdetail) {
		this.insuranceturnoverdetail = insuranceturnoverdetail;
	}

	public List<Map<String, Object>> getInsuranceMap() {
		return insuranceMap;
	}

	public void setInsuranceMap(List<Map<String, Object>> insuranceMap) {
		this.insuranceMap = insuranceMap;
	}

	public List<Map<String, Object>> getReturnTicketnoMap() {
		return returnTicketnoMap;
	}

	public void setReturnTicketnoMap(List<Map<String, Object>> returnTicketnoMap) {
		this.returnTicketnoMap = returnTicketnoMap;
	}

	public List<Map<String, Object>> getCancelTicketnoMap() {
		return cancelTicketnoMap;
	}

	public void setCancelTicketnoMap(List<Map<String, Object>> cancelTicketnoMap) {
		this.cancelTicketnoMap = cancelTicketnoMap;
	}

	public List<Map<String, Object>> getBillTicketnoMap() {
		return billTicketnoMap;
	}

	public void setBillTicketnoMap(List<Map<String, Object>> billTicketnoMap) {
		this.billTicketnoMap = billTicketnoMap;
	}

}
