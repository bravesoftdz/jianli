package cn.nova.bus.system.service.impl;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.base.model.District;
import cn.nova.bus.base.model.Station;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.dao.OrganizationDao;
import cn.nova.bus.system.model.Organization;
import cn.nova.bus.system.service.OrganizationService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class OrganizationServiceImpl implements OrganizationService {
	
	private OrganizationDao dao = new OrganizationDao();

	@Override
	public Organization save(Organization organ) throws ServiceException {
		// （0售票公司、1配客点、2车站、3车队、4子公司、5集团公司、6市运管、7省运管）

		if (dao.isExistByName(organ)) {
			// 该机构名称已经存在！
			throw new ServiceException("0248");
		}
		if (dao.isExistByValue(organ)) {
			// 该机构编码已经存在！
			throw new ServiceException("0249");
		}
		if (organ.getId() == 0) {
			if (dao.isExistByStation(organ)) {
				throw new ServiceException("0104");
			}
			if (dao.isExistByUnit(organ)) {
				throw new ServiceException("0105");
			}
			if(organ.getType().equals("1")||organ.getType().equals("2")){
				Station station=(Station) dao.get(Station.class, organ.getStation().getId());
				station.setIsdepart(true);
				station.setUpdateby(organ.getCreateby());
				station.setUpdatetime(new Date());
				dao.merge(station);
			}
			if(organ.getOrgan().getId()==0){
				organ.setOrgan(null);
			}
			organ.setIsonline(false);
			return dao.getEntityManager().merge(organ);
		} else {
			Organization oldorg=(Organization) dao.get(Organization.class, organ.getId());
			if(oldorg.getStation()!=null){
				Station s=oldorg.getStation();
				s.setIsdepart(false);
				s.setUpdateby(organ.getCreateby());
				s.setUpdatetime(new Date());
				dao.merge(s);
			}
			if(organ.getType().equals("1")||organ.getType().equals("2")){
				Station station=(Station) dao.get(Station.class, organ.getStation().getId());
				station.setIsdepart(true);
				station.setUpdateby(organ.getUpdateby());
				station.setUpdatetime(new Date());
				dao.merge(station);
			}
			organ.setIsonline(oldorg.getIsonline());
			organ.setConnectcosttime(oldorg.getConnectcosttime());
			if(organ.getOrgan().getId()==0){
				organ.setOrgan(null);
			}
			if(organ.getDistrict()!=null)
				organ.setDistrict((District)dao.get(District.class, organ.getDistrict().getId()));
			return dao.getEntityManager().merge(organ);
		}
	}

	@Override
	public List<Organization> query() {
		return dao.query(Organization.class, null);
	}

	@Override
	public Organization getById(Long id) {
		return (Organization) dao.get(Organization.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "id", "code", "name", "type",
				"parentid", "describe", "serversaddress",
				"ticketserversaddress", "address", "contactperson",
				"contactphone", "unitid", "stationid", "isactive",
				"createtime", "createby", "updatetime", "updateby",
				"districtid", "islocal", "username", "parentname", "unitname",
				"stationname", "updatename", "districtname","synccode" },
				dao.query(propertyFilterList), new Object[] { Long.class,
						String.class, String.class, String.class, Long.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, Long.class, Long.class,
						boolean.class, Timestamp.class, Long.class,
						Timestamp.class, Long.class, Long.class, boolean.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class });
	}

	@Override
	public boolean equals(String code, String name) {

		@SuppressWarnings("rawtypes")
		List list = dao.getOrgan(code, name);
		if (list.isEmpty()) {
			return false;
		}
		return true;
	}

	@Override
	public String getValue(Long id, String value) {
		return dao.getValue(id, value);
	}

	@Override
	public Long findId(String code) {
		return dao.findId(code);
	}

	/*
	 * qryOrgRight方法：获取当前用户的机构权限<br/> <br/>
	 * 
	 * @param orgids
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.system.service.OrganizationService#qryOrgRight(java.lang.
	 * String)
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryUserOrgRight(String orgids) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				dao.qryOrgRight(orgids), new Object[] { Long.class,
						String.class, String.class });
	}

	/*
	 * qryOrgRight方法：获取有配客点和车站<br/> <br/>
	 * 
	 * @exception
	 */
	@Override
	public List<Map<String, Object>> qryAllOrg() {
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				dao.qryAllOrg(), new Object[] { Long.class,
						String.class, String.class });
	}
	
	@Override
	public Organization getOrgByStationId(long departstationid){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!station.id", departstationid));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
		return org;
	}

	@Override
	public Organization getOrgByStationCode(String departstationcode){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!station.code", departstationcode));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
		return org;
	}
	
	@Override
	public Organization getOrgByCode(String departorgcode){
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!code", departorgcode));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		Organization org = (Organization)dao.uniqueResult(Organization.class, propertyFilters);
		return org;
	}
	  
	/**
	 * 跳过虚拟机构取上级机构
	 * @param org
	 * @return
	 */
	@Override
	public Organization getDirectlyParentOrg(Organization org) {
		while(org!=null&&org.getIslocal()&&org.getOrgan()!=null){
			org = org.getOrgan();
			if(!org.getIslocal()){
				return org;
			}
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> qryAllSubOrg() {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQS_t!type", "4"));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		List<Object> list=dao.query(Organization.class, propertyFilters);
		return ListUtil.listToMap(new Object[] {Organization.class },
				list, new Object[] { Organization.class });
	}

	@Override
	public List<Map<String, Object>> qryOrgbyParentOrg(String porgids) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("INS_t!organ.id",porgids));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		propertyFilters.add(new PropertyFilter("INS_t!type", "(1,2)"));
		List<Object> list=dao.query(Organization.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQS_t!type", "0"));		
		//propertyFilters.add(new PropertyFilter("INS_t!type", "(0,8)"));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));		
		list.addAll(dao.query(Organization.class, propertyFilters));
		return ListUtil.listToMap(new Object[] {Organization.class },
				list, new Object[] { Organization.class });
	}

	@Override
	public List<Map<String, Object>> qryAllTicketsellOrg() {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("INS_t!type","(0,1,2)"));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		List<Object> list=dao.query(Organization.class, propertyFilters);
		return ListUtil.listToMap(new Object[] {Organization.class },
				list, new Object[] { Organization.class });
	}

	@Override
	public List<Map<String, Object>> qryOtherOrgbyParentOrg(String porgid,
			long curorgid) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("INS_t!organ.id",porgid));
		propertyFilters.add(new PropertyFilter("NOEQL_t!id",curorgid));		
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		propertyFilters.add(new PropertyFilter("INS_t!type","(2)"));	
		List<Object> list=dao.query(Organization.class, propertyFilters);
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("INS_t!type", "(0,8)"));		
		//propertyFilters.add(new PropertyFilter("EQS_t!type", "0"));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));		
		list.addAll(dao.query(Organization.class, propertyFilters));
		return ListUtil.listToMap(new Object[] {Organization.class },
				list, new Object[] { Organization.class });

	}

	@Override
	public List<Map<String, Object>> qryOtherOrg() {
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				dao.qryOtherOrg(), new Object[] { Long.class,
						String.class, String.class });
	}

	@Override
	public List<Object> qryOrginfoBy(Organization org) {
		// TODO Auto-generated method stub
		return dao.qryOrginfoBy(org);
	}

	@Override
	public List<Map<String, Object>> qryuseAllStation() {
		return ListUtil.listToMap(new Object[] { "id", "name", "code" },
				dao.qryAllStation(), new Object[] { Long.class,
						String.class, String.class });
	}
}
