package cn.nova.bus.pack.dao;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.balance.model.Balance;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.model.Packarriver;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packfee;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {

		StringBuffer sql = new StringBuffer("select ")
				.append("0 as ischoose ,p.id,p.packtype,p.goodtype,p.sendstationid,p.tostationid,p.name,")
				.append("p.scheduleid,p.vehicleid,p.departdate,p.packno,p.invoiceno,p.sellby,")
				.append("p.pieces,p.weight,p.volume,p.packed,p.shipprice,p.packfee,p.handfee,p.unloadfee,")
				.append("p.custodial,p.transitfee,p.insuredamount,p.insurancefee,p.insurance,")
				.append("p.deliveryfee,p.otherfee,p.totalfee,p.location,p.packprice,p.sender,")
				.append("p.senderphone,p.senderaddress,p.consignee,p.consigneephone,p.consigneeaddress,")
				.append("p.certificatetype,p.certificateno,p.shiptype,p.paymethod,p.valuables,p.status,")
				.append("p.packtturnoverid,p.remak,p.orgid,p.createtime,p.createby,p.updatetime,p.updateby,p.integraterprice,p.servicefee,")
				.append("f.name as sendstationname,e.name as tostationname,s.code as schedulecode,cast(s.starttime as varchar2(5)) as departtime,v.vehicleno as vehiclecode,")
				.append(" c.name as sellbyname,u.name as updatebyname,")
				.append(" p.signby,us.name as signbyname,p.signtime,p.onlycode,p.synccode,org.name orgname")
				.append(" ,cnt.id as clientid ,cnt.mobilephone,cnt.name as clientname,cnt.address as clientaddress,")
				.append(" cnt.code as clientcode,cnt.integrater as clientintegrater,cnt.type as clienttype,p.singbillno,")
				.append(" p.zhuanyuntostationid,zy.name zhuanyuntostationname,p.takename,p.takecertificateno,dd.value as vcstatus,p.balancestatus as balancestatus,p.collectstatus as collectstatus,p.recyclestatus as recyclestatus,p.goodsstatus as goodsstatus,dd2.value as packedname")
				.append(" ,dd3.value as locationname, ")
				.append(" p.sendercertificatetype,p.sendercertificateno ")  //托运人证件类型，  托运人证件号码
				.append(" from pack p")
				.append(" left join Station f on f.id=p.sendstationid")
				.append(" left join Station e on e.id=p.tostationid")
				.append(" left join Station zy on zy.id=p.zhuanyuntostationid")
				.append(" left join Schedule s on s.id=p.scheduleid ")
				.append(" left join Vehicle v on v.id=p.vehicleid")
				.append(" left join Unit ut on ut.id=v.unitid")
				.append(" left join Userinfo c on c.id=p.sellby ")
				.append(" left join Userinfo u on u.id=p.updateby")
				.append(" left join Userinfo us on us.id=p.signby")
				.append(" left join Client cnt on cnt.id=p.clientid")
				.append(" ,Organization org, digitaldictionary d,digitaldictionarydetail dd ,digitaldictionary d2,digitaldictionarydetail dd2,digitaldictionary d3,digitaldictionarydetail dd3  where 1=1 and org.id=p.orgid ")
				.append(" and d.id=dd.digitaldictionaryid and d.tablename='pack' and d.columnname='status'  and p.status=dd.code")
				.append(" and d2.id=dd2.digitaldictionaryid and d2.tablename='pack' and d2.columnname='packed' and p.packed=dd2.code")
				.append(" and d3.id=dd3.digitaldictionaryid and d3.tablename='pack' and d3.columnname='location' and p.packed=dd3.code")
				.append(PropertyFilter.toJpql(propertyFilters, true))
//				.append(" and p.status <> 3 ")
				.append(" order by case vcstatus when '发货库存' then 1 when '到货库存' then 2 end,createtime desc");
  
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> list = query.getResultList();
		return list;
	}

	/**
	 * 作废操作
	 * 
	 * @param pack
	 * @param userid
	 * @return
	 * @throws ServiceException
	 */
	public boolean wastePack(Pack pack, long userid) {
		StringBuffer sb = new StringBuffer(
				"update Pack set status=:status,updateby=:updateby,updatetime=:updatetime where id=:id");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("status", pack.getStatus());
		query.setParameter("updateby", userid);
		query.setParameter("updatetime", pack.getUpdatetime());
		query.setParameter("id", pack.getId());

		return query.executeUpdate() > 0 ? true : false;
	}

	/**
	 * 根据起点站至终点站获取最大里程数
	 * 
	 * @param propertyFilters
	 * @return
	 */
	public Object queryDistance(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer(
				"select max(t.distance) from Route r, Routestop t, Station s")
				.append(" where r.id = t.route.id and r.isactive = 1 and t.stationid = s.id and t.isactive = 1");

		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		sb.append(" group by s.name");
		Query query = getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> o = query.getResultList();
		if (o == null || o.size() <= 0) {
			return 0;
		} else {
			return o.get(0);
		}
	}

	/**
	 * 根据里程数件数重量查找托运费
	 * 
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Packfee> getShipprice(long orgid, String feecode ,int distance) {
		/*
		StringBuffer sb = new StringBuffer(" select p from Packfee p where (")
				.append("(p.fromdistance<=:distance and p.todistance>=:distance)")
				.append(" or p.todistance =(select max(p2.todistance) from Packfee p2 where p2.packfeetypeid=p.packfeetypeid and p2.fromdistance<=:distance and p2.orgid=:orgid)")
				.append(")")
				.append(" and (")
				.append("( p.fromweight<=:weight and p.toweight>=:weight)")
				.append(" or p.toweight =(select max(p3.toweight) from Packfee p3 where p3.packfeetypeid=p.packfeetypeid and p3.fromweight<=:weight and p.todistance=p3.todistance and p3.orgid=:orgid)")

				.append(")").append(" and p.orgid=:orgid and ");
         */
		StringBuffer sb = new StringBuffer("select p")
		.append(" from Packfee p,  Packfeetype pt ")
		.append(" where pt.orgid = p.orgid and p.packfeetypeid = pt.id")
		.append(" and pt.code=:feecode and  p.orgid=:orgid and p.fromdistance<=:distance and p.todistance>=:distance")
		.append(" order by p.fromdistance");
		
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("distance", distance);
		//query.setParameter("weight", BigDecimal.valueOf(weight));
		query.setParameter("orgid", orgid);
		query.setParameter("feecode", feecode);
		List<Packfee> list = query.getResultList();
		return list;
	}

	@SuppressWarnings("unchecked")
	public List<Object> queryschedule(String param,
			List<PropertyFilter> propertyFilters) {

		/*
		 * StringBuffer sb = new StringBuffer(); sb.append(
		 * "select distinct s2.id,s2.code as name,r.name as code,s.departdate,trim(ss.departtime) as departtime"
		 * ); sb.append(
		 * ", (case nvl(v.isdeparted,ss.isdeparted) when 1 then '是' when 0 then '否' end) as isdeparted "
		 * );
		 * sb.append(", (case ss.status when '0' then '正常' when '1' then '报停'");
		 * sb.append(" when '2' then '晚点' when '3' then '被并'"); sb.append(
		 * " when '4' then '脱班' when '5' then '停售' end) as statusvalue,vc.id as vehicleid,vc.vehicleno,v.id as vehportid,ss.id as schstatusid"
		 * ); sb.append(
		 * "  from Scheduleplan s left join Vehiclereport v on s.id=v.scheduleplanid left join Vehicle vc on vc.id=v.vehicleid,Schedule s2,Route r,Routestop rt,Schedulestatus ss "
		 * ); sb.append(
		 * " where s2.id=s.scheduleid and rt.routeid =s2.routeid and r.id=s2.routeid and ss.scheduleplanid=s.id"
		 * ); sb.append(" ");
		 * sb.append(" and nvl(v.isdeparted,ss.isdeparted)<>1");
		 */
		// sb.append(" and rt.stationid=:stationid and s.departdate=:departdate");

		StringBuffer sb = new StringBuffer();
		// sb.append("select s.id, st.name, s.code, trim(ss.departtime)")
		// .append("  from ticketprice tp, schedule s, schedulestatus ss, station st")
		// .append(" where tp.scheduleid = s.id and tp.scheduleplanid = ss.scheduleplanid")
		// .append("  and tp.departdate = ss.departdate  and tp.reachstationid = st.id");
		// sb.append(" and (s.code like '%").append(param)
		// .append("%' or st.name like '%").append(param)
		// .append("%' or st.jianpin like '%").append(param).append("%')");
		// sb.append(PropertyFilter.toJpql(propertyFilters, true))
		// .append(" order by ss.departtime");

		sb.append(
				" select s.id,'',s.code,trim(ss.departtime), v.id vehicleid, v.vehicleno vehicleno ,st.id stationid, st.name stationname,s.routeid routeid,r.name routename ")
				.append(" from schedule s, schedulestatus ss, scheduleplan sp left join vehiclereport vp on vp.scheduleplanid = sp.id ")
				//.append(" vehiclereport vp  ")
				.append(" left join vehicle v on vp.vehicleid = v.id , route r,station st, schedulestop rs  ")
				.append(" where s.id = ss.scheduleid and s.id = sp.scheduleid and ss.scheduleplanid = sp.id and rs.scheduleid=s.id ")
				.append(" and s.routeid = r.id and rs.stationid = st.id")
				.append(" and ss.status <> '1' ")
				.append(" and r.isactive=1 and st.isactive=1  and s.isactive=1 and (st.name like '%"
						+ param
						+ "%' or s.code like '%"
						+ param
						+ "%' or st.jianpin like '%" + param + "%')");
		// .append("%' or st.name like '%").append(param)
		// .append("%' or st.jianpin like '%").append(param).append("%')");
		sb.append(PropertyFilter.toJpql(propertyFilters, true)).append(
				" order by ss.departtime");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Object> result = query.getResultList();

		return result;
	}

	/**
	 * 查找与登陆站点相关联的站点
	 * 
	 * @param param
	 * @param orgid
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> querystation(String param, long stationid,long routeid) {
		StringBuffer sql = new StringBuffer();
		sql.append("select distinct t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade from Station t,Routestop rt where t.isactive=1 and t.id=rt.stationid");
		sql.append(" and rt.route.id in(");
		sql.append(" select distinct rt.route.id  from Routestop rt where rt.isactive = 1 and rt.stationid=:stationid )");
		sql.append(" and (t.name like '%").append(param)
				.append("%' or t.jianpin like '%").append(param)
				.append("%' or t.helpcode like '%").append(param).append("%')");
		if(routeid>0){
			sql.append(" and rt.route.id = "+routeid);
		}
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("stationid", stationid);

		List<Object> result = query.getResultList();
		return result;

	}

	/**
	 * 修改行包领用票据
	 * 
	 * @param recipients
	 * @param status
	 * @param nextno
	 * @return
	 * @throws ServiceException
	 */
	public boolean updateBillinuse(long recipients, String billtypecode,
			String status, long nextno, long nextform) {
		StringBuffer sb = new StringBuffer(
				"update Billinuse set status=:status,nextno=:nextno where recipients=:recipients");
		sb.append(" and nextno=:nextform and status=1 and billtypeid =(select bt.id from Billtype bt");
		sb.append(" where bt.code=:billtypecode)");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("status", status);
		query.setParameter("nextno", nextno);
		query.setParameter("recipients", recipients);
		query.setParameter("billtypecode", billtypecode);
		query.setParameter("nextform", nextform);
		int res = query.executeUpdate();
		// if(status.equals("2")){
		// sb = new StringBuffer(
		// "update Billinuse set status=:status,nextno=:nextno where recipients=:recipients");
		// sb.append(" and status=0 and billtypeid =(select bt.id from Billtype bt");
		// sb.append(" where bt.code=:billtypecode)");
		// }
		return res > 0 ? true : false;
	}

	/**
	 * 查找客户
	 * 
	 * @param param
	 * @param propertyFilters
	 * @return 
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryclient(String param,
			List<PropertyFilter> propertyFilters) {

		StringBuffer sb = new StringBuffer();
		sb.append("select cnt.id,cnt.name,cnt.code,cnt.mobilephone");
		sb.append(", (case cnt.type when '1' then cnt.contacter else cnt.name end) as contacter ,cnt.address,cnt.type,cnt.integrater");
		sb.append("  from Client cnt");
		sb.append(" where 1=1");
		sb.append(" and (cnt.code like '%").append(param)
		// .append("%' or r.code like '%").append(param)
		//.append("%' or cnt.name like '%").append(param)
		// .append("%' or r.jianpin like '%").append(param)
				.append("%')");
		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		Query query = getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> result = query.getResultList();

		return result;
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryTotal(float balancefeerate,Date startdate,Date enddate,long scheduleid,String isbukai) {
		if(isbukai.equals("1")){//补开
			StringBuffer sb = new StringBuffer("select p.* from Pack p where 1=1 and p.status='1' ");
			sb.append(" and p.id not in(select pdp.packid from packdepartinvoicespack pdp) ");
			sb.append(" and p.departdate>=:startdate and p.departdate<=:enddate").append(" and p.scheduleid=").append(scheduleid);
			StringBuffer sql = new StringBuffer("select ")				
					.append(" p.tostationid,e.name as tostationname,p.packno,f.name as sendstationname, sum(p.pieces) pieces,sum(p.shipprice) shipprice,sum(p.packfee) packfee,sum(p.handfee) handfee, ")
					.append(" sum(p.transitfee) transitfee,sum(p.insuredamount) insuredamount,sum(p.insurancefee) insurancefee,sum(p.insurance) insurance,sum(p.deliveryfee) deliveryfee,")
					.append(" sum(p.otherfee) otherfee,sum(p.totalfee) totalfee,sum(p.packprice) packprice,sum(p.shipprice)*").append(balancefeerate).append(" balancefeecountmoney,p.sendstationid,p.id as packid,sum(p.custodial) custodial,sum(p.servicefee) servicefee ").append(" from (")
					.append(sb.toString()).append(") p")
					.append(" left join Station f on f.id=p.sendstationid")
					.append(" left join Station e on e.id=p.tostationid")
					.append(" left join Schedule s on s.id=p.scheduleid ")
					.append(" left join Vehicle v on v.id=p.vehicleid")
					.append(" left join Userinfo c on c.id=p.updateby ")
					.append(" left join Userinfo u on u.id=p.updateby")
					.append(" left join Userinfo us on us.id=p.signby")
					.append(" left join Client cnt on cnt.id=p.clientid")
					.append(" ,Organization org where org.id=p.orgid ")
	                .append(" group by p.tostationid,e.name,p.packno,f.name,p.sendstationid,p.id");

			Query query = getEntityManager().createNativeQuery(sql.toString());
			query.setParameter("startdate", startdate);
			query.setParameter("enddate", enddate);

			List<Object> list = query.getResultList();
			return list;
		}else{
		StringBuffer sb = new StringBuffer("select p.* from Pack p where 1=1 and p.status='1' ");
		sb.append(" and p.id not in(select pdp.packid from packdepartinvoicespack pdp) ");
		sb.append(" and p.departdate>=:startdate and p.departdate<=:enddate").append(" and p.scheduleid=").append(scheduleid);
		StringBuffer sql = new StringBuffer("select ")				
				.append(" p.tostationid,e.name as tostationname,p.packno,f.name as sendstationname, sum(p.pieces) pieces,sum(p.shipprice) shipprice,sum(p.packfee) packfee,sum(p.handfee) handfee, ")
				.append(" sum(p.transitfee) transitfee,sum(p.insuredamount) insuredamount,sum(p.insurancefee) insurancefee,sum(p.insurance) insurance,sum(p.deliveryfee) deliveryfee,")
				.append(" sum(p.otherfee) otherfee,sum(p.totalfee) totalfee,sum(p.packprice) packprice,sum(p.shipprice)*").append(balancefeerate).append(" balancefeecountmoney,p.sendstationid,p.id as packid,sum(p.custodial) custodial,sum(p.servicefee) servicefee ").append(" from (")
				.append(sb.toString()).append(") p")
				.append(" left join Station f on f.id=p.sendstationid")
				.append(" left join Station e on e.id=p.tostationid")
				.append(" left join Schedule s on s.id=p.scheduleid ")
				.append(" left join Vehicle v on v.id=p.vehicleid")
				.append(" left join Userinfo c on c.id=p.updateby ")
				.append(" left join Userinfo u on u.id=p.updateby")
				.append(" left join Userinfo us on us.id=p.signby")
				.append(" left join Client cnt on cnt.id=p.clientid")
				.append(" ,Organization org where org.id=p.orgid ")
                .append(" group by p.tostationid,e.name,p.packno,f.name,p.sendstationid,p.id");

		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);

		List<Object> list = query.getResultList();
		return list;
	   }
	}
	/**
	 * 查询已经提领出库的行包
	 * @param packarriverno
	 * @param arriverdate
	 * @param unitid
	 * @param vehicleid
	 * @param arriverenddate
	 * @param ids 
	 * @param status 
	 * @return
	 */
	public List<Object> qryPackArrive(String packarriverno, Date arriverdate,long vehicleid, Date arriverenddate, String ids, String status) {
		StringBuffer sb = new StringBuffer();
		sb.append(" SELECT pa.packarriverno,s.name  routename,(pa.packfee - pa.servicefee) packfee, pa.packprice, pa.pieces, pa.servicefee, pa.id, ")
		.append(" (pa.packfee + pa.packprice) balancemoney, pa.status , to_char(pb.balancetime,'yyyy-mm-dd hh24:mi:ss'),u.name balanceby, p.status packstatus  ")
		.append("  FROM packarriver pa left join packbalance pb on pa.packbalanceid = pb.id left join pack p on p.id = pa.packid ")
		.append(" left join station s on s.id = pa.sendstationid left join vehicle v on p.vehicleid = v.id left join userinfo u on u.id = pb.balancby")
		.append(" where  p.status in ('2','7')  and  pa.arriverdate >= :arriverdate and pa.arriverdate <= :arriverenddate and pa.id not in  " + ids); 
		if(packarriverno!=null&&packarriverno!=""){
			sb.append(" and pa.packarriverno = "+packarriverno);
		}
		if(vehicleid!=0){
			sb.append(" and p.vehicleid = "+vehicleid);
		}
		if(status!=null && !status.equals("")){
			sb.append(" and pa.status in "+status);
		}
		Query query = getEntityManager().createNativeQuery(sb.toString());
		if(packarriverno!=null&&packarriverno!=""){
			query.setParameter("packarriverno", packarriverno);
		}
		query.setParameter("arriverdate", arriverdate);
		query.setParameter("arriverenddate", arriverenddate);
		List<Object> list = query.getResultList();
		return list;
	}

	public boolean isExistBalancedeNo(String balanceno) {
		StringBuilder sql = new StringBuilder("select d ").append(
				" from PackBalance d").append(" where d.packbalanceno=:balanceno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("balanceno", balanceno);
		List<Object> list = query.getResultList();
		return list != null && list.size() > 0 ? true : false;
	}
	
	public List<Packarriver> qryPackArriveById(String ids) {
		StringBuilder sql = new StringBuilder("select d ").append(
				" from Packarriver d").append(" where d.id  in ("+ids+") ");
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	public List<Object> qryPackBalance(String departinvoicesno,
			Date senddepartdate, Date sendenddate, String status,String ids, long vehicleid,long orgid) {
		  
		
		String parameterValue = new ParameterServiceImpl().findParamValue(ParamterConst.Param_8083,orgid);	//2372 FIX5.2-1 蕲春+前台结算+行包结算单补录	
		
		StringBuilder sql = new StringBuilder();
		
		sql.append(" SELECT pdi.departdate,pdi.departinvoicesno,v.vehicleno,pdi.pieces,pdi.shipprice packmoney,nvl(pdi.totalfee,pdi.shipprice) as totalfee, ")
		.append(" pdi.balanceamount  as balanceamount, ")  //2372 FIX5.2-1 蕲春+前台结算+行包结算单补录
		          .append(" (pdi.balanceamount - pdi.shipprice*("+parameterValue+")) as balanceableamount, ")  //应结算金额
				  .append(" ("+parameterValue+") agentrate,pdi.shipprice*("+parameterValue+") agent, ")
				  .append(" to_char(pb.balancetime,'yyyy-mm-dd hh24:mi:ss'),u.name balanceby,   ")
				  .append(" pdi.status,pdi.id,pdi.packprice,o.name")
				  .append(" FROM packdepartinvoices pdi                                                     ")
				  //.append(" left join packdepartinvoicespack pdip on pdip.packdepartinvoicesid =pdi.id      ")
				  //.append(" left join pack p on p.id = pdip.packid                                          ")
				  .append(" left join vehicle v on pdi.vehicleid = v.id                                       ")
				  //.append(" left join packarriver pa on pa.packid = pdip.packid                             ")
				  .append(" left join packbalance pb on pb.id = pdi.packbalanceid         ")
				  .append(" left join userinfo u on u.id = pb.balancby                                      ")
				  .append(" left join organization o on pdi.printorgid=o.id ")
			.append(" where pdi.departdate >= :senddepartdate and pdi.departdate <= :sendenddate ")
			.append(" and pdi.id not in  " + ids);
		if(departinvoicesno != null && !departinvoicesno.equals("")){
			sql.append(" and pdi.departinvoicesno = '"+departinvoicesno+"' ");
		}
		if(status!=null && !status.equals("")){
			sql.append(" and pdi.status in "+status);
		}
		if(vehicleid>0){
			sql.append(" and v.id = "+vehicleid);
		}
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("senddepartdate", senddepartdate);
		query.setParameter("sendenddate", sendenddate);
		//query.setParameter("ids", ids);
		return query.getResultList();
	}

	public List<Packdepartinvoices> qryPackdepartinvoicesById(String ids) {
		StringBuilder sql = new StringBuilder("select d ").append(
				" from Packdepartinvoices d").append(" where d.id  in ("+ids+")");
		Query query = em.createQuery(sql.toString());
		return query.getResultList();
	}

	public Object qryBalanceByNo(String departinvoicesno, int tflag) {
		if (tflag == 1) {
			StringBuilder sql = null;
			sql = new StringBuilder("select ds").append(
					" from Packdepartinvoices ds").append(
					" where ds.departinvoicesno =:departinvoicesno");
			Query query = em.createQuery(sql.toString());
			query.setParameter("departinvoicesno", departinvoicesno);
			List<Packdepartinvoices> list = query.getResultList();
			return list != null && list.size() > 0 ? list.get(0) : null;
		}else{
			StringBuilder sql = null;
			sql = new StringBuilder("select ds").append(
					" from Packarriver ds").append(
					" where ds.packarriverno =:departinvoicesno");
			Query query = em.createQuery(sql.toString());
			query.setParameter("departinvoicesno", departinvoicesno);
			List<Packarriver> list = query.getResultList();
			return list != null && list.size() > 0 ? list.get(0) : null;
		}
	}

	public PackBalance qryPackBalanceByid(long packbalanceid) {
		StringBuilder sql = null;
		sql = new StringBuilder("select ds")
				.append(" from PackBalance ds")
				.append(" where ds.id =:packbalanceid");
		Query query = em.createQuery(sql.toString());
		query.setParameter("packbalanceid", packbalanceid);
		List<PackBalance> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
	}
	
	public List<Object> findPackInfoByscheduleid(Date startdate,Date enddate,long scheduleid){
		
		StringBuilder sql = null;
		sql = new StringBuilder("select p.status,p.signtime from pack p,schedule s,scheduleplan sp ")
				.append(" where p.scheduleid=s.id and sp.scheduleid=s.id and p.paymethod=1 ")
				.append(" and p.scheduleid=:scheduleid and sp.departdate>=:startdate and sp.departdate<=:enddate ");
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("scheduleid", scheduleid);
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);
		List<Object> list = query.getResultList();
		return list!=null && list.size()>0?list:null;
		
	}

	public Packdepartinvoices qryPackdepartinvoicesByNo(String departinvoicesno) {
		StringBuilder sql = null;
		sql = new StringBuilder("select ds")
				.append(" from Packdepartinvoices ds")
				.append(" where ds.departinvoicesno =:departinvoicesno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("departinvoicesno", departinvoicesno);
		List<Packdepartinvoices> list = query.getResultList();
		return list != null && list.size() > 0 ? list.get(0) : null;
		
	}

	public List<Object> queryPackBalanced(Date senddepartdate,
			Date sendenddate, String status, String packbalanceno,
			String datatype, String unitname) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				" SELECT pa.packbalanceno,trim(CASE pa.datatype WHEN '0' THEN '出库结算' WHEN '1' THEN '前台结算'END) datatype, ")
				.append(" pa.pieces,pa.packnos,pa.packmoney,pa.packprice,pa.packbalancemoney,u.name balancby ,pa.balancetime, ")
				.append(" trim(CASE pa.cancelby WHEN 0 THEN '' else u1.name END) cancelby," )
				.append(" pa.cleartime,trim(CASE pa.status WHEN '0' THEN '正常' WHEN '1' THEN '注销'END) status,pa.id ")
				.append(" FROM packbalance pa left join userinfo u on u.id = pa.balancby	left join userinfo u1 on u1.id = pa.cancelby ")
				.append(" where pa.balancetime >= :senddepartdate and pa.balancetime <= :sendenddate ");
		if (datatype != null && datatype != "") {
			sql.append("and pa.datatype = " + datatype);
		}
		if (status != null && status != "") {
			sql.append(" and pa.status in " + status);
		}
		if (packbalanceno != null && packbalanceno != "") {
			sql.append(" and pa.packbalanceno = " + packbalanceno);
		}
		if (unitname != "" && unitname != null) {
			sql.append(" and pa.balanceunitname = " + unitname);
		}
		Query query = em.createNativeQuery(sql.toString());
		query.setParameter("senddepartdate", senddepartdate);
		query.setParameter("sendenddate", sendenddate);
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Object> qryDetail(long packbalanceid) {
		StringBuilder sql = new StringBuilder();
		sql.append(
				"SELECT tt.pdate,tt.pno,tt.station,tt.pieces,tt.packfee,tt.packprice,tt.balanceamount,tt.datatype from ")
				.append(" (SELECT pdi.departdate pdate,pdi.departinvoicesno pno,st.name station,pdi.pieces,pdi.packfee, ")
				.append(" pdi.packprice, pdi.balanceamount,pdi.packbalanceid,trim(CASE pdi.datatype WHEN '0' THEN '微机单' WHEN '1' THEN '手工单'END) datatype")
				.append(" FROM packdepartinvoices pdi left join packbalance pa on pdi.packbalanceid = pa.id ")
				.append(" left join schedule s on pdi.scheduleid = s.id left join route r on r.id = s.routeid ")
				.append(" left join station st on st.id = r.endstationid ")
				.append(" union all ")
				.append(" SELECT p.arriverdate pdate, p.packarriverno pno, s.name  station,p.pieces,(p.packfee + p.servicefee) packfee, ")
				.append(" p.packprice,(p.packfee + p.servicefee + p.packprice) balanceamount, p.packbalanceid,'' datatype")
				.append(" FROM packarriver p left join packbalance pa on p.packbalanceid = pa.id ")
				.append(" left join station s on s.id = p.sendstationid) tt ")
				.append(" where tt.packbalanceid = " + packbalanceid);
		Query query = em.createNativeQuery(sql.toString());
		List<Object> list = query.getResultList();
		return list;
	}

	public List<Packarriver> qryPackarriverByPackbalanceid(Long packbalanceid) {
		StringBuilder sql = new StringBuilder();
			sql.append("SELECT p FROM Packarriver p ,PackBalance pa where p.packbalanceid = pa.id  and pa.id = "
					+ packbalanceid);
			Query query = em.createQuery(sql.toString());
			return query.getResultList();
	}
	public List<Packdepartinvoices> qryPackdepartinvoicesByPackbalanceid(Long packbalanceid) {
		StringBuilder sql = new StringBuilder();
	sql.append("SELECT p FROM Packdepartinvoices p , PackBalance pa where p.packbalanceid = pa.id and pa.id = "
			+ packbalanceid);
	Query query = em.createQuery(sql.toString());
	return query.getResultList();
	}
	
	public List<Object> qryPackMonthBalance(List<PropertyFilter> propertyFilters) {

		StringBuffer sql = new StringBuffer("select p.departdate as departdate, ");
		sql.append(" sum(case when p.datatype = '1' then p.BALANCEAMOUNT  else 0 end) as packdepartinvoicesother, ")//1:手工单
			.append(" sum(case when p.datatype = '0' then p.BALANCEAMOUNT else  0 end) as packdepartinvoices, ")//0:微机单
			.append(" sum(p.BALANCEAMOUNT) as totalfee ")
			.append(" from packdepartinvoices p where p.isaudit = 1 ");
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
		sql.append(" group by p.departdate ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> list = query.getResultList();
		return list;
	}
	public List<Object> qryPackDayBalance(List<PropertyFilter> propertyFilters) {

		StringBuffer sql = new StringBuffer()
				.append("select p.datatype as datatype,p.departinvoicesno as departinvoicesno,")
				.append(" p.balanceamount    as balanceamount,case when p.isaudit = 1 then  P.BALANCEAMOUNT else null end  as shenhejine,")
				.append("  p.isaudit          as isaudit   from packdepartinvoices p")
				.append(" where 1=1 ");
			
		sql.append(PropertyFilter.toJpql(propertyFilters, true));
				
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> list = query.getResultList();
		return list;
	}

	

	public Packdepartinvoices qryPackDayBalancequery(String departinvoicesno) {

		StringBuffer sql = new StringBuffer()
				.append("select p.id as id,p.departinvoicesno as departinvoicesno,p.scheduleplanid as scheduleplanid ,p.departdate as departdate")
				.append(",p.scheduleid as scheduleid ,p.departtime  as departtime  ,p.vehicleid  as vehicleid")
				.append(",p.reportid as reportid  ,p.printorgid as printorgid,p.printip  as printip ,p.printby as printby,p.printtime  as printtime")
				.append(",p.pieces as pieces  ,p.shipprice as shipprice,p.packfee as packfee ,p.handfee as handfee ")
				.append(",p.custodial as custodial,p.transitfee as transitfee  ,p.insuredamount as insuredamount  ,p.insurancefee  as insurancefee,p.deliveryfee as deliveryfee ")
				.append(",p.otherfee  as otherfee,p.packprice as packprice,p.servicefee as servicefee  ,p.totalfee  as totalfee,p.balanceamount as balanceamount")
				.append(",p.cancelstationid  as cancelstationid,p.cancelby  as cancelby,p.canceltime as canceltime  ,p.status as status  ,p.packbalanceid as packbalanceid")
				.append(",p.printway  as printway,p.datatype  as datatype,p.createtime as createtime  ,p.createby  as createby")
				.append("  from packdepartinvoices p")
				.append(" where p.departinvoicesno = '" + departinvoicesno +"'");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		List<Packdepartinvoices> list = query.getResultList();
		if (list!=null&&list.size()>0) {
			return list.get(0);
		}
		return null;
	}
//	findPackinfoByid

	public List<Object> findPackinfoByid(long departinvoiceid) {
		StringBuffer sb =  new StringBuffer();
		sb.append("  select p from Pack p, Packdepartinvoicespack pt where p.id = pt.packid and pt.packdepartinvoicesid ='"+departinvoiceid+"'");
		
		Query query = getEntityManager().createQuery(sb.toString());
		List<Object> list = query.getResultList();
		if (list!=null&&list.size()>0) {
			return list;
		}
		
		return null;
	}
	/**
	 * 公共方法 查询行包营收
	 * @param acceptby
	 * @param date
	 * @return
	 */
	public Packtturnoverdetail getPacktturnoverdetail(long acceptby, Date date) {
		StringBuffer sb =  new StringBuffer();
		sb.append("  select p from Packtturnoverdetail p where p.createtime between :date and :date +0.99999 and p.createby = :acceptby order by p.createtime desc");
		
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("acceptby", acceptby);
		query.setParameter("date", date);
		List<Object> list = query.getResultList();
		if (list!=null&&list.size()>0) {
			return (Packtturnoverdetail) list.get(0);
		}
		return null;
	}
}
