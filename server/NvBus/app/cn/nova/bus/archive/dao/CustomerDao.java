package cn.nova.bus.archive.dao;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import util.JsonUtil;

import cn.nova.bus.archive.model.Customer;
import cn.nova.bus.archive.model.CustomerUpdateVo;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketsell;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * <b>类描述：顾客档案管理</b><br/>
 * <b>类名称：</b>VipbooktimeDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b><br/>
 * <b>关键修改：修改查询功能，获取vip等级名称，用于订票时直接利用该名称</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
@SuppressWarnings("rawtypes")
public class CustomerDao extends EntityManagerDaoSurport {

	@SuppressWarnings("unchecked")
	public List<Object> queryCustomer(List<PropertyFilter> propertyFilterList,String showfullidno) {
		StringBuilder sql = new StringBuilder(
				"select c.id,o.id orgid,c.createby,c.education,c.familyaddress,c.familyphone,c.mobilephone,c.name,c.sex,c.updateby,");
		play.Logger.info("queryCustomer.propertyFilterList="+JsonUtil.toSimpleString(propertyFilterList)+",showfullidno="+showfullidno);
		if ("1".equals(showfullidno)){
			sql.append(" c.certificateno as certificateno,");	
		}else{
			sql.append(" case when c.certificatetype='0' then substr(c.certificateno,0,10)||'****'||substr(c.certificateno,-4,4) else c.certificateno end as certificateno,");
		}
		
				sql.append("c.certificatetype,c.inputway,")
				.append("c.remarks,c.createtime,c.updatetime,c.birthday,c.email,c.ticketoutletsid,c.lastbuytickettime,")
				.append("o.name as orgname ,uc.name as createname,up.name as updatename,")
				.append(" v.vipgrade,v.vipcardno,v.money,v.vipamount,v.status,dd.value as vipgradename, ")
				.append(" c.departstationname,c.reachstationname,c.endstationname,c.ticketno,c.schcode, ")  //增加的冗余字段
//				.append(" s1.name as departstationname,s2.name as reachstationname,s3.name as endstationname,t.ticketno,sch.code as schcode,")
				.append(" c.departdate,c.departtime,c.planvehicleno,c.nation ")  //增加的冗余字段
//				.append(" t.departdate,trim(t.departtime) as tsdeparttime, vc.vehicleno as planvehicleno,c.nation ")
				.append(" ,case when c.isblack=1 then '是' else '否' end as isblack ,c.isblack as  isblackcheck")
				.append(" ,c.isred as  isred ,case when c.isred =1 then '是' else '否' end as isredstring,  ")
				.append(" c.ticketstatus,c.seatno ")  //车票状态，座位号
				.append(" from Customer c ")
//				.append(" left join ")
//				.append("  (select ts.createtime,ts.customerid,ts.departstationid,ts.reachstationid,")
//				.append(" ts.ticketno,ts.scheduleid,ts.departdate,trim(ts.departtime) as departtime,ts.vehiclereportid, ")
//				.append("   row_number()over(partition by ts.customerid order by ts.createtime desc) sn ")
//				.append("  from ticketsell ts,Customer cc where ts.customerid=cc.id ) t ")
//				.append("  on c.id = t.customerid  and t.sn = 1 ")
				.append(" left join Vip v")
				.append(" left join digitaldictionarydetail dd ")
				.append(" on dd.digitaldictionaryid =38  ")
				.append(" and  dd.code = v.vipgrade on c.id=v.customerid and v.status not in ('1','3','5') ")
				.append(" left join Userinfo uc on uc.id = c.createby ")
				.append(" left join Userinfo up on up.id = c.updateby ")
				.append(" left join Organization o on o.id = c.orgid ")
//				.append(" left join Station s1 on t.departstationid = s1.id ")
//				.append(" left join Station s2 on t.reachstationid = s2.id")
//				.append("  left join Schedule sch on t.scheduleid = sch.id ")
//				.append(" left join route r on sch.routeid = r.id left join Station s3 on r.endstationid = s3.id ")
//				.append("  left join Vehiclereport vr on t.vehiclereportid = vr.id  ")
//				.append(" left join Vehicle vc on vr.vehicleid = vc.id ")
				.append(" where  c.isactive=1  and rownum < 1000 ");	
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list= query.getResultList();
		play.Logger.info("queryCustomer.list.size()="+list.size());
		return list;
	}

	/**
	 * 顾客购票明细，
	 * 
	 * @param propertyFilterList
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryBuyTicket(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select t.selltime,t.departdate,t.departtime, t.fullprice,t.seatno,t.ticketentrance ,")
				.append(" t.ischecked ,s.code as schedulename,st.name as reachname,ot.name as ticketoutname ")
				.append(" from Ticketsell t,Schedule s,Station st, Ticketoutlets ot")
				.append(" where s.id = t.scheduleid and st.id = t.reachstationid and t.ticketoutletsid = ot.id and ot.id = t.ticketoutletsid ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}

	public long isExistCustomer(String certificatetype, String certificateno,
			String mobilephone) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (certificatetype != null) {
			map.put("certificatetype", certificatetype);
		}
		if (certificateno != null) {
			map.put("certificateno", certificateno);
		}
		if (mobilephone != null) {
			map.put("mobilephone", mobilephone);
		}
		//map.put("isactive", true);
		List<Customer> customer = find(Customer.class, map);
		return customer != null && customer.size() > 0 ? customer.get(0)
				.getId() : 0;
	}
	public Customer isExistCustomer(String certificatetype, String certificateno) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (certificatetype != null) {
			map.put("certificatetype", certificatetype);
		}
		if (certificateno != null) {
			map.put("certificateno", certificateno);
		}
		Customer cus=null;
		List<Customer> customer = find(Customer.class, map);
		if(customer != null && customer.size()>1){
			for(Customer c:customer){
				if(c.getIsactive()){
					cus=c;
					break;
				}
			}
		}else{
			cus=customer != null && customer.size() > 0 ? customer.get(0) : null;
		}
		return cus;
	}


	@SuppressWarnings("unchecked")
	public boolean update(long delid) {
		int resultnum = 0;
		String sql = "update Customer t set t.isactive = 0,t.islocaldelete = 1,t.isblack = 0 where t.id = "
				+ delid;
		resultnum = execute(sql);
		if (resultnum > 0) {
			return true;
		} else {
			return false;
		}

	}

	public Customer findByTrueMajorKey(String certificatetype,
			String certificateno) {
		Map<String, Object> map = new HashMap<String, Object>();
		map.put("certificatetype", certificatetype);
		map.put("certificateno", certificateno);
		map.put("isactive", true);
		return (Customer) super.uniqueResult(Customer.class, map);
	}
	
	public boolean updateCustomerByctypeAndcno(String name,String certificatetype,
			String certificateno){
		StringBuilder sql = new StringBuilder();
		sql.append(" update Customer c set c.name=:name,c.isactive=1 where c.certificatetype=:certificatetype and c.certificateno=:certificateno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("name",name );
		query.setParameter("certificatetype",certificatetype );
		query.setParameter("certificateno",certificateno );
		return query.executeUpdate()>0?true:false;
	}
	public boolean updateCustomerByctypeAndcno(String certificatetype,
			String certificateno){
		StringBuilder sql = new StringBuilder();
		sql.append(" update Customer c set c.isactive=0 where c.certificatetype=:certificatetype and c.certificateno=:certificateno");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("certificatetype",certificatetype );
		query.setParameter("certificateno",certificateno );
		return query.executeUpdate()>0?true:false;
	}
	public Customer findCustomer(String certificatetype, String certificateno,
			String mobilephone,String name) {
		Map<String, Object> map = new HashMap<String, Object>();
		if (certificatetype != null) {
			map.put("certificatetype", certificatetype);
		}
		if (certificateno != null) {
			map.put("certificateno", certificateno);
		}
		map.put("isactive", true);
		List<Customer> customer = find(Customer.class, map);
		if(customer==null || customer.size()==0){
			map.clear();
			if (certificatetype != null) {
				map.put("certificatetype", certificatetype);
			}
			if (certificateno != null) {
				map.put("certificateno", certificateno);
			}
			customer = find(Customer.class, map);
		}
		return customer != null && customer.size() > 0 ? customer.get(0)
				 : null;
	}

	/**
	 * 查询当天的售票信息
	 * @return
	 */
	public List<Object> queryTicketsell() {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t.scheduleplanid ")
		.append(" from ticketsell t ")
		.append(" where t.selltime >= (sysdate - 2) and t.customerid>1 ")
		.append(" group by t.scheduleplanid,t.departdate,t.departtime ")
		.append(" order by t.departdate,t.departtime ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}


	/**
	 * 查询售票表和客户表的关联信息
	 */
	public List<Ticketsell> queryTicketsellAndCustomer(long scheduleplanid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t from Ticketsell t,Customer c ")
		.append(" where t.customer.id=c.id ")
		.append(" and t.selltime >= (sysdate - 2) and t.customer.id>1 and t.scheduleplanid=:scheduleplanid order by t.selltime ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("scheduleplanid",scheduleplanid );
		return query.getResultList();
	}

	/**
	 * 查询要更新到customer表中的信息
	 */
	public List<CustomerUpdateVo> queryTicketsellInfo(long scheduleplanid, long customerid) {
		StringBuilder sql = new StringBuilder();
		sql.append(" select t.id,s1.name as departstationname,s2.name as reachstationname,")
		.append(" s3.name as endstationname,sch.code as schcode,v.vehicleno as planvehicleno ")
		.append(" from ticketsell t ")
		.append(" left join station s1 on t.departstationid=s1.id ")
		.append(" left join station s2 on t.reachstationid=s2.id ")
		.append(" left join schedule sch on t.scheduleid=sch.id ")
		.append(" left join route r on sch.routeid=r.id ")
		.append(" left join station s3 on r.endstationid=s3.id ")
		.append(" left join vehiclereport vr on t.vehiclereportid=vr.id ")
		.append(" left join vehicle v on vr.vehicleid=v.id ")
		.append(" where t.scheduleplanid=:scheduleplanid and t.customerid=:customerid and t.selltime >= (sysdate - 2) order by t.selltime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString(), CustomerUpdateVo.class);
		query.setParameter("scheduleplanid",scheduleplanid );
		query.setParameter("customerid",customerid);
		return query.getResultList();
	}



}
