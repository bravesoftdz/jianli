/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.dao<br/>
 * <b>文件名：</b>RoutesellerIncomeDao.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b> 2012-11-29  <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;

/**
 * <b>类描述：线路售票统计表</b><br/>
 * <b>类名称：</b>RoutesellerIncomeDao.java<br/>
 * <b>创建人：</b><a href="mailto:huanghaoze@nova.net.cn">hhz</a><br/>
 * <b>创建时间：</b>2012-8  <br/>
 * <b>关键修改：修改为可以按照 线路，站点，售票员  分别统计分组，
 *  加上多选框：运行区域 查询条件（该模块在SalerRevenueDao提炼出来）</b><br/>
 * <b>修改时间：2012-11-29</b><br/>
 * <b>修改人：hhz</b><br/>
 */
@SuppressWarnings("rawtypes")
public class RoutesellerIncomeDao extends EntityManagerDaoSurport {

	
	/**
	 * 线路售票统计表
	 * @param seller 
	 * 
	 * @param String orgids,Date startdate,
	 * Date enddate, Boolean issellgroup ,String districttype
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryRouteIncome(String orgids, Date startdate, Date enddate, 
			Boolean issellgroup, Long seller,Boolean isstationgroup,Boolean isroutegroup,String districttype,Boolean isworkwaysgroup,String workways,Long stationid,Long routeid
			,Boolean iscodegroup, Long scheduleid,Long ticketoutletsid,Boolean isticketoutletsgroup) {
		StringBuilder sql = new StringBuilder(" select  ");
		if (isroutegroup) {
			sql.append(" routename, ");
		} else {
			sql.append(" '' routename, ");
		}
		if (isstationgroup) {
			sql.append(" stationname, ");
		} else {
			sql.append(" '' stationname, ");
		}
		if (issellgroup) {
			sql.append(" sellname, ");
		} else {
			sql.append(" '' sellname, ");
		}
		if (isworkwaysgroup) {
			sql.append(" workwaysname, ");
		} else {
			sql.append(" '' workwaysname, ");
		}
		if (isticketoutletsgroup) {
			sql.append(" ticketoutletsname, ");
		} else {
			sql.append(" '' ticketoutletsname, ");
		}
		sql.append(" sum(totalprice) totalprice,sum(totalnum) totalnum,")
				.append(" sum(stationservicefee) stationservicefee,sum(fueladditionfee) fueladditionfee,")
				.append(" sum(computefee) computefee,sum(coolairfee) coolairfee,sum(additionfee) additionfee,")
				.append(" sum(waterfee) waterfee,sum(insurefee) insurefee,sum(otherfee) otherfee,")
				.append(" (sum(stationservicefee) + sum(fueladditionfee)+ sum(computefee) + sum(coolairfee) + sum(additionfee) + sum(waterfee) + sum(insurefee)  + sum(otherfee)) totalfee, ")
				.append(" (sum(totalprice)  - sum(stationservicefee) - sum(computefee)")//- sum(returnprice) - sum(cancelprice)
				.append(" - sum(coolairfee) - sum(additionfee) - sum(waterfee) - sum(insurefee) ")
//				.append(" - sum(otherfee)+sum(charges)) incomeprice, sum(ticketnum) ticketnum, ")
				.append(" - sum(otherfee)) incomeprice, sum(ticketnum) ticketnum, ")
				.append(" sum(ticketprice) ticketprice,sum(halfticketnum) halfticketnum,")
				.append(" sum(halfticketprice) halfticketprice,")
				.append(" sum(studentticketnum) studentticketnum,sum(studentticketprice) studentticketprice,")
				.append(" sum(discountticketnum) discountticketnum, sum(discountticketprice) discountticketprice, ")
				.append(" sum(returnnum) returnnum,sum(returnprice) returnprice,sum(charges) returncharges ,")
				.append(" sum(cancelnum) cancelnum,sum(cancelprice) cancelprice ")
				.append(" ,(sum(totalprice)  - sum(stationservicefee) - sum(computefee)")//- sum(returnprice) - sum(cancelprice)
				.append(" - sum(coolairfee) - sum(additionfee) - sum(waterfee) - sum(insurefee) ")
				.append(" - sum(otherfee)+sum(charges)) revenueprice ")
				.append(" ,sum(changenum) changenum,sum(changeservicefee) changeservicefee ")
				.append(" ,sum(totalnum) - sum(returnnum) - sum(cancelnum) - sum(changenum) totalpersonnum ")
				.append(" ,sum(nonfactpeoplenum) nonfactpeoplenum,sum(xianjinprice)+sum(changeservicefee)+sum(charges) xianjinprice ")
				.append(" ,sum(totalnum) - sum(returnnum) - sum(cancelnum) - sum(nonfactpeoplenum) factpeoplenum")
				.append(" ,sum(xianjinprice) + sum(netprice)+sum(changeservicefee)+sum(charges) totalpeopleprice")
				.append(" ,sum(netprice) netprice");
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					sql.append(" ,code ");
				}
				sql.append(" from (select ");
		if (isroutegroup) {
			sql.append(" r.name routename, ");
		} 
		if (isstationgroup) {
			sql.append(" st.name stationname, ");
		} 
		if (issellgroup) {
			sql.append(" u.name sellname, ");
		}
		if (isworkwaysgroup) {
			sql.append(" dd.value workwaysname, ");
		}
		if (isticketoutletsgroup) {
			sql.append(" tl.name ticketoutletsname, ");
		}
		
				sql.append(" sum(ts.price) totalprice,count(ts.id) totalnum,sum(ts.stationservicefee) stationservicefee,")
				.append(" sum(ts.fueladditionfee) fueladditionfee,sum(ts.computefee) computefee,sum(ts.coolairfee) coolairfee,")
				.append(" sum(ts.additionfee) additionfee,sum(ts.waterfee) waterfee,sum(ts.insurefee) insurefee,")
				.append(" sum(ts.otherfee) otherfee, ")
				.append(" sum(case ts.tickettype when 'Q' then 1 else 0 end) ticketnum, ")//全票
				.append(" sum(case ts.tickettype when 'Q' then ts.price else 0 end) ticketprice, ")
				.append(" sum(case ts.tickettype when 'B' then 1 else 0 end) halfticketnum,")//半票
                .append(" sum(case ts.tickettype when 'B' then ts.price else 0 end) halfticketprice,")
                .append(" sum(case ts.tickettype when 'X' then 1 else 0 end) studentticketnum,")//学生票
                .append(" sum(case ts.tickettype when 'X' then ts.price else 0 end) studentticketprice,")
                .append(" sum(case when ts.tickettype<>'Q' and ts.tickettype<>'B' and ts.tickettype<>'X' then 1")
                .append("     else 0  end) discountticketnum,") //其他都算打折票
                .append(" sum(case  when ts.tickettype<>'Q' and ts.tickettype<>'B' and ts.tickettype<>'X' then ts.price")
                .append("    else 0 end) discountticketprice,")
                .append(" 0 returnnum,0 returnprice,0 charges,0 cancelnum,0 cancelprice,0 changenum,0 changeservicefee,0 nonfactpeoplenum,0 xianjinprice,0 netprice ") ;
                if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
                	sql.append(" ,s.code ") ; 
				}
				sql.append(" from ticketsell ts, schedule s, route r ");
				if(isstationgroup){
					sql.append(",station st ");
				}
				if (issellgroup) {
					sql.append(" ,userinfo u ");
				}
				if(isworkwaysgroup){					
					sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
				}
				
				if (isticketoutletsgroup) {
					sql.append(" ,ticketoutlets tl ");
				}
				sql.append(" where ts.scheduleid = s.id and s.routeid = r.id ")
//				.append(" and ts.ticketstatus='0' and ts.orgid in " + orgids)
				.append("  and ts.paymethod in('0','1') and ts.orgid in " + orgids);
				
				if(isroutegroup){
					if (routeid != null && routeid > 0) {
						sql.append(" and r.id="+routeid);
					}
				}
				if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if (scheduleid != null && scheduleid > 0) {
						sql.append(" and s.id = "+scheduleid);
					}
				}
				
				if(isticketoutletsgroup){
					sql.append(" and ts.ticketoutletsid=tl.id ");
					if (ticketoutletsid != null && ticketoutletsid > 0) {
						sql.append(" and tl.id="+ticketoutletsid);
					}
				}
											
				if(isstationgroup){
					sql.append(" and st.id=ts.reachstationid ");
					if (stationid != null && stationid > 0) {
						sql.append(" and st.id="+stationid);
					}
				}
								
				if (issellgroup) {
					sql.append(" and ts.sellby=u.id ");
					if (seller != null && seller > 0) {
						sql.append(" and u.id="+seller);
					}
				}
				
				if(isworkwaysgroup){
					sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
					if(!workways.equals("")){
						sql.append("  and s.workways in "+workways);
					}
				}
				if(!districttype.equals("")){
					sql.append(" and s.districttype in "+districttype);
				}
				sql.append(" and ts.selltime between :salestartdate and  :saleenddate + 0.99999 ")
				.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
				
				if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
					sql.append("group by ");
				}
				if (isroutegroup ) {
					sql.append(" r.name ");
				}
				if( isstationgroup){
					if(isroutegroup){sql.append(" , ");}
					sql.append(" st.name ");
				}
				if (issellgroup) {
					if(isroutegroup || isstationgroup){sql.append(" , ");}
					sql.append(" u.name ");
				}
				if (isworkwaysgroup) {
					if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
					sql.append(" dd.value ");
				}
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" s.code ");
				}
				if (isticketoutletsgroup) {
					if(iscodegroup || isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" tl.name ");
				}
				
				
				sql.append(" union all ")
				.append(" select ");
				if (isroutegroup) {
					sql.append(" r.name routename, ");
				} 
				if (isstationgroup) {
					sql.append(" st.name stationname, ");
				} 
				if (issellgroup) {
					sql.append(" u.name sellname, ");
				}
				if (isworkwaysgroup) {
					sql.append(" dd.value workwaysname, ");
				}
				if (isticketoutletsgroup) {
					sql.append(" tl.name ticketoutletsname, ");
				}
						sql.append(" 0 totalprice,0 totalnum,0 stationservicefee,")
						.append(" 0 fueladditionfee,0 computefee,0 coolairfee,")
						.append(" 0 additionfee,0 waterfee,0 insurefee,")
						.append(" 0 otherfee, ")
						.append(" 0 ticketnum, ")
						.append(" 0 ticketprice, ")
						.append(" 0 halfticketnum,")
		                .append(" 0 halfticketprice,")
		                .append(" 0 studentticketnum,")
		                .append(" 0 studentticketprice,")		             
		                .append(" 0 discountticketnum,")		               
		                .append(" 0 discountticketprice,")
		                .append(" 0 returnnum,0 returnprice,0 charges,0 cancelnum,0 cancelprice,0 changenum,0 changeservicefee, ")
						.append(" count(ts.id) nonfactpeoplenum,0 xianjinprice,0 netprice ");
						if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
							sql.append(" ,s.code "); 
						}
		                sql.append(" from ticketsell ts, schedule s, route r ");
						if(isstationgroup){
							sql.append(",station st ");
						}
						if (issellgroup) {
							sql.append(" ,userinfo u ");
						}
						if(isworkwaysgroup){					
							sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
						}
						if(isticketoutletsgroup){
							sql.append(" ,ticketoutlets tl ");
						}
						sql.append(" where ts.scheduleid = s.id and s.routeid = r.id ")
						.append(" and ts.ticketstatus in ('0','4') and ts.isdepartinvoices = 0  and ts.orgid in " + orgids);
						
						if(isroutegroup){
							if (routeid != null && routeid > 0) {
								sql.append(" and r.id="+routeid);
							}
						}
						if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
							if (scheduleid != null && scheduleid > 0) {
								sql.append(" and s.id = "+scheduleid);
							}
						}
						if(isticketoutletsgroup){
							sql.append(" and ts.ticketoutletsid = tl.id ");
							if (ticketoutletsid !=null && ticketoutletsid>0){
								sql.append(" and tl.id = "+ ticketoutletsid);
							}
						}
						if(isstationgroup){
							sql.append(" and st.id=ts.reachstationid ");
							if (stationid != null && stationid > 0) {
								sql.append(" and st.id="+stationid);
							}
						}
										
						if (issellgroup) {
							sql.append(" and ts.sellby=u.id ");
							if (seller != null && seller > 0) {
								sql.append(" and u.id="+seller);
							}
						}
						
						if(isworkwaysgroup){
							sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
							if(!workways.equals("")){
								sql.append("  and s.workways in "+workways);
							}
						}
						if(!districttype.equals("")){
							sql.append(" and s.districttype in "+districttype);
						}
						sql.append(" and ts.selltime between :salestartdate and  :saleenddate + 0.99999 ")
						.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
						
						if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
							sql.append("group by ");
						}
						if (isroutegroup ) {
							sql.append(" r.name ");
						}
//						if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
//							sql.append(" ,s.code ");
//						}
						if( isstationgroup){
							if(isroutegroup){sql.append(" , ");}
							sql.append(" st.name ");
						}
						if (issellgroup) {
							if(isroutegroup || isstationgroup){sql.append(" , ");}
							sql.append(" u.name ");
						}
						if (isworkwaysgroup) {
							if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
							sql.append(" dd.value ");
						}
						
						if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
							if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
							sql.append(" s.code ");
						}
						if (isticketoutletsgroup){
							if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
							sql.append(" tl.name ");
						}
						
						sql.append(" union all ")
						.append(" select ");
						if (isroutegroup) {
							sql.append(" r.name routename, ");
						} 
						if (isstationgroup) {
							sql.append(" st.name stationname, ");
						} 
						if (issellgroup) {
							sql.append(" u.name sellname, ");
						}
						if (isworkwaysgroup) {
							sql.append(" dd.value workwaysname, ");
						}
						if (isticketoutletsgroup) {
							sql.append(" tl.name ticketoutletsname, ");
						} 
								sql.append(" 0 totalprice,0 totalnum,0 stationservicefee,")
								.append(" 0 fueladditionfee,0 computefee,0 coolairfee,")
								.append(" 0 additionfee,0 waterfee,0 insurefee,")
								.append(" 0 otherfee, ")
								.append(" 0 ticketnum, ")
								.append(" 0 ticketprice, ")
								.append(" 0 halfticketnum,")
				                .append(" 0 halfticketprice,")
				                .append(" 0 studentticketnum,")
				                .append(" 0 studentticketprice,")		             
				                .append(" 0 discountticketnum,")		               
				                .append(" 0 discountticketprice,")
				                .append(" 0 returnnum,0 returnprice,0 charges,0 cancelnum,0 cancelprice,0 changenum,0 changeservicefee, ")
								.append(" 0 nonfactpeoplenum,0 xianjinprice,sum(ts.price) netprice ");
								if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
									sql.append(" ,s.code ") ; 
								}
				                sql.append(" from ticketsell ts, schedule s, route r ");
								if(isstationgroup){
									sql.append(",station st ");
								}
								if (issellgroup) {
									sql.append(" ,userinfo u ");
								}
								if(isworkwaysgroup){					
									sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
								}
								if(isticketoutletsgroup){
									sql.append(" ,ticketoutlets tl");
								}
								sql.append(" where ts.scheduleid = s.id and s.routeid = r.id ")
								.append(" and ts.ticketstatus in ('0','4') and ts.paymethod = 1 and ts.orgid in " + orgids);
								
								if(isroutegroup){
									if (routeid != null && routeid > 0) {
										sql.append(" and r.id="+routeid);
									}
								}
								
								if(isticketoutletsgroup){
									sql.append(" and ts.ticketoutletsid=tl.id");
									if (ticketoutletsid != null && ticketoutletsid > 0) {
										sql.append(" and tl.id="+ticketoutletsid);
									}
								}
								
								if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
									if (scheduleid != null && scheduleid > 0) {
										sql.append(" and s.id = "+scheduleid);
									}
								}
															
								if(isstationgroup){
									sql.append(" and st.id=ts.reachstationid ");
									if (stationid != null && stationid > 0) {
										sql.append(" and st.id="+stationid);
									}
								}
												
								if (issellgroup) {
									sql.append(" and ts.sellby=u.id ");
									if (seller != null && seller > 0) {
										sql.append(" and u.id="+seller);
									}
								}
								
								if(isworkwaysgroup){
									sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
									if(!workways.equals("")){
										sql.append("  and s.workways in "+workways);
									}
								}
								if(!districttype.equals("")){
									sql.append(" and s.districttype in "+districttype);
								}
								sql.append(" and ts.selltime between :salestartdate and  :saleenddate + 0.99999 ")
								.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
								
								if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
									sql.append("group by ");
								}
								if (isroutegroup ) {
									sql.append(" r.name ");
								}
//								if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
//									sql.append(" ,s.code ");
//								}
								if( isstationgroup){
									if(isroutegroup){sql.append(" , ");}
									sql.append(" st.name ");
								}
								if (issellgroup) {
									if(isroutegroup || isstationgroup){sql.append(" , ");}
									sql.append(" u.name ");
								}
								if (isworkwaysgroup) {
									if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
									sql.append(" dd.value ");
								}
								if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
									if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
									sql.append(" s.code ");
								}
								if (isticketoutletsgroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
									if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
									sql.append(" tl.name ");
								}
								
								sql.append(" union all ")
								.append(" select ");
								if (isroutegroup) {
									sql.append(" r.name routename, ");
								} 
								if (isstationgroup) {
									sql.append(" st.name stationname, ");
								} 
								if (issellgroup) {
									sql.append(" u.name sellname, ");
								}
								if (isworkwaysgroup) {
									sql.append(" dd.value workwaysname, ");
								}
								if (isticketoutletsgroup) {
									sql.append(" tl.name ticketoutletsname, ");
								}
										sql.append(" 0 totalprice,0 totalnum,0 stationservicefee,")
										.append(" 0 fueladditionfee,0 computefee,0 coolairfee,")
										.append(" 0 additionfee,0 waterfee,0 insurefee,")
										.append(" 0 otherfee, ")
										.append(" 0 ticketnum, ")
										.append(" 0 ticketprice, ")
										.append(" 0 halfticketnum,")
						                .append(" 0 halfticketprice,")
						                .append(" 0 studentticketnum,")
						                .append(" 0 studentticketprice,")		             
						                .append(" 0 discountticketnum,")		               
						                .append(" 0 discountticketprice,")
						                .append(" 0 returnnum,0 returnprice,0 charges,0 cancelnum,0 cancelprice,0 changenum,0 changeservicefee, ")
										.append(" 0 nonfactpeoplenum,sum(ts.price) xianjinprice,0 netprice ");
										if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
											sql.append(" ,s.code ");
										}
						                sql.append(" from ticketsell ts, schedule s, route r ");
										if(isstationgroup){
											sql.append(",station st ");
										}
										if (issellgroup) {
											sql.append(" ,userinfo u ");
										}
										if (isticketoutletsgroup) {
											sql.append(" ,ticketoutlets tl ");
										}
										if(isworkwaysgroup){					
											sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
										}
										sql.append(" where ts.scheduleid = s.id and s.routeid = r.id ")
										.append(" and ts.ticketstatus in ('0','4') and ts.paymethod = 0  and ts.orgid in " + orgids);
										
										if(isroutegroup){
											if (routeid != null && routeid > 0) {
												sql.append(" and r.id="+routeid);
											}
										}
										
										if(isticketoutletsgroup){
											sql.append(" and tl.id=ts.ticketoutletsid ");
											if (ticketoutletsid != null && ticketoutletsid > 0) {
												sql.append(" and tl.id="+ticketoutletsid);
											}
										} 
										
										if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
											if (scheduleid != null && scheduleid > 0) {
												sql.append(" and s.id = "+scheduleid);
											}
										}
																	
										if(isstationgroup){
											sql.append(" and st.id=ts.reachstationid ");
											if (stationid != null && stationid > 0) {
												sql.append(" and st.id="+stationid);
											}
										}
														
										if (issellgroup) {
											sql.append(" and ts.sellby=u.id ");
											if (seller != null && seller > 0) {
												sql.append(" and u.id="+seller);
											}
										}
										
										if(isworkwaysgroup){
											sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
											if(!workways.equals("")){
												sql.append("  and s.workways in "+workways);
											}
										}
										if(!districttype.equals("")){
											sql.append(" and s.districttype in "+districttype);
										}
										sql.append(" and ts.selltime between :salestartdate and  :saleenddate + 0.99999 ")
										.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
										
										if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
											sql.append("group by ");
										}
										if (isroutegroup ) {
											sql.append(" r.name ");
										}
//										if (iscodegroup) {
//											sql.append(" ,s.code ");//李电志 查询结果增加班次 2015年12月25日 16:52:54
//										}
										if( isstationgroup){
											if(isroutegroup){sql.append(" , ");}
											sql.append(" st.name ");
										}
										if (issellgroup) {
											if(isroutegroup || isstationgroup){sql.append(" , ");}
											sql.append(" u.name ");
										}
										if (isworkwaysgroup) {
											if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
											sql.append(" dd.value ");
										}
										if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
											if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
											sql.append(" s.code ");
										}
										if (isticketoutletsgroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
											if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
											sql.append(" tl.name ");
										}
																										
				sql.append(" union all ")
				.append(" select  ");
				if (isroutegroup) {
					sql.append("  r.name routename, ");
				} 
				if (isstationgroup) {
					sql.append(" st.name stationname, ");
				} 				
				if (issellgroup) {
					sql.append(" u.name sellname, ");
				}
				if (isworkwaysgroup) {
					sql.append(" dd.value workwaysname, ");
				}
				if (isticketoutletsgroup) {
					sql.append(" tl.name ticketoutletsname, ");
				}
				sql.append(" 0 totalprice,0 totalnum,0 stationservicefee,0 fueladditionfee,")
				.append(" 0 computefee,0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
				.append(" 0 ticketnum,0 ticketprice,0 halfticketnum,0 halfticketprice,0 studentticketnum,")
                .append(" 0 studentticketprice,0 discountticketnum,0 discountticketprice,")
                .append(" 0 returnnum,0 returnprice,0 charges,")
                .append(" 0 cancelnum,0 cancelprice, count(ts.id) changenum,sum(ts.servicefee) changeservicefee,0 nonfactpeoplenum,0 xianjinprice,0 netprice ");
                if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
                	sql.append(" ,s.code ");
				}
                sql.append(" from ticketsell ts, schedule s, route r, ticketchange tch") ;
				if(isstationgroup){
					sql.append(" ,station st ");
				}
				if (issellgroup) {
					sql.append(" ,userinfo u ");
				}
				if(isworkwaysgroup){					
					sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
				}
				if(isticketoutletsgroup){
					sql.append(" ,ticketoutlets tl ");
				}
				sql.append(" where ts.scheduleid = s.id and ts.id = tch.newticketsellid")
				.append(" and s.routeid = r.id ")
				.append(" and ts.orgid in " + orgids);
				if(isroutegroup){
					if (routeid != null && routeid > 0) {
						sql.append(" and r.id="+routeid);
					}
				}
				if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if (scheduleid != null && scheduleid > 0) {
						sql.append(" and s.id = "+scheduleid);
					}
				}
				if(isticketoutletsgroup){
					sql.append(" and tl.id=ts.ticketoutletsid ");
					if (ticketoutletsid != null && ticketoutletsid > 0) {
						sql.append(" and tl.id = "+ticketoutletsid);
					}
				}
											
				if(isstationgroup){
					sql.append(" and st.id=ts.reachstationid ");
					if (stationid != null && stationid > 0) {
						sql.append(" and st.id="+stationid);
					}
				}
				
				if (issellgroup) {
					sql.append(" and ts.sellby=u.id ");
					if (seller != null && seller > 0) {
						sql.append(" and u.id="+seller);
					}
				}
				
				if(isworkwaysgroup){
					sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
					if(!workways.equals("")){
						sql.append("  and s.workways in "+workways);
					}
				}
				if(!districttype.equals("")){
					sql.append(" and s.districttype in "+districttype);
				}
				sql.append(" and tch.changetime between :returnstartdate and  :returnenddate + 0.99999 ")
				.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
				
				if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
					sql.append("group by ");
				}
				if (isroutegroup) {
					sql.append(" r.name ");
				}
//				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
//					sql.append(" ,s.code ");
//				}
				if(isstationgroup){
					if(isroutegroup){sql.append(" , ");}
					sql.append(" st.name ");
				}
				if (issellgroup) {
					if(isroutegroup || isstationgroup){sql.append(" , ");}
					sql.append(" u.name ");
				}
				if (isworkwaysgroup) {
					if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
					sql.append(" dd.value ");
				}
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" s.code ");
				}
				if (isticketoutletsgroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
					sql.append(" tl.name ");
				}
				
				sql.append(" union all")
				
				.append(" select  ");
				if (isroutegroup) {
					sql.append("  r.name routename, ");
				} 
				if (isstationgroup) {
					sql.append(" st.name stationname, ");
				} 				
				if (issellgroup) {
					sql.append(" u.name sellname, ");
				}
				if (isworkwaysgroup) {
					sql.append(" dd.value workwaysname, ");
				}
				if (isticketoutletsgroup) {
					sql.append(" tl.name ticketoutletsname, ");
				}
				sql.append(" 0 totalprice,0 totalnum,0 stationservicefee,0 fueladditionfee,")
				.append(" 0 computefee,0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
				.append(" 0 ticketnum,0 ticketprice,0 halfticketnum,0 halfticketprice,0 studentticketnum,")
                .append(" 0 studentticketprice,0 discountticketnum,0 discountticketprice,")
                .append(" count(ts.id) returnnum,sum(ts.price) returnprice,sum(tr.charges) charges,")
                .append(" 0 cancelnum,0 cancelprice,0 changenum,0 changeservicefee,0 nonfactpeoplenum,0 xianjinprice,0 netprice");
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					sql.append(" ,s.code ");
				}
				sql.append(" from ticketsell ts, schedule s, route r, ticketreturn tr") ;
				if(isstationgroup){
					sql.append(" ,station st ");
				}
				if(isticketoutletsgroup){
					sql.append(" ,ticketoutlets tl ");
				}
				
				if (issellgroup) {
					sql.append(" ,userinfo u ");
				}
				if(isworkwaysgroup){					
					sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
				}
				sql.append(" where ts.scheduleid = s.id and ts.id = tr.sellid")
				.append(" and s.routeid = r.id and tr.returnway <> '3' ")
				.append(" and ts.orgid in " + orgids);
				if(isroutegroup){
					if (routeid != null && routeid > 0) {
						sql.append(" and r.id="+routeid);
					}
				}
				if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if (scheduleid != null && scheduleid > 0) {
						sql.append(" and s.id = "+scheduleid);
					}
				}
											
				if(isstationgroup){
					sql.append(" and st.id=ts.reachstationid ");
					if (stationid != null && stationid > 0) {
						sql.append(" and st.id="+stationid);
					}
				}
				if(isticketoutletsgroup){
					sql.append(" and tl.id=ts.ticketoutletsid ");
					if (ticketoutletsid != null && ticketoutletsid > 0) {
						sql.append(" and tl.id="+ticketoutletsid);
					}
				}
				
				if (issellgroup) {
					sql.append(" and ts.sellby=u.id ");
					if (seller != null && seller > 0) {
						sql.append(" and u.id="+seller);
					}
				}
				
				if(isworkwaysgroup){
					sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
					if(!workways.equals("")){
						sql.append("  and s.workways in "+workways);
					}
				}
				if(!districttype.equals("")){
					sql.append(" and s.districttype in "+districttype);
				}
				sql.append(" and tr.returntime between :returnstartdate and  :returnenddate + 0.99999 ")
				.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
				
				if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
					sql.append("group by ");
				}
				if (isroutegroup) {
					sql.append(" r.name ");
				}
//				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
//					sql.append(" ,s.code ");
//				}
				if(isstationgroup){
					if(isroutegroup){sql.append(" , ");}
					sql.append(" st.name ");
				}
				if (issellgroup) {
					if(isroutegroup || isstationgroup){sql.append(" , ");}
					sql.append(" u.name ");
				}
				if (isworkwaysgroup) {
					if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
					sql.append(" dd.value ");
				}
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" s.code ");
				}
				if (isticketoutletsgroup) {
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
					sql.append(" tl.name ");
				}
				
				sql.append(" union all")
				.append(" select  ");
				if (isroutegroup) {
					sql.append(" r.name routename, ");
				}
				if (isstationgroup) {
					sql.append(" st.name stationname, ");
				}
				if (issellgroup) {
					sql.append(" u.name sellname, ");
				}
				if (isworkwaysgroup) {
					sql.append(" dd.value workwaysname, ");
				}
				if (isticketoutletsgroup) {
					sql.append(" tl.name ticketoutletsname, ");
				}
				sql.append(" 0 totalprice,0 totalnum,0 stationservicefee,0 fueladditionfee,")
				.append(" 0 computefee,0 coolairfee,0 additionfee,0 waterfee,0 insurefee,0 otherfee,")
				.append(" 0 ticketnum,0 ticketprice,0 halfticketnum,0 halfticketprice,0 studentticketnum,")
                .append(" 0 studentticketprice,0 discountticketnum,0 discountticketprice,")
                .append(" 0 returnnum,0 returnprice,0 charges,")
                .append(" count(ts.id) cancelnum,sum(ts.price) cancelprice,0 changenum,0 changeservicefee,0 nonfactpeoplenum,0 xianjinprice,0 netprice");
                if (iscodegroup) {
                	sql.append(" ,s.code ");//李电志 查询结果增加班次 2015年12月25日 16:52:54
				}
                sql.append(" from ticketsell ts,schedule s,route  r, ticketcancel tc ");
				if(isstationgroup){
					sql.append("  ,station st ");
				}
				if (issellgroup) {
					sql.append(" ,userinfo u ");
				}
				if (isticketoutletsgroup) {
					sql.append(" ,ticketoutlets tl ");
				}
				if(isworkwaysgroup){					
					sql.append(" ,digitaldictionary d,digitaldictionarydetail dd ");					
				}
				sql.append(" where ts.scheduleid = s.id  and ts.id = tc.sellid")
				.append(" and s.routeid = r.id  ")
				.append(" and ts.orgid in " + orgids);
				
				if(isroutegroup){
					if (routeid != null && routeid > 0) {
						sql.append(" and r.id="+routeid);
					}
				}
				if(iscodegroup){//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if (scheduleid != null && scheduleid > 0) {
						sql.append(" and s.id = "+scheduleid);
					}
				}
											
				if(isstationgroup){
					sql.append(" and st.id=ts.reachstationid ");
					if (stationid != null && stationid > 0) {
						sql.append(" and st.id="+stationid);
					}
				}
				
				if(isticketoutletsgroup){
					sql.append(" and tl.id=ts.ticketoutletsid ");
					if (ticketoutletsid != null && ticketoutletsid > 0) {
						sql.append(" and tl.id="+ticketoutletsid);
					}
				}
				
				if (issellgroup) {
					sql.append(" and ts.sellby=u.id ");
					if (seller != null && seller > 0) {
						sql.append(" and u.id="+seller);
					}
				}
				
				if(isworkwaysgroup){
					sql.append(" and d.tablename='schedule' and d.columnname='workways' and dd.digitaldictionaryid=d.id and s.workways=dd.code ");
					if(!workways.equals("")){
						sql.append("  and s.workways in "+workways);
					}
				}
				
				if(!districttype.equals("")){
					sql.append(" and s.districttype in "+districttype);
				}
				sql.append(" and tc.canceltime between :cancelstartdate and  :cancelenddate + 0.99999 ")
				.append(" and ts.departdate between  :dptstartdate-10 and :dptenddate+30 ");
				if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
					sql.append("group by  ");
				}
				if (isroutegroup) {
					sql.append(" r.name ");
				}
//				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
//					sql.append(" ,s.code ");
//				}
				if(isstationgroup){
					if(isroutegroup ){sql.append(" , ");}
					sql.append(" st.name ");
				}
				if (issellgroup) {
					if(isroutegroup || isstationgroup){sql.append(" , ");}
					sql.append(" u.name ");
				}
				if (isworkwaysgroup) {
					if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
					sql.append(" dd.value ");
				}
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" s.code ");
				}
				if (isticketoutletsgroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
					sql.append(" tl.name ");
				}
				sql.append(") ");
				// 如果全为false，没有group by
				if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
					sql.append("group by ");
				}
				
				if (isroutegroup ) {
					sql.append(" routename ");
				}
//				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
//					sql.append(" ,code ");
//				}
				if(isstationgroup){
					if(isroutegroup ){sql.append(" , ");}
					sql.append(" stationname ");
				}
				if (issellgroup) {
					if(isroutegroup || isstationgroup){sql.append(" , ");}
					sql.append(" sellname ");
				}
				if (isworkwaysgroup) {
					if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
					sql.append(" workwaysname ");
				}
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" code ");
				}
				if (isticketoutletsgroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
					sql.append(" ticketoutletsname ");
				}
				//如果全为false，没有order by
				if(isroutegroup||isstationgroup||issellgroup||isworkwaysgroup||iscodegroup||isticketoutletsgroup){
					sql.append(" order by ");
				}
				if (isroutegroup ) {
					sql.append(" routename ");
				}
				if(isstationgroup){
					if(isroutegroup ){sql.append(" , ");}
					sql.append(" stationname ");
				}
				if (issellgroup) {
					if(isroutegroup || isstationgroup){sql.append(" , ");}
					sql.append(" sellname ");
				}
				if (isworkwaysgroup) {
					if(isroutegroup || isstationgroup||issellgroup){sql.append(" , ");}
					sql.append(" workwaysname ");
				}
				if (iscodegroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup){sql.append(" , ");}
					sql.append(" code ");
				}
				if (isticketoutletsgroup) {//李电志 查询结果增加班次 2015年12月25日 16:52:54
					if(isroutegroup || isstationgroup||issellgroup||isworkwaysgroup||iscodegroup){sql.append(" , ");}
					sql.append(" ticketoutletsname ");
				}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("dptstartdate", startdate);
		query.setParameter("dptenddate", enddate);
		query.setParameter("salestartdate", startdate);
		query.setParameter("saleenddate", enddate);
		query.setParameter("returnstartdate", startdate);
		query.setParameter("returnenddate", enddate);
		query.setParameter("cancelstartdate", startdate);
		query.setParameter("cancelenddate", enddate);
		
		return query.getResultList();
	}	
}
