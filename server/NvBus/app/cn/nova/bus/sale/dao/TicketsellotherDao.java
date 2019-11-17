/**
 * 
 */
package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.NetOrgTakeSetting;
import cn.nova.bus.sale.model.Ticketsellother;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author ice
 *
 */

public class TicketsellotherDao extends
		EntityManagerDaoSurport<Ticketsellother> {
	public List<Map<String,Object>> findETicketInfo(List<PropertyFilter> propertyFilters){
	
		List<Object> result = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder("select case when ts.ticketstatus='0' and tso.istaked=0 then 1 ")
				.append(" else null end as isselected, ts.id,ts.departdate,sc.code as schedulecode,trim(ts.departtime),ts.selltime")
				.append(",std.name as departstationname,str.name as reachstationname, ts.seatno,tt.name as tickettypename,ts.price")
				.append(" ,tso.istaked,tso.taketime,ts.ticketno,tso.orderno,'' as mobilephone")
				.append(" ,tso.eticketno,tso.password,tso.eticketid,tso.id as tsoid,")
				.append(" trim(dd.value) as vcticketstatus")
				.append(" from Ticketsell ts,Ticketsellother tso,Station std,Station str,Schedule sc,Tickettype tt,Digitaldictionarydetail dd")
				.append(" where ts.id=tso.ticketsellid ")
				.append(" and dd.digitaldictionary.id = 52 ")
				.append(" and dd.code = ts.ticketstatus ")
				.append(" and ts.departstationid=std.id ")
				.append(" and ts.reachstationid=str.id")
				.append(" and ts.scheduleid=sc.id")
				.append(" and ts.tickettype=tt.code")
				.append(" and tt.isactive=1");
//				.append(" and t.ticketstatus='0' and t.ischecked='0' ");
		List<Object> oldresult = super.find(sql.toString(),propertyFilters);
		
		
		
		
		
		
		
		
		return ListUtil.listToMap(new Object[]{"isselected","id","departdate","schedulecode","departtime","selltime"
				                              ,"departstationname","reachstationname","seatno","tickettypename","price"
				                              ,"istaked","taketime","ticketno","orderno","mobilephone"
				                              ,"eticketno","password","eticketid","tsoid","vcticketstatus"},
								result,
								new Object[]{Boolean.class,Long.class,Date.class,String.class,String.class,Timestamp.class
							                ,String.class,String.class, Integer.class,String.class,BigDecimal.class
							                ,Boolean.class,Timestamp.class,String.class,String.class,String.class
							                ,String.class,String.class,String.class,Long.class,String.class}
								);
	}

	public List<Map<String,Object>> findETicketInfoByCustomer(List<PropertyFilter> propertyFilters){
		/**
		 * 原来网售取票   根据身份证号取票
		 */
		List<Object> result = new ArrayList<Object>();
		StringBuilder sql = new StringBuilder("select case when ts.ticketstatus='0' and tso.istaked=0 then 1 ")
				.append(" else null end as isselected,ts.id,ts.departdate,sc.code as schedulecode,trim(ts.departtime),ts.selltime")
				.append(",std.name as departstationname,str.name as reachstationname, ts.seatno,tt.name as tickettypename,ts.price")
				.append(" ,tso.istaked,tso.taketime,ts.ticketno,tso.orderno,cu.mobilephone")
				.append(" ,tso.eticketno,tso.password,tso.eticketid,tso.id as tsoid,")
				.append(" trim(dd.value) as vcticketstatus ")
				.append(" from Ticketsell ts,Ticketsellother tso,Station std,Station str,Schedule sc,Tickettype tt,Customer cu,Digitaldictionarydetail dd")
				.append(" where ts.id=tso.ticketsellid ")
				.append(" and dd.digitaldictionary.id = 52 ")
				.append(" and dd.code = ts.ticketstatus ")
				.append(" and ts.departstationid=std.id ")
				.append(" and ts.reachstationid=str.id")
				.append(" and ts.scheduleid=sc.id")
				.append(" and ts.tickettype=tt.code")
				.append(" and tt.isactive=1")
				.append(" and ts.customer=cu");
		List<Object> oldresult = super.find(sql.toString(),propertyFilters);
		
		/**
		 * 网售票混检后 原票为退票  根据身份证号取票方式
		 */
		
		sql = new StringBuilder("select case when ts.ticketstatus='0' and tso.istaked=0 then 1 ")
				.append(" else null end as isselected,ts.id,ts.departdate,sc.code as schedulecode,trim(ts.departtime),ts.selltime")
				.append(",std.name as departstationname,str.name as reachstationname, ts.seatno,tt.name as tickettypename,ts.price")
				.append(" ,tso.istaked,tso.taketime,ts.ticketno,tso.orderno,cu.mobilephone")
				.append(" ,tso.eticketno,tso.password,tso.eticketid,tso.id as tsoid,")
				.append(" trim(dd.value) as vcticketstatus ")
				.append(" from Ticketsell ts,TicketMixChange tmx,Ticketsellother tso,Station std,Station str,Schedule sc,Tickettype tt,Customer cu,Digitaldictionarydetail dd")
				.append(" where ts.id = tmx.sellid and tso.ticketsellid = tmx.oldsellid ")
				.append(" and dd.digitaldictionary.id = 52 ")
				.append(" and dd.code = ts.ticketstatus ")
				.append(" and ts.departstationid=std.id ")
				.append(" and ts.reachstationid=str.id")
				.append(" and ts.scheduleid=sc.id")
				.append(" and ts.tickettype=tt.code")
				.append(" and tt.isactive=1")
				.append(" and ts.customer=cu");
		List<Object> newresult = super.find(sql.toString(),propertyFilters);
		result = getResult(oldresult,newresult);
		return ListUtil.listToMap(new Object[]{"isselected","id","departdate","schedulecode","departtime","selltime"
				                              ,"departstationname","reachstationname","seatno","tickettypename","price"
				                              ,"istaked","taketime","ticketno","orderno","mobilephone"
				                              ,"eticketno","password","eticketid","tsoid","vcticketstatus"},
								result,
								new Object[]{Boolean.class,Long.class,Date.class,String.class,String.class,Timestamp.class
							                ,String.class,String.class, Integer.class,String.class,BigDecimal.class
							                ,Boolean.class,Timestamp.class,String.class,String.class,String.class
							                ,String.class,String.class,String.class,Long.class,String.class}
								);
	}
	public List<Map<String, Object>> findETicketInfoByCustomeridcardno(Date departdate,String idcardno) {
		List<Object> result = new ArrayList<Object>();
		SimpleDateFormat df =  new  SimpleDateFormat("yyyyMMdd");
		String begin = 	df.format(departdate);
		StringBuilder sql = new StringBuilder("select case when ts.ticketstatus='0' and tso.istaked=0 then 1 ")
				.append(" else null end as isselected,ts.id,ts.departdate,sc.code as schedulecode,trim(ts.departtime),ts.selltime")
				.append(",std.name as departstationname,str.name as reachstationname, ts.seatno,tt.name as tickettypename,ts.price")
				.append(" ,tso.istaked,tso.taketime,ts.ticketno,tso.orderno,cu.mobilephone")
				.append(" ,tso.eticketno,tso.password,tso.eticketid,tso.id as tsoid,")
				.append(" trim(dd.value) as vcticketstatus")
				.append(" from Ticketsell ts,Ticketsellother tso,Station std,Station str,Schedule sc,Tickettype tt,Customer cu,Digitaldictionarydetail dd")
				.append(" where ts.id=tso.ticketsellid ")
				.append(" and ts.departstationid=std.id ")
				.append(" and dd.digitaldictionaryid = 52 ")
				.append(" and dd.code = ts.ticketstatus ")
				.append(" and ts.reachstationid=str.id")
				.append(" and ts.scheduleid=sc.id")
				.append(" and ts.tickettype=tt.code")
				.append(" and tt.isactive=1")
				.append(" and ts.customerid=cu.id ")
				.append(" and ts.departdate >= :departdate")
				.append(" and upper(cu.certificateno) = upper('"+idcardno+"')")
				.append(" and ts.departdate >= to_date('"+begin+"','yyyymmdd')");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		List<Object> oldresult = query.getResultList();		
		sql = new StringBuilder("select case when ts.ticketstatus='0' and tso.istaked=0 then 1 ")
				.append(" else null end as isselected,ts.id,ts.departdate,sc.code as schedulecode,trim(ts.departtime),ts.selltime")
				.append(",std.name as departstationname,str.name as reachstationname, ts.seatno,tt.name as tickettypename,ts.price")
				.append(" ,tso.istaked,tso.taketime,ts.ticketno,tso.orderno,cu.mobilephone")
				.append(" ,tso.eticketno,tso.password,tso.eticketid,tso.id as tsoid,")
				.append(" trim(dd.value) as vcticketstatus")
				.append(" from Ticketsell ts,TicketMixChange tmx,Ticketsellother tso,Station std,Station str,Schedule sc,Tickettype tt,Customer cu,Digitaldictionarydetail dd")
				.append(" where ts.id = tmx.sellid and tso.ticketsellid = tmx.oldsellid ")
				.append(" and ts.departstationid=std.id ")
				.append(" and dd.digitaldictionaryid = 52 ")
				.append(" and dd.code = ts.ticketstatus ")
				.append(" and ts.reachstationid=str.id")
				.append(" and ts.scheduleid=sc.id")
				.append(" and ts.tickettype=tt.code")
				.append(" and tt.isactive=1")
				.append(" and ts.customerid=cu.id ")
				.append(" and ts.departdate >= :departdate")
				.append(" and upper(cu.certificateno) = upper('"+idcardno+"')")
				.append(" and ts.departdate >= to_date('"+begin+"','yyyymmdd')");
		query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("departdate", departdate);
		List<Object> newresult = query.getResultList();		
		
		result = getResult(oldresult,newresult);
		
		return ListUtil.listToMap(new Object[]{"isselected","id","departdate","schedulecode","departtime","selltime"
				                              ,"departstationname","reachstationname","seatno","tickettypename","price"
				                              ,"istaked","taketime","ticketno","orderno","mobilephone"
				                              ,"eticketno","password","eticketid","tsoid","vcticketstatus"},
								result,
								new Object[]{Boolean.class,Long.class,Date.class,String.class,String.class,Timestamp.class
							                ,String.class,String.class, Integer.class,String.class,BigDecimal.class
							                ,Boolean.class,Timestamp.class,String.class,String.class,String.class
							                ,String.class,String.class,String.class,Long.class,String.class}
								);
	
	}
	public Ticketsellother getByETicketid(String eticketid){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!eticketid", eticketid));
		return (Ticketsellother) super.uniqueResult(Ticketsellother.class, propertyFilters);
	}
	
	public Ticketsellother getByETicketno(String eticketno){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!eticketno", eticketno));
		return (Ticketsellother) super.uniqueResult(Ticketsellother.class, propertyFilters);
	}
	
	public Ticketsellother getByPassword(String password){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!password", password));
		return (Ticketsellother) super.uniqueResult(Ticketsellother.class, propertyFilters);
	}

	public List<Ticketsellother> findByOrderno(String orderno){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!orderno", orderno));
		return super.find(Ticketsellother.class, propertyFilters);
	}
	
	/**
	 * 查询在NetOrgTakeSetting网售取票机构控制表中不可取票的机构
	 * @param netOrgCode
	 * @return
	 */
	public NetOrgTakeSetting qryForbidNetOrgs(String netOrgCode){
		StringBuffer sql = new StringBuffer();
		sql.append("select t from NetOrgTakeSetting t, Organization o ")
			.append(" where t.orgcode = o.code  ")
			.append("  and t.cantake = 0 ")
			.append("  and o.isactive = 1 ")
			.append("  and t.orgcode = :netOrgCode ");
		
		Query query = getEntityManager().createQuery(sql.toString(), NetOrgTakeSetting.class);
		query.setParameter("netOrgCode", netOrgCode);
		List<NetOrgTakeSetting> list = query.getResultList();
		return (list != null && list.size() > 0) ? list.get(0) : null;
	}

	//通过票号id获取电子取票信息
	public Ticketsellother qryTicketsellotherByTicketsellid(long ticketsellid) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("ticketsellid", ticketsellid);
		return (Ticketsellother) super.uniqueResult(Ticketsellother.class, map);
	}
	
	/**
	 * 电子票号混检后，进行电子票取票查询操作
	 * @param propertyFilters
	 * @return
	 */
	public List<Map<String,Object>> findETicketInfoAndMixChange(List<PropertyFilter> propertyFilters){
		StringBuilder sql = new StringBuilder("select case when ts.ticketstatus='0' and tso.istaked=0 then 1 ")
				.append(" else null end as isselected, ts.id,ts.departdate,sc.code as schedulecode,trim(ts.departtime),ts.selltime")
				.append(",std.name as departstationname,str.name as reachstationname, ts.seatno,tt.name as tickettypename,ts.price")
				.append(" ,tso.istaked,tso.taketime,ts.ticketno,tso.orderno,'' as mobilephone")
				.append(" ,tso.eticketno,tso.password,tso.eticketid,tso.id as tsoid,")
				.append(" trim(dd.value) as vcticketstatus")
				.append(" from Ticketsell ts,TicketMixChange tmx,Ticketsellother tso,Station std,Station str,Schedule sc,Tickettype tt,Digitaldictionarydetail dd")
				.append(" where ts.id = tmx.sellid and tso.ticketsellid = tmx.oldsellid ")
				.append(" and dd.digitaldictionary.id = 52 ")
				.append(" and dd.code = ts.ticketstatus ")
				.append(" and ts.departstationid=std.id ")
				.append(" and ts.reachstationid=str.id")
				.append(" and ts.scheduleid=sc.id")
				.append(" and ts.tickettype=tt.code")
				.append(" and tt.isactive=1");
//				.append(" and t.ticketstatus='0' and t.ischecked='0' ");
		List<Object> result = super.find(sql.toString(),propertyFilters);
		return ListUtil.listToMap(new Object[]{"isselected","id","departdate","schedulecode","departtime","selltime"
				                              ,"departstationname","reachstationname","seatno","tickettypename","price"
				                              ,"istaked","taketime","ticketno","orderno","mobilephone"
				                              ,"eticketno","password","eticketid","tsoid","vcticketstatus"},
								result,
								new Object[]{Boolean.class,Long.class,Date.class,String.class,String.class,Timestamp.class
							                ,String.class,String.class, Integer.class,String.class,BigDecimal.class
							                ,Boolean.class,Timestamp.class,String.class,String.class,String.class
							                ,String.class,String.class,String.class,Long.class,String.class}
								);
	}
	public List<Object> getResult(List<Object> oldresult,List<Object> newresult){
		List<Object> result = new ArrayList<Object>();
		if(oldresult.size()>0&&oldresult!=null){
			if(newresult.size()>0&&newresult!=null){
				for(int i = oldresult.size()-1;i>=0;i--){
					Object[] olddata = (Object[]) oldresult.get(i);
					String oldtsoid = olddata[19].toString();
					for(int j=0;j<newresult.size();j++){
						Object[] newdata = (Object[]) newresult.get(j);
						String newtsoid = newdata[19].toString();
						if(oldtsoid.equals(newtsoid)){
							oldresult.remove(i);
						}
					}
				}
			}
		}
		result.addAll(oldresult);
		result.addAll(newresult);
		return result;
	}
	
}
