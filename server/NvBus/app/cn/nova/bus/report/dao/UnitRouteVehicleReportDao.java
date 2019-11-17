package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：发班运量统计表</b><br/>
 * <b>类名称：</b>UnitRouteVehicleReportDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">黄浩泽</a><br/>
 * <b>创建时间：</b>2012-4-28  <br/>
 * <b>关键修改：1:添加车牌查询条件，更正座位利用率不对的情况</b><br/>
 * <b>    2:添加统计方式：按车牌和线路统计</b><br/>
 * <b>    3:添加统计方式：按发车日期统计。添加查询条件：运行区域</b><br/>
 * <b>修改时间：2013-03-21</b><br/>
 * <b>修改人：黄浩泽</b><br/>
 * <b>关键修改： 1.添加统计方式：按车属单位和线路统计</b><br/>
 * <b>          2.查询条件增加单位类型           </b><br/>
 * <b>修改时间：2016-07-13</b><br/>
 * <b>修改人：遥路</b><br/>
 */
@SuppressWarnings("rawtypes")
public class UnitRouteVehicleReportDao extends EntityManagerDaoSurport{	
	
	/**
	 * 机构，线路，车辆 统计分析表
	 * @param orgids
	 * @param startdate
	 * @param enddate
	 * @param groupby:统计方式  (1:结算单位线路，2：线路车辆，3：线路和发车时间,4车辆线路，5发车日期，6车属单位线路)
	 * @param vehicleid
	 * @param districttype:班次运行区域
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryUnitRouteVehicleReport(
			String orgids, Date startdate,Date enddate,String groupby,long vehicleid,String districttype,String type,String vehicleunitid) {
		StringBuffer sql=new StringBuffer("select ");
		//按线路和结算单位统计
		if(groupby.equals("1")){
			sql.append("decode(grouping(rname)+grouping(unitname) , 1, '小计',2, '合计', rname) rname,")
			.append("decode(grouping(unitname) + grouping(rname),1, '', unitname) unitname,");
		}
		//按线路和车牌统计
		if(groupby.equals("2")){
			sql.append("decode(grouping(rname)+ grouping(vehicleno) ,1, '小计',2, '合计', rname) rname,")
			.append("decode(grouping(rname)+ grouping(vehicleno) , 1, '', vehicleno) vehicleno,");
		}
		//按线路和班次发车时间统计
		if(groupby.equals("3")){
			sql.append("decode(grouping(rname)+ grouping(starttime) ,1, '小计',2, '合计', rname) rname,")
			.append("decode(grouping(rname)+ grouping(starttime) , 1, '', starttime) starttime,");
		}
		//按车牌和线路统计
		if(groupby.equals("4")){
			sql.append("decode(grouping(vehicleno)+ grouping(rname) ,1, '小计',2, '合计', vehicleno) vehicleno,")
			.append("decode(grouping(vehicleno)+ grouping(rname) , 1, '', rname) rname,");
		}
		//按发车日期统计
		if(groupby.equals("5")){
			sql.append("decode(grouping(departdate),1, '合计',to_char(departdate,'yyyy-mm-dd')) departdate,")
			.append(" '' rname,");
		}
		//按车属单位和线路统计
		if(groupby.equals("6")){
			sql.append("decode(grouping(rname)+grouping(carunitname) , 1, '小计',2, '合计', rname) rname,")
			.append("decode(grouping(carunitname) + grouping(rname),1, '', carunitname) carunitname,");
		}
		//按按线路和班线类别统计
		if(groupby.equals("7")){
			sql.append("decode(grouping(rname)+ grouping(sctype) ,1, '小计',2,'合计', rname) rname,")
			.append("decode(grouping(rname)+ grouping(sctype) , 1, '',2,'', decode(sctype,1,'豪华',2,'空调',3,'卧铺','普通')) sctype,");
		}
		if(groupby.equals("8")){
			sql.append("decode(grouping(unitname)+grouping(rname) , 1, '小计',2, '合计', unitname) unitname,")
			.append("decode(grouping(unitname) + grouping(rname),1, '', rname) rname,");
		}
			sql.append("nvl(sum(invoicesnonum), 0),")
			.append("nvl(sum(schedulenum), 0),")
			.append("nvl(sum(ticketnum), 0),")
			.append("nvl(sum(totalamount), 0),")
			.append("nvl(sum(stationservicefee), 0),")
			.append("nvl(sum(computefee), 0),")
			.append("nvl(sum(coolairfee), 0),")
			.append("nvl(sum(additionfee), 0),")
			.append("nvl(sum(fueladditionfee), 0),")
			.append("nvl(sum(waterfee), 0),")
			.append("nvl(sum(insurefee), 0),")
			.append("nvl(sum(otherfee), 0),")
			.append("nvl(sum(basemount), 0),")
			.append("nvl(sum(agentfee), 0),")
			.append("nvl(sum(income), 0),")
			.append("nvl(sum(balanceamount), 0),")
			.append("nvl(sum(peopledistance), 0) peopledistance,")
			.append("nvl(sum(moreprice), 0),")
			.append("nvl(sum(subtotal), 0),")
			.append("nvl(sum(seats), 0),")
			.append("nvl((case sum(needpeopledistance)")
			.append(" 	when 0 then '0' else")
			.append(" 	(to_char(sum(peopledistance) * 100 / sum(needpeopledistance),")
			.append(" 	'990.99')) end),0) || '%' as rate,")
			.append("nvl((case sum(seats)")
			.append(" when 0 then '0' else")
			.append(" (to_char(sum(ticketnum) * 100 / sum(seats), '990.99'))")
			.append(" end) ,0)|| '%' as seatrate,")
			.append(" nvl(sum(overtime), 0),")
			.append("nvl(sum(needschedulenum), 0),")
			.append("nvl(sum(needpeopledistance), 0),");
			if (groupby.equals("1")){
				sql.append("decode(grouping(unitname) + grouping(rname),");
			}
			if (groupby.equals("2")){
				sql.append("decode(grouping(rname) + grouping(vehicleno),");
			}
			if (groupby.equals("3")){
				sql.append("decode(grouping(rname) + grouping(starttime),");
			}
			if (groupby.equals("4")){
				sql.append("decode(grouping(vehicleno) + grouping(rname),");
			}
			if (groupby.equals("5")){
				sql.append("decode(grouping(departdate),");
			}
			if (groupby.equals("6")){
				sql.append("decode(grouping(carunitname) + grouping(rname),");
			}
			if (groupby.equals("7")){
				sql.append("decode(grouping(rname) + grouping(sctype),");
			}
			if (groupby.equals("8")){
				sql.append("decode(grouping(rname) + grouping(unitname),");
			}
			sql.append(" 1, '',nvl(sum(distance)/( case sum(invoicesnonum) when 0 then 1 else sum(invoicesnonum) end ),0)) routedistance")
			.append(" ,null comments ")
			.append(" from (select bs.scorgname,")//查询流水班
			.append(" bs.departdate,bs.rname,bs.type sctype, bs.unitname,bs.carunitname,bs.vehicleno,");       
			if(groupby.equals("3") || groupby.equals("5")){
				sql.append("s.starttime,");
			}
					sql.append("bs.seats,")
					.append("bs.needschedulenum,")
					.append("bs.needpeopledistance,")
					.append("nl.distance,")
					.append("nl.schedulenum,")
					.append("nl.overtime,")
					.append("nl.invoicesnonum,")
					.append("nl.ticketnum,")
					.append("nl.totalamount,")
					.append("nl.stationservicefee,")
					.append("nl.computefee,")
					.append("nl.coolairfee,")
					.append("nl.additionfee,")
					.append("nl.fueladditionfee,")
					.append("nl.waterfee,")
					.append("nl.insurefee,")
					.append("nl.otherfee,")
					.append("nl.basemount,")
					.append("nl.agentfee,")
					.append("nl.income,")
					.append("nl.balanceamount,")
					.append("nl.peopledistance,")
					.append("nl.moreprice,")
					.append("nl.waterfee + nl.insurefee + nl.otherfee")
					.append("+ nl.fueladditionfee + nl.stationservicefee")
					.append("+ nl.additionfee + nl.computefee + nl.coolairfee subtotal")
					.append(" from (select sco.name scorgname,")//查询流水班计划情况
					.append(" sp.departdate,r.name rname,r.id routeid,sc.type,u.name unitname,cu.name carunitname,v.vehicleno,");
					if(groupby.equals("3") || groupby.equals("5")){                       
						sql.append("sc.id scheduleid,");
					}
							sql.append("sum(v.seatnum) seats,")
							.append("count(vp.vehicleid) needschedulenum,")
							.append("sum(v.seatnum * r.distance) needpeopledistance")
							.append(" from schedulestatus ss,")
									.append("scheduleplan   sp,")
									.append("vehiclereport  vp,")
									.append("vehicle        v,")
									.append("unit           u,")
									.append("unit          cu,")       
									.append("schedule       sc,")
									.append("route          r,")
									.append("organization   sco")
									.append(" where ss.scheduleplanid = sp.id")
									.append(" and ss.scheduleid = sc.id")
									.append(" and sc.routeid = r.id")
									.append(" and sc.islinework = 1")
									.append(" and sc.districttype in " + districttype)
									.append(" and sp.id = vp.scheduleplanid")
									.append(" and vp.isactive = 1")									
									.append(" and ss.departstationid=sco.stationid")
									.append(" and vp.vehicleid = v.id");
									//.append(" and vp.isdeparted=1");									
									if(vehicleid!=0){
										sql.append(" and v.id="+vehicleid);
									}								
									sql.append(" and v.balanceunitid = u.id")
									.append(" and v.unitid = cu.id ")            
								//	.append(" and sc.orgid = sco.id") 集中式数据库时 两个机构共用一个班次时防止单独查询配载站的数据差不到
									.append(" and ss.departdate=sp.departdate ")
									.append(" and sp.departdate between :startdate and :enddate")
									.append(" and sco.id in "+orgids);
									if (type != null && !type.equals("")) {
               				         sql.append(" and cu.type =" + type);                                              //+1s
			                         }
									
									if(vehicleunitid!=null&&!vehicleunitid.equals("")){
										sql.append(" and u.id = " + vehicleunitid);
									}
									sql.append(" group by sco.name,")
									.append(" sp.departdate,r.name,r.id,sc.type, u.name,cu.name, v.vehicleno ");
									if(groupby.equals("3") || groupby.equals("5")){
										sql.append(", sc.id ) bs left join ");
									}else{
										sql.append(" ) bs left join ");
									}
									sql.append("(select sco.name scorgname,")//查询流水班次的实际运量情况
										.append("dv.departdate,r.name rname,r.id routeid,u.name unitname,v.vehicleno,");
									if(groupby.equals("3") || groupby.equals("5")){
										sql.append(" s.id scheduleid,");
									}										
										sql.append("sum(r.distance) distance,count(distinct dv.reportid) as schedulenum,")
										.append("sum(case  when s.isovertime = 1 then 1 else 0 end) overtime,")
										.append("count(distinct dv.departinvoicesno) as invoicesnonum,")
										.append("sum(dv.ticketnum) as ticketnum,")
										.append("sum(dv.totalamount) as totalamount,")
										.append("sum(dv.stationservicefee) as stationservicefee,")
										.append("sum(nvl((select sum(dd.deductmoney)")
										.append(" from departinvoicesdeductdetail dd,")
									    .append(" balancedeductitem          a")
									    .append(" where dd.departinvoicesid = dv.id")
									    .append(" and dd.balanceitemid = a.id")
									    .append(" and dd.status <> '1'")
									    .append(" and a.name like '%微机费%'),")
									    .append("0)) computefee,")
									    .append("sum(nvl((select sum(dd.deductmoney)")
										.append(" from departinvoicesdeductdetail dd,")
										.append(" balancedeductitem          a")
										.append(" where dd.departinvoicesid = dv.id")
										.append(" and dd.balanceitemid = a.id")
										.append(" and dd.status <> '1'")
										.append(" and a.name like '%空调费%'),")
										.append("0)) coolairfee,")
										.append("sum(nvl((select sum(dd.deductmoney)")
										.append(" from departinvoicesdeductdetail dd,")
										.append(" balancedeductitem          a")
										.append(" where dd.departinvoicesid = dv.id")
										.append(" and dd.balanceitemid = a.id")
										.append(" and dd.status <> '1'")
										.append(" and a.name like '%附加费%'),")
										.append("0)) additionfee,")
										.append("sum(dv.fueladditionfee) as fueladditionfee,")
										.append("sum(nvl((select sum(dd.deductmoney)")
										.append(" from departinvoicesdeductdetail dd,")
										.append(" balancedeductitem          a")
										.append(" where dd.departinvoicesid = dv.id")
										.append(" and dd.balanceitemid = a.id")
										.append(" and dd.status <> '1'")
										.append(" and a.name like '%水费%'),")
										.append("0)) waterfee,")
										.append("sum(nvl((select sum(dd.deductmoney)")
										.append(" from departinvoicesdeductdetail dd,")
										.append(" balancedeductitem          a")
										.append(" where dd.departinvoicesid = dv.id")
										.append(" and dd.balanceitemid = a.id")
										.append(" and dd.status <> '1'")
										.append(" and a.name like '%保险费%'),")
										.append("0)) insurefee,")
										.append("sum(nvl((select sum(dd.deductmoney)")
										.append(" from departinvoicesdeductdetail dd,")
										.append(" balancedeductitem          a")
										.append(" where dd.departinvoicesid = dv.id")
										.append(" and dd.balanceitemid = a.id")
										.append(" and dd.status <> '1'")
										.append(" and (a.name like '%其他%' or a.name like '%其它%') ),")
										.append("0)) otherfee,")
										.append("sum(dv.totalamount - dv.stationservicefee -")
										.append("dv.fueladditionfee - dv.othterfee) as basemount,")
										.append("sum(dv.agentfee) as agentfee,")
										.append("sum(dv.stationservicefee + dv.othterfee + dv.agentfee) income,")
										.append("sum(dv.balanceamount) balanceamount,")
										.append("sum(de.peopledistance) peopledistance,")
										.append("sum(dv.moreprice) moreprice")
								.append(" from departinvoices dv,")
								.append("route r,")
								.append("schedule s,")
								.append("scheduleplan sp,")
								.append("(select dt.departinvoicesid,")
								.append("sum(dt.distance * dt.ticketnum) peopledistance")
								.append(" from departinvoicesdetail dt")
								.append(" where dt.departdate between :startdate and :enddate")
								.append(" group by dt.departinvoicesid) de,")
								.append("vehicle v,")
								.append("unit u,")
				                .append(" unit cu, ")			  //+1s	
								.append("organization sco, schedulestatus ss")
								.append(" where dv.scheduleid = s.id")
								.append(" and ss.scheduleplanid = dv.scheduleplanid  and ss.departstationid = sco.stationid and sco.id= dv.printorgid")
								//.append(" and s.orgid = sco.id")
								.append(" and s.islinework = 1")
								.append(" and s.routeid = r.id")
								.append(" and s.districttype in " + districttype)
								.append(" and dv.id = de.departinvoicesid(+)")
								.append(" and dv.scheduleplanid = sp.id")
								.append(" and dv.departdate between :startdate and :enddate")
//								.append(" and sco.id in "+orgids)
								.append(" and dv.printorgid in "+orgids)
								.append(" and dv.status <> '1'")
								.append(" and dv.vehicleid = v.id");
								if(vehicleid!=0){
									sql.append(" and v.id="+vehicleid);
								}
								sql.append(" and dv.balanceunitid = u.id")
								.append(" and sp.departdate = dv.departdate")
								.append(" and v.unitid = cu.id ") ; 
								if (type != null && !type.equals("")) {
               				         sql.append(" and cu.type =" + type);                                              //+1s
			                         }
								if(vehicleunitid!=null&&!vehicleunitid.equals("")){
									sql.append(" and u.id = " + vehicleunitid);
								}
							 sql.append(" group by sco.name,")
								.append(" dv.departdate,r.name,r.id, u.name, v.vehicleno");
								if(groupby.equals("3") || groupby.equals("5")){
									sql.append(",s.id ) nl");
									sql.append(" on bs.scorgname = nl.scorgname")
									.append(" and bs.departdate = nl.departdate")
									.append(" and bs.rname = nl.rname")
									.append(" and bs.routeid = nl.routeid")
									.append(" and bs.vehicleno = nl.vehicleno")
									.append(" and bs.unitname = nl.unitname")
									.append(" and bs.scheduleid=nl.scheduleid,route r,schedule s where r.id = s.routeid and r.id = bs.routeid and bs.scheduleid = s.id");
								}else{
									sql.append(" ) nl");
									sql.append(" on bs.scorgname = nl.scorgname")
									.append(" and bs.departdate = nl.departdate")
									.append(" and bs.rname = nl.rname")
									.append(" and bs.routeid = nl.routeid")
									.append(" and bs.vehicleno = nl.vehicleno")
									.append(" and bs.unitname = nl.unitname");
								}										
			sql.append(" union all")
			.append(" select bs.scorgname,")//查询非流水班次  
					.append(" bs.departdate,bs.rname,bs.type sctype,nl.unitname,nl.carunitname,nl.vehicleno,");
			if(groupby.equals("3") || groupby.equals("5")){
				sql.append("s.starttime,");
			}
					sql.append(" bs.seats,")
					.append(" bs.needschedulenum,")
					.append(" bs.needpeopledistance,")
					.append(" nl.distance,")
					.append(" nl.schedulenum,")  
					.append(" nl.overtime,")
					.append(" nl.invoicesnonum,")
					.append(" nl.ticketnum,")
					.append(" nl.totalamount,")
					.append(" nl.stationservicefee,")
					.append(" nl.computefee,")
					.append(" nl.coolairfee,")
					.append(" nl.additionfee,")
					.append(" nl.fueladditionfee,")
					.append(" nl.waterfee,")
					.append(" nl.insurefee,")
					.append(" nl.otherfee,")
					.append(" nl.basemount,")
					.append(" nl.agentfee,")
					.append(" nl.income,")
					.append(" nl.balanceamount,")
					.append(" nl.peopledistance,")
					.append(" nl.moreprice,")
					.append(" nl.waterfee + nl.insurefee + nl.otherfee")
					.append(" + nl.fueladditionfee +nl.stationservicefee ")
					.append(" + nl.additionfee + nl.computefee + nl.coolairfee subtotal")
					//查询非流水班次计划情况
					.append(" from (select sco.name scorgname,")						
						.append(" sp.departdate,r.name rname,r.id routeid,");
					if ("7".equals(groupby)) {    //20434 发班运量统计表和班次结算查询统计数来的数据对不上
						sql.append("sc.type, ");
					} else {
						sql.append(" '1' as type, ");
					}
					if(groupby.equals("3") || groupby.equals("5")){
						sql.append("sc.id scheduleid,");
					}else{
						sql.append("u.name unitname,v.vehicleno,");
					}
						sql.append(" sum(sp.seatnum - sp.fixedreserveseatnum) seats,")
						.append(" count(sp.id) needschedulenum,")
						.append(" sum((sp.seatnum - sp.fixedreserveseatnum) * r.distance) needpeopledistance")
						.append(" from schedulestatus ss,")
						.append(" scheduleplan   sp,")
						.append(" schedule       sc,")
						.append(" route          r,")
						.append(" organization   sco");
						if(!groupby.equals("3")||!groupby.equals("5")||vehicleid!=0){
							sql.append(",vehiclereport rp,vehicle v,unit u,unit cu ");                       //+1s
						}
						sql.append(" where ss.scheduleplanid = sp.id")
						.append(" and ss.scheduleid = sc.id")
						.append(" and sc.routeid = r.id")
						.append(" and sc.islinework = 0")
						.append("  and ss.departstationid = sco.stationid ")
//						.append(" and sc.orgid = sco.id")
						.append(" and sc.districttype in " + districttype)
						.append(" and ss.departdate = sp.departdate ")
						.append(" and sp.departdate between :startdate and :enddate")
						.append("  and sco.id in "+orgids);
						if(!groupby.equals("3") || !groupby.equals("5") || vehicleid!=0){
							sql.append(" and rp.scheduleplanid=sp.id and sc.id=rp.scheduleid ")
							.append(" and rp.vehicleid=v.id and rp.isactive=1 and v.balanceunitid=u.id  ");//and rp.isdeparted=1
							if(vehicleid!=0){
								sql.append(" and v.id="+vehicleid);
							}
						}
					    sql.append(" and v.unitid = cu.id ");
                        if (type != null && !type.equals("")) {
               		    sql.append(" and cu.type =" + type);                                              //+1s
			            }
						if(vehicleunitid!=null&&!vehicleunitid.equals("")){
							sql.append(" and u.id = " + vehicleunitid);
						}
						sql.append(" group by sco.name, r.name,r.id, sp.departdate ");
						if ("7".equals(groupby)) {
							sql.append(",sc.type ");
						}
						if(groupby.equals("3") || groupby.equals("5")){
							sql.append(",sc.id");
						}else{
							sql.append(",u.name,v.vehicleno");
						}
						sql.append(" ) bs left join (select sco.name scorgname,")//查询非流水班次实际情况
								.append(" dv.departdate,r.name rname,r.id routeid,u.name unitname,cu.name carunitname,v.vehicleno, ");
						if ("7".equals(groupby)) {
							sql.append(" s.type, ");
						}
						if(groupby.equals("3") || groupby.equals("5")){
							sql.append(" s.id scheduleid, ");
						}
								sql.append(" sum(r.distance) distance,count(distinct dv.reportid) as schedulenum,")
								.append(" count( distinct case when s.isovertime = 1 then dv.reportid end) overtime,")
								.append(" count(distinct dv.departinvoicesno) as invoicesnonum,")
								.append(" sum(dv.ticketnum) as ticketnum,")
								.append(" sum(dv.totalamount) as totalamount,")
								.append(" sum(dv.stationservicefee) as stationservicefee,")
								.append(" sum(nvl((select sum(dd.deductmoney)")
								.append(" from departinvoicesdeductdetail dd,")
								.append(" balancedeductitem          a")
								.append(" where dd.departinvoicesid = dv.id")
								.append(" and dd.balanceitemid = a.id")
								.append(" and dd.status <> '1'")
								.append(" and a.name like '%微机费%'),")
								.append(" 0)) computefee,")
								.append(" sum(nvl((select sum(dd.deductmoney)")
								.append(" from departinvoicesdeductdetail dd,")
								.append(" balancedeductitem          a")
								.append(" where dd.departinvoicesid = dv.id")
								.append(" and dd.balanceitemid = a.id")
								.append(" and dd.status <> '1'")
								.append(" and a.name like '%空调费%'),")
								.append(" 0)) coolairfee,")
								.append(" sum(nvl((select sum(dd.deductmoney)")
								.append(" from departinvoicesdeductdetail dd,")
								.append(" balancedeductitem          a")
								.append(" where dd.departinvoicesid = dv.id")
								.append(" and dd.balanceitemid = a.id")
								.append(" and dd.status <> '1'")
								.append(" and a.name like '%附加费%'),")
								.append(" 0)) additionfee,")
								.append(" sum(dv.fueladditionfee) as fueladditionfee,")
								.append(" sum(nvl((select sum(dd.deductmoney)")
								.append(" from departinvoicesdeductdetail dd,")
								.append(" balancedeductitem          a")
								.append(" where dd.departinvoicesid = dv.id")
								.append(" and dd.balanceitemid = a.id")
								.append(" and dd.status <> '1'")
								.append(" and a.name like '%水费%'),")
								.append(" 0)) waterfee,")
								.append(" sum(nvl((select sum(dd.deductmoney)")
								.append(" from departinvoicesdeductdetail dd,")
								.append(" balancedeductitem          a")
								.append(" where dd.departinvoicesid = dv.id")
								.append(" and dd.balanceitemid = a.id")
								.append(" and dd.status <> '1'")
								.append(" and a.name like '%保险费%'),")
								.append(" 0)) insurefee,")
								.append(" sum(nvl((select sum(dd.deductmoney)")
								.append(" from departinvoicesdeductdetail dd,")
								.append(" balancedeductitem          a")
								.append(" where dd.departinvoicesid = dv.id")
								.append(" and dd.balanceitemid = a.id")
								.append(" and dd.status <> '1'")
								.append(" and (a.name like '%其他%' or a.name like '%其它%')),")
								.append(" 0)) otherfee,")
								.append(" sum(dv.totalamount - dv.stationservicefee -")
								.append(" dv.fueladditionfee - dv.othterfee) as basemount,")
								.append(" sum(dv.agentfee) as agentfee,")
								.append(" sum(dv.stationservicefee + dv.othterfee +")
								.append(" dv.agentfee) income,")
								.append(" sum(dv.balanceamount) balanceamount,")
								.append(" sum(de.peopledistance) peopledistance,")
								.append(" sum(dv.moreprice) moreprice")
								.append(" from departinvoices dv,")
								.append(" route r,")
								.append(" schedule s,")
								.append(" scheduleplan sp,")
								.append(" (select dt.departinvoicesid,")
								.append(" sum(dt.distance * dt.ticketnum) peopledistance")
								.append(" from departinvoicesdetail dt")
								.append(" where dt.departdate between :startdate and :enddate")
								.append(" group by dt.departinvoicesid) de,")
								.append(" vehicle v,")
								.append(" unit u,unit cu, ")
								.append(" organization sco, schedulestatus ss")
								.append(" where dv.scheduleid = s.id")    
								//.append(" and s.orgid = sco.id")
								.append(" and s.islinework = 0")       
								.append(" and s.routeid = r.id")
								.append(" and s.districttype in " + districttype)
								.append(" and dv.id = de.departinvoicesid(+)")
								.append(" and dv.scheduleplanid = sp.id")
								.append("  and ss.scheduleplanid = dv.scheduleplanid  and ss.departstationid = sco.stationid  and sco.id= dv.printorgid")
								.append(" and dv.departdate between :startdate and :enddate")
//								.append(" and sco.id in"+orgids)
								.append(" and dv.printorgid in"+orgids)
								.append(" and dv.status <> '1'")
								.append(" and dv.vehicleid = v.id");
								if(vehicleid!=0){
								sql.append(" and v.id="+vehicleid);
								}
								sql.append(" and v.balanceunitid = u.id") //使用车牌的结算单位
								.append(" and v.unitid = cu.id  ")
								.append(" and sp.departdate = dv.departdate");
								if (type != null && !type.equals("")) {
               				    sql.append(" and cu.type =" + type);                                              //+1s
			                     }
								if(vehicleunitid!=null&&!vehicleunitid.equals("")){
									sql.append(" and u.id = " + vehicleunitid);
								}
								sql.append(" group by sco.name, dv.departdate,r.name,r.id,u.name,cu.name,v.vehicleno");
								if ("7".equals(groupby)) {
									sql.append(" ,s.type ");
								}
								if(groupby.equals("3") || groupby.equals("5")){
									sql.append(",s.id ) nl  ");
								}else{
									sql.append(" ) nl ");
								}
								sql.append(" on bs.scorgname = nl.scorgname")
								.append(" and bs.departdate = nl.departdate and bs.rname = nl.rname and bs.routeid = nl.routeid ");
								if(groupby.equals("3") || groupby.equals("5")){
									sql.append(" and bs.scheduleid=nl.scheduleid ,route r,schedule s where r.id = s.routeid and r.id = bs.routeid and bs.scheduleid = s.id ");
								}else {
									sql.append(" and bs.unitname = nl.unitname")
									   .append(" and bs.vehicleno = nl.vehicleno");
								}	
								if ("7".equals(groupby)) {
									sql.append(" and bs.type = nl.type ");
								}
				sql.append(" ) alls");
			if(groupby.equals("1")){
				sql.append(" where alls.unitname IS NOT NULL group by rollup(rname,unitname)");
			}
			if(groupby.equals("2")){
				sql.append(" where alls.unitname IS NOT NULL group by rollup(rname,vehicleno)");
			}
			if(groupby.equals("3")){
				sql.append(" group by rollup(rname,starttime)");
			}						
			if(groupby.equals("4")){
				sql.append(" where alls.unitname IS NOT NULL group by rollup(vehicleno,rname)");
			}
			if(groupby.equals("5")){//只按日期统计
				sql.append(" group by rollup(departdate) ");
			}
			if(groupby.equals("6")){
				sql.append(" where alls.unitname IS NOT NULL group by rollup(rname,carunitname)");
			}
			if(groupby.equals("7")){
				sql.append(" group by rollup(rname,sctype) ");
			}
			if(groupby.equals("8")){
				sql.append(" where alls.unitname IS NOT NULL group by rollup(unitname,rname)");
			}
		Query query = getEntityManager().createNativeQuery(sql.toString());			
		System.out.println(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);		
		return query.getResultList();
	}				
	
	public List<Object> queryinfo(String orgid){
		Query query = getEntityManager().createNativeQuery("select contactperson from organization where id="+orgid);						
		return query.getResultList();
		
	}
}
