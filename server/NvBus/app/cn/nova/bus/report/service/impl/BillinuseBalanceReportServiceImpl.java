package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.BillinuseBalanceReportDao;
import cn.nova.bus.report.service.BillinuseBalanceReportService;
import cn.nova.utils.orm.jpa.ListUtil;
public class BillinuseBalanceReportServiceImpl implements BillinuseBalanceReportService {
	private BillinuseBalanceReportDao billinuseBalanceReportDao = new BillinuseBalanceReportDao();

	@Override
	public List<Map<String,Object>> reportBillinuseBalance(String orgids, Date startdate,
			Date enddate, Long salerid, boolean check) {
		billinuseBalanceReportDao = new BillinuseBalanceReportDao();
		List<Object> list =new ArrayList<Object>();
		list =billinuseBalanceReportDao.reportBillinuseBalance(orgids, startdate, enddate, salerid,check);
		
		List result = new ArrayList();
		for (Object element : list) {
			Object[] arr = (Object[]) element;
			String startnumver =  (String) arr[2];
			String endnumver =  arr[3].toString();
			for (int difference=startnumver.length()-endnumver.length();difference>0;difference--){
				endnumver= "0" + endnumver;
			}
			arr[3]=endnumver;
			result.add(arr);
		}
		
		
		return ListUtil.listToMap(new Object[]{"salername","billsource","laststartno","lastendno","lastticketnum"
												,"sellnum","cancelnum","eticketnum","returnnum","damagednum"
												,"balancestartno","balanceendno","balanceticketnum"
											  }, result,
						  // billinuseBalanceReportDao.reportBillinuseBalance(orgids, startdate, enddate, salerid,check),
						   new Object[]{String.class,String.class,String.class,String.class,BigDecimal.class
									    ,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class,BigDecimal.class
									    ,String.class,String.class,BigDecimal.class});
	}
	
}
