/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.report.service.impl<br/>
 * <b>文件名：</b>QueryBalanceitemServiceImpl.java<br/>
 * <b>版本信息：</b>v4.0<br/>
 * <b>日期：</b>2012-11-1 上午11:19:02<br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.report.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

import cn.nova.bus.report.dao.QueryBalanceitemDao;
import cn.nova.bus.report.service.QueryBalanceitemService;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * <b>类描述：</b><br/>
 * <b>类名称：</b>QueryBalanceitemServiceImpl.java<br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2012-11-1 上午11:19:02<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class QueryBalanceitemServiceImpl implements QueryBalanceitemService {
	private QueryBalanceitemDao dao = new QueryBalanceitemDao();
	
	@Override
	public List<Map<String, Object>> queryBalanceitem(String orgid, Date startdate, Date enddate, Long unitid,
			String vehicleno, String routename, String balanceno, String delphiField) {
		//结算通知单号-balanceno,线路-routename
		String[] strlist = delphiField.split(",");
		Object[] field = new Object[strlist.length];
		Object[] fieldType = new Object[strlist.length];
		for (int i = 0; i <= strlist.length-1; i++) {
			field[i] = strlist[i].split("-")[1];
			if(i<=3 || i==strlist.length-1){
				fieldType[i] = String.class;
			}else{
				fieldType[i] = BigDecimal.class;
			} 
		}
		List<Object> genBalanceData = genBalanceData(orgid, startdate, enddate, unitid, vehicleno);
		return ListUtil.listToMap(field, genBalanceData , fieldType);
	}
	
	
	// 获取前端展示列名
	public String genDelphiField(String orgid) {
		StringBuffer field = new StringBuffer();
		field.append("结算通知单号-balanceno,线路-routename,车牌号-vehicleno,结算单位-name,") // 4  0-3  
				.append("配载金额|客运收入-cargoticket,配载金额|行包收入-packprice,配载金额|包车收入-rentmoney,配载金额|车辆预缴款-vehicleturnover,"
						+ "配载金额|补录营收-cargodepartinvoicesother,配载金额|货票金额-packamount,配载金额|小计-dividemoney,") // 7, 4-10
				.append("扣款项目|分成金额-dividemoney,扣款项目|客运劳务费-diagentfee,扣款项目|行包劳务费-packmoney,扣款项目|包车劳务费-price,扣款项目|站务附加费-additionfee,扣款项目|货票代理费-packagent");// 6  11-16
		List<Object> itemlist = dao.genDelphiField(orgid);
		for (Object object : itemlist) {
			Object[] obj = (Object[]) object;
			field.append(",扣款项目|" + obj[0].toString() + "-" + obj[1].toString());
		}
		field.append(",扣款项目|扣款小计-deducttotal,实结金额-balancemoney,领款人签名-autograph"); // 3

		return field.toString();
	}
	
	// 查询并处理数据
	public List<Object> genBalanceData(String orgid, Date startdate, Date enddate, Long unitid, String vehicleno) {
		List<Object> listitem = dao.getBalancedeductitemName(orgid);
		List<Object> listdetail = dao.getBalancedeductdetail(orgid, startdate, enddate, unitid, vehicleno, "", "");
		List<Object> listbalance = dao.getBalance(orgid, startdate, enddate, unitid, vehicleno, "", "");  // 18列 
		List<Object> list = new ArrayList<Object>();
		Object[] objdetail = new Object[] {};
		Object[] objbalance = new Object[] {};
		Object[] newObject;
		BigDecimal[] sumObj = new BigDecimal[20 + listitem.size()];// 合计列信息
		if(listbalance==null||listbalance.size()==0){
			return null;
		}
		for (int i = 0; i < listbalance.size(); i++) {   
			newObject = new Object[20 + listitem.size()];
			boolean isExist = false;
			objbalance = (Object[]) listbalance.get(i);
			for (int j = 0; j < listdetail.size(); j++) {
				objdetail = (Object[]) listdetail.get(j);
				if (objbalance[0].equals(objdetail[0])) {
					BigDecimal money = new BigDecimal(0);
					newObject[0] = objbalance[1];
					newObject[1] = objbalance[2];
					newObject[2] = objbalance[3];
					newObject[3] = objbalance[4];
					if (objbalance[5] == null) {
						newObject[4] = 0;
					} else {
						newObject[4] = objbalance[5];
					}
					newObject[5] = objbalance[6];
					newObject[6] = objbalance[7];
					newObject[7] = objbalance[8];
					if (objbalance[11] == null) {
						newObject[8] = 0;
					} else {
						newObject[8] = objbalance[9];
					}
					newObject[9] = objbalance[16];
					newObject[10] = new BigDecimal(newObject[4].toString()).add(new BigDecimal(newObject[5].toString()))
							.add(new BigDecimal(newObject[6].toString())).add(new BigDecimal(newObject[7].toString()))
							.add(new BigDecimal(newObject[8].toString())).add(new BigDecimal(newObject[9].toString()));
					newObject[11] = objbalance[10];
					newObject[12] = objbalance[11];
					newObject[13] = objbalance[12];
					newObject[14] = objbalance[13];
					newObject[15] = objbalance[14];
					newObject[16] = objbalance[17];

					money = money.add(new BigDecimal(newObject[11].toString()));
					money = money.add(new BigDecimal(newObject[12].toString()));
					money = money.add(new BigDecimal(newObject[13].toString()));
					money = money.add(new BigDecimal(newObject[14].toString()));
					money = money.add(new BigDecimal(newObject[15].toString()));
					money = money.add(new BigDecimal(newObject[16].toString()));
					for (int k = 0; k < listitem.size(); k++) {
						newObject[17 + k] = objdetail[1 + k];
						String tem = "0";
						if (objdetail[1 + k] != null) {
							tem = objdetail[1 + k].toString();
						}
						money = money.add(new BigDecimal(tem));
					}
					newObject[17 + listitem.size()] = money;
					newObject[18 + listitem.size()] = objbalance[15];
					newObject[19 + listitem.size()] = "";
					list.add(newObject);
					// 合计信息 开始
					for (int m = 4; m <= 18 + listitem.size(); m++) {
						if ((newObject[m] != null && "".equals(newObject[m]) || newObject[m] == null)) {
							sumObj[m] = sumObj[m];
						} else {
							sumObj[m] = sumObj[m]==null?BigDecimal.ZERO:sumObj[m].add(new BigDecimal(String.valueOf(newObject[m])));
						}
					}
					// 合计信息 结束
					newObject = null;
					isExist = true;
				}
			}
			if (!isExist) {
				BigDecimal money = new BigDecimal(0);
				newObject[0] = objbalance[1];
				newObject[1] = objbalance[2];
				newObject[2] = objbalance[3];
				newObject[3] = objbalance[4];
				if (objbalance[5] == null) {
					newObject[4] = 0;
				} else {
					newObject[4] = objbalance[5];
				}
				newObject[5] = objbalance[6];
				newObject[6] = objbalance[7];
				newObject[7] = objbalance[8];
				if (objbalance[11] == null) {
					newObject[8] = 0;
				} else {
					newObject[8] = objbalance[9];
				}
				newObject[9] = objbalance[16];
				newObject[10] = new BigDecimal(newObject[4].toString()).add(new BigDecimal(newObject[5].toString()))
						.add(new BigDecimal(newObject[6].toString())).add(new BigDecimal(newObject[7].toString()))
						.add(new BigDecimal(newObject[8].toString())).add(new BigDecimal(newObject[9].toString()));
				newObject[11] = objbalance[10];
				newObject[12] = objbalance[11];
				newObject[13] = objbalance[12];
				newObject[14] = objbalance[13];
				newObject[15] = objbalance[14];
				newObject[16] = objbalance[17];

				money = money.add(new BigDecimal(newObject[11].toString()));
				money = money.add(new BigDecimal(newObject[12].toString()));
				money = money.add(new BigDecimal(newObject[13].toString()));
				money = money.add(new BigDecimal(newObject[14].toString()));
				money = money.add(new BigDecimal(newObject[15].toString()));
				money = money.add(new BigDecimal(newObject[16].toString()));
				for (int k = 0; k < listitem.size(); k++) {
					newObject[17 + k] = 0;
				}
				newObject[17 + listitem.size()] = money;
				newObject[18 + listitem.size()] = objbalance[15];
				;
				newObject[19 + listitem.size()] = "";
				list.add(newObject);
				// 合计信息 开始
				for (int m = 4; m <= 18 + listitem.size(); m++) {
					if (newObject[m] == null || "".equals(newObject[m])) {
						sumObj[m] = sumObj[m];
					} else {
						sumObj[m] = sumObj[m]==null?BigDecimal.ZERO:sumObj[m].add(new BigDecimal(String.valueOf(newObject[m])));
					}
				}
				// 合计信息 结束
				newObject = null;
			}
		}
		return list;
	}
	
	
	
	
	
	/*
	 * (non-Javadoc) 运费结算明细表
	 * 
	 * @see
	 * cn.nova.bus.report.service.QueryBalanceitemService#getBalanceitem(long,
	 * java.util.Date, java.util.Date)
	 */
	@Override
	public List<Map<String, Object>> getBalanceitem(String orgid, Date startdate,
			Date enddate, Long unitid, String vehicleno) {
		dao = new QueryBalanceitemDao();
		List<Object> listitem = dao.getBalancedeductitemName(orgid);
		List<Object> listdetail = dao.getBalancedeductdetail(orgid, startdate,
				enddate, unitid, vehicleno,"","");
		List<Object> listbalance = dao.getBalance(orgid, startdate, enddate,
				unitid, vehicleno,"","");
		Object[] objdetail = new Object[] {};
		Object[] objbalance = new Object[] {};
		Object[] newObject;
		BigDecimal[] sumObj;//合计列信息
		sumObj = new BigDecimal[18 + listitem.size()];
		for(int m = 4; m <= 16+listitem.size(); m++){
			sumObj[m] = new BigDecimal(0);
		}
		List<Object> list = new ArrayList<Object>();
		if (listitem.size() > 0) {
			newObject = new Object[18 + listitem.size()];
			newObject[0] = "0";
			newObject[1] = 1;
			newObject[2] = 2;
			newObject[3] = 3;
			newObject[4] = 4;
			newObject[5] = 5;
			newObject[6] = 6;
			newObject[7] = 7;
			newObject[8] = 8;
			newObject[9] = 9;
			newObject[10] = 10;
			newObject[11] = 11;
			newObject[12] = 12;
			newObject[13] = 13;
			newObject[14] = 14;
			for (int k = 0; k < listitem.size(); k++) {
				newObject[15 + k] = 15 + k;
			}
			newObject[15 + listitem.size()] = 15 + listitem.size();
			newObject[16 + listitem.size()] = 16 + listitem.size();
			newObject[17 + listitem.size()] = "" + (17 + listitem.size());
			list.add(newObject);
			newObject = null;
		}
		for (int i = 0; i < listbalance.size(); i++) {
			newObject = new Object[18 + listitem.size()];
			boolean isExist = false;
			objbalance = (Object[]) listbalance.get(i);
			for (int j = 0; j < listdetail.size(); j++) {
				objdetail = (Object[]) listdetail.get(j);
				if (objbalance[0].equals(objdetail[0])) {
					BigDecimal money = new BigDecimal(0);
					newObject[0] = objbalance[1];
					newObject[1] = objbalance[2];
					newObject[2] = objbalance[3];
					newObject[3] = objbalance[4];
					if (objbalance[5] == null) {
						newObject[4] = 0;
					} else {
						newObject[4] = objbalance[5];
					}
					newObject[5] = objbalance[6];
					newObject[6] = objbalance[7];
					newObject[7] = objbalance[8];
					if (objbalance[9] == null) {
						newObject[8] = 0;
					} else {
						newObject[8] = objbalance[9];
					}
					newObject[9]= new BigDecimal(newObject[4].toString())
							.add(new BigDecimal(newObject[5].toString()))
							.add(new BigDecimal(newObject[6].toString()))
							.add(new BigDecimal(newObject[7].toString()))
							.add(new BigDecimal(newObject[8].toString()));
					newObject[10] = objbalance[10];
					newObject[11] = objbalance[11];
					newObject[12] = objbalance[12];
					newObject[13] = objbalance[13];
					newObject[14] = objbalance[14];

					money = money.add(new BigDecimal(newObject[14].toString()));
					money = money.add(new BigDecimal(newObject[10].toString()));
					money = money.add(new BigDecimal(newObject[11].toString()));
					money = money.add(new BigDecimal(newObject[12].toString()));
					money = money.add(new BigDecimal(newObject[13].toString()));
					for (int k = 0; k < listitem.size(); k++) {
						newObject[15 + k] = objdetail[1 + k];
						String tem = "0";
						if (objdetail[1 + k] != null) {
							tem = objdetail[1 + k].toString();
						}
						money = money.add(new BigDecimal(tem));
					}
					newObject[15 + listitem.size()] = money;
					newObject[16 + listitem.size()] = objbalance[15];
					newObject[17 + listitem.size()] = "";
					list.add(newObject);
					//合计信息 开始
					for(int m = 4; m <= 16+listitem.size(); m++){
						if( (newObject[m]!=null && "".equals(newObject[m]) || newObject[m]==null)){
							sumObj[m] = sumObj[m];
						}
						else{
							sumObj[m] = sumObj[m].add( new BigDecimal(String.valueOf(newObject[m])) );
						}
					}
					//合计信息 结束
					newObject = null;
					isExist = true;
				}
			}
			if (!isExist) {
				BigDecimal money = new BigDecimal(0);
				newObject[0] = objbalance[1];
				newObject[1] = objbalance[2];
				newObject[2] = objbalance[3];
				newObject[3] = objbalance[4];
				if (objbalance[5] == null) {
					newObject[4] = 0;
				} else {
					newObject[4] = objbalance[5];
				}
				newObject[5] = objbalance[6];
				newObject[6] = objbalance[7];
				newObject[7] = objbalance[8];
				if (objbalance[9] == null) {
					newObject[8] = 0;
				} else {
					newObject[8] = objbalance[9];
				}
				newObject[9]= new BigDecimal(newObject[4].toString())
						.add(new BigDecimal(newObject[5].toString()))
						.add(new BigDecimal(newObject[6].toString()))
						.add(new BigDecimal(newObject[7].toString()))
						.add(new BigDecimal(newObject[8].toString()));
				newObject[10] = objbalance[10];
				newObject[11] = objbalance[11];
				newObject[12] = objbalance[12];
				newObject[13] = objbalance[13];
				newObject[14] = objbalance[14];

				money = money.add(new BigDecimal(newObject[14].toString()));
				money = money.add(new BigDecimal(newObject[10].toString()));
				money = money.add(new BigDecimal(newObject[11].toString()));
				money = money.add(new BigDecimal(newObject[12].toString()));
				money = money.add(new BigDecimal(newObject[13].toString()));
				for (int k = 0; k < listitem.size(); k++) {
					newObject[15 + k] = 0;
				}
				newObject[15 + listitem.size()] = money;
				newObject[16 + listitem.size()] = objbalance[15];
				;
				newObject[17 + listitem.size()] = "";
				list.add(newObject);
				//合计信息 开始
				for(int m = 4; m <= 16+listitem.size(); m++){
					if(newObject[m]==null || "".equals(newObject[m])){
						sumObj[m] = sumObj[m];
					}
					else{
						sumObj[m] = sumObj[m].add( new BigDecimal(String.valueOf(newObject[m])) );
					}
				}
				//合计信息 结束
				newObject = null;
			}
		}
//		//合计列开始
		newObject = new Object[18 + listitem.size()];
		newObject[0] = "【合计】";
		newObject[1] = "";
		newObject[2] = "";
		newObject[3] = "";
		for(int m = 4; m <= 16+listitem.size(); m++){
			newObject[m] = sumObj[m];
		}
		newObject[17+listitem.size()] = "";
		list.add(newObject);
		sumObj = null;
		newObject = null;
//		//合计列结束
		Object[] field = new Object[18 + listitem.size()];
		Object[] fieldType = new Object[18 + listitem.size()];
		Object[] oldfield = new Object[] { "结算单号", "线路", "车牌号", "结算单位",
				"配载金额|客运收入", "配载金额|行包收入", "配载金额|包车收入", "配载金额|车辆预缴款", "配载金额|补录营收","配载金额|小计",
				"扣款项目|分成金额", "扣款项目|客运劳务费", "扣款项目|行包劳务费", "扣款项目|包车劳务费",
				"扣款项目|站务附加费" };
		Object[] oldfieldType = new Object[] { String.class, String.class,
				String.class, String.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class };
		for (int i = 0; i < oldfield.length; i++) {
			field[i] = oldfield[i];
		}
		for (int i = 0; i < oldfieldType.length; i++) {
			fieldType[i] = oldfieldType[i];
		}
		for (int i = 0; i < listitem.size(); i++) {
			field[15 + i] = "扣款项目|" + listitem.get(i).toString();
			fieldType[15 + i] = BigDecimal.class;
		}
		field[15 + listitem.size()] = "扣款项目|扣款小计";
		field[16 + listitem.size()] = "实结金额";
		field[17 + listitem.size()] = "领款人签名";
		
		fieldType[15 + listitem.size()] = BigDecimal.class;
		fieldType[16 + listitem.size()] = BigDecimal.class;
		fieldType[17 + listitem.size()] = String.class;
		String fileds ="";
		for (int i = 0; i < field.length; i++) {
			fileds += field[i]+",";
		}
		fileds = fileds.substring(0, fileds.length()-1);
		RedisUtil.set(RedisDBApp.temp, "Balanceitem", fileds);
		return ListUtil.listToMap(field, list, fieldType);
	}
	
	
	@Override
	public List<Map<String, Object>> getBalanceitemDelphi(String orgid,
			Date startdate, Date enddate, Long unitid, String vehicleno,
			String routename, String balanceno) {
		dao = new QueryBalanceitemDao();
		List<Object> listitem = dao.getBalancedeductitemName(orgid);
		List<Object> listdetail = dao.getBalancedeductdetail(orgid, startdate,
				enddate, unitid, vehicleno,routename,balanceno);
		List<Object> listbalance = dao.getBalance(orgid, startdate, enddate,
				unitid, vehicleno,routename,balanceno);
		Object[] objdetail = new Object[] {};
		Object[] objbalance = new Object[] {};
		Object[] newObject;
		List<Object> list = new ArrayList<Object>();
		if (listitem.size() > 0) {
			newObject = new Object[18 + listitem.size()];
			newObject[0] = "0";
			newObject[1] = 1;
			newObject[2] = 2;
			newObject[3] = 3;
			newObject[4] = 4;
			newObject[5] = 5;
			newObject[6] = 6;
			newObject[7] = 7;
			newObject[8] = 8;
			newObject[9] = 9;
			newObject[10] = 10;
			newObject[11] = 11;
			newObject[12] = 12;
			newObject[13] = 13;
			newObject[14] = 14;
			for (int k = 0; k < listitem.size(); k++) {
				newObject[15 + k] = 15 + k;
			}
			newObject[15 + listitem.size()] = 15 + listitem.size();
			newObject[16 + listitem.size()] = 16 + listitem.size();
			newObject[17 + listitem.size()] = "" + (17 + listitem.size());
//			list.add(newObject);
			newObject = null;
		}
		for (int i = 0; i < listbalance.size(); i++) {
			newObject = new Object[18 + listitem.size()];
			boolean isExist = false;
			objbalance = (Object[]) listbalance.get(i);
			for (int j = 0; j < listdetail.size(); j++) {
				objdetail = (Object[]) listdetail.get(j);
				if (objbalance[0].equals(objdetail[0])) {
					BigDecimal money = new BigDecimal(0);
					newObject[0] = objbalance[1];
					newObject[1] = objbalance[2];
					newObject[2] = objbalance[3];
					newObject[3] = objbalance[4];
					if (objbalance[5] == null) {
						newObject[4] = 0;
					} else {
						newObject[4] = objbalance[5];
					}
					newObject[5] = objbalance[6];
					newObject[6] = objbalance[7];
					newObject[7] = objbalance[8];
					if (objbalance[9] == null) {
						newObject[8] = 0;
					} else {
						newObject[8] = objbalance[9];
					}
					newObject[9]= new BigDecimal(newObject[4].toString())
							.add(new BigDecimal(newObject[5].toString()))
							.add(new BigDecimal(newObject[6].toString()))
							.add(new BigDecimal(newObject[7].toString()))
							.add(new BigDecimal(newObject[8].toString()));
					newObject[10] = objbalance[10];
					newObject[11] = objbalance[11];
					newObject[12] = objbalance[12];
					newObject[13] = objbalance[13];
					newObject[14] = objbalance[14];

					money = money.add(new BigDecimal(newObject[14].toString()));
					money = money.add(new BigDecimal(newObject[10].toString()));
					money = money.add(new BigDecimal(newObject[11].toString()));
					money = money.add(new BigDecimal(newObject[12].toString()));
					money = money.add(new BigDecimal(newObject[13].toString()));
					for (int k = 0; k < listitem.size(); k++) {
						newObject[15 + k] = objdetail[1 + k];
						String tem = "0";
						if (objdetail[1 + k] != null) {
							tem = objdetail[1 + k].toString();
						}
						money = money.add(new BigDecimal(tem));
					}
					newObject[15 + listitem.size()] = money;
					newObject[16 + listitem.size()] = objbalance[15];
					newObject[17 + listitem.size()] = "";
					list.add(newObject);
					newObject = null;
					isExist = true;
				}
			}
			if (!isExist) {
				BigDecimal money = new BigDecimal(0);
				newObject[0] = objbalance[1];
				newObject[1] = objbalance[2];
				newObject[2] = objbalance[3];
				newObject[3] = objbalance[4];
				if (objbalance[5] == null) {
					newObject[4] = 0;
				} else {
					newObject[4] = objbalance[5];
				}
				newObject[5] = objbalance[6];
				newObject[6] = objbalance[7];
				newObject[7] = objbalance[8];
				if (objbalance[9] == null) {
					newObject[8] = 0;
				} else {
					newObject[8] = objbalance[9];
				}
				newObject[9]= new BigDecimal(newObject[4].toString())
						.add(new BigDecimal(newObject[5].toString()))
						.add(new BigDecimal(newObject[6].toString()))
						.add(new BigDecimal(newObject[7].toString()))
						.add(new BigDecimal(newObject[8].toString()));
				newObject[10] = objbalance[10];
				newObject[11] = objbalance[11];
				newObject[12] = objbalance[12];
				newObject[13] = objbalance[13];
				newObject[14] = objbalance[14];

				money = money.add(new BigDecimal(newObject[14].toString()));
				money = money.add(new BigDecimal(newObject[10].toString()));
				money = money.add(new BigDecimal(newObject[11].toString()));
				money = money.add(new BigDecimal(newObject[12].toString()));
				money = money.add(new BigDecimal(newObject[13].toString()));
				for (int k = 0; k < listitem.size(); k++) {
					newObject[15 + k] = 0;
				}
				newObject[15 + listitem.size()] = money;
				newObject[16 + listitem.size()] = objbalance[15];
				;
				newObject[17 + listitem.size()] = "";
				list.add(newObject);
				newObject = null;
			}
		}
		Object[] field = new Object[18 + listitem.size()];
		Object[] fieldType = new Object[18 + listitem.size()];
		Object[] oldfield = new Object[] { "结算单号", "线路", "车牌号", "结算单位",
				"配载金额|客运收入", "配载金额|行包收入", "配载金额|包车收入", "配载金额|车辆预缴款", "配载金额|补录营收","配载金额|小计",
				"扣款项目|分成金额", "扣款项目|客运劳务费", "扣款项目|行包劳务费", "扣款项目|包车劳务费",
				"扣款项目|站务附加费" };
		Object[] oldfieldType = new Object[] { String.class, String.class,
				String.class, String.class, BigDecimal.class, BigDecimal.class,BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class, BigDecimal.class,
				BigDecimal.class, BigDecimal.class };
		for (int i = 0; i < oldfield.length; i++) {
			field[i] = oldfield[i];
		}
		for (int i = 0; i < oldfieldType.length; i++) {
			fieldType[i] = oldfieldType[i];
		}
		for (int i = 0; i < listitem.size(); i++) {
			field[15 + i] = "扣款项目|" + listitem.get(i).toString();
			fieldType[15 + i] = BigDecimal.class;
		}
		field[15 + listitem.size()] = "扣款项目|扣款小计";
		field[16 + listitem.size()] = "实结金额";
		field[17 + listitem.size()] = "领款人签名";
		
		fieldType[15 + listitem.size()] = BigDecimal.class;
		fieldType[16 + listitem.size()] = BigDecimal.class;
		fieldType[17 + listitem.size()] = String.class;
		
		return ListUtil.listToMap(field, list, fieldType);
	}

}
