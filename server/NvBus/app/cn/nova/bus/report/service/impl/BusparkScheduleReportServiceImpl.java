/**
 * 
 */
package cn.nova.bus.report.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import cn.nova.bus.report.dao.BusparkScheduleReportDao;
import cn.nova.bus.report.service.BusparkScheduleReportService;

/**
 * @author ice
 *
 */
public class BusparkScheduleReportServiceImpl implements
		BusparkScheduleReportService {
		private BusparkScheduleReportDao busparkScheduleReportDao = new BusparkScheduleReportDao();
	/* (non-Javadoc)
	 * @see cn.nova.bus.report.service.BusparkScheduleReportService#query(long, java.util.Date)
	 */
	@Override
	public List<Map<String, Object>> query(long orgid, Date departdate) {
		busparkScheduleReportDao = new BusparkScheduleReportDao();
		List<Map<String,Object>> result = new ArrayList<Map<String,Object>>(); 
		List<Object> _result = busparkScheduleReportDao.query(orgid, departdate);
		int row = 22;
		int currow = 0;
		int curcol= 0;
		String curBuspark = null;
		Map<String,Object> fieldtypemap = new HashMap<String, Object>();
		for (Object object : _result) {
			Object[] objects = (Object[]) object;
			Map<String,Object> curmap = null;
			if(curBuspark==null){
				curBuspark = (String) objects[0];
			}
			else{
				if(!curBuspark.equals((String) objects[0])){
					if(currow<row-1){
						//补空行
						for (int i = currow; i < row-1; i++) {
							curmap = new HashMap<String, Object>();
							curmap.put("buspark"+curcol, "");
							curmap.put("time"+curcol, "");
							curmap.put("endstationname"+curcol, "");
							fieldtypemap.put("buspark"+curcol, String.class);
							fieldtypemap.put("time"+curcol, String.class);
							fieldtypemap.put("endstationname"+curcol, String.class);
						}
					}
					curBuspark = (String) objects[0];
					currow=-1;
					curcol++;
				}
			}
			if(currow==row-1){
				currow=-1;
				curcol++;
			}
			currow++;
			if(curcol>0&&currow<result.size()){
				curmap = result.get(currow);
			}
			else{
				//添加行
				curmap = new HashMap<String, Object>();
				result.add(curmap);
			}
			curmap.put("buspark"+curcol, curBuspark);
			curmap.put("time"+curcol, objects[1]);
			curmap.put("endstationname"+curcol, objects[2]);
			fieldtypemap.put("buspark"+curcol, String.class);
			fieldtypemap.put("time"+curcol, String.class);
			fieldtypemap.put("endstationname"+curcol, String.class);
		}
		fieldtypemap.put("DATA-FLAG",String.class);			
		if(fieldtypemap.size()<=1){//解决当查询结果为空时，报错的问题：客户端要有两个查询结果集，才能打开
			fieldtypemap.put("buspark", String.class);
		}
		result.add(fieldtypemap);
		return result;
	}
}