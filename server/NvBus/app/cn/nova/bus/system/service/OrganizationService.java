package cn.nova.bus.system.service;

import java.util.List;
import java.util.Map;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Organization;
import cn.nova.utils.orm.PropertyFilter;

public interface OrganizationService {

	public Organization save(Organization or) throws ServiceException;

	public List<Organization> query();

	public Organization getById(Long id);

	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilterList);

	public boolean equals(String code, String name);

	public String getValue(Long id, String value);

	public Long findId(String code);
	//获取当前用户的机构权限
	public List<Map<String, Object>> qryUserOrgRight(String orgids);
	//获取当前机构所有发车站
	public List<Map<String, Object>> qryuseAllStation();
	//获取配客点和车站
	public List<Map<String, Object>> qryAllOrg();

	/**
	 * 根据departStationid取Organization
	 * @param departstationid 发车站点ID
	 * @return 机构
	 */
	public Organization getOrgByStationId(long departstationid);

	/**
	 * 根据发车站点编码取organization
	 * @param departstationcode 发车站点编码
	 * @return 机构
	 */
	public Organization getOrgByStationCode(String departstationcode);

	/**
	 * 根据机构编码取organization
	 * @param departorgcode 机构编码
	 * @return 机构
	 */
	public Organization getOrgByCode(String departorgcode);
	
	/**
	 * 跳过虚拟机构取上级机构
	 * @param org
	 * @return
	 */
	public Organization getDirectlyParentOrg(Organization org);
	
	/**
	 * 
	 * qryAllSubOrg方法：查询所有的分公司<br/>
	 * <br/>
	 * @return 
	 * @exception
	 */
    public List<Map<String, Object>> qryAllSubOrg();
	
    /**
     * 
     * qryOrgbyParentOrg方法：根据分公司查询下属所有车站<br/>
     * <br/>
     * @param orgid
     * @return 
     * @exception
     */
    public List<Map<String, Object>> qryOrgbyParentOrg(String porgids);
    
    
    /**
     * 
     * qryOrgbyParentOrg方法：根据分公司查询下属其他所有车站<br/>
     * <br/>
     * @param orgid
     * @return 
     * @exception
     */
    public List<Map<String, Object>> qryOtherOrgbyParentOrg(String porgids,long curorgid);
    /**
     * 
     * qryAllTicketsellOrg方法：查询所有的售票机构<br/>
     * <br/>
     * @return 
     * @exception
     */
    public List<Map<String, Object>> qryAllTicketsellOrg();
    
    public List<Map<String, Object>>  qryOtherOrg();
    
    public List<Object> qryOrginfoBy(Organization org);
}
