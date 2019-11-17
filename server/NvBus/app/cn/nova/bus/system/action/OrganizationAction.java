package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.bus.system.service.impl.OrganizationServiceImpl;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 
 * <p>
 * Title: 机构管理
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

public class OrganizationAction extends BaseAction{
	private Organization organization;// 添加时映射的对象
	private Long orgid;//
	private String orgids;//

	private List<Organization> orglist;// 查询时返回的数据集,批量提交时也用这个变量
	private List<Map<String, Object>> orgmap;// 查询时返回的数据集,批量提交时也用这个变量
	private List<Map<String,Object>> datalist;//返回机构权限

	private OrganizationService organService;

	public String query() {
		try {
			organService = new OrganizationServiceImpl();
			setOrgmap(organService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//获取当前用户的机构权限
	public String qryuserorgright() {
		try {
			Global global = CurrentUtil.getGlobal();
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryUserOrgRight(global.getOrgIDs()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	//获取配客点和车站
	public String qryallorg() {
		try {
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryAllOrg());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//获取配客点和车站
	public String qryOtherOrg() {
		try {
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryOtherOrg());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String save() {
		Global global = CurrentUtil.getGlobal();
		try {
			organService = new OrganizationServiceImpl();
			if (organization != null) {
				if (organization.getId() > 0) {
					msg = "修改成功！";
					markSuccess();
					organization.setUpdateby(global.getUserinfo().getId());
					organization.setUpdatetime(new Date());
				} else {
					msg = "添加成功！";
					markSuccess();
					organization.setCreateby(global.getUserinfo().getId());
					organization.setCreatetime(new Date());
					organization.setUpdateby(global.getUserinfo().getId());
					organization.setUpdatetime(new Date());
				}
				organization=organService.save(organization);
				orgid=organization.getId();				
			}
		} catch (ServiceException se) {
			orgid=new Long(0);
			msg = se.getMessage();
			markFail();
		} catch (Exception e) {
			orgid=new Long(0);
			play.Logger.error(e.getMessage(), e);
			msg = "系统异常！";
			markFail();
		}
		return "json";
	}

	public String delete() {
		Global global = CurrentUtil.getGlobal();
		if (organization != null) {
			try {
				organService = new OrganizationServiceImpl();
				if (organization.getId() > 0) {
					msg = "删除成功！";
					markSuccess();
					Organization organ = organService.getById(organization
							.getId());
					organ.setIsactive(false);
					organ.setIslocal(true);
					organ.setUpdateby(global.getUserinfo().getId());
					organ.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					organService.save(organ);
				} else {
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

	public String qryAllSubOrg() {
		try {
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryAllSubOrg());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryOtherOrgbyParentOrg() {
		try {
			Global global = CurrentUtil.getGlobal();
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryOtherOrgbyParentOrg(orgids,global.getOrganization().getId()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String qryOrgbyParentOrg() {
		try {
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryOrgbyParentOrg(orgids));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	//获取当前用户的机构权限
	public String qryuseAllStation() {
		try {
			
			organService = new OrganizationServiceImpl();
			setDatalist(organService.qryuseAllStation());
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public Organization getOrganization() {
		return organization;
	}

	public void setOrganization(Organization organization) {
		this.organization = organization;
	}

	public List<Organization> getOrglist() {
		return orglist;
	}

	public void setOrglist(List<Organization> orglist) {
		this.orglist = orglist;
	}

	public List<Map<String, Object>> getOrgmap() {
		return orgmap;
	}

	public void setOrgmap(List<Map<String, Object>> orgmap) {
		this.orgmap = orgmap;
	}
	public Long getOrgid() {
		return orgid;
	}

	public void setOrgid(Long orgid) {
		this.orgid = orgid;
	}
	
	public List<Map<String, Object>> getDatalist() {
		return datalist;
	}

	public void setDatalist(List<Map<String, Object>> datalist) {
		this.datalist = datalist;
	}
	
	public String getOrgids() {
		return orgids;
	}
	public void setOrgids(String orgids) {
		this.orgids = orgids;
	}
}
