package cn.nova.bus.sale.dao;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.base.service.TicketreturnrateService;
import cn.nova.bus.base.service.impl.TicketreturnrateServiceImpl;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.sale.model.Ticketreturn;
import cn.nova.bus.sale.model.Ticketsign;
import cn.nova.bus.sale.service.TicketreturnService;
import cn.nova.bus.sale.service.impl.TicketreturnServiceImpl;
import cn.nova.bus.sale.vo.TicketreturnQueryDto;
import cn.nova.bus.sale.vo.TicketreturnQueryVo;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CommonUtil;
import util.CurrentUtil;
import util.JsonUtil;

public class TicketreturnDao extends EntityManagerDaoSurport<Ticketreturn> {
	private ParameterService parameterService = new ParameterServiceImpl();

	public List<Map<String, Object>> find(List<PropertyFilter> propertyFilters,
			Long loginorgid,String  param1115) throws ParseException {
		// 判断查询方式
		boolean isfindbyvip = false; // 按VIP查询
		boolean isfindbyschedule = false; // 按班次查询
		String datestr = "";
		boolean departdateequals = false;
		Iterator<PropertyFilter> iterator = propertyFilters.iterator();
			while(iterator.hasNext()){
				PropertyFilter	propertyFilter = iterator.next();
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase(
					"v!vipcardno")) {
				isfindbyvip = true;
			}
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase("sc!id")) {
				isfindbyschedule = true;
			}
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase("tsl!departdate")) {
				if(propertyFilter.getMatchType().name().trim().equalsIgnoreCase("EQ") ){
					departdateequals = true;
					datestr = DateUtils.formatDate((Date)propertyFilter.getMatchValue());
				}else{
						int day =Math.abs(Integer.valueOf(param1115));
					datestr = DateUtils.formatDate(DateUtils.add(new Date(), -day));
				}
				iterator.remove();
			}				
			play.Logger.info("_________________________退票查询日期:   "+datestr);
		}
		//若查询语句增加查询字段必须从查询结果最后一个字段增加，还需要注意字段顺序不能乱，否则接下来按数据下标计算手续费时会报错
		StringBuilder sql = new StringBuilder();
		sql.append("select  1 as isselfschedule,");
		if (loginorgid == null || loginorgid <= 0) {
			sql.append(
					" case tsl.ticketstatus when '0' then 1 else 0 end as isselected,")
					.append(" case when isr.id is not null and isr.insurancestatus='0' and "
							+"to_number(to_char(tsl.departdate, 'yyyymmdd') || replace(tsl.departtime, ':', ''))"
				            +"  > = to_number(to_char(sysdate, 'yyyymmddhh24mi')) "
							+ "then 0 else null end as isreturninsure,");
		} else {
			sql.append(
					" case when tsl.ticketstatus='0' and (tsl.orgid="
							+ loginorgid + " or sc.orgid=" + loginorgid
							+ ")  then 1 else null end as isselected,").append(
					" case when isr.id is not null and isr.insurancestatus='0' and (tsl.orgid="
							+ loginorgid + " or sc.orgid=" + loginorgid +") and "
							+ "to_number(to_char(tsl.departdate, 'yyyymmdd') || replace(tsl.departtime, ':', ''))"
							+" > = to_number(to_char(sysdate, 'yyyymmddhh24mi')) "
							+ " then 0 else null end as isreturninsure,");
		}
		sql.append(
				" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
				.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.orgid,sc.orgid as scheduleorgid,tsl.paymethod,")
				.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
//				.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
				.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus, typ.name as tickettype, tsl.carrychildnum as childnum,")//携童数
				.append(" tsl.departstationid,tsl.reachstationid,")

				.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

				.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

				.append(" us.name as signbyname,")
				.append(" sc.code as schedulecode,")
				.append(" ctm.name as customername,")
				.append(" std.name as departstationname,")
				.append(" str.name as reachstationname,ss.status,")
				.append(" dd2.value as ticketstatusname,'' as openapiorgname")
				.append(" ,ddt.value as certificatetype,ctm.certificateno as certificateno,nvl(tsg.signrate,0) as signrate,nvl(tn.rate,0) as rate,nvl((tn.charges + tn.chargesweb),0) charges, ")
				.append(" nvl(tsl.returnfeemode,'0') canreturnmoneyback ,isr.sellway insurancesellway ")
				.append(" , 0 as isohteragent ") //是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票
				.append("  ,tsl.orderno, isr.orderno as insuorderno ")
				.append(" from Ticketsell tsl left join Ticketsign tsg")
				.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=1")
				.append(" left join Ticketreturn tn on tn.sellid=tsl.id")
				.append(" left join Userinfo us on tsg.signby=us.id")
				.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
				.append(" left join Customer ctm on tsl.customerid=ctm.id")
				.append(" left join Tickettype typ on tsl.tickettype = typ.code ")
				.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
				.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")
				.append(" ,Schedule sc,Station std,Station str,Schedulestatus ss ,Userinfo usell");
		if (isfindbyvip) {
			sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
		}
		sql.append(" ,digitaldictionary d1,digitaldictionarydetail dd2");
		//sql.append(" ,digitaldictionary d2,digitaldictionarydetail dd3");
		sql.append(" where tsl.scheduleid=sc.id")
				.append(" and tsl.departstationid=std.id")
				.append(" and tsl.reachstationid=str.id")
				.append(" and tsl.departstationid=ss.departstationid")
				.append(" and tsl.scheduleplanid=ss.scheduleplanid")
				.append(" and tsl.sellway<>'12'")
				.append(" and ((tsl.ticketstatus in( '0','1')) or ") //新增退票查询只查询退票状态的
				.append(" 	(tsl.tickettype = 'T' ) ) ") //团体票全部查询出来 下面处理
				.append(" and tsl.ticketstatus=dd2.code and d1.id=dd2.digitaldictionaryid")
//				.append(" and ctm.certificatetype=dd3.code and d2.id=dd3.digitaldictionaryid")
				.append(" and d1.tablename='ticketsell' and d1.columnname='ticketstatus'")
				.append(" and tsl.sellby=usell.id and tsl.price>0 AND SS.DEPARTDATE = TSL.DEPARTDATE ");
//		.append(" and d2.tablename='customer' and d2.columnname='certificatetype'");
		if (isfindbyvip) {
			sql.append(" and v.id=vc.vipid").append(" and vc.type='0'")
					.append(" and vc.id=vcd.vipconsumeid")
					.append(" and vcd.isselfschedule=1")
					.append(" and vcd.sellid=tsl.id");
		}
		if(departdateequals){
			sql.append( " and tsl.departdate = to_date('"+ datestr+"','yyyy-mm-dd')");
		}else{
			sql.append( " and tsl.departdate >= to_date('"+ datestr+"','yyyy-mm-dd')");
		}
		sql.append(" and tsl.tickettype <> 'E'  ");//排除儿童票
		String clientCondition = PropertyFilter.toJpql(propertyFilters, true);
		if (clientCondition == null || clientCondition.trim().equals("")) {
			clientCondition = " and 1=2";
		}
		sql.append(clientCondition);

		List<PropertyFilter> propertyFilters_agent = new ArrayList<PropertyFilter>();
		propertyFilters_agent.addAll(propertyFilters);

		if (!isfindbyschedule) {
			// 查询售异站票表
			sql.append(" union all select  0 as isselfschedule,")
					.append(" case tsl.ticketstatus when '0' then 1 else 0 end as isselected,")
					.append(" case when isr.id is not null and isr.insurancestatus='0' then 1 else null end as isreturninsure,")
					.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
					.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
					.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
//					.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
					.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus, typ.name as tickettype, tsl.carrychildnum as childnum,")//携童数
					.append(" tsl.departstationid,tsl.reachstationid,")

					.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

					.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

					.append(" us.name as signbyname,")
					.append(" tsl.schedulecode,")
					.append(" ctm.name as customername,")
					.append(" std.name as departstationname,")
					.append(" str.name as reachstationname,'0' as status,")
					.append(" dd2.value as ticketstatusname,'' as openapiorgname")
					.append(" ,ddt.value as certificatetype,ctm.certificateno as certificateno,tsg.signrate,tn.rate,(tn.charges + tn.chargesweb) charges, ")
					.append(" '0' canreturnmoneyback,isr.sellway insurancesellway ")
					.append(" , decode(usell.orgid, :loginorgid, 0, 1) as isohteragent ") //是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票。ticketsellagent中售票员所属机构与退票员所属机构相同，则为本站所售联网票，否则为异站联网票
					.append("  ,tsl.orderno, isr.orderno as insuorderno ")
					.append(" from Ticketsellagent tsl left join Ticketsign tsg")
					.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=0")
					.append(" left join Ticketreturn tn on tn.sellid=tsl.id")
					.append(" left join Userinfo us on tsg.signby=us.id")
					.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
					.append(" left join Customer ctm on tsl.customerid=ctm.id")
					.append(" left join Tickettype typ on tsl.tickettype = typ.code ")
					.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
					.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")
					.append(" ,Station std,Station str,Userinfo usell");
			if (isfindbyvip) {
				sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
			}
			sql.append(" ,digitaldictionary d1,digitaldictionarydetail dd2");
		//	sql.append(" ,digitaldictionary d2,digitaldictionarydetail dd3");
			sql.append(" where tsl.departstationid=std.id")
					.append(" and tsl.reachstationid=str.id")
					.append(" and tsl.sellby=usell.id")
					.append(" and ((tsl.ticketstatus in( '0','1')) or ") //新增退票查询只查询退票状态的
					.append(" 	(tsl.tickettype = 'T' ) ) ") //团体票全部查询出来 下面处理
					.append(" and tsl.ticketstatus=dd2.code and d1.id=dd2.digitaldictionaryid")
					//.append(" and ctm.certificatetype=dd3.code and d2.id=dd3.digitaldictionaryid")
					.append(" and d1.tablename='ticketsell' and d1.columnname='ticketstatus'");
				//	.append(" and d2.tablename='customer' and d2.columnname='certificatetype'");
			if (isfindbyvip) {
				sql.append(" and v.id=vc.vipid").append(" and vc.type='0'")
						.append(" and vc.id=vcd.vipconsumeid")
						.append(" and vcd.isselfschedule=0")
						.append(" and vcd.sellid=tsl.id");
			}
			if(departdateequals){
				sql.append( " and tsl.departdate = to_date('"+ datestr+"','yyyy-mm-dd')");
			}else{
				sql.append( " and tsl.departdate >= to_date('"+ datestr+"','yyyy-mm-dd')");
			}
			sql.append(" and tsl.tickettype <> 'E'  ");//排除儿童票
			String clientCondition_agent = PropertyFilter.toJpql(
					propertyFilters_agent, true);
			if (clientCondition_agent == null
					|| clientCondition_agent.trim().equals("")) {
				clientCondition_agent = " and 1=2";
			}
			sql.append(clientCondition_agent);

			// openAPI省中心联网票退票查询
			sql.append(" union all select  0 as isselfschedule,")
					.append(" case tsl.ticketstatus when '0' then 1 else 0 end as isselected,")
					.append(" case when isr.id is not null and isr.insurancestatus='0' then 1 else null end as isreturninsure,")
					.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
					.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
					.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
//					.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
					.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus, typ.name as tickettype, tsl.carrychildnum as childnum,")//携童数
					.append(" tsl.departstationid,tsl.reachstationid,")

					.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

					.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

					.append(" us.name as signbyname,")
					.append(" tsl.schedulecode,")
					.append(" ctm.name as customername,")
					.append(" tsl.departstationname as departstationname,tsl.reachstationname as reachstationname,")
					.append(" '0' as status,")
					.append(" dd2.value as ticketstatusname,tsl.orgname as openapiorgname")
					.append(" ,ddt.value as certificatetype,ctm.certificateno as certificateno,tsg.signrate,tn.rate,(tn.charges + tn.chargesweb) charges, ")
					.append("  '0' canreturnmoneyback,isr.sellway insurancesellway  ")
					.append(" , decode(usell.orgid, :loginorgid, 0, 1) as isohteragent ") //是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票。ticketsellagent中售票员所属机构与退票员所属机构相同，则为本站所售联网票，否则为异站联网票
					.append("  ,tsl.orderno, isr.orderno as insuorderno ")//车票订单号  保险订单号
					.append(" from Ticketsellagent tsl left join Ticketsign tsg")
					.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=0")
					.append(" left join Ticketreturn tn on tn.sellid=tsl.id")
					.append(" left join Userinfo us on tsg.signby=us.id")
					.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
					.append(" left join Customer ctm on tsl.customerid=ctm.id")
					.append(" left join Tickettype typ on tsl.tickettype = typ.code ")
					.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
					.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")
					.append(" ,Userinfo usell");
			if (isfindbyvip) {
				sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
			}
			sql.append(" ,digitaldictionary d1,digitaldictionarydetail dd2");
//			sql.append(" ,digitaldictionary d2,digitaldictionarydetail dd3");
			sql.append(" where 1=1")
					.append(" and tsl.departstationname is not null and tsl.reachstationname is not null ")
					.append(" and tsl.sellby=usell.id")
					.append(" and ((tsl.ticketstatus in( '0','1')) or ") //新增退票查询只查询退票状态的
					.append(" 	(tsl.tickettype = 'T' ) ) ") //团体票全部查询出来 下面处理
					.append(" and tsl.ticketstatus=dd2.code and d1.id=dd2.digitaldictionaryid")
//					.append(" and ctm.certificatetype=dd3.code and d2.id=dd3.digitaldictionaryid")
					.append(" and d1.tablename='ticketsell' and d1.columnname='ticketstatus'");
				//	.append(" and d2.tablename='customer' and d2.columnname='certificatetype'");
			if (isfindbyvip) {
				sql.append(" and v.id=vc.vipid").append(" and vc.type='0'")
						.append(" and vc.id=vcd.vipconsumeid")
						.append(" and vcd.isselfschedule=0")
						.append(" and vcd.sellid=tsl.id");
			}
			if(departdateequals){
				sql.append( " and tsl.departdate = to_date('"+ datestr+"','yyyy-mm-dd')");
			}else{
				sql.append( " and tsl.departdate >= to_date('"+ datestr+"','yyyy-mm-dd')");
			}
			sql.append(" and tsl.tickettype <> 'E'  ");//排除儿童票
			clientCondition_agent = PropertyFilter.toJpql(
					propertyFilters_agent, true);
			if (clientCondition_agent == null
					|| clientCondition_agent.trim().equals("")) {
				clientCondition_agent = " and 1=2";
			}
			sql.append(clientCondition_agent);

		}
		
		sql.append(" order by ticketno");

		play.Logger.info("sql=:" + sql.toString());
		Query query = getEntityManager().createNativeQuery(sql.toString(), TicketreturnQueryDto.class);
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		if (!isfindbyschedule) {
			query.setParameter("loginorgid", loginorgid);
		}
		List<TicketreturnQueryDto> list = query.getResultList();
//		List<Object[]> result1 = query.getResultList();
		
		if(list != null && list.size() > 0 && !isfindbyschedule){ //若按班次查询，则直接返回上面结果：即查出全班次或按座位号精确查询
			TicketreturnQueryDto arr = list.get(0);
			if(arr.getTickettype()!=null && "团体票".equals(arr.getTickettype())){
				String ticketno = arr.getTicketno();//团体票主票票号
				if(ticketno.length() > (new BilltypeServiceImpl().findByCode("Ticket").getTicketnolength())){
					play.Logger.info(ticketno + "该团体票票号长度大于车票票据类型长度，则认为是团体票副票！");
				}else{
					//票号长度小于等于票据类型长度，则认为是团体票主票
					list.removeAll(list);
					list.addAll(qryTuanTickets(propertyFilters, ticketno, loginorgid));
				}
			}
		}
		getEntityManager().clear();
		//对退票查询界面退票手续费进行小数点进位规则处理显示
				String para1105 = parameterService.findParamValue("1105",loginorgid);
				for (TicketreturnQueryDto temp : list) {
					String ticketno = temp.getTicketno(); //票号
					BigDecimal openReturnFee =  BigDecimal.valueOf(0);
					if(temp.getOpenapiorgname() != null){//openApi调用接口获取手续费
						TicketreturnService ticketreturnService = new TicketreturnServiceImpl(); 
						try {
							openReturnFee = ticketreturnService.findReturnFee(temp.getId());
						} catch (Exception e) {
							e.printStackTrace();
							play.Logger.error("OpenApi退票查询手续费失败", e);
						}	
					}
					if(getTicketreturn(ticketno).size() == 0){
						Ticketsign signrate = getSignRate(ticketno);//查询签手续费
						if(signrate != null){
							temp.setCharges(signrate.getCharges());
							temp.setRate(BigDecimal.valueOf(signrate.getSignrate()));
						}else{
							BigDecimal rate = getRate(DateUtils.formatDate(temp.getDepartdate()) + " " + temp.getDeparttime(), temp.getIslinework());
							if("3".equals(parameterService.findParamValue("1107", temp.getOrgid()))){
								//新增一个参数来判断是否是二连浩特的特票手续费公式  1179参数启用则按照（票价-4）*退票费率+4
								//1179参数整合到1107参数中，为3时--二连浩特
								temp.setCharges((temp.getPrice().subtract(BigDecimal.valueOf(4L))).multiply(rate).add(BigDecimal.valueOf(4L)));
							}else if("1".equals(parameterService.findParamValue("1107", temp.getOrgid()))){
								//1107为1时扣除票价分项
								BigDecimal ticketfee = findticketfee(temp.getIsselfschedule(), temp.getId());
								//扣除票价分项
								temp.setCharges(ticketfee.add((temp.getPrice().subtract(ticketfee)).multiply(rate)));
							}else if("2".equals(parameterService.findParamValue("1107", temp.getOrgid()))){
								//票价*退票手续费+站务费
								BigDecimal ticketfee=findticketfee(temp.getIsselfschedule(), temp.getId());
								temp.setCharges(ticketfee.add((temp.getPrice()).multiply(rate)));
							}else{
								temp.setCharges(temp.getPrice().multiply(rate));
							}
							if(openReturnFee.compareTo(BigDecimal.valueOf(0))==1){//openReturnFee大于0表明openApi售的票
								temp.setCharges(openReturnFee); //退票手续费
								temp.setRate(openReturnFee.divide(temp.getPrice(), 2, BigDecimal.ROUND_HALF_UP));//根据退票手续费除以票价重新获取手续费率，四舍五入。
							}else{
								temp.setRate(rate);
							}   
						}
					}
					//1四舍五入、2舍去、3入、4小于5角进到5角，高于5角进到1元、5保留小数点,6保留一位小数四舍五入
					if(("1").equals(para1105)){
						temp.setCharges((temp.getCharges().setScale(0, BigDecimal.ROUND_HALF_UP)));
					}else if(("2").equals(para1105)){
						temp.setCharges((temp.getCharges().setScale(0,BigDecimal.ROUND_DOWN)));
					}else if(("3").equals(para1105)){
						BigDecimal chargeTemp = temp.getCharges().setScale(0, BigDecimal.ROUND_UP);//#2406 1105=3入，若手续费大于票价，则取票价
						if(chargeTemp.compareTo(temp.getPrice()) > 0){
							temp.setCharges(temp.getPrice());
						}else{
							temp.setCharges((temp.getCharges().setScale(0,BigDecimal.ROUND_UP)));
						}
					}else if (("4").equals(para1105)){
						BigDecimal decimal = (temp.getCharges().setScale(0,BigDecimal.ROUND_DOWN));//去掉小数之后的值，整数部分
						BigDecimal returncharges =(temp.getCharges().subtract((temp.getCharges().setScale(0, BigDecimal.ROUND_DOWN))));//小数部分的值，小数部分
						//有小数部分再进行判断
						if(returncharges.compareTo(BigDecimal.ZERO) > 0){
							if(returncharges.subtract(BigDecimal.valueOf(0.5)).compareTo(BigDecimal.ZERO) > 0){
								//（小数部分 - 0.5） > 0，即小数部分大于0.5，进到1元
								temp.setCharges(decimal.add(BigDecimal.valueOf(1)));
							}else{
								//（小数部分 - 0.5） <= 0，即小数部分大于0.5，进到1元
								temp.setCharges(decimal.add(BigDecimal.valueOf(0.5)));
							}
						}
					}else if("5".equals(para1105)){
						//temp.setCharges((temp.getCharges().setScale(1, BigDecimal.ROUND_HALF_UP)));
					}else{
						temp.setCharges(temp.getCharges().setScale(1, BigDecimal.ROUND_HALF_UP));
					}
					//若手续费大于票价，则取票价
					if(temp.getCharges().compareTo(temp.getPrice()) > 0){
						temp.setCharges(temp.getPrice());
					}
				}
				
				//listToMap时，对象类型需要为@DelphiDS
				List<TicketreturnQueryVo> voList = new ArrayList<TicketreturnQueryVo>();
				for (TicketreturnQueryDto dto : list) {
					TicketreturnQueryVo vo = new TicketreturnQueryVo();
					vo = JsonUtil.parseObject(JsonUtil.toSimpleString(dto), TicketreturnQueryVo.class);
					voList.add(vo);
				}
				genReturnPrice(loginorgid, voList);
				List<Object> result = new ArrayList<Object>(voList);
				return ListUtil.listToMap(new Object[] {TicketreturnQueryVo.class}, result, new Object[] {TicketreturnQueryVo.class});
	}

	private BigDecimal getRate(String departtime, String strislinework)
			throws ParseException {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date departdatetime = fmt.parse(departtime);
		Global global = CurrentUtil.getGlobal();
		TicketreturnrateService ticketreturnrateService = new TicketreturnrateServiceImpl();
		Date now = new Date();
		BigDecimal hoursbetweendeparttime = new BigDecimal(0);
		hoursbetweendeparttime = (new BigDecimal(departdatetime.getTime()
				- now.getTime())).divide(new BigDecimal(1000))
				.divide(new BigDecimal(60), BigDecimal.ROUND_UP)
				.divide(new BigDecimal(60), BigDecimal.ROUND_UP);
		play.Logger.info(String.valueOf(hoursbetweendeparttime));
		boolean islinework = false;
		if (strislinework.equals("1")) {
			islinework = true;
		}
		return ticketreturnrateService.getticketreturnrate(global
				.getOrganization().getId(), hoursbetweendeparttime,fmt.parse(departtime), islinework);
	}

	public BigDecimal findticketfee(boolean isselfschedule, long ticketsellid) {
		BigDecimal ticketfee = new BigDecimal(0);
		try {
			TicketreturnService ticketreturnService = new TicketreturnServiceImpl();
			ticketfee = ticketreturnService.findticketfee(isselfschedule,
					ticketsellid);
		} catch (Exception e) {
		}
		return ticketfee;
	}
	
	//新增方法来查询特权退票和责任退票的手续费率和手续费
	public List<Object[]> getTicketreturn(String ticketno)
	{		//处理为团体票时，price为0的情况
		StringBuffer sql = new StringBuffer("SELECT tr.returnway,tr.charges,decode(ts.price,0,0,(ts.price - tr.returnamount) / ts.price),ts.price FROM ticketreturn tr,ticketsell ts"); 
					sql.append(" where tr.sellid=ts.id and ts.ticketno=:ticketno") ;
					sql.append(" union all ");
					sql.append("select tr.returnway,tr.charges,decode(ta.price,0,0,(ta.price - tr.returnamount) / ta.price),ta.price  from ticketreturn tr,ticketsellagent ta");
					sql.append(" where tr.sellid=ta.id and ta.ticketno=:ticketno");
		
		Query query = super.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		List list = query.getResultList();
		return list;
		
	}
	
	/**
	 * 查询某个单号对应的Billinuse记录
	 * @param billtypeid
	 * @param orgid
	 * @param recipient
	 * @param voucherno
	 * @param batchno
	 * @return
	 */
	public Billinuse getBillinuse(Long billtypeid, Long orgid, Long recipient, Long voucherno){
		StringBuffer sql = new StringBuffer();
		sql.append("select t from Billinuse t ")
				.append(" where t.orgid = :orgid  ")
				.append(" and t.billtypeid = :billtypeid ")
				.append(" and t.recipients = :recipient ")
				.append(" and t.startno <= :voucherno ")
				.append(" and t.endno >= :voucherno ")
				.append(" and t.status in ('1', '2') ")//1正在使用,2已经用完
				.append("  order by t.createtime desc ");
		Query query = super.getEntityManager().createQuery(sql.toString());
		query.setParameter("billtypeid", billtypeid);
		query.setParameter("orgid", orgid);
		query.setParameter("recipient", recipient);
		query.setParameter("voucherno", voucherno);
		
		List<Billinuse> list = query.getResultList();
		return (list != null && list.size() > 0) ? list.get(0) : null;
	}
	
	/**
	 * 通过退票记录id查询退票打印信息
	 * @param ticketreturnid
	 * @param qryType: from ticketsell or ticketsellagent
	 * @return
	 */
	public List<Object> qryTicketreurnInfo(Long ticketreturnid, String qryType){
		StringBuffer sql = new StringBuffer();
		if("ticketsell".equals(qryType)){
			//从ticketsell表进行查询
			sql.append("select ts.price as tickettotalprice, t.returnamount as ticketreturntotal,");
			sql.append("       t.charges as charges, ts.price as ticketprice, t.returnamount as returnamount,");
			sql.append("       t.returnvoucherno as returnvoucherno, t.returntime as returntime,");
			sql.append("       tt.name as ticketoutletsname, u.code as sellbycode, u.name as sellbyname,");
			sql.append("       ts.ticketno as ticketno, s.code as schedulecode, c.name as customername,");
			sql.append("       ds.name as departstationname, rs.name as reachstationname,");
			sql.append("       ts.departdate as departdate, ts.departtime as departtime, '' || ts.seatno as seatno,");
			sql.append("       ir.insuranceno as insuranceno, ir.premium as premium, 1 as returnnum");
			sql.append("       from ticketreturn t left join ticketsell ts on t.sellid = ts.id");
			sql.append("            left join insurance ir on ts.id = ir.sellid");
			sql.append("            left join ticketoutlets tt on t.ticketoutletsid = tt.id");
			sql.append("            left join userinfo u on t.returnby = u.id");
			sql.append("            left join schedule s on ts.scheduleid = s.id");
			sql.append("            left join customer c on ts.customerid = c.id");
			sql.append("            left join station ds on ts.departstationid = ds.id");
			sql.append("            left join station rs on ts.reachstationid = rs.id");
			sql.append("       where t.id = :ticketreturnid ");
		}else{
			//从ticketsellagent表进行查询
			sql.append("select ts.price as tickettotalprice, t.returnamount as ticketreturntotal,");
			sql.append("       t.charges as charges, ts.price as ticketprice, t.returnamount as returnamount,");
			sql.append("       t.returnvoucherno as returnvoucherno, t.returntime as returntime,");
			sql.append("       tt.name as ticketoutletsname, u.code as sellbycode, u.name as sellbyname,");
			sql.append("       ts.ticketno as ticketno, ts.schedulecode as schedulecode, c.name as customername,");
			sql.append("       ds.name as departstationname, rs.name as reachstationname,");
			sql.append("       ts.departdate as departdate, ts.departtime as departtime, '' || ts.seatno as seatno,");
			sql.append("       ir.insuranceno as insuranceno, ir.premium as premium, 1 as returnnum");
			sql.append("       from ticketreturn t left join ticketsellagent ts on t.sellid = ts.id");
			sql.append("            left join insurance ir on ts.id = ir.sellid");
			sql.append("            left join ticketoutlets tt on t.ticketoutletsid = tt.id");
			sql.append("            left join userinfo u on t.returnby = u.id            ");
			sql.append("            left join customer c on ts.customerid = c.id");
			sql.append("            left join station ds on ts.departstationid = ds.id");
			sql.append("            left join station rs on ts.reachstationid = rs.id");
			sql.append("       where t.id = :ticketreturnid ");
		}

		Query query = super.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("ticketreturnid", ticketreturnid);
		return query.getResultList();
	}
	
	private Ticketsign getSignRate(String ticketno) {
		StringBuffer sql = new StringBuffer("select t from Ticketsell ts , Ticketsign t where t.sellid = ts.id and ts.ticketno = :ticketno "); 
		Query query = super.getEntityManager().createQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		List list = query.getResultList();
		return (Ticketsign) (list!=null && list.size()>0 ? list.get(0) : null);
	}
	
	/**
	 * 团体票：根据主票票号查询出所有主票和副票数据
	 * @param propertyFilters
	 * @param ticketno：主票票号
	 * @return
	 */
	private  List<TicketreturnQueryDto> qryTuanTickets(List<PropertyFilter> propertyFilters, String ticketno, Long loginorgid){
		Iterator<PropertyFilter> iterator = propertyFilters.iterator();
		while(iterator.hasNext()){
			PropertyFilter propertyFilter = iterator.next();
			if (propertyFilter.getPropertyFullName().equalsIgnoreCase("tsl!ticketno")) {
				iterator.remove();
				break;
			}
		}
		
		// 判断查询方式
				boolean isfindbyvip = false; // 按VIP查询
				boolean isfindbyschedule = false; // 按班次查询
				for (PropertyFilter propertyFilter : propertyFilters) {
					if (propertyFilter.getPropertyFullName().equalsIgnoreCase(
							"v!vipcardno")) {
						isfindbyvip = true;
					}
					if (propertyFilter.getPropertyFullName().equalsIgnoreCase("sc!id")) {
						isfindbyschedule = true;
					}
				}

				StringBuilder sql = new StringBuilder();
				sql.append("select  1 as isselfschedule,");
				if (loginorgid == null || loginorgid <= 0) {
					sql.append(
							" case tsl.ticketstatus when '0' then 1 else 0 end as isselected,")
							.append(" case when isr.id is not null and isr.insurancestatus='0' and "
									+"to_number(to_char(tsl.departdate, 'yyyymmdd') || replace(tsl.departtime, ':', ''))"
						            +"  > = to_number(to_char(sysdate, 'yyyymmddhh24mi')) "
									+ "then 0 else null end as isreturninsure,");
				} else {
					sql.append(
							" case when tsl.ticketstatus='0' and (tsl.orgid="
									+ loginorgid + " or sc.orgid=" + loginorgid
									+ ")  then 1 else null end as isselected,").append(
							" case when isr.id is not null and isr.insurancestatus='0' and (tsl.orgid="
									+ loginorgid + " or sc.orgid=" + loginorgid +") and "
									+ "to_number(to_char(tsl.departdate, 'yyyymmdd') || replace(tsl.departtime, ':', ''))"
									+" > = to_number(to_char(sysdate, 'yyyymmddhh24mi')) "
									+ " then 0 else null end as isreturninsure,");
				}
				sql.append(
						" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
						.append(" tsl.ischecked,tsl.isdepartinvoices,tsl.islinework,tsl.orgid,sc.orgid as scheduleorgid,tsl.paymethod,")
						.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
//						.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
						.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus, typ.name as tickettype, tsl.carrychildnum as childnum,")//携童数
						.append(" tsl.departstationid,tsl.reachstationid,")

						.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

						.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

						.append(" us.name as signbyname,")
						.append(" sc.code as schedulecode,")
						.append(" ctm.name as customername,")
						.append(" std.name as departstationname,")
						.append(" str.name as reachstationname,ss.status,")
						.append(" dd2.value as ticketstatusname,'' as openapiorgname")
						.append(" ,ddt.value as certificatetype,ctm.certificateno as certificateno,tsg.signrate as signrate ,tn.rate as rate,(tn.charges + tn.chargesweb) charges, ")
						.append(" tsl.returnfeemode canreturnmoneyback ,isr.sellway insurancesellway ")
						.append(" , 0 as isohteragent ") //是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票
						.append("  ,tsl.orderno, isr.orderno as insuorderno ")
						.append(" from Ticketsell tsl left join Ticketsign tsg")
						.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=1")
						.append(" left join Ticketreturn tn on tn.sellid=tsl.id")
						.append(" left join Userinfo us on tsg.signby=us.id")
						.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
						.append(" left join Customer ctm on tsl.customerid=ctm.id")
						.append(" left join Tickettype typ on tsl.tickettype = typ.code ")
						.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
						.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")
						.append(" ,Schedule sc,Station std,Station str,Schedulestatus ss ,Userinfo usell");
				if (isfindbyvip) {
					sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
				}
				sql.append(" ,digitaldictionary d1,digitaldictionarydetail dd2");
				//sql.append(" ,digitaldictionary d2,digitaldictionarydetail dd3");
				sql.append(" where tsl.scheduleid=sc.id")
						.append(" and tsl.departstationid=std.id")
						.append(" and tsl.reachstationid=str.id")
						.append(" and tsl.departstationid=ss.departstationid")
						.append(" and tsl.scheduleplanid=ss.scheduleplanid")
						.append(" and tsl.sellway<>'12'")
						.append(" and tsl.ticketstatus in( '0','1')") //新增退票查询只查询退票状态的
						.append(" and tsl.ticketstatus=dd2.code and d1.id=dd2.digitaldictionaryid")
//						.append(" and ctm.certificatetype=dd3.code and d2.id=dd3.digitaldictionaryid")
						.append(" and d1.tablename='ticketsell' and d1.columnname='ticketstatus'")
						.append(" and tsl.sellby=usell.id and tsl.price>0 ");
//				.append(" and d2.tablename='customer' and d2.columnname='certificatetype'");
				if (isfindbyvip) {
					sql.append(" and v.id=vc.vipid").append(" and vc.type='0'")
							.append(" and vc.id=vcd.vipconsumeid")
							.append(" and vcd.isselfschedule=1")
							.append(" and vcd.sellid=tsl.id");
				}
				if (!"".equals(ticketno)) {
					sql.append(" and tsl.ticketno like '").append(ticketno).append("%' ");//团体票票号查询使用like
				}
				String clientCondition = PropertyFilter.toJpql(propertyFilters, true);
				if ((clientCondition == null || clientCondition.trim().equals("")) && CommonUtil.isEmptyString(ticketno)) {
					clientCondition = " and 1=2";
				}
				sql.append(clientCondition);

				List<PropertyFilter> propertyFilters_agent = new ArrayList<PropertyFilter>();
				propertyFilters_agent.addAll(propertyFilters);

				if (!isfindbyschedule) {
					// 查询售异站票表
					sql.append(" union all select  0 as isselfschedule,")
							.append(" case tsl.ticketstatus when '0' then 1 else 0 end as isselected,")
							.append(" case when isr.id is not null and isr.insurancestatus='0' then 1 else null end as isreturninsure,")
							.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
							.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
							.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
//							.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
							.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus, typ.name as tickettype, tsl.carrychildnum as childnum,")//携童数
							.append(" tsl.departstationid,tsl.reachstationid,")

							.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

							.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

							.append(" us.name as signbyname,")
							.append(" tsl.schedulecode,")
							.append(" ctm.name as customername,")
							.append(" std.name as departstationname,")
							.append(" str.name as reachstationname,'0' as status,")
							.append(" dd2.value as ticketstatusname,'' as openapiorgname")
							.append(" ,ddt.value as certificatetype,ctm.certificateno as certificateno,tsg.signrate,tn.rate,(tn.charges + tn.chargesweb) charges, ")
							.append("  '0' canreturnmoneyback,isr.sellway insurancesellway  ")
							.append(" , decode(usell.orgid, :loginorgid, 0, 1) as isohteragent ") //是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票。ticketsellagent中售票员所属机构与退票员所属机构相同，则为本站所售联网票，否则为异站联网票
							.append("  ,tsl.orderno, isr.orderno as insuorderno ")
							.append(" from Ticketsellagent tsl left join Ticketsign tsg")
							.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=0")
							.append(" left join Ticketreturn tn on tn.sellid=tsl.id")
							.append(" left join Userinfo us on tsg.signby=us.id")
							.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
							.append(" left join Customer ctm on tsl.customerid=ctm.id")
							.append(" left join Tickettype typ on tsl.tickettype = typ.code ")
							.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
							.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")
							.append(" ,Station std,Station str,Userinfo usell");
					if (isfindbyvip) {
						sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
					}
					sql.append(" ,digitaldictionary d1,digitaldictionarydetail dd2");
				//	sql.append(" ,digitaldictionary d2,digitaldictionarydetail dd3");
					sql.append(" where tsl.departstationid=std.id")
							.append(" and tsl.reachstationid=str.id")
							.append(" and tsl.sellby=usell.id")
							.append(" and tsl.ticketstatus in( '0','1')") //新增退票查询只查询退票状态的
							.append(" and tsl.ticketstatus=dd2.code and d1.id=dd2.digitaldictionaryid")
							//.append(" and ctm.certificatetype=dd3.code and d2.id=dd3.digitaldictionaryid")
							.append(" and d1.tablename='ticketsell' and d1.columnname='ticketstatus'");
						//	.append(" and d2.tablename='customer' and d2.columnname='certificatetype'");
					if (isfindbyvip) {
						sql.append(" and v.id=vc.vipid").append(" and vc.type='0'")
								.append(" and vc.id=vcd.vipconsumeid")
								.append(" and vcd.isselfschedule=0")
								.append(" and vcd.sellid=tsl.id");
					}
					if (!"".equals(ticketno)) {
						sql.append(" and tsl.ticketno like '").append(ticketno).append("%' ");//团体票票号查询使用like
					}
					String clientCondition_agent = PropertyFilter.toJpql(
							propertyFilters_agent, true);
					if ((clientCondition_agent == null || clientCondition_agent.trim().equals("")) && CommonUtil.isEmptyString(ticketno)) {
						clientCondition_agent = " and 1=2";
					}
					sql.append(clientCondition_agent);

					// openAPI省中心联网票退票查询
					sql.append(" union all select  0 as isselfschedule,")
							.append(" case tsl.ticketstatus when '0' then 1 else 0 end as isselected,")
							.append(" case when isr.id is not null and isr.insurancestatus='0' then 1 else null end as isreturninsure,")
							.append(" tsl.id,tsl.departdate,trim(tsl.departtime) as departtime,tsl.fullprice,")
							.append(" null as ischecked,null as isdepartinvoices,tsl.islinework,usell.orgid,tsl.orgid as scheduleorgid,tsl.paymethod,")
							.append(" tsl.price,tsl.servicefee,tsl.seatno,tsl.sellby,usell.name as sellbyname,tsl.selltime,")
//							.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus,tsl.tickettype,tsl.seattype,")
							.append(" tsl.ticketno,tsl.sellway,tsl.ticketstatus, typ.name as tickettype, tsl.carrychildnum as childnum,")//携童数
							.append(" tsl.departstationid,tsl.reachstationid,")

							.append(" tsg.id as ticketsignid,tsg.charges as signcharges,tsg.signreason,tsg.signtime,tsg.signby,")

							.append(" isr.id as insuranceid,isr.premium,isr.paymethod as insurancepaymethod,isr.insuranceno,")

							.append(" us.name as signbyname,")
							.append(" tsl.schedulecode,")
							.append(" ctm.name as customername,")
							.append(" tsl.departstationname as departstationname,tsl.reachstationname as reachstationname,")
							.append(" '0' as status,")
							.append(" dd2.value as ticketstatusname,tsl.orgname as openapiorgname")
							.append(" ,ddt.value as certificatetype,ctm.certificateno as certificateno,tsg.signrate,tn.rate,(tn.charges + tn.chargesweb) charges, ")
							.append("  '0' canreturnmoneyback,isr.sellway insurancesellway  ")
							.append(" , decode(usell.orgid, :loginorgid, 0, 1) as isohteragent ") //是否为他站所售联网票：供参数1106业务判断使用， 集中式环境下，本站（A站）能否退B站售C站票。ticketsellagent中售票员所属机构与退票员所属机构相同，则为本站所售联网票，否则为异站联网票
							.append("  ,tsl.orderno, isr.orderno as insuorderno ")
							.append(" from Ticketsellagent tsl left join Ticketsign tsg")
							.append(" on tsl.id=tsg.sellid and tsg.isselfschedule=0")
							.append(" left join Ticketreturn tn on tn.sellid=tsl.id")
							.append(" left join Userinfo us on tsg.signby=us.id")
							.append(" left join Insurance isr on tsl.id=isr.sellid and isr.insurancestatus=0")
							.append(" left join Customer ctm on tsl.customerid=ctm.id")
							.append(" left join Tickettype typ on tsl.tickettype = typ.code ")
							.append(" left join (select dd3.code,dd3.value  from digitaldictionarydetail dd3 ,digitaldictionary d2 where  d2.tablename = 'customer'")
							.append("    and d2.columnname = 'certificatetype'  and d2.id = dd3.digitaldictionaryid ) ddt on ddt.code = ctm.certificatetype ")
							.append(" ,Userinfo usell");
					if (isfindbyvip) {
						sql.append(",vip v,vipconsume vc,vipconsumeldetail vcd");
					}
					sql.append(" ,digitaldictionary d1,digitaldictionarydetail dd2");
//					sql.append(" ,digitaldictionary d2,digitaldictionarydetail dd3");
					sql.append(" where 1=1")
							.append(" and tsl.departstationname is not null and tsl.reachstationname is not null ")
							.append(" and tsl.sellby=usell.id")
							.append(" and tsl.ticketstatus in( '0','1')") //新增退票查询只查询退票状态的
							.append(" and tsl.ticketstatus=dd2.code and d1.id=dd2.digitaldictionaryid")
//							.append(" and ctm.certificatetype=dd3.code and d2.id=dd3.digitaldictionaryid")
							.append(" and d1.tablename='ticketsell' and d1.columnname='ticketstatus'");
						//	.append(" and d2.tablename='customer' and d2.columnname='certificatetype'");
					if (isfindbyvip) {
						sql.append(" and v.id=vc.vipid").append(" and vc.type='0'")
								.append(" and vc.id=vcd.vipconsumeid")
								.append(" and vcd.isselfschedule=0")
								.append(" and vcd.sellid=tsl.id");
					}
					if (!"".equals(ticketno)) {
						sql.append(" and tsl.ticketno like '").append(ticketno).append("%' ");//团体票票号查询使用like
					}
					clientCondition_agent = PropertyFilter.toJpql( propertyFilters_agent, true);
					if ((clientCondition_agent == null || clientCondition_agent.trim().equals("")) && CommonUtil.isEmptyString(ticketno)) {
						clientCondition_agent = " and 1=2";
					}
					sql.append(clientCondition_agent);

				}
				sql.append(" order by ticketno");
		
		Query query = super.getEntityManager().createNativeQuery(sql.toString(),TicketreturnQueryDto.class);
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		if (!isfindbyschedule) {
			query.setParameter("loginorgid", loginorgid);
		}
//		List<Object[]> result = query.getResultList();
		return query.getResultList();
	}
	private BigDecimal getRate(String departtime, boolean strislinework)
			throws ParseException {
		DateFormat fmt = new SimpleDateFormat("yyyy-MM-dd HH:mm");
		Date departdatetime = fmt.parse(departtime);
		Global global = CurrentUtil.getGlobal();
		TicketreturnrateService ticketreturnrateService = new TicketreturnrateServiceImpl();
		Date now = new Date();
		BigDecimal hoursbetweendeparttime = new BigDecimal(0);
		hoursbetweendeparttime = (new BigDecimal(departdatetime.getTime()
				- now.getTime())).divide(new BigDecimal(1000))
				.divide(new BigDecimal(60), BigDecimal.ROUND_UP)
				.divide(new BigDecimal(60), BigDecimal.ROUND_UP);
		play.Logger.info(String.valueOf(hoursbetweendeparttime));
		boolean islinework = false;
//		if (strislinework.equals("true")) {
//			islinework = true;
//		}
		return ticketreturnrateService.getticketreturnrate(global
				.getOrganization().getId(), hoursbetweendeparttime,fmt.parse(departtime), strislinework);
	}
	/**
	 * 生成车票现金、车站垫付、原路返还对应的退票款
	 * @param trvoList
	 */
	public void genReturnPrice(long orgid, List<TicketreturnQueryVo> trvoList){
		String para1180 = parameterService.findParamValue("1180", orgid);//参数1180: 窗口电子支付退款方式，0：车站垫付，1：原路返还
		
		for (TicketreturnQueryVo vo : trvoList) {
			if("7".equals(vo.getSellway()) || "10".equals(vo.getSellway())){
				//网售
				if(vo.isCanreturnmoneyback()){
					//原路返还
					vo.setNocashreturnprice(vo.getPrice().subtract(vo.getCharges()));//电子退款金额
					vo.setCashreturnprice(BigDecimal.ZERO);
					vo.setNochargesnocashprice(vo.getPrice());
					vo.setNocashinsureprice(vo.getPremium());
				}else{
					//车站垫付
					vo.setNocashreturnprice(BigDecimal.ZERO);//电子退款金额
					vo.setCashreturnprice(vo.getPrice().subtract(vo.getCharges()));
					vo.setNochargesnocashprice(BigDecimal.ZERO);
					vo.setNocashinsureprice(BigDecimal.ZERO);
				}
			}else{
				//非网售
				if("0".equals(vo.getPaymethod())){
					//现金售
					vo.setCashreturnprice(vo.getPrice().subtract(vo.getCharges()));//现金退款金额
					vo.setNocashreturnprice(BigDecimal.ZERO);
					vo.setNochargesnocashprice(BigDecimal.ZERO);
					vo.setNocashinsureprice(BigDecimal.ZERO);
				}else{
					//非现金售
					if("0".equals(para1180)){
						//1180=0：车站垫付
						vo.setNocashreturnprice(BigDecimal.ZERO);//电子退款金额
						vo.setCashreturnprice(vo.getPrice().subtract(vo.getCharges()));
						vo.setNochargesnocashprice(BigDecimal.ZERO);
						vo.setNocashinsureprice(BigDecimal.ZERO);
					}else if("1".equals(para1180)){
						//1180=1：原路返还
						vo.setNocashreturnprice(vo.getPrice().subtract(vo.getCharges()));//电子退款金额
						vo.setCashreturnprice(BigDecimal.ZERO);
						vo.setNochargesnocashprice(vo.getPrice());
						if("0".equals(vo.getInsurancepaymethod())){
							vo.setNocashinsureprice(BigDecimal.ZERO);
						}else{
							vo.setNocashinsureprice(vo.getPremium());
						}
					}
				}
			}
		}
		
	}
}