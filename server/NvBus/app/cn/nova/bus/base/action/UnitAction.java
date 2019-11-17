/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.base.action<br/>
 * <b>文件名：</b>UnitAction.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.Unit;
import cn.nova.bus.base.service.UnitService;
import cn.nova.bus.base.service.impl.UnitServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;
/**
 * <b>类描述：</b>
 * <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39	<br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class UnitAction extends BaseAction{

	private Unit unit;
	private Long id;
	private List<Unit> unitlist;
	private List<Map<String, Object>> unitmap;

	private UnitService unitService;

	public String query() {
		try {
			unitService = new UnitServiceImpl();
			setUnitmap(unitService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		unitService = new UnitServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (unit != null) {
				if (unit.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					Unit un = unitService.getById(unit.getId());
					unit.setIsactive(true);
					unit.setIslocaldelete(false);
					unit.setSynccode(un.getSynccode());
					unit.setUpdateby(global.getUserinfo().getId());
					unit.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					if (!"".equals(unit.getCardno())) {
						if (un.getCardno() != null) {
							if (!un.getCardno().equals(unit.getCardno())) {
								if (unitService.unique("cardno",
										unit.getCardno())) {
									msg = "车属单位结算卡号已经存在，请重新输入！";
									markFail();
									return "json";
								}
							}
						} else {
							if (unitService.unique("cardno",
									unit.getCardno())) {
								msg = "车属单位结算卡号已经存在，请重新输入！";
								markFail();
								return "json";
							}
						}
					}
					if (!un.getName().equals(unit.getName())) {
						if (unitService.unique("name", unit.getName())) {
							msg = "车属单位名称已经存在，请重新输入！";
							markFail();
							return "json";
						}
					}
					if (!un.getFullname().equals(unit.getFullname())) {
						if (unitService.unique("fullname", unit.getFullname())) {
							msg = "车属单位全称已经存在，请重新输入！";
							markFail();
							return "json";
						}
					}
					if (!un.getCode().equals(unit.getCode())) {
						if (unitService.unique("code", unit.getCode())) {
							msg = "车属单位编码已经存在，请重新输入！";
							markFail();
							return "json";
						}
					}
				} else {
					msg = "添加成功！";
					markSuccess();
					unit.setIsactive(true);
					unit.setIslocaldelete(false);
					unit.setUpdateby(global.getUserinfo().getId());
					unit.setCreateby(global.getUserinfo().getId());
					unit.setOrgid(global.getOrganization().getId());
					unit.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					unit.setCreatetime(new Timestamp(System.currentTimeMillis()));
					if (unitService.unique("name", unit.getName())) {
						msg = "车属单位名称已经存在，请重新输入！";
						markFail();
						return "json";
					}
					if (unitService.unique("fullname", unit.getFullname())) {
						msg = "车属单位全称已经存在，请重新输入！";
						markFail();
						return "json";
					}
					if (unitService.unique("cardno", unit.getCardno())) {
						msg = "车属单位的结算卡已经存在，请重新输入！";
						markFail();
						return "json";
					}
					if (unitService.unique("code", unit.getCode())) {
						msg = "车属单位编码已经存在，请重新输入！";
						markFail();
						return "json";
					}
				}
				unit = unitService.save(unit, global);
				setId(unit.getId());
			}
		} catch (ServiceException ex){
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg(e.getMessage());
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		if (unit != null) {
			try {
				unitService = new UnitServiceImpl();
				if (unitService.isApply(unit.getId())) {
					setMsg("对不起，该车属单位已经被使用，不能删除！");
					markSuccess();
					return "json";
				}
				if (unit.getId() > 0) {
					msg = "删除成功！";
					markSuccess();
					Unit un = unitService.getById(unit.getId());
					un.setIsactive(false);
					un.setIslocaldelete(true);
					un.setUpdateby(global.getUserinfo().getId());
					un.setUpdatetime(new Timestamp(System.currentTimeMillis()));
					unitService.save(un, null);
				} else {
					msg = "删除失败！";
					markFail();
				}
			} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
				msg = "删除失败！";
				markFail();
			}
		}
		return "json";
	}

	public Unit getUnit() {
		return unit;
	}

	public void setUnit(Unit unit) {
		this.unit = unit;
	}

	public List<Unit> getUnitlist() {
		return unitlist;
	}

	public void setUnitlist(List<Unit> unitlist) {
		this.unitlist = unitlist;
	}

	public List<Map<String, Object>> getUnitmap() {
		return unitmap;
	}

	public void setUnitmap(List<Map<String, Object>> unitmap) {
		this.unitmap = unitmap;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
