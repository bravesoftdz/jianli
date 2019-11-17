package cn.nova.bus.sale.service.impl;

import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import util.SystemException;
import util.UserTransaction;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.bus.sale.model.Ticketsellagent;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.utils.orm.PropertyFilter;

public class UpdateTicketsellServiceImpl extends EntityManagerDaoSurport {
	private UserTransaction usertransaction = new UserTransaction();
	/**
	 * 修改Ticketsell和Ticketsellagent的冗余字段
	 */
	public void updateTicketsellAndTicketsellagent(Date date){
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		Calendar today =  Calendar.getInstance(); 
		long days = (today.getTime().getTime() - calendar.getTime().getTime())/(1000*3600*24);//相差天数

		for (long i = 0; i <= days; i++) {
			try {
				usertransaction.begin();
				updateDatas(calendar.getTime());//每天一次提交
				usertransaction.commit();
			} catch (SystemException e) {
				try {
					usertransaction.rollback();
				} catch (SystemException e1) {
					play.Logger.error("更新售票顾客姓名等冗余字段事务处理出错" + e.getMessage());
				}
			}catch (Exception e) {
				play.Logger.error("更新售票顾客姓名等冗余字段出错：" + e.getMessage());
			}
			calendar.add(Calendar.DAY_OF_YEAR, 1);
		}
	}
	
	public void updateDatas(Date date) throws ServiceException{
		Object[] arr;
		Long ticketsellId;
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		
		List ticketsells = qryUpdateTicketsells(date);//查询售票表Ticketsell
//		int colum = 1;
		play.Logger.info("更新发车日期为" + sdf.format(date) + "的Ticketsell条数为：" + ticketsells.size());
		for (int i = 0; i < ticketsells.size(); i++) {
			arr = (Object[]) ticketsells.get(i);
			ticketsellId = ((BigDecimal) arr[0]).longValue();
//			play.Logger.info("colum1 = " + colum);
			Ticketsell ticketsell = (Ticketsell) get(Ticketsell.class, ticketsellId);
//			colum ++;
//			play.Logger.info("colum2 = " + colum);
			if(arr[1] != null){
				ticketsell.setCustomername((String) arr[1]);
				ticketsell.setCertificatetypename((String) arr[2]);
				ticketsell.setCertificateno((String) arr[3]);
			}
			if(arr[4] != null){
				ticketsell.setDepartinvoicesno((String) arr[4]);
			}
			if(arr[5] != null){
				ticketsell.setVehicleid(((BigDecimal)arr[5]).longValue());
			}
			if(arr[6] != null){
				ticketsell.setVehiclebrandmodelid(((BigDecimal)arr[6]).longValue());
			}
			getEntityManager().merge(ticketsell);
			getEntityManager().flush();
		}
		play.Logger.info("更新发车日期为" + sdf.format(date) + "的Ticketsell数据完成");
		
		List ticketsellagents = qryUpdateTicketsellagents(date);//查询代售票表Ticketsellagent
		play.Logger.info("更新发车日期为" + sdf.format(date) + "的ticketsellagent条数为：" + ticketsellagents.size());
		for (int i = 0; i < ticketsellagents.size(); i++) {
			arr = (Object[]) ticketsellagents.get(i);
			ticketsellId = ((BigDecimal) arr[0]).longValue();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			propertyFilters.add(new PropertyFilter("EQL_t!id", ticketsellId));
			Ticketsellagent ticketsellagent = (Ticketsellagent) super.uniqueResult(Ticketsellagent.class, propertyFilters);
			if(arr[1] != null){
				ticketsellagent.setCustomername((String) arr[1]);
				ticketsellagent.setCertificatetypename((String) arr[2]);
				ticketsellagent.setCertificateno((String) arr[3]);
			}
			getEntityManager().merge(ticketsellagent);
			getEntityManager().flush();
		}
		play.Logger.info("更新发车日期为" + sdf.format(date) + "的ticketsellagent数据完成");
		
	}
	
	//查询需要修改的Ticketsell售票数据
	public List<Object> qryUpdateTicketsells(Date date){
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct tid, customername, certificatetype, certificateno, departinvoicesno, vehicleid, vehiclebrandmodelid from ( ");
		sql.append("select t.id as tid, c.name as customername, dd.value as certificatetype, ")
			.append(" c.certificateno as certificateno, ds.departinvoicesno as departinvoicesno, ")
			.append(" decode(ds.vehicleid, null, svp.planvehicleid, ds.vehicleid) as vehicleid, ")
			.append(" decode(v.vehiclebrandmodelid, null, svp.planvehiclebrandmodelid, v.vehiclebrandmodelid) as vehiclebrandmodelid ")
			.append("from Ticketsell t left join Customer c on t.customerid = c.id ")
			.append(" left join Digitaldictionary d on d.tablename = 'customer' and d.columnname = 'certificatetype' ")
			.append(" left join Digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and c.certificatetype = dd.code ")
			.append(" left join Departinvoices ds on t.departinvoicesid = ds.id and ds.status = '0' ")
			.append(" left join Vehicle v on ds.vehicleid = v.id  ")
			.append(" left join Schedulevehiclepeopleplan svp on t.scheduleplanid = svp.scheduleplanid and svp.orderno = 0 ")
			.append("where t.selltime between trunc(:date) + 0.00001 and trunc(:date) + 0.99999  ")
//			.append("where t.selltime >= trunc(:date) + 0.00001 ")
			.append(" and t.departdate >= trunc(:date)  and t.customerid is not null  ")
			.append(" and t.customername is null ");
		sql.append(" union all ");
		sql.append("select t.id as tid, c.name as customername, dd.value as certificatetype, ")
			.append(" c.certificateno as certificateno, ds.departinvoicesno as departinvoicesno, ")
			.append(" decode(ds.vehicleid, null, svp.planvehicleid, ds.vehicleid) as vehicleid, ")
			.append(" decode(v.vehiclebrandmodelid, null, svp.planvehiclebrandmodelid, v.vehiclebrandmodelid) as vehiclebrandmodelid ")
			.append("from Ticketsell t left join Customer c on t.customerid = c.id ")
			.append(" left join Digitaldictionary d on d.tablename = 'customer' and d.columnname = 'certificatetype' ")
			.append(" left join Digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and c.certificatetype = dd.code ")
			.append(" left join Departinvoices ds on t.departinvoicesid = ds.id and ds.status = '0' ")
			.append(" left join Vehicle v on ds.vehicleid = v.id  ")
			.append(" left join Schedulevehiclepeopleplan svp on t.scheduleplanid = svp.scheduleplanid and svp.orderno = 0  ")
			.append("where t.selltime between trunc(:date) + 0.00001 and trunc(:date) + 0.99999  ")
//			.append("where t.selltime >= trunc(:date) + 0.00001 ")
			.append(" and t.departdate >= trunc(:date) ")
			.append(" and t.departinvoicesno is null  and t.departinvoicesid is not null ");
		sql.append(" union all ");
		sql.append("select t.id as tid, c.name as customername, dd.value as certificatetype, ")
			.append(" c.certificateno as certificateno, ds.departinvoicesno as departinvoicesno, ")
			.append(" decode(ds.vehicleid, null, svp.planvehicleid, ds.vehicleid) as vehicleid, ")
			.append(" decode(v.vehiclebrandmodelid, null, svp.planvehiclebrandmodelid, v.vehiclebrandmodelid) as vehiclebrandmodelid ")
			.append("from Ticketsell t left join Customer c on t.customerid = c.id ")
			.append(" left join Digitaldictionary d on d.tablename = 'customer' and d.columnname = 'certificatetype' ")
			.append(" left join Digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and c.certificatetype = dd.code ")
			.append(" left join Departinvoices ds on t.departinvoicesid = ds.id and ds.status = '0' ")
			.append(" left join Vehicle v on ds.vehicleid = v.id  ")
			.append(" left join Schedulevehiclepeopleplan svp on t.scheduleplanid = svp.scheduleplanid and svp.orderno = 0 ")
			.append("where t.selltime between trunc(:date) + 0.00001 and trunc(:date) + 0.99999  ")
//			.append("where t.selltime >= trunc(:date) + 0.00001 ")
			.append(" and t.departdate >= trunc(:date) ")
			.append(" and t.vehiclebrandmodelid is null ");
		sql.append(" )");
		
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("date", date);
		return query.getResultList();
	}
	
	//查询需要修改的Ticketsellagent售票数据
	public List<Object> qryUpdateTicketsellagents(Date date){
		StringBuffer sql = new StringBuffer();
		sql.append(" select t.id as tid, c.name as customername, ")
			.append("  dd.value as certificatetype,  ")
			.append("  c.certificateno as certificateno ")
			.append("from Ticketsellagent t left join Customer c on t.customerid = c.id ")
			.append("  left join Digitaldictionary d on d.tablename = 'customer' and d.columnname = 'certificatetype' ")
			.append("  left join Digitaldictionarydetail dd on dd.digitaldictionaryid = d.id and c.certificatetype = dd.code ")
			.append("where t.selltime between trunc(:date) + 0.00001 and trunc(:date) + 0.99999  ")
//			.append("where t.selltime >= trunc(:date) + 0.00001 ")
			.append("  and t.departdate >= trunc(:date) ")
			.append("  and t.customername is null ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("date", date);
		return query.getResultList();
	}
}
