package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.map.HashedMap;

import util.SystemException;
import util.UserTransaction;

import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PacktturnoverDao;
import cn.nova.bus.pack.dao.PacktturnoverdetailDao;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packdepartinvoicesdetail;
import cn.nova.bus.pack.model.Packtturnover;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.pack.service.PacktturnoverService;
import cn.nova.bus.pack.service.PacktturnoverdetailService;
import cn.nova.bus.pack.vo.PackDeparVO;
import cn.nova.bus.pack.vo.PacktturnoverVO;
import cn.nova.bus.report.dao.TicketTurnOverReportDao;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.security.Global;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import cn.nova.utils.commons.StringUtils;


public class PacktturnoverServiceImpl implements PacktturnoverService {

	
	PacktturnoverDao packtturnoverDao =  new PacktturnoverDao();
	PacktturnoverdetailDao packturnoverdetaildao = new PacktturnoverdetailDao();
	PacktturnoverdetailService turnoverdetailService = new PacktturnoverdetailServiceImpl();
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	//UserTransaction usertransaction = new UserTransaction();
	
	@Override
	public List<Map<String, Object>> query(String orgid, Long userid, Date fromdate,Date enddate) {
		
		
		return ListUtil.listToMap(new Object[]{
				"ischoose","sellby","sellbyname","sellbytime"
				,"orgid","orgname","acceptpieces","accepttotalfee",
				"goodspieces","goodstotalfee","pkuppieces","pkuptotalfee",
				"totalmoney","upmoneystatus","upmoneydate","receipttime",
				"receiver","receivername","lastlost"
				,"depositpieces","recaptionspieces"
				},
				packtturnoverDao.query(orgid,userid, fromdate,enddate),
				new Object[]{
			Boolean.class,Long.class,String.class,String.class
			,Long.class,String.class,Integer.class,BigDecimal.class,
			Integer.class,BigDecimal.class,Integer.class,BigDecimal.class,
			BigDecimal.class,Boolean.class,Timestamp.class,Timestamp.class,
			Long.class,String.class,BigDecimal.class
			,Integer.class,Integer.class
			});
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Packtturnover savePacktturnover(Packtturnover packtturnover,String pactturnoverdetailid) throws ServiceException {
		
			packtturnover = packtturnoverDao.getEntityManager().merge(packtturnover);

				
		
		if (!"".equals(pactturnoverdetailid)) {
			String[] packdetailid = pactturnoverdetailid.split(",");
			Packtturnoverdetail packtturnoverdetail = null;
			for (int i = 0; i < packdetailid.length; i++) {
				packtturnoverdetail = turnoverdetailService.getById(Long
						.parseLong(packdetailid[i]));
				if (!packtturnoverdetail.isIsturnover()) {
					packtturnoverdetail.setIsturnover(true);
					packtturnoverdetail.setTurnovertime(new Date());
					packtturnoverdetail.setPacktturnoverid(packtturnover.getId());
					packtturnoverdetail.setUpdateby(packtturnover.getCreateby());
					packtturnoverdetail.setUpdatetime(new Date());
						packturnoverdetaildao.merge(packtturnoverdetail);		
					
				} else {
					
				}
				
			}
		}
				
		return packtturnover;
	}

	@Override
	public Packtturnover auditPacktturnover(Global global,String pactturnoverdetailid)
			throws ServiceException {
		// TODO Auto-generated method stub
		
		if (!"".equals(pactturnoverdetailid)) {
			String[] packdetailid = pactturnoverdetailid.split(",");
			Packtturnoverdetail packtturnoverdetail = null;
			for (int i = 0; i < packdetailid.length; i++) {
				packtturnoverdetail = turnoverdetailService.getById(Long
						.parseLong(packdetailid[i]));
				if (!packtturnoverdetail.isIsaudit()) {
					packtturnoverdetail.setIsaudit(true);
					packtturnoverdetail.setAudittime(new Date());
					packtturnoverdetail.setUpdateby(global.getUserinfo().getId());
					packtturnoverdetail.setUpdatetime(new Date());
						packturnoverdetaildao.merge(packtturnoverdetail);

				} else {
					
				}
				
			}
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> queryRevenueOfDay(String packdatafrom,
			List<PropertyFilter> propertyFilter) {
		// TODO Auto-generated method stub
		
		return ListUtil.listToMap(new Object[] { "userid","code", "name","packnum","sendpacktnum",
				"sendpackamount", "pickupsnum", "pickupamount", "moneypayable","actupmoney","ticketstartno",
				"ticketendno","shortlost","longlost","packstrike" },
				packtturnoverDao.queryRevenueOfDay(packdatafrom,propertyFilter), new Object[] {
						Long.class,String.class, String.class,Integer.class,Integer.class,
						BigDecimal.class, Integer.class,
						BigDecimal.class,BigDecimal.class, BigDecimal.class,
						String.class, String.class,BigDecimal.class,BigDecimal.class,BigDecimal.class});
		
		
		
	}

	@Override
	public Map<String, Object> queryTicketErrorReport(
			List<PropertyFilter> propertyFilter, int querytype,String packdatafrom) {
		// TODO Auto-generated method stub
		
		List<Object> list = packtturnoverDao.queryTicketErrorReport(propertyFilter,packdatafrom);
		
		// 记录横坐标
		Map<String, Integer> x = new HashedMap();
		// 记录纵坐标
		Map<String, Integer> y = new HashedMap();
		List<Object> panels = new ArrayList<Object>();
		panels.add("日期");
		List<Object> results = new ArrayList<Object>();
		int j = 1;
		// 生成横向坐标
		for (Object result : list) {
			Object[] rs = (Object[]) result;
			if (x.get(rs[2] + "") == null) {
				x.put(rs[2] + "", j);
				if (querytype == 0) {// 默认全部查询，使用复合表头显示长短款
					panels.add( rs[2] + "|长款");
					panels.add( rs[2] + "|短款");
					j += 2;
				} else {// 二选一显示
					panels.add(rs[2]);
					j += 1;
				}
			}
		}
		// querytype为0时默认查询长短款
		int length = querytype == 0 ? x.size() * 2 + 2: x.size() + 2;
		for (Object result : list) {
			Object[] rs = (Object[]) result;
			// 生成纵向坐标
			if (y.get(rs[0] + "") == null) {
				Object[] datas = new Object[length];
				datas[0] = rs[0];
				datas[length - 1] = 0;
				results.add(datas);
				y.put(rs[0] + "", results.size() - 1);
			}

			// 根据坐标设置数据
			Float d = new Float(rs[3] + "");
			if (querytype == 0) {// 长短款复合显示
				if (d > 0) {
					((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2]
							+ "")] = rs[3];
				} else if (d < 0) {
					((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2]
							+ "") + 1] = rs[3];
				}
				// 计算横向小计
				((Object[]) results.get(y.get(rs[0] + "")))[length - 1] = new BigDecimal(
						((Object[]) results.get(y.get(rs[0] + "")))[length - 1]
								+ "").add(new BigDecimal(rs[3] + ""));

			} else if (querytype == 1 && d > 0) {// 长款
				((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2] + "")] = rs[3];
				// 计算横向小计
				((Object[]) results.get(y.get(rs[0] + "")))[length - 1] = new BigDecimal(
						((Object[]) results.get(y.get(rs[0] + "")))[length - 1]
								+ "").add(new BigDecimal(rs[3] + ""));
			} else if (querytype == 2 && d < 0) {// 短款
				((Object[]) results.get(y.get(rs[0] + "")))[x.get(rs[2] + "")] = rs[3];
				// 计算横向小计
				((Object[]) results.get(y.get(rs[0] + "")))[length - 1] = new BigDecimal(
						((Object[]) results.get(y.get(rs[0] + "")))[length - 1]
								+ "").add(new BigDecimal(rs[3] + ""));
			}

		}

		// 返回数据集类型
		Object[] fieldtypes = new Object[length];
		// 固定类型设置
		fieldtypes[0] = Date.class;
		for (int i = 1; i < fieldtypes.length; i++) {
			fieldtypes[i] = BigDecimal.class;
		}
		// 返回数据集表头字段名称
		String title = "";
		panels.add("小计");
		for (int i = 0; i < panels.size(); i++) {
			title += "".equals(title) ? panels.get(i) : ":" + panels.get(i);
		}
		play.Logger.info("title:%s", title);
		// 返回多个数据
		Map<String, Object> returndatas = new HashMap<String, Object>();		
		returndatas.put("title", title);
		returndatas.put("resultmap",
				ListUtil.listToMap(panels.toArray(), results, fieldtypes));
		return returndatas;
		
		
	}

	@Override
	public List<Map<String, Object>> qryPacktturnoverinfo(long packtturndetailid) {
		// TODO Auto-generated method stub
		
		return ListUtil.listToMap(new Object[]{Packtturnover.class},
				packtturnoverDao.qryPacktturnoverinfo(packtturndetailid),
				new Object[]{Packtturnover.class});
	}
	
	@Override
	public List<Map<String, Object>> packManualMakeup(
			List<PropertyFilter> propertyFilters) {
		packtturnoverDao = new PacktturnoverDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"id","departdate", "departinvoicesno", "packno", "tostationname",
				"shipprice", "balanceamount", "status"},
				packtturnoverDao.packManualMakeup(propertyFilters),
				new Object[] { long.class,Date.class,String.class, String.class,String.class,
			BigDecimal.class,BigDecimal.class,String.class
						 });
		return result;
	}

	@Override
	public List<Map<String, Object>> findpackAndDepinfo(String packno) {
		packtturnoverDao = new PacktturnoverDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"packno", "tostationid", "tostationname","departinvoicesno", "shipprice", 
				"balanceamount","departdate","vehicleid","vehicleno","packdepartinvoiceid"},
				packtturnoverDao.findpackAndDepinfo(packno),
				new Object[] { String.class,long.class, String.class,String.class,BigDecimal.class
			,BigDecimal.class,Date.class,long.class,String.class,long.class});
		
		return result;  
	}

	@Override
	public boolean packManualsave(Global global, PackDeparVO packDeparvo)
			throws ServiceException {
		packtturnoverDao = new PacktturnoverDao();
		
		if(packDeparvo.getPackdepartinvoicesid()>0){
			return packtturnoverDao.updatePackDepart(packDeparvo);
		}else{
			
			Billtype billtype = billtypeService.findByCode(ConstDefiniens.BalanceBill);
			
			String departinvoicesno = packDeparvo.getDepartinvoicesno();
				
			// 补零操作
			if (billtype.getTicketnolength() != departinvoicesno.length()) {
				departinvoicesno = StringUtils.strPad(departinvoicesno,
						(int) billtype.getTicketnolength(), "0");
			}
			
			packDeparvo.setDepartinvoicesno(departinvoicesno);
			
			List list = findpackedepartinvoiceAndDepinfo(packDeparvo.getDepartinvoicesno());
			if(list.size()>1){
				throw new ServiceException("0606");     //行包结算单号已经存在
				
			}
			Packdepartinvoices packdepartinvoices = new Packdepartinvoices();
			packdepartinvoices.setDepartinvoicesno(packDeparvo.getDepartinvoicesno());
			packdepartinvoices.setDepartdate(packDeparvo.getDepartdate());
			packdepartinvoices.setVehicleid(packDeparvo.getVehicleid());
			packdepartinvoices.setShipprice(packDeparvo.getShipprice());
			packdepartinvoices.setBalanceamount(packDeparvo.getBalancemount());
			packdepartinvoices.setStatus("0");
			packdepartinvoices.setDatatype("1");
			packdepartinvoices.setCreateby(global.getUserinfo().getId());
			packdepartinvoices.setCreatetime(new Date());
			packdepartinvoices.setUpdateby(global.getUserinfo().getId());
			packdepartinvoices.setUpdatetime(new Date());
			packdepartinvoices = (Packdepartinvoices)packtturnoverDao.merge(packdepartinvoices);
			
			Packdepartinvoicesdetail packdepartinvoicesdetail = new Packdepartinvoicesdetail(); 
			
			packdepartinvoicesdetail.setPackdepartinvoicesid(packdepartinvoices.getId());
			packdepartinvoicesdetail.setSendstationid(global.getOrganization().getStation().getId());
			packdepartinvoicesdetail.setTostationid(packDeparvo.getTostationid());
			packdepartinvoicesdetail.setShipprice(packDeparvo.getShipprice());
			packdepartinvoicesdetail.setBalanceamount(packDeparvo.getBalancemount());
			packdepartinvoicesdetail.setCreateby(global.getUserinfo().getId());
			packdepartinvoicesdetail.setCreatetime(new Date());
			packdepartinvoicesdetail.setUpdateby(global.getUserinfo().getId());
			packdepartinvoicesdetail.setUpdatetime(new Date());
			packdepartinvoicesdetail = (Packdepartinvoicesdetail)packtturnoverDao.merge(packdepartinvoicesdetail);
			return packdepartinvoices.getId()>0?true:false;
		}
//		return 0;
	}

	@Override
	public boolean packManualdel(Packdepartinvoices packdepartinvoices) {
		packtturnoverDao = new PacktturnoverDao();
	    return packtturnoverDao.packManualdel(packdepartinvoices);
	}

	@Override
	public List<Map<String, Object>> findpackedepartinvoiceAndDepinfo(String packdepartinvoicesno) {
		// TODO Auto-generated method stub
		packtturnoverDao = new PacktturnoverDao();
		List<Map<String, Object>> result = ListUtil.listToMap(new Object[] {
				"id"},
				packtturnoverDao.findpackedepartinvoiceAndDepinfo(packdepartinvoicesno),
				new Object[] {long.class });
		
		return result;   
	}

}
