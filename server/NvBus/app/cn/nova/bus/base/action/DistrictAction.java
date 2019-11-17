/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b><br/>
 * <b>文件名：</b>.java<br/>
 * <b>版本信息：</b>南凌客运信息管理系统 v4.0<br/>
 * <b>日期：</b> 2011-8-11 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 * 
 */
package cn.nova.bus.base.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.base.model.District;
import cn.nova.bus.base.service.DistrictService;
import cn.nova.bus.base.service.impl.DistrictServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * <b>类描述：</b> <b>类名称：</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-8-11 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */
public class DistrictAction extends BaseAction{

	private District district;
	private Long id;
	private List<District> districtlist;
	private List<Map<String, Object>> districtmap;

	private DistrictService districtService;

	public String query() {
		try {
			districtService = new DistrictServiceImpl();
			setDistrictmap(districtService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();
		districtService = new DistrictServiceImpl();
		if (district != null) {
			if (district.getId() > 0) {
				msg = "修改成功！";
				markSuccess();
				district.setUpdateby(global.getUserinfo().getId());
				district.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			} else {
				msg = "添加成功！";
				markSuccess();
				district.setIsactive(true);
				district.setIslocaldelete(false);
				district.setCreateby(global.getUserinfo().getId());
				district.setUpdateby(global.getUserinfo().getId());
				district.setOrgid(global.getOrganization().getId());
				district.setUpdatetime(new Timestamp(System.currentTimeMillis()));
				district.setCreatetime(new Timestamp(System.currentTimeMillis()));
			}
		}
		try {
			district = districtService.save(district);
			setId(district.getId());
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "操作失败！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		districtService = new DistrictServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (district != null) {
				District dis = null;
				if (district.getId() > 0) {
					boolean csFlag = districtService.isContainSta(district.getId()); //区域是否包含站点
					//区域包含站点不删除
					if (csFlag==true) {
						msg = "该区域("+district.getName()+")下包含有站点信息，不能删除。";
						markSuccess();
						setId(district.getId());
					}
					//区域不包含站点删除
					else {
						dis = districtService.getById(district.getId());
						dis.setIsactive(false);
						dis.setIslocaldelete(true);
						dis.setUpdateby(global.getUserinfo().getId());
						dis.setUpdatetime(new Timestamp(System.currentTimeMillis()));
						msg = "删除成功！";
						markSuccess();
						dis = districtService.save(dis);
						setId(dis.getId());
					}
				}
			}
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			msg = "删除失败！";
			markFail();
		}
		return "json";
	}

	public District getDistrict() {
		return district;
	}

	public void setDistrict(District district) {
		this.district = district;
	}

	public List<District> getDistrictlist() {
		return districtlist;
	}

	public void setDistrictlist(List<District> districtlist) {
		this.districtlist = districtlist;
	}

	public List<Map<String, Object>> getDistrictmap() {
		return districtmap;
	}

	public void setDistrictmap(List<Map<String, Object>> districtmap) {
		this.districtmap = districtmap;
	}

	public DistrictService getDistrictService() {
		return districtService;
	}

	public void setDistrictService(DistrictService districtService) {
		this.districtService = districtService;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
