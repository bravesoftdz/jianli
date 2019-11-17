package cn.nova.bus.check.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import util.CurrentUtil;
import util.JsonUtil;
import util.TransactionUtil;

import cn.nova.bus.archive.model.Driver;
import cn.nova.bus.base.model.Route;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.check.dao.SecuritycheckDao;
import cn.nova.bus.check.model.Chkitem;
import cn.nova.bus.check.model.Securitycheck;
import cn.nova.bus.check.model.Securitycheckplan;
import cn.nova.bus.check.service.SecuritycheckService;
import cn.nova.bus.check.service.VehicledistanceactiveService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.DateUtils;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class SecuritycheckServiceImpl implements SecuritycheckService {

	private SecuritycheckDao dao = new SecuritycheckDao();

	private List<Securitycheckplan> securitycheckplanlist;
	private List<Securitycheck> securitycheck;

	private ParameterService parameterService = new ParameterServiceImpl();

	@Override
	public Securitycheck save(Securitycheck security) throws ServiceException {
		//		vehicle.setv
		/*Vehicle vehicle = dao.getVehicle(security.getVehicleid());
		// 判断车辆的行驶证、营运证、强险、责任险的到期日期是否过期
		//只在客户端选择合格时做判断
		if ("合格".equals(security.getLeak())) {
			checkVehicledate(security.getOrgid(), vehicle);
		}*/
		return (Securitycheck) dao.merge(security);
	}

	private void checkVehicledate(long orgid, Vehicle vehicle)
			throws ServiceException {
		if (ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_6002, orgid))) {
			//判断过期提示弹出然后是否正常安检
			//新增参数6022，如果参数是1表示打开过期提示能正常安检，参数是0，则提示为过期提示，不让安检
			if(ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_6022, orgid)))
			{
			if (vehicle.getLicensestartdate() != null
					&& DateUtils.compare(vehicle.getLicenseenddate(),
							new Date()) < 0) {
				throw new ServiceException("0396");
			}
			if (vehicle.getLiabilityinsureenddate() != null
					&& DateUtils.compare(vehicle.getLiabilityinsureenddate(),
							new Date()) < 0) {
				throw new ServiceException("0397");
			}
			if (vehicle.getCompulsoryinsureenddate() != null
					&& DateUtils.compare(vehicle.getCompulsoryinsureenddate(),
							new Date()) < 0) {
				throw new ServiceException("0398");
			}
			if (vehicle.getWorkenddate() != null
					&& DateUtils.compare(vehicle.getWorkenddate(), new Date()) < 0) {
				throw new ServiceException("0399");
			}
			}
		}
	}

	@Override
	public List<Securitycheck> query() {
		return dao.query(Securitycheckplan.class, null);
	}

	@Override
	public Securitycheck getById(Long id) {
		return (Securitycheck) dao.get(Securitycheck.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "result", "createby",
				"updateby", "checkby", "orgid", "light", "mirror", "drive",
				"brake", "turn", "wheel", "hang", "leak", "window", "safety",
				"createtime", "updatetime", "checktime", "remarks",
				"vehicleno", "vehiclebrandmodelid", "unitname", "checkname",
				"createname", "updatename", "type", "orgname", "routename",
				"camera", "returncheck", "notenum", "vehicletypename","drivername",
				"workno", "qualification", "roadno","fueltype", "reprinttimes" },
				dao.query(propertyFilterList), new Object[] { Long.class,
						String.class, Long.class, Long.class, Long.class,
						Long.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class,
						Timestamp.class, Timestamp.class, Timestamp.class,
						String.class, String.class, Long.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class,String.class,
						String.class,String.class,String.class,String.class, Integer.class });
	}

	@Override
	public Long getBySecurityId(Long vehicleno, String periodtype) {
		return dao.getBySecurityId(vehicleno, periodtype);
	}

	@Override
	public String getSerialnumber(Long checkby) {
		return dao.getSerialnumber(checkby);
	}

	@Override
	public Long getId(Securitycheck check, short period) {
		Date time = new Timestamp(System.currentTimeMillis());
		Date checktime = check.getChecktime();
		long millisecond = time.getTime() - checktime.getTime();
		int day = (int) (millisecond / 24 / 60 / 60 / 1000);
		if (day <= period) {
			return check.getId();
		}
		return (long) 0;
	}

	/**
	 * 返回的-1未检 1合格 0不合格 2是无安检计划无需校验安检
	 * 3:24小时内安检合格，-2,已发班里程大于设置需要重复安检里程，提示需要再次安检，-3:
	 * 24小时有效情况下，如果已经发过一次班，提示需要再次安检
	 */
	@Override
	public MethodResult getVehicleCheckResult(long vehicleid, Date departdate,
			long orgid) {
		MethodResult methodResult = new MethodResult();
		Vehicle v = dao.getVehicle(vehicleid);
		String result = v.getVehicleno() + ": ";
		try {
			//转化前台页面传入的日期，同一格式为 2000-8-9 00:00:00;此处，报班页面传入的为2000-8-9 23:59:00，自动报班为2000-8-9 00:00:00
			departdate = new SimpleDateFormat("yyyy-MM-dd").parse(DateUtils.formatDate(departdate));
		} catch (ParseException e) {
			e.printStackTrace();
		}
		// 获取安检计划信息
		securitycheckplanlist = dao.getCheckListbyVehicleId(vehicleid,
				departdate);
		String periodtype ="0";
		if (securitycheckplanlist != null
				&& securitycheckplanlist.size() > 0){
			 periodtype = securitycheckplanlist.get(0).getPeriodtype();
		}
		int oncheckresult = getCheckList(vehicleid, periodtype, departdate, orgid);
		// 2013：是否需要安检合格才允许报到
		if (!ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_2013, orgid))) {
			if (securitycheckplanlist != null
					&& securitycheckplanlist.size() > 0// 有安检计划
					&& (oncheckresult == -1 || oncheckresult == 0)) {// 未安检或者不合格
				methodResult.setResult(-3);
				result = "该车辆需要安检合格才允许报到！";
				methodResult.setResultMsg(result);
				return methodResult;
			}
			// 6008:无安检计划时，是否需要安检才允许报到---(用户不可编辑)
			if (ParamterConst.COMMON_FLAG.FALG_NO.equals(parameterService.findParamValue(ParamterConst.Param_6008, orgid))) {// 无安检计划，不需要安检合格
				if (oncheckresult == -1) {// ------>显示: 未安检，但是可以报班
					methodResult.setResult(2);
					result = "当前车辆无安检计划!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == 0) {
					// 安检不合格
					methodResult.setResult(0);
					result = "该车辆例检不合格！";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == 1) {
					methodResult.setResult(1);
					result = "该车辆当日例检合格!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == 2) {
					methodResult.setResult(3);
					result = "该车辆24小时内例检合格!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == -2) {
					methodResult.setResult(-2); // 有安检过，则 受参数6011 控制，需要再次安检
					result = "发班里程大于再次安检里程，请重新安检!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == -3) {
					methodResult.setResult(-3);
					result = "该车需要再次安检!";
					methodResult.setResultMsg(result);
				}
				return methodResult;
			} else { // 无安检计划，需要安检合格才能报到}
				if (oncheckresult == -1) {
					methodResult.setResult(-1);
					result = "该车辆还没例检！";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == 0) {
					// 安检不合格
					methodResult.setResult(0);
					result = "该车辆例检不合格！";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == 1) {
					methodResult.setResult(1);
					result = "该车辆当日例检合格!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == 2) {
					methodResult.setResult(3);
					result = "该车辆24小时内例检合格!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == -2) {
					methodResult.setResult(-2);
					result = "发班里程大于再次安检里程，请重新安检!";
					methodResult.setResultMsg(result);
				} else if (oncheckresult == -3) {
					methodResult.setResult(-3);
					result = "该车辆需要再次安检!";
					methodResult.setResultMsg(result);

				}
				return methodResult;
			}

		}

		// 3、如果需要安检
		if (securitycheckplanlist != null && securitycheckplanlist.size() > 0) {
			for (Securitycheckplan securitycheckplan : securitycheckplanlist) {
				int days = DateUtils.getIntervalDays(
						securitycheckplan.getStartdate(), departdate);
				// 日检
				if (securitycheckplan.getPeriodtype().equals("0")) {
					int flag = getCheckList(vehicleid,
							securitycheckplan.getPeriodtype(), departdate,
							orgid);
					methodResult.setResult(1);
					if (flag == -1) {
						methodResult.setResult(-1);
						result = "该车辆当日还没例检！";
						methodResult.setResultMsg(result);
						return methodResult;
					} else if (flag == 0) {
						// 安检不合格
						methodResult.setResult(0);
						result = "该车辆当日例检不合格！";
						methodResult.setResultMsg(result);
						return methodResult;
					} else if (flag == 1) {
						methodResult.setResult(1);
						result = "该车辆当日例检合格!";
					} else if (flag == 2) {
						methodResult.setResult(3);
						result = "该车辆24小时内例检合格!";
					} else if (flag == -2) {
						methodResult.setResult(-2);
						result = "发班里程大于再次安检里程，请重新安检!";
						methodResult.setResultMsg(result);
					} else if (flag == -3) {
						methodResult.setResult(-3);
						result = "该车需要再次安检!";
						methodResult.setResultMsg(result);
					}
				} else if (securitycheckplan.getPeriodtype().equals("4")) {
					// 半月检
					int flag = getCheckList(vehicleid,
							securitycheckplan.getPeriodtype(), departdate,
							orgid);
					if (flag == -1) {
						// 未安检
						if (result.length() > 0) {
							result = result + "，但还未半月检";
						}
						if (days == 15) {
							methodResult.setResult(-1);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else if (flag == 0) {
						// 安检不合格
						if (result.length() > 0) {
							result = result + "，但半月检不合格";
						}
						methodResult.setResultMsg(result);
						if (days == 15) {
							methodResult.setResult(0);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else {
						if (result.length() > 0) {
							methodResult.setResult(1);
							result = result + "，半月检合格";
						}
					}
				} else if (securitycheckplan.getPeriodtype().equals("1")) {
					// 月检
					int flag = getCheckList(vehicleid,
							securitycheckplan.getPeriodtype(), departdate,
							orgid);
					if (flag == -1) {
						// 未安检
						if (result.length() > 0) {
							result = result + "，但还未月检";
						}
						if (days == 30) {
							methodResult.setResult(-1);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else if (flag == 0) {
						// 安检不合格
						if (result.length() > 0) {
							result = result + "，但月检不合格";
						}
						if (days == 30) {
							methodResult.setResult(0);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else {
						if (result.length() > 0) {
							methodResult.setResult(1);
							result = result + "，月检合格";
						}
					}
				} else if (securitycheckplan.getPeriodtype().equals("2")) {
					// 季检
					int flag = getCheckList(vehicleid,
							securitycheckplan.getPeriodtype(), departdate,
							orgid);
					if (flag == -1) {
						// 未安检
						if (result.length() > 0) {
							result = result + "，但还未季检";
							methodResult.setResultMsg(result);
						}
						if (days == 90) {
							methodResult.setResult(-1);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else if (flag == 0) {
						// 安检不合格
						if (result.length() > 0) {
							result = result + "，但季检不合格";
						}
						if (days == 90) {
							methodResult.setResult(0);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else {
						if (result.length() > 0) {
							methodResult.setResult(1);
							result = result + "，季检合格";
						}
					}
				} else {
					// 年检
					int flag = getCheckList(vehicleid,
							securitycheckplan.getPeriodtype(), departdate,
							orgid);
					if (flag == -1) {
						// 未安检
						if (result.length() > 0) {
							result = result + "，但还未年检";
						}
						if (days == 365) {
							methodResult.setResult(-1);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else if (flag == 0) {
						// 安检不合格
						if (result.length() > 0) {
							result = result + "，但年检不合格";
						}
						if (days == 365) {
							methodResult.setResult(0);
							methodResult.setResultMsg(result);
							return methodResult;
						}
					} else {
						if (result.length() > 0) {
							methodResult.setResult(1);
							result = result + "，年检合格";
						}
					}
				}
			}
			methodResult.setResultMsg(result);
		} else {
			methodResult.setResult(2);
			methodResult.setResultMsg("当前车辆无安检计划!");
		}
		return methodResult;
	}

	/**
	 * 查询安检情况
	 * 
	 * @param vehicleId
	 *            车辆ID
	 * @param periodType
	 *            安检周期类型（日检、半月检、月检、季检、年检）
	 * @param departdate
	 *            发车日期
	 * @param orgid
	 *            机构id （用户获取机构对应的安检有效时间类型）
	 * @return 
	 *         -1：未安检，0：安检不合格，1：当日安检合格,2:24小时内安检合格,-2,已发班里程大于设置需要重复安检里程，提示需要再次安检，
	 *         -3: 24小时有效情况下，如果已经发过一次班，提示需要再次安检
	 */
	private int getCheckList(long vehicleId, String periodType,
			Date departdate, long orgid) {
		// 车辆安检有效时间类型：0:当日内有效，1:24小时内有效
		String valitype = parameterService.findParamValue(ParamterConst.Param_6010, orgid);
		// 安检24小时有效：当天发过班次，安检合格单是否只对当天有效，1：当天有效性，0：24小时有效
		String is24validate = parameterService.findParamValue(ParamterConst.Param_6017, orgid);
//		if (valitype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
//			departdate = DateUtils.add(departdate, -1);
//		}
		securitycheck = dao.getCheckList(vehicleId, periodType, departdate,valitype);
		if (securitycheck == null || securitycheck.size() == 0) {
			return -1;
		} else {
			Date checketime = (Date) securitycheck.get(0).getChecktime();
			if (securitycheck.get(0).getResult().equals("0")
					|| securitycheck.get(0).getResult().equals("2")) {
				// 安检以后，车辆需要再次安检的行驶公里数
				int recheckKM = Integer.parseInt(parameterService
						.findParamValue(ParamterConst.Param_6011, orgid));

				Date printtime = null;
				int departKM = 0;
				List<Map<String, Object>> depart = ListUtil.listToMap(
						new Object[] { "departdistance", "printtime",
								"vehicleid" },
						dao.qryDipartInfo(vehicleId, departdate), new Object[] {
								Integer.class, Timestamp.class, Long.class });
				if (depart != null && depart.size() > 1) {
					Map departmap = depart.get(0);
					if (!securitycheck.get(0).getChecktime().equals("")) {
						printtime = (Date) departmap.get("printtime");
						Object o = departmap.get("departdistance");
						departKM = Integer.parseInt(o.toString());
						Date printdate = DateUtils.trunc(printtime);
						if (printtime.compareTo(checketime) > 0) {// 安检后，有发过班次
							if (recheckKM > 0) {
								if (departKM > recheckKM) {
									return -2;
								}
							}
							if (valitype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
								if (is24validate.equals(ParamterConst.COMMON_FLAG.FALG_YES)// 安检合格单24小时有效
										&& DateUtils.add(checketime, 1)
												.compareTo(new Date()) < 0) {// 如果距离目前时间超过24小时
																				// 则车辆为未捡
									return -1;// 超过24小时，返回未捡
								} else if (is24validate.equals(ParamterConst.COMMON_FLAG.FALG_NO)
										&& DateUtils.compare(checketime,
												DateUtils.add(departdate, 1)) < 0// 安检时间不在当天
										&& DateUtils.compare(printdate,
												DateUtils.add(departdate, 1)) < 0) {// 最后一次开运量单不在同一天
									// 有效时间为24小时,且不是当天安检，发过一次班了，则需要再次安检（即安检后，发过班次了，安检有效期只对当天有效）
									return -3;
								}
							}

						} else {
							if (valitype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
								// 如果距离目前时间超过24小时 则车辆为未捡
								if (DateUtils.add(checketime, 1).compareTo(
										new Date()) < 0) {
									return -1;
								}
								return 2;
							} else {
								return 1;
							}
						}

					}
				}
				if (valitype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
					// 如果距离目前时间超过24小时 则车辆为未捡
					if (DateUtils.add(checketime, 1).compareTo(new Date()) < 0) {
						return -1;
					}
					return 2;
				} else {
					return 1;
				}
			} else {
				return 0;
			}
		}
	}

	@Override
	public List<Map<String, Object>> qrySecurityVehicle(String cardno,
			Long vehicleid, long orgid) throws ServiceException, ParseException {
		List<Map<String, Object>> resultList = null;
		List<Vehicle> vlist = null;
		if (cardno != null && !cardno.equals("")) {
			vlist = dao.getVehicle(cardno);
			if (vlist == null || vlist.size() == 0) {
				// 系统不存在该IC卡信息！
				throw new ServiceException("0236");
			} else if (vlist.size() > 1) {
				// 系统中存在2辆以上的车与该卡对应，请先修改！
				throw new ServiceException("0428");
			}
		}
		if (vlist != null && vlist.get(0) != null) {
			vehicleid = vlist.get(0).getId();
		}
		// 车辆安检有效时间类型：0:当日内有效，1:24小时内有效
		String validitytype = parameterService.findParamValue(ParamterConst.Param_6010, orgid);
		Date d = null;
		if (validitytype.equals(ParamterConst.COMMON_FLAG.FALG_YES)) {
			d = DateUtils.add(new Date(), -1);
		} else {
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String s = sf.format(new Date());
			d = sf.parse(s);

		}
		// 6018 无安检计划是否允许车辆进行安检
		String checkeWithoutPlan = parameterService.findParamValue(ParamterConst.Param_6018,
				orgid);
		if (checkeWithoutPlan.equals(ParamterConst.COMMON_FLAG.FALG_NO)) {
			// 获取安检计划信息
			securitycheckplanlist = dao.getCheckListbyVehicleId(vehicleid, new Date());
			if (securitycheckplanlist != null
					&& securitycheckplanlist.size() < 1) {
				// 该车辆无安检计划，不允许安检!
				throw new ServiceException("0463");
			}
		}
		resultList = ListUtil.listToMap(new Object[] { "securitycheckid",
				"notenum", "checktime", "periodtype", "result", "remarks",
				"vehicleno", "cardno", "vehicleid", "checker", "checkerid",
				"checkercode", "vehicletypename", "unitname", "workno",
				"driver1name","routeid","routename","roadno","liabilityinsureno"
				,"liabilityinsurestartdate","liabilityinsureenddate","workstartdate"
				//20615 内蒙古通达南站站务需求 ，车辆安检时【车牌ONIDCHANGE事件】 - 增加查询交强险编号：compulsoryinsureno
				,"workenddate","driverlicense","checkfee","driverid","compulsoryinsureno"
				,"licenseenddate","compulsoryinsureenddate"}, dao.getSecurityVehicle(cardno, vehicleid, d),
				new Object[] { Long.class, String.class, Timestamp.class,
						String.class, String.class, String.class, String.class,
						String.class, Long.class, String.class, Long.class,
						String.class, String.class, String.class, String.class,
						String.class,Long.class,String.class,String.class,String.class,Date.class
						,Date.class,Date.class,Date.class,String.class,BigDecimal.class,long.class,String.class
						,Date.class,Date.class});
		if (resultList != null && resultList.size() > 1) {
			List<Map<String, Object>> departList = null;
			// 安检以后，车辆需要再次安检的行驶公里数
			int recheckKM = Integer.parseInt(parameterService.findParamValue(
					ParamterConst.Param_6011, orgid));
			if (recheckKM > 0) {
				Date printtime = null;
				Date checketime = null;
				int departKM = 0;
				departList = ListUtil.listToMap(new Object[] {
						"departdistance", "printtime", "vehicleid", },
						dao.qryDipartInfo(vehicleid, d), new Object[] {
								Integer.class, Timestamp.class, Long.class });
				if (departList != null && departList.size() > 1) {
					Map resultmap = resultList.get(0);
					Map departmap = departList.get(0);
					if (resultmap.get("checktime") != null
							&& !resultmap.get("checktime").equals("")) {
						checketime = (Date) resultmap.get("checktime");
						printtime = (Date) departmap.get("printtime");
						Object o = departmap.get("departdistance");
						departKM = Integer.parseInt(o.toString());
						if (printtime.compareTo(checketime) > 0) {
							if (departKM > recheckKM) {
								Map nocheckemap = resultmap;
								nocheckemap.remove("result");
								nocheckemap.put("result", "");
								resultList.set(0, nocheckemap);
							}
						}
					}
				}
			}
		}
		return resultList;
	}

	@Override
	public List<Map<String, Object>> queryCheckinfo(long id) {
		return ListUtil.listToMap(new Object[] { "id", "notenum", "checktime",
				"routename", "color", "vehicleno", "checkorg", "checker",
				"checkerid", "checkercode", "vehicletypename","rechecktime","idcard","workno","driverlicense","vehicleunitname" },
				dao.queryCheckinfo(id), new Object[] { Long.class,
						String.class, Timestamp.class, String.class,
						String.class, String.class, String.class, String.class,
						Long.class, String.class, String.class,Timestamp.class, String.class, String.class, String.class ,String.class});
	}

	@Override
	public long checkCardNO(String cardno, boolean isautosave, Global global)
			throws ServiceException {
		if (cardno == null || "".equals(cardno)) {
			// 系统不存在该IC卡信息！
			throw new ServiceException("0236");
		}
		long createby = global.getUserinfo().getId();
		List<Vehicle> vlist = dao.getVehicle(cardno);
		if (vlist == null || vlist.size() == 0) {
			// 系统不存在该IC卡信息！
			throw new ServiceException("0236");
		} else if (vlist.size() > 1) {
			// 系统中存在2辆以上的车与该卡对应，请先修改！
			throw new ServiceException("0428");
		}
		Securitycheck sc = new Securitycheck();
		Vehicle vh = vlist.get(0);
		checkVehicledate(global.getOrganization().getId(), vh);// 判断车辆的行驶证、营运证、强险、责任除的日期
		String result = "0";

		// 车辆安检有效时间类型：0:当日内有效，1:24小时内有效
		String validatetype = parameterService.findParamValue(ParamterConst.Param_6010, global
				.getOrganization().getId());
		Date d = null;
		// 安检以后，车辆需要再次安检的行驶公里数
		int recheckKM = Integer.parseInt(parameterService.findParamValue(
				ParamterConst.Param_6011, global.getOrganization().getId()));
		List<Map<String, Object>> departresult = null;
		// 判断是否已安检
		if (validatetype.equals(ParamterConst.COMMON_FLAG.FALG_NO)) { // 安检记录当日内有效
			SimpleDateFormat sf = new SimpleDateFormat("yyyy-MM-dd");
			String s = sf.format(new Date());
			try {
				d = sf.parse(s);
			} catch (ParseException e) {
				play.Logger.error(e.getMessage(), e);
			}
			Securitycheck schecked = dao.getSecurityCheckInfo(vh.getId(), "0",
					d);
			if (schecked != null) {
				if (schecked.getResult().equals("1")) {// 有不合格的安检记录，则结果登记为复检合格
					result = "2";
				} else if (schecked.getResult().equals("2")
						|| schecked.getResult().equals("0")) {// 已安检
					if (recheckKM > 0) {
						Date printtime = null;
						Date checketime = null;
						int departKM = 0;
						departresult = ListUtil.listToMap(new Object[] {
								"departdistance", "printtime", "vehicleid" },
								dao.qryDipartInfo(vh.getId(), d), new Object[] {
										Integer.class, Timestamp.class,
										Long.class });
						if (departresult != null && departresult.size() > 1) {
							Map departmap = departresult.get(0);
							if (!schecked.getChecktime().equals("")) {
								checketime = (Date) schecked.getChecktime();
								printtime = (Date) departmap.get("printtime");
								Object o = departmap.get("departdistance");
								departKM = Integer.parseInt(o.toString());
								if (printtime.compareTo(checketime) > 0) {
									if (departKM < recheckKM) {
										return -2; // 该车辆当日 已检合格";
									}// 否则：发班里程大于重检里程，可以再次报道
								} else {
									return -2; // 该车辆当日 已检合格";
								}
							}
						} else {
							return -2;
						}
					} else {
						return -2;
					}
				}
			}
		} else {// 安检记录24小时内有效 //24小时内允许再次安检，故屏蔽该功能
			// d = DateUtils.add(new Date(),-1);//-1天即24小时内是否有安检
			// Securitycheck schecked = dao.getSecurityCheckInfo(vh.getId(),
			// "0",
			// d);
			// if (schecked != null) {
			// if (schecked.getResult().equals("1")) {// 有不合格的安检记录，则结果登记为复检合格
			// result = "2";
			// } else if (schecked.getResult().equals("2")
			// || schecked.getResult().equals("0")) {
			// if(recheckKM >0){
			// Date printtime = null;
			// Date checketime = null;
			// int departKM =0;
			// departresult = ListUtil.listToMap(new Object[] {
			// "departdistance","printtime","vehicleid"},
			// dao.qryDipartInfo(vh.getId(),d),
			// new Object[] {
			// Integer.class,Timestamp.class,Long.class });
			// if(departresult != null && departresult.size() > 1){
			// Map departmap = departresult.get(0);
			// if(!schecked.getChecktime().equals("")){
			// checketime = (Date) schecked.getChecktime();
			// printtime = (Date) departmap.get("printtime");
			// Object o = departmap.get("departdistance");
			// departKM = Integer.parseInt(o.toString());
			// if(printtime.compareTo(checketime) > 0){
			// if(departKM < recheckKM){
			// return -3;
			// }//否则：发班里程大于重检里程，可以再次报道
			// }else{
			// return -3;
			// }
			// }
			// }else{
			// return -3;
			// }
			// }else{
			// return -3; // 该车辆24小时内已检合格";
			// }
			// }
			// }
		}
		if (isautosave) {
			sc.setBrake("合格");
			sc.setCheckby(createby);
			sc.setChecktime(new Date());
			sc.setCreateby(createby);
			sc.setCreatetime(new Date());
			sc.setHang("合格");
			sc.setLeak("合格");
			sc.setLight("合格");
			sc.setMirror("合格");
			sc.setDrive("合格");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyymmdd");
			String depart = sdf.format(new Date());
			String notenum = depart + global.getOrganization().getCode()
					+ global.getUserinfo().getCode()
					+ getSerialnumber(createby);
			sc.setNotenum(notenum);
			sc.setOrgid(global.getOrganization().getId());
			sc.setPeriodtype("0");
			sc.setRemarks("");
			sc.setSafety("合格");
			sc.setTurn("合格");
			sc.setUpdateby(createby);
			sc.setUpdatetime(new Date());
			sc.setVehicleid(vh.getId());
			sc.setWheel("合格");
			sc.setWindow("合格");
			// 原来遗漏的代码导致安检失败
			sc.setCamera("合格");
			sc.setReturncheck("合格");
			//
			sc.setResult(result);
			sc = save(sc);
			return sc.getId();
		} else {
			return vh != null ? vh.getId() : 0;
		}
	}

	/**
	 * 注销车辆安检记录
	 */
	@Override
	public boolean deleteScurityCheck(Long id) throws ServiceException {
		Securitycheck sc = (Securitycheck) dao.get(Securitycheck.class, id);
		// 安检记录N分钟内允许注销
		long deletetime = new Long(parameterService.findParamValue(ParamterConst.Param_6001,
				sc.getOrgid()));
		long timemargin = ((new Date()).getTime() - sc.getChecktime().getTime()) / 1000 / 60;
		if (timemargin > deletetime) {
			// 已过安检记录注销时间！
			throw new ServiceException("0380");
		}
		return dao.delete(sc);
	}

	/*
	 * (non-Javadoc)
	 * 
	 * @see
	 * cn.nova.bus.check.service.SecuritycheckService#querySecuritycheck(java
	 * .util.List)
	 */
	@Override
	public List<Map<String, Object>> querySecuritycheck(
			List<PropertyFilter> propertyFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "checktime", "count",
				"checkresult", "light", "mirror", "drive", "brake", "turn",
				"wheel", "hang", "leak", "window", "safety", "camera",
				"returncheck" },
				dao.querySecuritycheck(propertyFromHttpRequest), new Object[] {
						Timestamp.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class, Long.class,
						Long.class, Long.class, Long.class });
	}

	/**
	 * 证件有效期提示
	 * 
	 * @param orgid
	 * @param vehicle
	 * @return
	 * @throws ServiceException
	 */
	
	@Override
	public List<Map<String, Object>> showValidate(long orgid, long vehicleid, String cardno,long driverid,long driverid1)
			throws ServiceException {
	//	StringBuffer  msg = new StringBuffer (" ");
//		msg.append("   证件名称                证件号              有效期            剩余天数\r");
		//long flag = 0;
		
		//StringBuilder sql = new StringBuilder(" select '' cardName,'' cardNo, null endDate, 0 days from dual ");
		if (cardno != null) {
			List<Vehicle> vlist = dao.getVehicle(cardno);
			if (vlist == null || vlist.size() == 0) {
				// 系统不存在该IC卡信息！
				throw new ServiceException("0236");
			} else if (vlist.size() > 1) {
				// 系统中存在2辆以上的车与该卡对应，请先修改！
				throw new ServiceException("0428");
			}
			Vehicle vh = vlist.get(0);
			vehicleid = vh.getId();
		}
		
		List<Object> vlist =dao.queryCardValidate(orgid, vehicleid,driverid,driverid1);
		return ListUtil.listToMap(new Object[] { "cardName", "cardNo",
				"endate", "days"},vlist, new Object[] {
						String.class, String.class, Date.class, Long.class });
		/*if (flag == -1) {
			return msg.toString();
		} else {
			return null;
		}*/
	}
	
	
	
	
	/*@Override
	public String showValidate(long orgid, long vehicleid, String cardno,long driverid)
			throws ServiceException {
		String msg = "   证件名称                证件号              有效期            剩余天数\r";
		long flag = 0;
		if (cardno != null) {
			List<Vehicle> vlist = dao.getVehicle(cardno);
			if (vlist == null || vlist.size() == 0) {
				// 系统不存在该IC卡信息！
				throw new ServiceException("0236");
			} else if (vlist.size() > 1) {
				// 系统中存在2辆以上的车与该卡对应，请先修改！
				throw new ServiceException("0428");
			}
			Vehicle vh = vlist.get(0);
			vehicleid = vh.getId();
		}
		Vehicle vehicle = dao.getVehicle(vehicleid);
		Driver driver = dao.getDriver(driverid);
		// 证件有效期到期提示天数
		int showdate = Integer.parseInt(parameterService.findParamValue("2024",
				orgid));
		if (vehicle.getLicenseenddate() != null
				&& DateUtils.compare(vehicle.getLicenseenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(vehicle.getLicenseenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "   行驶证        "+vehicle.getDriverlicense()+"             "+vehicle.getLicenseenddate()+"        "
					+ DateUtils.getIntervalDays(new Date(),
							DateUtils.add(vehicle.getLicenseenddate(), 2))
					+ "天\r";
			flag = -1;
		}
		if (vehicle.getWorkenddate() != null
				&& DateUtils.compare(vehicle.getWorkenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(vehicle.getWorkenddate(), -showdate),
						new Date()) < 0) {
			msg = msg 
					+ "   营运证   "+"            "+vehicle.getWorkno()+"          "+vehicle.getWorkenddate()+"       "
					+ DateUtils.getIntervalDays(new Date(),
							DateUtils.add(vehicle.getWorkenddate(), 2))
					+ "天\r";
			flag = -1;
		}
		//新增驾驶证有效期判断
		if (driver.getDrivinglicense() != null
				&& DateUtils.compare(driver.getDrivinglicenseenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(driver.getDrivinglicenseenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "    驾驶证       "+driver.getDrivinglicense()+"  "+driver.getDrivinglicenseenddate()+"         "
					+ DateUtils.getIntervalDays(new Date(),
							DateUtils.add(driver.getDrivinglicenseenddate(), 2))
					+ "天\r";
			flag = -1;
		}
		//新增从业资格证有效期判断
		if (driver.getQualification() != null
				&& DateUtils.compare(driver.getQualificationenddate(), new Date()) >= 0
				&& DateUtils.compare(
						DateUtils.add(driver.getQualificationenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "  从业资格证  "+driver.getQualification()+" "+driver.getQualificationenddate()+"       "
					+ DateUtils.getIntervalDays(new Date(),
							DateUtils.add(driver.getQualificationenddate(), 2))
					+ "天\r";
			flag = -1;
		}
		if (vehicle.getLiabilityinsureenddate() != null
				&& DateUtils.compare(vehicle.getLiabilityinsureenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getLiabilityinsureenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "    承运险       "+vehicle.getLiabilityinsureenddate()+"  "+vehicle.getLiabilityinsureenddate()+"         "
					+ DateUtils.getIntervalDays(new Date(), DateUtils.add(
							vehicle.getLiabilityinsureenddate(), 2)) 
					+ "天\r";
			flag = -1;
		}
		if (vehicle.getCompulsoryinsureenddate() != null
				&& DateUtils.compare(vehicle.getCompulsoryinsureenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getCompulsoryinsureenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "    承运险       "+vehicle.getCompulsoryinsureenddate()+"  "+
					+ DateUtils.getIntervalDays(new Date(), DateUtils.add(
							vehicle.getCompulsoryinsureenddate(), 2)) + "天过期!";
			flag = -1;
		}
		
		if (flag == -1) {
			return msg;
		} else {
			return null;
		}
	}*/

	@Override
	public boolean querycheckplan(long vehicleid, Date departdate, long orgid) {
		securitycheckplanlist = dao.getCheckListbyVehicleId(vehicleid,
				departdate);
		if (securitycheckplanlist == null || securitycheckplanlist.size() == 0) {
			return false;
		} else {
			return true;
		}
	}

	@Override
	public String outdateshowValidate(long orgid, long vehicleid,
			String cardno, long driverid) throws ServiceException {
		String msg = "";
		long flag = 0;
		if (cardno != null) {
			List<Vehicle> vlist = dao.getVehicle(cardno);
			/*if (vlist == null || vlist.size() == 0) {
				// 系统不存在该IC卡信息！
				throw new ServiceException("0236");
			} else if (vlist.size() > 1) {
				// 系统中存在2辆以上的车与该卡对应，请先修改！
				throw new ServiceException("0428");
			}*/
			Vehicle vh = vlist.get(0);
			vehicleid = vh.getId();
		}
		Vehicle vehicle = dao.getVehicle(vehicleid);
//		Driver driver = dao.getDriver(driverid);
		
		
		// 证件有效期到期提示天数
//		int showdate = Integer.parseInt(parameterService.findParamValue("2024",
//				orgid));
		if (vehicle.getLicenseenddate() != null
				&& DateUtils.compare(vehicle.getLicenseenddate(), new Date()) < 0) {
			msg = msg
					+ "   行驶证        "+vehicle.getDriverlicense()+"                  "+vehicle.getLicenseenddate()+"        "
					+ "-"+DateUtils.getIntervalDays(new Date(),
							DateUtils.add(vehicle.getLicenseenddate(), 2))
					+ "天\r";
			flag = -1;
		}
		if (vehicle.getWorkenddate() != null
				&& DateUtils.compare(vehicle.getWorkenddate(), new Date()) < 0) {
			msg = msg 
					+ "   营运证   "+"            "+vehicle.getWorkno()+"          "+vehicle.getWorkenddate()+"       "
					+ "-"+DateUtils.getIntervalDays(new Date(),
							DateUtils.add(vehicle.getWorkenddate(), 2))
					+ "天\r";
			flag = -1;
		}
		if (driverid!=0) {
			Driver driver = dao.getDriver(driverid);
			//新增驾驶证有效期判断
			if (driver.getDrivinglicense() != null
					&& DateUtils.compare(driver.getDrivinglicenseenddate(), new Date()) < 0) {
				msg = msg
				+ "    驾驶证      "+driver.getDrivinglicense()+"  "+driver.getDrivinglicenseenddate()+"        "
				+ "-"+DateUtils.getIntervalDays(new Date(),driver.getDrivinglicenseenddate())
				+ "天\r";
				flag = -1;
			}
			//新增从业资格证有效期判断
			if (driver.getQualification() != null
					&& DateUtils.compare(driver.getQualificationenddate(), new Date()) < 0) {
				msg = msg
				+ "  从业资格证  "+driver.getQualification()+" "+driver.getQualificationenddate()+"       "
				+"-"+ DateUtils.getIntervalDays(new Date(),driver.getQualificationenddate())
				+ "天\r";
				flag = -1;
			}
		}
		/*if (vehicle.getLiabilityinsureenddate() != null
				&& DateUtils.compare(vehicle.getLiabilityinsureenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getLiabilityinsureenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "承运人责任险有效期还有"
					+ DateUtils.getIntervalDays(new Date(), DateUtils.add(
							vehicle.getLiabilityinsureenddate(), 2)) + "天过期!";
			flag = -1;
		}
		if (vehicle.getCompulsoryinsureenddate() != null
				&& DateUtils.compare(vehicle.getCompulsoryinsureenddate(),
						new Date()) >= 0
				&& DateUtils.compare(DateUtils.add(
						vehicle.getCompulsoryinsureenddate(), -showdate),
						new Date()) < 0) {
			msg = msg
					+ "交强险有效期还有"
					+ DateUtils.getIntervalDays(new Date(), DateUtils.add(
							vehicle.getCompulsoryinsureenddate(), 2)) + "天过期!";
			flag = -1;
		}*/
		
		if (flag == -1) {
			return msg;
		} else {
			return null;
		}
	}

	/**
	 * 更新车牌信息  李电志  2015年7月8日 16:45:12
	 * return Vehicle
	 */
	@Override
	public Vehicle saveVehicleInfo(Long vehicleid, long routeid) {
		//获取并更新车牌信息，增加线路id 李电志 2015年7月8日 16:37:27
		Vehicle vehicle = (Vehicle) dao.get(Vehicle.class, vehicleid);
		//通过routeid获取route实体  李电志  2015年7月8日 16:37:32
		Route route = (Route) dao.get(Route.class, routeid);
		//更新车牌信息   李电志  2015年7月8日 16:37:39
		vehicle.setRoute(route);
		dao.merge(vehicle);
		return vehicle;
	}

	@Override
	public Vehicle showExpire(long orgid, long vehicleid, String cardno,
			long driverid, long driverid1) throws ServiceException {
		if (cardno != null) {
			List<Vehicle> vlist = dao.getVehicle(cardno);
			if (vlist == null || vlist.size() == 0) {
				// 系统不存在该IC卡信息！
				throw new ServiceException("0236");
			} else if (vlist.size() > 1) {
				// 系统中存在2辆以上的车与该卡对应，请先修改！
				throw new ServiceException("0428");
			}
			Vehicle vh = vlist.get(0);
			return vh;
		}
		
		return dao.getVehicle(vehicleid);
	}
	@Override
	public long getVehicleId(String vehicleno) {
		
		return dao.getVehicleId(vehicleno);
	}

	@Override
	public Map<String, String> saveSecuritycheckresult(List<Chkitem> list,
			String vehicleno, String periodtype, String checkby,
			String checktime, String result, String notenum) {
		Securitycheck securitycheck = new Securitycheck();
		Map<String, String> map = new HashMap<String, String>();
		String res = "1";
		String msg = "安检成功";
		try {
			
			//list只存不合格的检查项
			securitycheck.setLight("合格");
			securitycheck.setMirror("合格");
			securitycheck.setDrive("合格");
			securitycheck.setBrake("合格");
			securitycheck.setTurn("合格");
			securitycheck.setWheel("合格");
			securitycheck.setHang("合格");
			securitycheck.setLeak("合格");
			securitycheck.setWindow("合格");
			securitycheck.setSafety("合格");
			securitycheck.setCamera("合格");
			securitycheck.setReturncheck("合格");
			if(null!=list)
			{
				for(Chkitem chkitem:list)
				{
					if("1".equals(chkitem.getItemname()))
					{
						securitycheck.setLight(chkitem.getCheckres());
					}else if("2".equals(chkitem.getItemname()))
					{
						securitycheck.setMirror(chkitem.getCheckres());
					}else if("3".equals(chkitem.getItemname()))
					{
						securitycheck.setDrive(chkitem.getCheckres());
					}else if("4".equals(chkitem.getItemname()))
					{
						securitycheck.setBrake(chkitem.getCheckres());
					}else if("5".equals(chkitem.getItemname()))
					{
						securitycheck.setTurn(chkitem.getCheckres());
					}else if("6".equals(chkitem.getItemname()))
					{
						securitycheck.setWheel(chkitem.getCheckres());
					}else if("7".equals(chkitem.getItemname()))
					{
						securitycheck.setHang(chkitem.getCheckres());
					}else if("8".equals(chkitem.getItemname()))
					{
						securitycheck.setLeak(chkitem.getCheckres());
					}else if("9".equals(chkitem.getItemname()))
					{
						securitycheck.setWindow(chkitem.getCheckres());
					}else if("10".equals(chkitem.getItemname()))
					{
						securitycheck.setSafety(chkitem.getCheckres());
					}else if("11".equals(chkitem.getItemname()))
					{
						securitycheck.setCamera(chkitem.getCheckres());
					}else if("12".equals(chkitem.getItemname()))
					{
						securitycheck.setReturncheck(chkitem.getCheckres());
					}
				}
			}	
			//先查询出vehicleno对应vehicleid
			long vehicleid = getVehicleId(vehicleno);
			
			//用来把安检时间转成日期格式
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
			Date chdatetime = null;
			try {
				chdatetime = sdf.parse(checktime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
			
			securitycheck.setVehicleid(vehicleid);
			securitycheck.setPeriodtype(periodtype);
			securitycheck.setCheckby(Long.parseLong(checkby));
			securitycheck.setChecktime(chdatetime);
			securitycheck.setResult(result);
			Date currentTime = new Date();
			if("1".equals(result))
			{
				//创建安检合格通知单号
				Date date = new Date();
				SimpleDateFormat sdf1 = new SimpleDateFormat("yyyyMMdd");
				String prenotenum = sdf1.format(date); 
				//合格通知单号
				notenum = prenotenum+checkby+currentTime.getSeconds();
				securitycheck.setNotenum(notenum);
				
			}else if("0".equals(result))//只传递安检合格通知单号，不传递不合格项
			{
				securitycheck.setNotenum(notenum);
			}
		
			securitycheck.setOrgid(1158012L);
			securitycheck.setCreatetime(currentTime);
			securitycheck.setUpdatetime(currentTime);
			securitycheck.setCreateby(1158013L);
			securitycheck.setUpdateby(1158013L);
			save(securitycheck);
			TransactionUtil.commit();
			} catch (Exception e) {
				res = "0";
				msg ="系统异常";
				e.printStackTrace();
			}finally
			{
				map.put("res", res);
				map.put("msg", msg);
			}
		return map;
	}
	
	@Override
	public String getVehicleUnitName(Long vehicleid) {
		// TODO Auto-generated method stub
		return dao.getVehicleUnitName(vehicleid);
	}
	
	/**
	 * 重打安检通知单
	 * @param securityCheckId
	 * @throws ServiceException 
	 */
	public List<Map<String, Object>> reprintSecurity(Global global, Long securityCheckId){
		//更新安检结果重打次数字段
		int reprinttimes = Integer.valueOf(parameterService.findParamValue(ParamterConst.Param_6071, global.getOrganization().getId())) ;//参数6071: 安检通知单允许重新打印次数，若参数为0无限制次数，默认为0
		Securitycheck securitycheck = (Securitycheck) dao.get(LockModeType.PESSIMISTIC_READ, Securitycheck.class, securityCheckId);
		if((reprinttimes > 0) && (securitycheck.getReprinttimes() >= reprinttimes)){
			throw new BusinessException("此安检通知单已超过允许重打次数，不可再次重打！");
		}
		
		//返回安检通知单打印信息
		Object[] fileds = new Object[] { "id", "notenum", "checktime",
				"routename", "color", "vehicleno", "checkorg", "checker",
				"checkerid", "checkercode", "vehicletypename","rechecktime",
				"idcard","workno","driverlicense","vehicleunitname" };
		Object[] filedTypes = new Object[] { Long.class,
				String.class, Timestamp.class, String.class,
				String.class, String.class, String.class, String.class,
				Long.class, String.class, String.class,Timestamp.class,
				String.class, String.class, String.class,String.class};
		List<Object> checklist = dao.queryCheckinfo(securityCheckId);
		
		boolean flag = true;//操作是否成功，若成功，则重打次数+1
		
		//0143：是否开启车辆里程限制
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(parameterService.findParamValue(ParamterConst.Param_0143, global.getOrganization().getId()))){
			String distancemessage;
			try {
				//如果二维有效期及里程有开启限制，需要查询提醒内容
				VehicledistanceactiveService vservice = new VehicledistanceactiveServiceImpl();
				distancemessage = vservice.qryVheicledistiance(securitycheck.getVehicleid(), global.getOrganization().getId(), false);
				
				if(distancemessage != null){
					//在原数据基础上增加字段distancemessage
					Object[] beforCheckInfo = (Object[]) checklist.get(0);
					Object[] afterCheckInfo = new Object[beforCheckInfo.length + 1];
					System.arraycopy(beforCheckInfo, 0, afterCheckInfo, 0, beforCheckInfo.length);
					afterCheckInfo[beforCheckInfo.length] = distancemessage;
					
					checklist = new ArrayList<Object>();
					checklist.add(afterCheckInfo);
					
					fileds = new Object[] { "id", "notenum", "checktime",
							"routename", "color", "vehicleno", "checkorg", "checker",
							"checkerid", "checkercode", "vehicletypename","rechecktime",
							"idcard","workno","driverlicense","vehicleunitname", "distancemessage" };
					filedTypes = new Object[] { Long.class,
							String.class, Timestamp.class, String.class,
							String.class, String.class, String.class, String.class,
							Long.class, String.class, String.class,Timestamp.class,
							String.class, String.class, String.class, String.class, String.class };
				}
			} catch (ServiceException e) {
				flag = false;//操作失败
				play.Logger.error("重打安检单时查询二维有效期出错：" , e);
				checklist = null;
				//throw new BusinessException("重打安检单时查询二维有效期出错");
			}
		}
		
		if(flag){
			securitycheck.setReprinttimes(securitycheck.getReprinttimes() + 1);//重打次数+1
			securitycheck.setUpdateby(global.getUserinfo().getId());
			securitycheck.setUpdatetime(new Date());
			dao.merge(securitycheck);
		}
		
		return ListUtil.listToMap(fileds, checklist, filedTypes);
	}

	@Override
	public List<Map<String, Object>> qrySecurityExpirydate(Global global,long vehicleid, long driverid) {
//		String value = parameterService.findParamValue(ParamterConst.Param_6072, global.getOrganization().getId());
//        Integer days = Integer.valueOf(value);
        List<Object> list = null;
        if(vehicleid>0){
            list = dao.qrySecurityVehicleExpirydate(vehicleid,0);
        }else if(driverid>0){
            list = dao.qrySecurityDriverExpirydate(driverid,0);
        }
        Object[] fileds = new Object[]{"id", "certificateType", "certificateNo","duedate", "remaindays"};
        Object[] filedTypes = new Object[] { Long.class,String.class,String.class, String.class, Integer.class};
        return ListUtil.listToMap(fileds,list,filedTypes);
	}
}
