package cn.nova.bus.report.service;

import java.util.Date;
import java.util.List;
import java.util.Map;

public interface BillinuseBalanceReportService {

	public List<Map<String,Object>> reportBillinuseBalance(String orgids,Date startdate,Date enddate,Long salerid, boolean check);

}
