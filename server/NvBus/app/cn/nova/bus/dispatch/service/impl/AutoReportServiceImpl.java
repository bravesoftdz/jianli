package cn.nova.bus.dispatch.service.impl;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import util.SystemException;
import util.UserTransaction;

import com.sun.jmx.snmp.Timestamp;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.dispatch.dao.AutoReportDao;
import cn.nova.bus.dispatch.model.Vehiclereport;
import cn.nova.bus.dispatch.service.AutoReportService;

public class AutoReportServiceImpl implements AutoReportService {
    private AutoReportDao autoReportDao = new AutoReportDao();
    private UserTransaction userTransaction = new UserTransaction();
	@Override
	public boolean start() {
		// TODO Auto-generated method stub
		boolean issuss =false;
        List<Object> list = autoReportDao.qryScheduleVehiclePeoplan(); //查询明天的有计划车辆且是自动报班的班次
        Long userid = autoReportDao.qryUserId();//获取admin的Id
        try {
			userTransaction.begin();
        for(Object obj:list){
        	Object[] objarry = (Object[])obj;
        	if(!autoReportDao.isExistVehicleReport(Long.parseLong(objarry[0].toString()),(Date)objarry[2],
        			Short.parseShort(objarry[4].toString()),Long.parseLong(objarry[3].toString()))){//如果已报到则不进行报到
        		Vehiclereport vehicleReport = new Vehiclereport();
        		vehicleReport.setScheduleplanid(Long.parseLong(objarry[0].toString()));
        		vehicleReport.setOrgid(Long.parseLong(objarry[1].toString()));
        		vehicleReport.setReportorgid(Long.parseLong(objarry[1].toString()));
        		vehicleReport.setDepartdate((Date)objarry[2]);
        		vehicleReport.setScheduleid(Long.parseLong(objarry[3].toString()));
        		vehicleReport.setReportway("0");
        		vehicleReport.setOrderno(Short.parseShort(objarry[4].toString()));
        		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        		Date date = null;
        		try {
        			date = sdf.parse(sdf.format(new Date()));					
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					issuss=false;
					e.printStackTrace();
				}
				vehicleReport.setReporttime(date);
				vehicleReport.setVehicleid(Long.parseLong(objarry[5].toString()));
				if(objarry[6]!=null){
					Driver driver1 = new Driver();
					driver1.setId(Long.parseLong(objarry[6].toString()));
				    vehicleReport.setDriver1(driver1);
				}
				if(objarry[7]!=null){
					Driver driver2 = new Driver();
					driver2.setId(Long.parseLong(objarry[7].toString()));
					vehicleReport.setDriver2(driver2);
				}
				if(objarry[8]!=null){
					Driver driver3 = new Driver();
					driver3.setId(Long.parseLong(objarry[8].toString()));
				    vehicleReport.setDriver1(driver3);
				}
				if(objarry[9]!=null){
					Driver driver4 = new Driver();
					driver4.setId(Long.parseLong(objarry[9].toString()));
					vehicleReport.setDriver2(driver4);
				}
				if(objarry[10]!=null){
					Steward steward1 = new Steward();
					steward1.setId(Long.parseLong(objarry[10].toString()));
				    vehicleReport.setSteward1(steward1);
				}
				if(objarry[11]!=null){
					Steward steward2 = new Steward();
					steward2.setId(Long.parseLong(objarry[11].toString()));
					vehicleReport.setSteward2(steward2);
				}
				vehicleReport.setIsactive(true);
				vehicleReport.setCreatetime(date);
				vehicleReport.setCreateby(userid);
				vehicleReport.setUpdatetime(date);
				vehicleReport.setUpdateby(userid);
				vehicleReport.setIsdeparted(false);
				vehicleReport.setIsreplace(false);
				autoReportDao.merge(vehicleReport);
				
				autoReportDao.updateScheduestaus(Long.parseLong(objarry[0].toString()), (Date)objarry[2], 
						Long.parseLong(objarry[3].toString()), userid);  //更新班次状态表
				
				
        	}
        }
        userTransaction.commit();
        play.Logger.info("自助报班执行完成！");
       issuss = true;
        } catch (SystemException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
			play.Logger.info("自助报班执行异常！");
			issuss =false;
			try {
				userTransaction.rollback();
			} catch (SystemException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
       return issuss; 
	}

}
