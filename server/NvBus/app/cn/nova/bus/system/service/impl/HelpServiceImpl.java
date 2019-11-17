package cn.nova.bus.system.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import util.AppConstant;
import util.CommonUtil;
import util.CurrentUtil;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.HelpService;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.openapi.sevice.impl.OpenApiAdapterImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;
import cn.nova.utils.orm.jpa.ListUtil;

public class HelpServiceImpl implements HelpService {

	private IDAO<Object> dao = new EntityManagerDaoSurport<Object>();

	@Override
	public List<Map<String, Object>> find(String helpType, String param,
			List<PropertyFilter> propertyFilterList, Global global) {
		StringBuilder sql = new StringBuilder();
		// 组织机构
		if (helpType.equals("OrgManagerHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Organization t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code from Organization t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 非不同步下载的是车站、配客点组织机构
		else if (helpType.equals("4")
				|| helpType.equals("OrgHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Organization t")
						.append(" where t.islocal=1 and t.isactive=1 ")
						.append(" and (t.type='1' or t.type='2' or t.type='0' or t.type='3')");
			} else {
				sql.append("select t.id,t.name,t.code from Organization t")
						.append(" where t.islocal=1  and t.isactive=1")
						.append(" and (t.type='1' or t.type='2'  or t.type='0')")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.code like '%" + param + "%')");
			}
			sql.append(" and t.id in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			// List<Object> objs = dao.find(sql.toString(), propertyFilterList,
			// new String[] { "t.id" });
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		else if (helpType.equals("DriverOrStewardHelpByVehicleid")) {

			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Driver t")
						.append(" where  t.isactive=1 ");
				
				for (PropertyFilter propertyFilter : propertyFilterList) {
					if(propertyFilter!=null){
						sql.append(" and t.vehicleid  = ");
						sql.append(propertyFilter.getMatchValue());
					}
				}
				sql.append(" union all ");
				sql.append(" select t.id,t.name,t.code from Steward t ")
				.append(" where  t.isactive=1 ");
				for (PropertyFilter propertyFilter : propertyFilterList) {
					if(propertyFilter!=null){
						sql.append(" and t.vehicleid  = ");
						sql.append(propertyFilter.getMatchValue());
					}
				}
		
			} 
//			else {
//				sql.append("select t.id,t.name,t.code from Driver t")
//				.append(" where  t.isactive=1 ");
//				sql.append(" union all ");
//				sql.append(" select t.id,t.name,t.code from Steward t")
//				.append(" where  t.isactive=1 ");
//			
//			}
			Query query = dao.getEntityManager().createNativeQuery(sql.toString());
			propertyFilterList.clear();
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, query.getResultList(), filedtypes);
		}
		else if (helpType.equals("OrgHelpStation")
				|| helpType.equals("OrgHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Organization t")
						.append(" where t.isactive=1 ") //t.islocal=1 and 
						.append(" and (t.type='1' or t.type='2' or t.type='0')");
			} else {
				sql.append("select t.id,t.name,t.code from Organization t")
						.append(" where t.islocal=1  and t.isactive=1")
						.append(" and (t.type='1' or t.type='2'  or t.type='0')")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.code like '%" + param + "%')");
			}
			sql.append(" and t.id in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			// List<Object> objs = dao.find(sql.toString(), propertyFilterList,
			// new String[] { "t.id" });
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 售票机构
		else if (helpType.equals("notnetOrg")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Organization t")
						.append(" where t.islocal=1 and t.isactive=1 ")
						.append(" and (t.type='1' or t.type='2')");
			} else {
				sql.append("select t.id,t.name,t.code from Organization t")
						.append(" where t.islocal=1  and t.isactive=1")
						.append(" and (t.type='1' or t.type='2')")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.code like '%" + param + "%')");
			}
			sql.append(" and t.id in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			// List<Object> objs = dao.find(sql.toString(), propertyFilterList,
			// new String[] { "t.id" });
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}// 非网络售票机构
		
		else if (helpType.equals("OrgticketingStation")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Organization t where 1=1 ");//where t.type not in('1','2')
			} else {

			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 部门
		else if (helpType.equals("DepHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Department t");
				sql.append("  where t.parentid in " + global.getOrgIDs());
			} else {
				sql.append("select t.id,t.name,t.code from Department t where t.name like '%"
						+ param + "%' or t.code like '%" + param + "%'");
				sql.append("  and t.parentid in " + global.getOrgIDs());
			}
			sql.append("  and t.isactive = 1");
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 角色用户二级联动
		else if (helpType.equals("UserRoleHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id ,t.name,t.code from Userinfo t,Userrole ur,Role r where t.isactive=1 and t.id = ur.id.userid and ur.id.roleid = r.id ");
			} else {
				sql.append("select t.id ,t.name,t.code  from Userinfo t,Userrole ur,Role r where t.isactive=1 and t.id = ur.id.userid and ur.id.roleid = r.id "
						+ " and ( t.name like '%"
						+ param
						+ "%'  or t.code like '%"
						+ param + "%' ) ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.code" }), filedtypes);
		}
		else if (helpType.equals("RoleCheckedHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.name as code from Role t ");
				sql.append("  where t.orgid in " + global.getOrgIDs());
			} else {
				sql.append("select t.id,t.name,t.name as code from Role t where t.name like '%"
						+ param + "%' ");//or t.code like '%" + param + "%'
				sql.append("  and t.orgid in " + global.getOrgIDs());
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
			
		}
		// 角色....
		else if (helpType.equals("RoleHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name from Role t ");
				sql.append("  where t.orgid in " + global.getOrgIDs());
			} else {
				sql.append("select t.id,t.name from Role t where t.name like '%"
						+ param + "%' or t.code like '%" + param + "%'");
				sql.append("  and t.orgid in " + global.getOrgIDs());
			}
			Object[] fileds = { "id", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		} // 区域帮助.....
		else if (helpType.equals("DistrictHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code,t.jianpin from District t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code ,t.jianpin from District t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%'  or t.jianpin like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code", "jianpin" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}//标准站点
		else if("stationStandard".equals(helpType)){
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.code,t.name,t.stationname,t.stationaddress from Stationstandard t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.code,t.name,t.stationname,t.stationaddress from Stationstandard t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%'  or t.name like '%"
						+ param
						+ "%') ");
			}
			Object[] fileds = { "id", "code","name", "stationname", "stationaddress" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class,String.class };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 车属单位
		else if (helpType.equals("UnitHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code,t.jianpin,t.fullname from Unit t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code,t.jianpin,t.fullname from Unit t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%'"
						+ " or t.jianpin like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code", "jianpin","fullname" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class,String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 支付方式
		else if(helpType.equals("paymethod")){
			List list= new ArrayList();
			Object[] arr1 ={1, "按电子支付统计","1"};
			list.add(arr1);
			Object[] arr2={2, "按现金支付统计","2"};
			list.add(arr2);
			Object[] fileds = {"id","name","code"};// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class};// 初始化要查询的字段
			// 的类型
			return ListUtil.listToMap(fileds, list, filedtypes);
		}
		// 车属单位
		else if (helpType.equals("UnitUsedHelp")) {
			if (param == null || "" == param || param.equals("")) {
				// List<PropertyFilter> filters = new
				// ArrayList<PropertyFilter>();
				// Date departdate=DateUtils.add(new Date(), -90);
				// filters.add(new PropertyFilter("GED_vr!departdate",
				// departdate));
				sql.append("select  t.id,t.name,t.code,t.jianpin")
						.append(" from Unit t, Vehiclereport vr, Vehicle v")
						.append(" where t.isactive = 1 and t.id = v.unitid  and vr.vehicleid = v.id")
						.append(" and vr.departdate >=sysdate-60")
						.append(" group by t.id, t.name, t.code, t.jianpin order by count(vr.id) desc");

				Object[] fileds = { "id", "name", "code", "jianpin" };// 初始化要查询的字段
				Object[] filedtypes = { Long.class, String.class, String.class,
						String.class };// 初始化要查询的字段
				return ListUtil.listToMap(fileds, dao.find(sql.toString()),
						filedtypes);
			} else {
				sql.append("select t.id,t.name,t.code,t.jianpin from Unit t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%'"
						+ " or t.jianpin like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code", "jianpin" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 结算单位
		else if (helpType.equals("BalanceUnitHelp")) {
			if (param == null || "" == param || param.equals("")) {
				// List<PropertyFilter> filters = new
				// ArrayList<PropertyFilter>();
				// Date departdate=DateUtils.add(new Date(), -60);
				// filters.add(new PropertyFilter("GED_vr!departdate",
				// departdate));
				sql.append("select t.id,t.name,t.code,t.jianpin")
						.append(" from Unit t, Vehiclereport vr, Vehicle v")
						.append(" where t.isactive = 1 and t.id = v.balanceunitid  and vr.vehicleid = v.id")
						.append(" and vr.departdate >=sysdate-60")
						.append(" group by t.id, t.name, t.code, t.jianpin order by count(vr.id) desc");
				Object[] fileds = { "id", "name", "code", "jianpin" };// 初始化要查询的字段
				Object[] filedtypes = { Long.class, String.class, String.class,
						String.class };// 初始化要查询的字段
				return ListUtil.listToMap(fileds, dao.find(sql.toString()),
						filedtypes);
			} else {
				sql.append("select t.id,t.name,t.code,t.jianpin from Unit t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%'"
						+ " or t.jianpin like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code", "jianpin" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 车型
		else if (helpType.equals("VehicletypeHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code,t.rationseatnum,t.customname from Vehicletype t where t.isactive=1");
			} else {
				sql.append("select t.id,t.name,t.code,t.rationseatnum,t.customname from Vehicletype t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%' or t.rationseatnum like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code", "rationseatnum",
					"customname" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					Short.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.name" }), filedtypes);

		}
		// 售票点
		else if (helpType.equals("TicketoutletHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.jianpin,t.code from Ticketoutlets t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.jianpin,t.code from Ticketoutlets t where (t.name like '%"
						+ param
						+ "%' or t.jianpin like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%') and t.isactive=1 ");
			}
			//去掉机构条件，需要查异站售票点
//			sql.append("  and t.orgid in " + global.getOrgIDs());
						
			Object[] fileds = { "id", "name", "jianpin", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			// 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		//联动售票点
		else if(helpType.equals("TicketoutletsHelp")){
			sql.append("select t.id,t.name,t.jianpin,t.code from Ticketoutlets t where t.isactive=1 " );
			if(param != null && param != "" && !param.equals("")){
				sql.append("and t.orgid in"+ param);
			}
			Object[] fileds = { "id", "name", "jianpin", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			// 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 驾驶员
		else if (helpType.equals("DriverHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code,t.workno,t.qualification from Driver t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code,t.workno,t.qualification from Driver t where t.isactive=1 and (t.name like '%"
						+ param + "%' or t.code like '%" + param + "%')");
			}
			//sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code","workno","qualification" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		//驾驶员（支持输入驾驶证号）
		else if (helpType.equals("drivinglicenseHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Driver t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code from Driver t where t.isactive=1 and (t.name like '%"
						+ param + "%' or t.drivinglicense like '%" + param + "%' or t.jianpin like '%" + param + "%')");
			}
			//sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 乘务员
		else if (helpType.equals("StewardHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Steward t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code from Steward t where t.isactive=1 and (t.name like '%"
						+ param + "%' or t.code like '%" + param + "%')");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}

		// 线路
		else if (helpType.equals("RouteHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code,t.jianpin,t.orgid,s.helpcode as endstationcode from Route t,Station s"
						+ " where t.endstationid=s.id and t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code,t.jianpin,t.orgid ,s.helpcode as endstationcode from Route t,Station s "
						+ "where (t.name like '%"
						+ param
						+ "%' or t.jianpin like '%"
						+ param
						+ "%' or s.helpcode like '%"
						+ param+"%') and t.endstationid=s.id and t.isactive=1 ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code", "jianpin", "orgid" ,"endstationcode"};// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, Long.class ,String.class};// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 线路终点站
		else if (helpType.equals("RouteEndHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select s.id, t.name,s.helpcode as code from Route t,Station s")
						.append(" where t.isactive=1 and t.endstationid=s.id");
			} else {
				sql.append("select  s.id, t.name,s.helpcode as code from Route t,Station s where (s.name like '%"
						+ param
						+ "%' or s.helpcode like '%"
						+ param
						+ "%' or s.jianpin like '%"
						+ param
						+ "%') and t.isactive=1 and t.endstationid=s.id");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
																				// 的类型
			return ListUtil.listToMap(fileds,dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 线路停靠点
		else if (helpType.equals("RouteStopHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select s.id,s.name,s.jianpin from Routestop t,Station s where t.stationid=s.id ");
			} else {
				sql.append("select s.id,s.name,s.jianpin from Routestop t,Station s where t.stationid=s.id and t.route.id="
						+ param + " ");
			}
			Object[] fileds = { "id", "name", "code", "jianpin" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.orderno" }),
					filedtypes);
		}
		// 线路停靠点
		else if (helpType.equals("RouteSHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select s.id,s.name,s.jianpin,s.isdepart,t.stationid from Routestop t,Station s where t.stationid=s.id and s.isactive=1 and t.isactive=1 ");
			} else {
				sql.append("select s.id,s.name,s.jianpin,s.isdepart,t.stationid from Routestop t,Station s where t.stationid=s.id and (s.jianpin like '%"
						+ param
						+ "%' or s.name like '%"
						+ param
						+ "%') and s.isactive=1 and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "jianpin", "isdepart",
					"stationid" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					boolean.class, Long.class };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.orderno" }),
					filedtypes);
		}
		// 班次
		else if (helpType.equals("ScheduleHelp")) {
			if (param == null || "" == param || param.equals("")) {
				//查询重复班次号
				//sql.append("select t.id ,t.code as name,t.code,t.starttime from Schedule t where t.isactive=1 ");
				sql.append("select t.id ,t.code as name,t.code,t.starttime from Schedule t where (t.isactive=1 or (t.isactive=0 and t.isovertime=1))  ");
			} else {
				//查询重复班次号
//				sql.append("select t.id ,t.code as name,t.code,t.starttime  from Schedule t where t.isactive=1 and "
//						+ "  (t.code like '%" + param + "%')");
				sql.append("select t.id ,t.code as name,t.code,t.starttime  from Schedule t where (t.isactive=1 or (t.isactive=0 and t.isovertime=1)) and "
						+ "  (t.code like '" + param + "%')   and rownum<=200 ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code", "starttime" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.code" }), filedtypes);
		}else if (helpType.equals("DistinctScheduleHelp")) {//按照发车时间和班次号分组的
			sql.append("select min(t.id) as id ,t.code as name,t.code,t.starttime  from Schedule t where (t.isactive=1 or (t.isactive=0 and t.isovertime=1))  ");
			if (CommonUtil.isNotEmptyString(param)) {
				sql.append(" and (t.code like '" + param + "%')");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			sql.append("  group by t.code,t.starttime ");
			Object[] fileds = { "id", "name", "code", "starttime" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.code" }), filedtypes);
		}
		// 班次+时间
		else if (helpType.equals("ScheduletimeHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id ,concat(t.code, '  (')||t.starttime||')' as name, t.code")
						.append(" from Schedule t where t.isactive=1 ");
			} else {
				sql.append(
						"select t.id ,concat(t.code, '  (')||t.starttime||')' as name, t.code ")
						.append(" from Schedule t where t.isactive=1 and "
								+ "  (t.code like '%" + param + "%')");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.code" }), filedtypes);
		}
		// 班次线路
		else if (helpType.equals("ScheduleRHelp")) {
			if (param == null || "" == param || param.equals("")) {
				/*
				 * sql.append(
				 * "select distinct t.id ,t.code as name,t.starttime, t.code,s.name as endstationname, "
				 * ) .append(
				 * "s.id as stationid from Schedule t,Route r ,Station s,Organization o,Schedulestop ss where t.isactive=1 and "
				 * ) .append(
				 * " t.route.id=r.id and r.endstationid=s.id and t.id = ss.schedule.id"
				 * ) .append(
				 * " and ss.stationid = o.station.id and ss.isdepart = 1 and ss.isactive = 1"
				 * );
				 */
				//
				sql.append(
					"select distinct t.id ,t.code as name,t.starttime, t.code,s.name as endstationname, ")
				//	.append("s.id as stationid from Schedule t,Route r ,Station s,Schedulestop ss where t.isactive=1 and ")
			    	.append("s.id as stationid from Schedule t,Route r ,Station s,Schedulestop ss,")
			    	.append(" Scheduleplan sp")
			    	.append(" where (t.isactive=1 or (t.isactive=0 and t.isovertime=1)) and t.isdelete = 0  ")
			    	.append(" and t.id = sp.scheduleid and sp.departdate >= trunc(sysdate)")
					.append(" and t.route.id=r.id and r.endstationid=s.id and t.id = ss.schedule.id")
					.append(" and ss.isdepart = 1 and ss.isactive = 1");

			} else {
				sql.append(
						"select distinct t.id ,t.code as name,t.starttime, t.code,s.name as endstationname, ")
						.append(" s.id as stationid from Schedule t ,Route r,Station s,Schedulestop ss where (t.isactive=1 or (t.isactive=0 and t.isovertime=1)) and  ")
						.append(" ss.isdepart = 1 and ss.isactive = 1 and t.isdelete = 0")
						.append(" and t.id = ss.schedule.id")
						.append(" and t.route.id=r.id and r.endstationid=s.id and (t.code like '")
						.append(param)
						.append("%' or r.jianpin like '%" + param + "%')" + " ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "starttime", "code",
					"endstationname", "stationid" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, String.class, Long.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.starttime" }),
					filedtypes);
		}
		
		// 班次循环专用
		else if (helpType.equals("ScheduleCycleHelp")) {
			if (param == null || "" == param || param.equals("")) {
				/*
				 * sql.append(
				 * "select distinct t.id ,t.code as name,t.starttime, t.code,s.name as endstationname, "
				 * ) .append(
				 * "s.id as stationid from Schedule t,Route r ,Station s,Organization o,Schedulestop ss where t.isactive=1 and "
				 * ) .append(
				 * " t.route.id=r.id and r.endstationid=s.id and t.id = ss.schedule.id"
				 * ) .append(
				 * " and ss.stationid = o.station.id and ss.isdepart = 1 and ss.isactive = 1"
				 * );
				 */
				//
				sql.append(
					"select distinct t.id ,t.code as name,t.starttime, t.code,s.name as endstationname, ")
				//	.append("s.id as stationid from Schedule t,Route r ,Station s,Schedulestop ss where t.isactive=1 and ")
			    	.append("s.id as stationid from Schedule t,Route r ,Station s,Schedulestop ss where (t.isactive=1 or (t.isactive=0 and t.isovertime=1 and t.updatetime >= sysdate -30)) and ")
					.append(" t.route.id=r.id and r.endstationid=s.id and t.id = ss.schedule.id")
					.append(" and ss.isdepart = 1 and ss.isactive = 1");

			} else {
				sql.append(
						"select distinct t.id ,t.code as name,t.starttime, t.code,s.name as endstationname, ")
						.append(" s.id as stationid from Schedule t ,Route r,Station s,Schedulestop ss where (t.isactive=1 or (t.isactive=0 and t.isovertime=1 t.updatetime >= sysdate -30)) and  ")
						.append(" ss.isdepart = 1 and ss.isactive = 1")
						.append(" and t.id = ss.schedule.id")
						.append(" and t.route.id=r.id and r.endstationid=s.id and (t.code like '%")
						.append(param)
						.append("%' or r.jianpin like '%" + param + "%')" + " ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "starttime", "code",
					"endstationname", "stationid" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, String.class, Long.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.starttime" }),
					filedtypes);
		}

		// 车辆品牌型号
		else if (helpType.equals("VehiclebrandmodelHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id as id ,t.brandname||'('||t.rationseatnum||')' as name ,t.modelcode as code,t.rationseatnum,")
						.append(" t.vehicletypeid,v.name as vehicletypename from Vehiclebrandmodel t,Vehicletype v")
						.append(" where t.isactive=1 and t.vehicletypeid=v.id ");
			} else {
				sql.append(
						"select t.id as id ,t.brandname||'('||t.rationseatnum||')' as name ,t.modelcode as code,t.rationseatnum, ")
						.append(" t.vehicletypeid,v.name as vehicletypename from Vehiclebrandmodel t,Vehicletype v")
						.append(" where t.isactive=1 and t.vehicletypeid=v.id and (t.brandname like '%"
								+ param
								+ "%' or t.modelcode like '%"
								+ param
								+ "%' or t.rationseatnum like '%"
								+param
								+"%') ");
			}
			Object[] fileds = { "id", "name", "code", "rationseatnum",
					"vehicletypeid", "vehicletypename" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					Short.class, Long.class, String.class };// 初始化要查询的字段
			return ListUtil
					.listToMap(fileds, dao.find(sql.toString(),
							propertyFilterList,
							new String[] { "t.brandname,t.rationseatnum" }),
							filedtypes);
		}

		// 站点帮助(所有站点)
		else if (helpType.equals("StationHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade,distance")
						.append(" from Station t")
						.append(" where t.isactive=1 ");
			} else {
				// sql.append(
				// "select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade from Station t")
				// .append(" where t.isactive=1 ")
				// .append(" and (t.name like '%").append(param)
				// .append("%' or t.jianpin like '%").append(param)
				// .append("%' or t.helpcode like '%").append(param)
				// .append("%')")
				// .append(" order by instr(t.jianpin,'").append(param).append("')||instr(t.helpcode,'").append(param).append("')||instr(t.name,'").append(param).append("')")
				// .append(" 		   ||case when instr(t.jianpin,'").append(param).append("')>0 then replace(t.jianpin,'").append(param).append("')")
				// .append("                 when instr(t.helpcode,'").append(param).append("')>0 then replace(t.helpcode,'").append(param).append("')")
				// .append("                 when instr(t.name,'").append(param).append("')>0 then replace(t.name,'").append(param).append("')")
				// .append("            end,t.createtime");
				sql.append(
						"select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade,t.distance ")
						.append(" from Station t Left Join Staionsort ts On ts.stationid=t.id")
						.append(" where t.isactive=1 ")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.jianpin like '%").append(param)
						.append("%' or t.helpcode like '%").append(param)
						.append("%')").append(" order by instr(t.jianpin,'")
						.append(param).append("')||instr(t.helpcode,'")
						.append(param).append("')||instr(t.name,'")
						.append(param).append("')")
						.append(" 		   ||case when instr(t.jianpin,'")
						.append(param).append("')>0 then replace(t.jianpin,'")
						.append(param).append("')")
						.append("                 when instr(t.helpcode,'")
						.append(param).append("')>0 then replace(t.helpcode,'")
						.append(param).append("')")
						.append("                 when instr(t.name,'")
						.append(param).append("')>0 then replace(t.name,'")
						.append(param).append("')").append("            end")
						.append("            ,nvl(sellnum,0) desc")
						.append("            ,t.createtime");
			}
			Object[] fileds = { "id", "code", "name", "helpcode", "jianpin",
					"isdepart", "grade", "distance" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, String.class, String.class, String.class,
					Long.class, };// 初始化要查询的字段
			Query query = dao.getEntityManager().createNativeQuery(
					sql.append(PropertyFilter.toJpql(propertyFilterList, true))
							.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			return ListUtil
					.listToMap(fileds, query.getResultList(), filedtypes);

		}
		// 票种
		else if (helpType.equals("TicketTypeHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.code,t.name,t.isdefault from Tickettype t"
						+ " where t.isactive=1 and t.code not in ('S') ");
			} else {
				sql.append("select t.id,t.code,t.name,t.isdefault  from Tickettype t"
						+ " where t.isactive=1 and t.code not in ('S') "
						+ " and t.name like '%"
						+ param
						+ "%'  or t.code like '%" + param + "%' " + " ");
			}
			Object[] fileds = { "id", "code", "name", "isdefault" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 票种要显示上限价
		else if (helpType.equals("TicketTypeSHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.code,t.name,t.isdefault from Tickettype t"
						+ " where t.isactive=1  ");
			} else {
				sql.append("select t.id,t.code,t.name,t.isdefault  from Tickettype t"
						+ " where t.isactive=1 "
						+ " and t.name like '%"
						+ param + "%'  or t.code like '%" + param + "%' " + " ");
			}
			Object[] fileds = { "id", "code", "name", "isdefault" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 票据类型 (所有类型)
		else if (helpType.equals("BilltypeHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.code,t.name,t.ticketnolength from Billtype t"
						+ " where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.code,t.name,t.ticketnolength  from Billtype t"
						+ " where t.isactive=1 "
						+ " and t.name like '%"
						+ param + "%'  or t.code like '%" + param + "%' " + " ");
			}
			Object[] fileds = { "id", "code", "name", "ticketnolength" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					Long.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 票据仓库
		else if (helpType.equals("BillstorageHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.code,t.name from Billstorage t"
						+ " where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.code,t.name from Billstorage t"
						+ " where t.isactive=1 " + " and t.name like '%"
						+ param + "%'  or t.code like '%" + param + "%' " + " ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "code", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}

		// 起点站帮助
		else if (helpType.equals("StartStationHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade,o.type as orgtype")
						.append(" from Station t,Organization o")
						.append(" where t.id=o.stationid and t.isactive=1 and t.isdepart = 1")
						.append(" and o.islocal=1");
			} else {
				/*
				 * sql.append(
				 * "select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade from Station t,Organization o"
				 * ) .append(" where o.station.id=t.id and t.isactive=1 ")
				 * .append(" and (t.name like '%").append(param)
				 * .append("%' or t.jianpin like '%").append(param)
				 * .append("%' or t.helpcode like '%").append(param)
				 * .append("%')").append(" and o.islocal=true");
				 */

				sql.append(
						"select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade,nvl(o.type,'1') as orgtype")
						.append("  from Station t left join Organization o on o.stationid=t.id ")
						.append(" where t.isactive=1 and t.isdepart = 1")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.jianpin like '%").append(param)
						.append("%' or t.helpcode like '%").append(param)
						.append("%')");
			}
			sql.append(" order by t.id").append(
					PropertyFilter.toJpql(propertyFilterList, true));
			Query query = dao.getEntityManager().createNativeQuery(
					sql.toString());
			JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
			Object[] fileds = { "id", "code", "name", "helpcode", "jianpin",
					"isdepart", "grade", "orgtype" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, String.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil
					.listToMap(fileds, query.getResultList(), filedtypes);
		}
		

		// 联网起点站帮助
		else if (helpType.equals("NetStartStationHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade,o.type as orgtype, 0 as isnet ")
						.append(" from Station t,Organization o ")
						.append(" where o.station.id=t.id and t.isactive=1 ")
						.append(" and o.islocal=0");
			} else {
				sql.append(
						"select t.id,t.code,t.name,t.helpcode,t.jianpin,t.isdepart,t.grade,o.type as orgtype, 0 as isnet ")
						.append(" from Station t,Organization o ")
						.append(" where o.station.id=t.id and t.isactive=1 ")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.jianpin like '%").append(param)
						.append("%' or t.helpcode like '%").append(param)
						.append("%')").append(" and o.islocal=0");
			}
			Object[] fileds = { "id", "code", "name", "helpcode", "jianpin",
					"isdepart", "grade", "orgtype", "isnet" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, String.class, String.class, String.class,
					String.class, Integer.class };// 初始化要查询的字段
			List<Object> list = dao.find(sql.toString(), propertyFilterList,
					new String[] { "t.id" });

			// 新增联网售票的始发站查询

			if (CurrentUtil.isOpenApiable()) {
				list.addAll(new OpenApiAdapterImpl()
						.findDepartStation2Array(param));
			}

			return ListUtil.listToMap(fileds, list, filedtypes);

		}

		// 联网起点区域帮助
		else if (helpType.equals("NetStartDistrictHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select distinct dt.id,dt.code,dt.name,dt.jianpin from Station t,Organization o,District dt")
						.append(" where o.station.id=t.id and t.isactive=1 ")
						.append(" and o.islocal=false")
						.append(" and t.districtid=dt.id");
			} else {
				sql.append(
						"select distinct dt.id,dt.code,dt.name,dt.jianpin from Station t,Organization o,District dt")
						.append(" where o.station.id=t.id and t.isactive=1 ")
						.append(" and o.islocal=false")
						.append(" and t.districtid=dt.id")
						.append(" and (dt.name like '%").append(param)
						.append("%' or dt.jianpin like '%").append(param)
						.append("%' or dt.code like '%").append(param)
						.append("%')");
			}
			Object[] fileds = { "id", "code", "name", "jianpin" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "dt.id" }), filedtypes);

		}

		// 检票口帮助
		else if (helpType.equals("TicketEntranceHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.printname as code from Ticketentrance t,Organization o"
						+ " where t.isactive=1 and t.orgid=o.id");
			} else {

			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 上车卡位帮助
		else if (helpType.equals("VehicleparkHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.printname as code from Vehiclepark t,Organization o"
						+ " where t.isactive=1  and t.orgid=o.id");
			} else {

			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 车牌号码+车属于单位+厂牌+车型帮助
		else if (helpType.equals("VehiclenoHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id,t.vehicleno as name,t.cardno as code,t.seatnum,v.brandname,")
						.append(" u.name as unitname,ve.name as vehicletypename,ve.id as vehicletypeid,t.unitid,v.id as brandid, ")
						.append(" t.balanceunitid,u2.name as balancename,t.isneedfinger,t.liabilityinsureno,")
						.append(" t.liabilityinsureenddate,t.compulsoryinsureno,t.compulsoryinsureenddate,t.driverlicense,")
						.append(" t.licenseenddate,t.workno,t.workenddate,t.roadno,t.type,dd.value,t.contractenddate,t.contractno")
						.append(" from Vehicle t,Vehiclebrandmodel  v,Unit u,Vehicletype ve,Unit u2,Digitaldictionary d,Digitaldictionarydetail dd ")
						.append(" where t.isactive=1 and t.unitid=u.id and t.vehicletypeid=ve.id and t.vehiclebrandmodelid=v.id and d.tablename = 'vehicle' and d.columnname = 'type' and dd.digitaldictionary.id = d.id and dd.code = t.type ")
						.append(" and t.balanceunitid=u2.id");
			} else {
				sql.append(
						"select t.id,t.vehicleno as name,t.cardno as code,t.seatnum,v.brandname,")
						.append(" u.name as unitname,ve.name as vehicletypename ,ve.id as vehicletypeid,t.unitid,v.id as brandid,")
						.append(" t.balanceunitid,u2.name as balancename,t.isneedfinger,t.liabilityinsureno,")
						.append(" t.liabilityinsureenddate,t.compulsoryinsureno,t.compulsoryinsureenddate,t.driverlicense,")
						.append(" t.licenseenddate,t.workno,t.workenddate,t.roadno,t.type,dd.value,t.contractenddate,t.contractno")
						.append(" from Vehicle t ,Vehiclebrandmodel  v,Unit u,Vehicletype ve,Unit u2,Digitaldictionary d,Digitaldictionarydetail dd ")
						.append(" where t.isactive=1 and t.unitid=u.id and t.vehiclebrandmodelid=v.id and d.tablename = 'vehicle' and d.columnname = 'type' and dd.digitaldictionary.id = d.id and dd.code = t.type and t.vehicletypeid=ve.id and t.vehicleno like '%")
						.append(param).append("%'")
						.append(" and t.balanceunitid=u2.id");
			}
			Object[] fileds = { "id", "name", "code", "seatnum", "brandname",
					"unitname", "vehicletypename", "vehicletypeid", "unitid",
					"brandid", "balanceunitid", "balancename", "isneedfinger",
					"liabilityinsureno", "liabilityinsureenddate",
					"compulsoryinsureno", "compulsoryinsureenddate",
					"driverlicense", "licenseenddate", "workno", "workenddate",
					"roadno", "type", "value","contractenddate","contractno"  };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					Short.class, String.class, String.class, String.class,
					Long.class, Long.class, Long.class, Long.class,
					String.class, boolean.class, String.class, Date.class,
					String.class, Date.class, String.class, Date.class,
					String.class, Date.class, String.class, String.class,
					String.class, Date.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		else if(helpType.equals("VehiclenofeeHelp"))//新增对于固定扣费中车牌号change事件的处理
		{
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id ,t.vehicleno from Feestandardstationagent f ,Vehicle t ");
				sql.append(" where f.vehicleid=v.id ");		
			} else {
				sql.append("select t.id,t.vehicleno from Feestandardstationagent f ,Vehicle t ");
				sql.append(" where f.vehicleid=t.id ")
						
						.append("  and t.vehicleno like '%"+param+"%'");
			}
			Object[] fileds = {"id","vehicleno" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 保险公司帮助
		else if (helpType.equals("InsurerHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.address as code from Insurers t where 1=1 ");
			} else {
				sql.append("select t.id,t.name,t.address as code from Insurers t"
						+ " where 1=1 and t.name like '%" + param + "%' ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		} else if (helpType.equals("VehicleHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.vehicleno as name,t.cardno as code from Vehicle t "
						+ " where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.vehicleno as name,t.type as code from Vehicle t "
						+ " where t.isactive=1 and t.unitid = " + param + " ");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		} else if (helpType.equals("Vehicle4licenseHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.vehicleno as name,t.cardno as code,t.workno,t.driverlicense from Vehicle t "
						+ " where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.vehicleno as name,t.type as code,t.workno,t.driverlicense from Vehicle t "
						+ " where t.isactive=1 and t.vehicleno like '% "+param+"%' ");
			}
			Object[] fileds = { "id", "name", "code","work","driverlicense" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 用户
		else if (helpType.equals("UserHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id ,t.name,t.code from Userinfo t where t.isactive=1 ");
			} else {
				sql.append("select t.id ,t.name,t.code  from Userinfo t where t.isactive=1 and "
						+ " ( t.name like '%"
						+ param
						+ "%'  or t.code like '%"
						+ param + "%' ) ");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.code" }), filedtypes);
		}
		// 售票员用户
		else if (helpType.equals("SellTicketUserHelp")) {
			List<Object> list = new ArrayList<Object>();
			sql.append("select distinct uf.id, uf.name, uf.code  from Userinfo uf, Billinuse bt where uf.id = bt.recipients  and bt.billtypeid = 1");
			sql.append("  and uf.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			list.addAll(dao.find(sql.toString(),propertyFilterList, new String[] { "uf.code" }));
			list.addAll(dao.find("select distinct uf.id, uf.name, uf.code from Userinfo uf where uf.code = 'HJ-9999'",propertyFilterList, new String[] { "uf.code" }));
			return ListUtil.listToMap(fileds, list, filedtypes);
		} else if (helpType.equals("light")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code from Securitycheckitem t where t.categorycode=0");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("mirror")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=1");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("drive")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=2");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("brake")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=3");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}

		else if (helpType.equals("turn")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=4");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("wheel")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=5");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("hang")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=6");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("leak")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=7");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("window")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code  from Securitycheckitem t where t.categorycode=8");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("safety")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code from Securitycheckitem t where t.categorycode=9");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("camera")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code from Securitycheckitem t where t.categorycode=10");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("returncheck")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.describe as name,1 as code from Securitycheckitem t where t.categorycode=11");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("SecuritycheckHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.notenum as name,t.result as code from Securitycheck t");
			} else {
				sql.append("select t.id, t.notenum as name,t.result as code from Securitycheck t where t.notenum like '%"
						+ param + "%' ");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		} else if (helpType.equals("CarryHelp")) { // 初始化进位规则 应用模块

			sql.append("select t.id, t.describe as name,t.formula as code,t.modulecode from Carrycontrol t");
			Object[] fileds = { "id", "name", "code", "modulecode" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 保险类型
		else if (helpType.equals("InsuretypeHelp")) { // 初始化保险类型 应用模块
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.name as name, t.code from Insuretype t, Organization o where t.orgid = o.id");
			} else {
				sql.append(
						"select t.id, t.name as name, t.code from Insuretype t, Organization o where t.orgid = o.id ")
						.append(" and (t.code like '%" + param
								+ "%' or t.name like '%" + param + "%' ) ");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 车辆内部空间
		else if (helpType.equals("VehiclespaceHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id, t.name as name from Vehiclespace t where t.isactive=1 ")
						.append(" and t.ispassengerseat=1 ");
			} else {
				sql.append(
						"select t.id, t.name as name from Vehiclespace t where t.isactive=1 ")
						.append(" and t.ispassengerseat=1 and t.name like '%");
				sql.append(param);
				sql.append("%'");
			}
			Object[] fileds = { "id", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 节日信息
		else if (helpType.equals("HolidayHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.fullname as name,t.startdate,t.enddate  from Holiday t where t.isactive=1");
			} else {
				sql.append("select t.id, t.fullname as name,t.startdate,t.enddate from Holiday t where t.isactive=1 and t.fullname like '%");
				sql.append(param);
				sql.append("%'");
			}
			Object[] fileds = { "id", "name", "startdate", "enddate" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, Date.class,
					Date.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.startdate" }),
					filedtypes);

		}
		// 计划班次
		else if (helpType.equals("ScheduleplanHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id,s.id as scheduleid,s.code as name,t.departdate,ss.departtime,s1.name as endstationname,r.name as routename from Scheduleplan t,Schedule s, Schedulestatus ss,Route r,Station s1")
						.append(" where s.route.id=r.id and r.endstationid=s1.id and t.scheduleid=s.id and ss.scheduleplan.id=t.id and t.islinework=0 ");
			} else {
				sql.append(
						"select t.id,s.id as scheduleid,s.code as name,t.departdate,ss.departtime,s1.name as endstationname,r.name as routename from Scheduleplan t,Schedule s, Schedulestatus ss ")
						.append(" ,Route r,Station s1")
						.append(" where t.scheduleid=s.id and ss.scheduleplan.id=t.id and rownum<=100 and ")
						.append(" s.route.id=r.id and r.endstationid=s1.id and  (s.code like '%")
						.append(param).append("%' or r.jianpin like '%")
						.append(param).append("%')");
			}
			Object[] fileds = { "id", "scheduleid", "name", "departdate",
					"departtime", "endstationname", "routename" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, Long.class, String.class,
					Date.class, String.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "ss.departtime" }),
					filedtypes);
		}
		// 送票人
		else if (helpType.equals("TicketdeliverHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.deliverby as name from Ticketdeliver t");
			} else {
				sql.append("select t.id, t.deliverby as name from Ticketdeliver t where t.deliverby like '%");
				sql.append(param);
				sql.append("%'");
			}
			Object[] fileds = { "id", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 结算固定扣费项目
		else if (helpType.equals("BalancedeductitemHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.name,t.isticketpriceitem from Balancedeductitem t where t.isactive=1");
			} else {
				sql.append("select t.id, t.name,t.isticketpriceitem from Balancedeductitem t where t.isactive=1 and t.name like '%");
				sql.append(param);
				sql.append("%'");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "isticketpriceitem" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, boolean.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.parentid" }),
					filedtypes);

		}
		// 结算固定扣费对象
		else if (helpType.equals("BalancedeductTargetHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.name from Balancededucttarget t where t.isactive=1");
			} else {
				sql.append("select t.id, t.name from Balancededucttarget t where t.isactive=1 and t.name like '%");
				sql.append(param);
				sql.append("%'");
			}
			Object[] fileds = { "id", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.prioritylevel" }),
					filedtypes);

		}
		// 结算公式扣费项目
		else if (helpType.equals("BalanceformulaHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.formulaname as name from Balanceformula t where t.isactive=1");
			} else {
				sql.append("select t.id, t.formulaname as name from Balanceformula t where t.isactive=1 and t.name like '%");
				sql.append(param);
				sql.append("%'");
			}
			Object[] fileds = { "id", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.parentid" }),
					filedtypes);

		}
		// 结算固定扣费对象
		else if (helpType.equals("DeductitemHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id, t.name,t.code from Deductitem t where t.isactive=1");
			} else {
				sql.append("select t.id, t.name,t.code from Deductitem t where t.isactive=1 and (t.name like '%");
				sql.append(param);
				sql.append("%'").append(" or t.code like '%").append(param)
						.append("%')");
			}
			sql.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.orderno" }),
					filedtypes);
		}
		// 顾客
		else if (helpType.equals("CustomerHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select cus.id ,cus.name,cus.certificateno as code,dt.value as type"
						+ " from Customer cus,Digitaldictionarydetail dt "
						+ " where cus.certificatetype = dt.code and dt.digitaldictionary.id=35 ");
			} else {
				sql.append("select cus.id ,cus.name,cus.certificateno as code,dt.value as type "
						+ "from Customer cus,Digitaldictionarydetail dt  "
						+ "where cus.certificatetype = dt.code and dt.digitaldictionary.id=35"
						+ " and (upper(cus.name) like '%"
						+ param
						+ "%' or cus.certificateno like '%" + param + "%')");
			}
			sql.append(" and rownum<=10 ");//加上这句 执行计划cost会少很多，并且没必要全部展示出来
			Object[] fileds = { "id", "name", "code", "type" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "cus.id" }), filedtypes);

		}
		// 承包者
		else if (helpType.equals("ContractorHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select c.id ,c.name,c.idcard as code "
						+ " from Contractor c ");
			} else {
				sql.append(
						"select c.id ,c.name,c.idcard as code "
								+ " from Contractor c "
								+ " where c.name like '%" + param + "%'")
						.append(" or c.contractno like '%" + param + "%'");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "c.startdate" }),
					filedtypes);

		}
		// 注册功能
		else if (helpType.equals("FunctionHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select f.id ,f.name,f.functionkey as code,f.functiondescribe,f.parameterdescribe ")
						.append(" from Functionreg f ");
			} else {
				sql.append(
						"select f.id ,f.name,f.functionkey as code,f.functiondescribe,f.parameterdescribe ")
						.append(" from Functionreg f ")
						.append(" where f.name like '%" + param + "%'")
						.append(" or f.functiondescribe like '%" + param + "%'")
						.append(" or f.parameterdescribe like '%" + param
								+ "%'");
			}
			return ListUtil.listToMap(new Object[] { "id", "name", "code",
					"functiondescribe", "parameterdescribe" },
					dao.find(sql.toString(), propertyFilterList), new Object[] {
							Long.class, String.class, String.class,
							String.class, String.class });

		}
		// 取智能卡初始化还没有发放的卡号
		else if (helpType.equals("InitcardHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select i.id, i.cardno, dig.value as name,i.serialnumber");
				sql.append(" from Initcard i, Digitaldictionarydetail dig ");
				sql.append(" where dig.digitaldictionary.id=24 and i.cardtype=dig.code and i.id not in");
				sql.append("(select ic.id from Initcard ic, Cardissue c where ic.serialnumber=c.serialnumber)");
			} else {
				sql.append("select i.id, i.cardno, dig.value as name,i.serialnumber ");
				sql.append(" from Initcard i, Digitaldictionarydetail dig ");
				sql.append(" where dig.digitaldictionary.id=24 and i.cardtype=dig.code and i.id not in ");
				sql.append("(select ic.id from Initcard ic, Cardissue c where ic.serialnumber=c.serialnumber ");
				sql.append(" and c.status not in (1) )");
				sql.append(" and i.cardno like '%").append(param).append("%'");
			}
			return ListUtil.listToMap(new Object[] { "id", "cardno", "name",
					"serialnumber" },
					dao.find(sql.toString(), propertyFilterList), new Object[] {
							Long.class, String.class, String.class,
							String.class });
		}
		// 取智能卡初始化已发放的卡号
		else if (helpType.equals("CardissueHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select i.id, i.cardno, dig.value as name ");
				sql.append(" from Initcard i, Digitaldictionarydetail dig ");
				sql.append(" where dig.digitaldictionary.id=24 and i.cardtype=dig.code and i.id in");
				sql.append("(select ic.id from Initcard ic, Cardissue c where ic.serialnumber=c.serialnumber)");
			} else {
				sql.append("select i.id, i.cardno, dig.value as name ");
				sql.append(" from Initcard i, Digitaldictionarydetail dig ");
				sql.append(" where dig.digitaldictionary.id=24 and i.cardtype=dig.code and i.id in");
				sql.append("(select ic.id from Initcard ic, Cardissue c where ic.serialnumber=c.serialnumber)");
				sql.append(" and i.cardno like '%").append(param).append("%'");
			}
			return ListUtil.listToMap(new Object[] { "id", "cardno", "name" },
					dao.find(sql.toString(), propertyFilterList), new Object[] {
							Long.class, String.class, String.class });
		}
		// 取VIP的顾客
		else if (helpType.equals("VipHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select c.id, c.name, c.certificateno as code,c.mobilephone ");
				sql.append(" from Vip v, Customer c where v.customerid=c.id ");
			} else {
				sql.append("select c.id, c.name, c.certificateno as code,c.mobilephone ");
				sql.append(" from Vip v, Customer c where v.customerid=c.id and c.name like '%"
						+ param + "%'");
			}
			return ListUtil.listToMap(new Object[] { "id", "name", "code",
					"mobilephone" },
					dao.find(sql.toString(), propertyFilterList), new Object[] {
							Long.class, String.class, String.class,
							String.class });
		}
		// 站点并取区域信息帮助(是车站)
		else if (helpType.equals("StationDHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.helpcode as code,t.name,t.jianpin,")
						.append(" d.id as districtid,d.name as districtname")
						.append(" from Station t,District d")
						.append(" where t.districtid=d.id and t.isactive=1");
			} else {
				sql.append("select t.id,t.helpcode as code,t.name,t.jianpin,")
						.append(" d.id as districtid,d.name as districtname")
						.append(" from Station t,District d")
						.append(" where t.districtid=d.id and t.isactive=1")
						.append(" and (t.name like '%").append(param)
						.append("%' or t.jianpin like '%").append(param)
						.append("%' or t.helpcode like '%").append(param)
						.append("%')");
			}
			Object[] fileds = { "id", "code", "name", "jianpin", "districtid",
					"districtname" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 车属单位并取区域信息帮助
		else if (helpType.equals("UnitDHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code,t.jianpin,")
						.append(" d.id as districtid,d.name as districtname from Unit t,District d ")
						.append(" where t.districtid=d.id and t.isactive=1");
			} else {
				sql.append("select t.id,t.name,t.code,t.jianpin,")
						.append(" d.id as districtid,d.name as districtname from Unit t,District d ")
						.append(" where t.districtid=d.id and t.isactive=1")
						.append(" and (t.name like '%" + param
								+ "%' or t.code like '%" + param + "%'"
								+ " or t.jianpin like '%" + param + "%')");
			}
			Object[] fileds = { "id", "name", "code", "jianpin", "districtid",
					"districtname" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class, Long.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 打印票据类型
		else if (helpType.equals("PrintBillHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.id as code")
						.append(" from Printtemplatetype t")
						.append(" where t.id>0");
			} else {
				sql.append("select t.id,t.name,t.id as code")
						.append(" from Printtemplatetype t")
						.append(" where t.id>0").append(" and (t.name like '%")
						.append(param).append("%')");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 坏票登记原因查询
		else if (helpType.equals("BilldamagedRemark")) {
			sql.append("select t.damageddscribe from Billdamaged t group by t.damageddscribe ");
			Object[] fileds = { "damageddscribe" };// 初始化要查询的字段
			Object[] filedtypes = { String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.damageddscribe" }),
					filedtypes);

		}
		// 打印票据类型
		else if (helpType.equals("PrintBillItemHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.itemname as name,t.itemcode as code")
						.append(" from Printtemplatetypeitem t")
						.append(" where t.islist=0");
			} else {
				sql.append("select t.id,t.itemname as name,t.itemcode as code")
						.append(" from Printtemplatetypeitem t")
						.append(" where t.islist=0")
						.append(" and (t.itemname like '%").append(param)
						.append("%')");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);

		}
		// 售/退票点查询，用于多选框。
		else if (helpType.equals("TicketoutletCheckCombox")) {
			sql.append(
					"select t.id,t.name,t.code from Ticketoutlets t where t.isactive=1 ")
					.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 非线上 售/退票点查询，用于多选框。
		else if (helpType.equals("TicketoutletCheckComboxNotOnline")) {
			sql.append(
					"select t.id,t.name,t.code from Ticketoutlets t,Organization o where t.orgid = o.id and t.isactive=1 and o.isonline = 0 ")
			.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 售/退票点查询包括网站，用于多选框。
		else if (helpType.equals("TicketoutletCheckComboxAll")) {
			sql.append(
					"select t.id,t.name,t.code from Ticketoutlets t where t.isactive=1 ");
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		//站外售票点查询，用于多选框。
		else if (helpType.equals("OutTicketoutletCheckCombox")) {
			sql.append(
					"select t.id,t.name,t.code from Ticketoutlets t where t.isactive=1 and t.id>0")
					.append("  and t.orgid in " + global.getOrgIDs());
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}
		// 会员礼品名称(礼品活动有效期内，库存大于0)
		else if (helpType.equals("vipgiftnameHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select v.id,v.name ,v.quantity ").append(
						" from Vipgift v ");
				// .append(" where  v.quantity >= 0  ");//and v.enddate >=
				// sysdate
			} else {
				sql.append("select v.id,v.name ,v.quantity ")
						.append(" from Vipgift v ")
						.append(" where v.name like '%" + param + "%' ");// and
																			// v.enddate
																			// >=
																			// sysdate
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "v.name" }), filedtypes);

		} else if (helpType.equals("vehiclecodeHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select v.id,v.name ,v.code, v.fullname ").append(
						" from Vehiclecode v ");
			} else {
				sql.append("select v.id,v.name ,v.code, v.fullname ")
						.append(" from Vehiclecode v ")
						.append(" where v.code like '%" + param + "%' ");// and
																			// v.enddate
																			// >=
																			// sysdate
			}
			Object[] fileds = { "id", "name", "code", "fullname" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "v.name" }), filedtypes);
			// 统计方式
		} else if (helpType.equals("groupHelp")) {
			sql.append(
					"select a.code as id, a.value as name, a.id as code from Digitaldictionary t, Digitaldictionarydetail a ")
					.append("where t.id=a.digitaldictionary.id and t.tablename='routesaleticketreport' and t.columnname='grouptype' ")
					.append("order by a.orderno");
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds,
					dao.find(sql.toString(), propertyFilterList), filedtypes);
		} else if (helpType.equals("packfeetypeHelp")) {
//			sql.append(
//					"select t.id, t.name from Packfeetype t where 1=1 and t.orgid= ")
//					.append(global.getOrganization().getId());
			sql.append("select t.id, t.name from Packfeetype t where 1=1");
			Object[] fileds = { "id", "name" };
			Object[] filedtypes = { Long.class, String.class };
			return ListUtil.listToMap(fileds,
					dao.find(sql.toString(), propertyFilterList), filedtypes);
		}
        //显示车牌号
		else if(helpType.equals("VehiclemonthyHelp")){
			if (param == null || "" == param || param.equals("")) {
				sql.append("SELECT t.vehicleno,t.id FROM Vehicle t");
			} else {
				sql.append("select t.vehicleno,t.id FROM Vehicle t where (t.vehicleno like '%"
						+ param
						+ "%'  ) ");

			}
			Object[] fileds = {  "vehicleno","id" };// 初始化要查询的字段
			Object[] filedtypes = { String.class,Long.class
					 };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		
		}
		// 收费项目
		else if (helpType.equals("FeeitemHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select f.id,f.code,f.name from Feeitem f"
						+ " where f.isactive=1 ");
			} else {
				sql.append("select f.id,f.code,f.name from Feeitem f"
						+ " where f.isactive=1 "
						+ " and f.name like '%"
						+ param + "%'  or f.code like '%" + param + "%' " + " ");
			}
			Object[] fileds = { "id", "code", "name" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class};// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "f.id" }), filedtypes);

		}
		//收费项目角色控制
		else if(helpType.equals("rolefeeitemmap")){
			
				sql.append("select t.name,t.code,t.id from Feeitem t ,FeeitemPermission f,Role r,Userrole ur,Userinfo ui"
						+ " where t.id  = f.feeitemid and f.roleid=  r.id  and ur.id.roleid = r.id and ui.id = ur.id.userid "
						+ "and ui.id =  "+ global.getUserinfo().getId());
			
			Object[] fileds = {  "name", "code","id" };// 初始化要查询的字段
			Object[] filedtypes = { String.class, String.class,Long.class
					 };// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}//售票方式
		else if(helpType.equals("sellway")){
			sql.append("select a.id, a.value, a.code  from Digitaldictionary t, Digitaldictionarydetail a ")
			.append(" where t.id = a.digitaldictionary.id ")
			.append(" and t.tablename='ticketsell' and t.columnname='sellway' ");
			
		Object[] fileds = {  "id", "name", "code" };// 初始化要查询的字段
		Object[] filedtypes = {Long.class, String.class, String.class};// 初始化要查询的字段 的类型
		return ListUtil.listToMap(fileds, dao.find(sql.toString(),
				propertyFilterList, new String[] { "a.orderno" }), filedtypes);
		}else if("vehicleType".equals(helpType)){//车辆营运类型
			sql.append("SELECT di.code,di.value,di.code FROM Digitaldictionary d,Digitaldictionarydetail di where di.digitaldictionary.id=d.id ")
			.append("and d.tablename='vehicle' and d.columnname='type' ");
			Object[] fileds = {  "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = {Long.class, String.class, String.class};// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "di.orderno" }), filedtypes);
		}
		//updateby tianhb 20170328--begin 票据退领-使用状态更改为多选
		else if("billinuse".equals(helpType)){//票据领用记录状态：0没有使用、1正在使用、2已经用完
			sql.append("SELECT di.code,di.value,di.code FROM Digitaldictionary d,Digitaldictionarydetail di where di.digitaldictionary.id=d.id ")
			.append("and d.tablename='billinuse' and d.columnname='status' ");
			Object[] fileds = {  "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = {Long.class, String.class, String.class};// 初始化要查询的字段 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "di.orderno" }), filedtypes);
		}
		//updateby tianhb 20170328--end 票据退领-使用状态更改为多选
		else if (helpType.equals("otherorghelp")){
		if (param == null || "" == param || param.equals("")) {
			sql.append("select t.id,t.name,t.code from Organization t")
					.append(" where  t.isactive=1 ")
					.append(" and t.type='0' ");
		} else {
			sql.append("select t.id,t.name,t.code from Organization t")
					.append(" where t.isactive=1")
					.append(" and t.type='0' ")
					.append(" and (t.name like '%").append(param)
					.append("%' or t.code like '%" + param + "%')");
		}
		Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
		Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
		return ListUtil.listToMap(fileds, dao.find(sql.toString(),
				propertyFilterList, new String[] { "t.id" }), filedtypes);
		//技术支持禅道：20569 湖北省+十堰中心站+营收缴款增加查询条件 updateby tinhb-begin 2018年6月4日
		//用户部门查询  department
		}else if (helpType.equalsIgnoreCase("department")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.code from Department t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.code from Department t where (t.name like '%"
						+ param
						+ "%' or t.code like '%"
						+ param
						+ "%') and t.isactive=1");
			}
			Object[] fileds = { "id", "name", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		//技术支持禅道：20569 湖北省+十堰中心站+营收缴款增加查询条件 updateby tinhb-end 2018年6月4日
		}else {
			return null;
		}
	}

	@Override
	public List<Map<String, Object>> find(String helpType, String param,
			List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder();
		// 售票点
		if (helpType.equals("TicketoutletHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append("select t.id,t.name,t.jianpin,t.code from Ticketoutlets t where t.isactive=1 ");
			} else {
				sql.append("select t.id,t.name,t.jianpin,t.code from Ticketoutlets t where (t.name like '%"
						+ param
						+ "%' or t.jianpin like '%"
						+ param
						+ "%') and t.isactive=1 ");
			}
			Object[] fileds = { "id", "name", "jianpin", "code" };// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					String.class };// 初始化要查询的字段
			// 的类型
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}// 车牌号码+车属于单位+厂牌+车型帮助
		else if (helpType.equals("VehiclenoHelp")) {
			if (param == null || "" == param || param.equals("")) {
				sql.append(
						"select t.id,t.vehicleno as name,t.cardno as code,t.seatnum")
						.append(" from Vehicle t ")
						.append(" where t.isactive=1  ");
			} else {
				sql.append(
						"select t.id,t.vehicleno as name,t.cardno as code,t.seatnum")
						.append(" from Vehicle t ")
						.append(" where t.isactive=1  and t.vehicleno like '%")
						.append(param).append("%'")
						.append(" ");
			}
			Object[] fileds = { "id", "name", "code", "seatnum"};// 初始化要查询的字段
			Object[] filedtypes = { Long.class, String.class, String.class,
					Short.class };// 初始化要查询的字段
			return ListUtil.listToMap(fileds, dao.find(sql.toString(),
					propertyFilterList, new String[] { "t.id" }), filedtypes);
		}  else {
			return null;
		}
	}

	public void listArraySort(List<Object> list) {
		Collections.sort(list, new Comparator<Object>() {
			@Override
			public int compare(Object o1, Object o2) {
				Object[] row1 = (Object[]) o1;
				Object[] row2 = (Object[]) o2;
				return ((String) row1[2]).compareTo((String) row2[2]);
			}
		});
	}
}
