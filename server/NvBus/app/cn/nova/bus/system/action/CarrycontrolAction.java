package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Carrycontrol;
import cn.nova.bus.system.service.CarrycontrolService;
import cn.nova.bus.system.service.impl.CarrycontrolServiceImpl;

/**
 * 
 * <p>
 * Title: 进位规则管理
 * </p>
 * <p>
 * Description:
 * </p>
 * <p>
 * Copyright: Copyright (c) 2010
 * </p>
 * <p>
 * Company: nova
 * </p>
 * 
 * @author lanckun
 * @version 0.1
 */

public class CarrycontrolAction extends BaseAction{
	private Carrycontrol carrycontrol;// 添加时映射的对象
	private List<Carrycontrol> carrylist;// 查询时返回的数据集,批量提交时也用这个变量
	private List<Map<String, Object>> carrymap;// 查询时返回的数据集,批量提交时也用这个变量

	private CarrycontrolService carrycontrolService;
	
	public String query() {
		try {
			carrycontrolService = new CarrycontrolServiceImpl();
			carrymap = carrycontrolService.query(carrycontrol.getDescribe());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String batchsave() {
		try {
			carrycontrolService = new CarrycontrolServiceImpl();
			if (carrylist.size() > 0) {
				for (int i = 0; i < carrylist.size(); i++) {
					Carrycontrol carr = carrylist.get(i);
					if (carr.getOpertype().equals("8")) {
						// 进行修改操作
						Carrycontrol oldcarr = carrycontrolService.getByModulecode(carr.getModulecode());
						//DataSetUtil.mergeObject(carr, oldcarr);
						carrycontrolService.save(oldcarr);
						carrylist.set(i, oldcarr);
						oldcarr.setUpdatetime(new Timestamp(System
								.currentTimeMillis()));
					} else if (carr.getOpertype().equals("2")) {
						// 进行删除
						carrycontrolService.delete(carr.getId());
					}
				}
				msg = "保存成功！";
				markSuccess();
			}
		} catch (Exception ex) {
			msg = "保存失败！";
			markSuccess();
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			carrycontrolService = new CarrycontrolServiceImpl();
			if (carrycontrol != null) {
				if (carrycontrol.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					carrycontrol.setUpdateby(global.getUserinfo().getId());
					carrycontrol.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					//判断当前Id的编码是否存在非当前Id存在的编码
					if (carrycontrolService.getValue(carrycontrol.getId(),"modulecode",carrycontrol.getModulecode())>0){						
							msg = "对不起，您输入的规则编码已经存在。请重新输入......";
							markFail();
							return "json";						
					}
					//判断当前Id的名称是否存在非当前Id存在的名称
					if (carrycontrolService.getValue(carrycontrol.getId(),"describe",carrycontrol.getDescribe())>0) {
						
							msg = "对不起，您输入规则名称已经存在。请重新输入......";
							markFail();
							return "json";
						
					}
					
				} else {
					msg = "添加成功！";
					markSuccess();
					
					carrycontrol.setUpdateby(global.getUserinfo().getId());
					carrycontrol.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					
					if (carrycontrolService.findModulecode(carrycontrol.getModulecode()) > 0) {
						msg = "对不起，您输入的规则编码已经存在。请重新输入......";
						markFail();
						return "json";
					}
					if (carrycontrolService.findDescribe(carrycontrol.getDescribe()) > 0) {
						
							msg = "对不起，您输入的规则名称已经存在。请重新输入......";
							markFail();
							return "json";
					}
				}
				if (!carrycontrolService.save(carrycontrol)) {
					msg = "操作失败！";
					markFail();
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		if (carrycontrol != null) {
			try {
				carrycontrolService = new CarrycontrolServiceImpl();
				if (carrycontrol.getId() > 0) {
					msg = "删除成功！";
					markSuccess();
					Carrycontrol carry = carrycontrolService.getById(carrycontrol.getId());					
					if (!carrycontrolService.delete(carry.getId())) {
						msg = "删除失败！";
						markFail();
					}
				}
				else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception ex) {
				play.Logger.error(ex.getMessage(), ex);
				msg = "删除失败:";
				markFail();
			}
		}
		return "json";
	}

	public Carrycontrol getCarrycontrol() {
		return carrycontrol;
	}

	public void setCarrycontrol(Carrycontrol carrycontrol) {
		this.carrycontrol = carrycontrol;
	}

	public List<Carrycontrol> getCarrylist() {
		return carrylist;
	}

	public void setCarrylist(List<Carrycontrol> carrylist) {
		this.carrylist = carrylist;
	}

	public List<Map<String, Object>> getCarrymap() {
		return carrymap;
	}

	public void setCarrymap(List<Map<String, Object>> carrymap) {
		this.carrymap = carrymap;
	}

}
