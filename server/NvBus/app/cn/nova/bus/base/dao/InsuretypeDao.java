package cn.nova.bus.base.dao;

import java.math.BigDecimal;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.base.model.Insuretype;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class InsuretypeDao extends EntityManagerDaoSurport { 
	
	private ParameterService parameterService = new ParameterServiceImpl();
	

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuffer sql = new StringBuffer(
				"select i.id,i.orgid,i.insurersid,i.code,i.name,i.premium,")
		.append("  i.maxinsureamount,i.dividedrate,i.description,i.createtime,")
		.append(" i.createby,i.updatetime,i.updateby,i.synccode,i.ywmoney,i.shmoney,")
		.append(" i.emoney,i.emmoney,u.name as createname, o.name as orgname,")
		.append(" us.name as updatename,iu.name as insurersname,it.fromdistance,it.enddistance, ")
		.append(" iu.bankcode as insurersbankcode");
		sql.append(" from Insuretype i left join Insuretypedistance it on  it.insuretypeid=i.id,")
		.append(" Userinfo u, Organization o, Userinfo us, Insurers iu where i.createby = u.id ");
		sql.append(" and i.orgid = o.id and i.updateby=us.id and i.insurersid=iu.id ");
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();
	}
	
	@SuppressWarnings("unchecked")
	public List<Object> queryinsuretype(long orgid) {
		String param2626 = parameterService.findParamValue(ParamterConst.Param_2626,orgid);//是否使用平台保险服务器
		StringBuffer sql = new StringBuffer("");
		Query query = null;
		if(ParamterConst.COMMON_FLAG.FALG_YES.equals(param2626)){
			sql.append(" select it.id,t.productcode,t.productcode,t.premium,t.dieinsureamount  ")
			.append(" ,t.insurecompanyname,0,0,it.insurersid,it.id,t.dieinsureamount,")
			.append("t.medicalinsureamount from   platforminsurancetype t,insurers i,insuretype it ")
			.append("where t.insurecompanycode=i.bankcode and i.id=it.insurersid ");
		}else{
			String param1060 = parameterService.findParamValue(ParamterConst.Param_1060,orgid);//只显示正常班次
			if (param1060.equals(ParamterConst.COMMON_FLAG.FALG_NO)){
				sql = new StringBuffer(
				"select i.id,i.code,i.name typename,i.premium,i.maxinsureamount,iu.name compname,itf.fromdistance,")
				.append(" itf.enddistance,i.insurersid,i.id as insuretypeid, i.emoney,i.emmoney ")
				.append(" from Insuretype i, Insurers iu, insuretypedistance itf")
				.append(" where i.insurersid = iu.id and i.id = itf.insuretypeid ")
				.append(" and i.orgid="+orgid);
			}else{
				sql = new StringBuffer(
				"select i.id,i.code,i.name typename,i.premium,i.maxinsureamount,iu.name compname,itf.fromprice,")
				.append(" itf.endprice,i.insurersid,i.id as insuretypeid, i.emoney,i.emmoney ")
				.append(" from Insuretype i, Insurers iu, insurancetypefares itf")
				.append(" where i.insurersid = iu.id and i.id = itf.insuretypeid ")
				.append(" and i.orgid="+orgid)			;
			}
		}
		query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
		
	}
	
	public Insuretype isExistCode(Long orgid, String code) {
		StringBuffer sql = new StringBuffer("select i from Insuretype i ");
		sql.append(" where i.orgid=:orgid and i.code=:code ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("code", code);
		if(query.getResultList()!=null && query.getResultList().size()>0){
			Insuretype result = (Insuretype) query.getResultList().get(0);
			return result;
		}else{
			return null;
		}		
	}

	public Insuretype isExistName(Long orgid, Long insurersid, String name) {
		StringBuffer sql = new StringBuffer("select i from Insuretype i ");
		sql.append(" where i.orgid=:orgid and i.insurersid=:insurersid and i.name=:name");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("orgid", orgid);
		query.setParameter("insurersid", insurersid);
		query.setParameter("name", name);
		if(query.getResultList()!=null && query.getResultList().size()>0){
			Insuretype result = (Insuretype) query.getResultList().get(0);
			return result;
		}else{
			return null;
		}	
	}

	public List<Object> qryInsuretypeByDistance(Long distance) {
		StringBuffer sql=new StringBuffer(" select i.insuretypeid from Insuretypedistance i ")
		.append("where :distance between i.fromdistance and i.enddistance ");
		Query query=getEntityManager().createQuery(sql.toString());
		query.setParameter("distance", distance);
		if(query.getResultList()!=null && query.getResultList().size()>0){
			return query.getResultList();
		}		
		return null;
	}

	public List<Object> qryInsuretypeByPrice(long fullprice) {
		StringBuffer sql=new StringBuffer(" select i.insuretypeid from Insurancetypefares i ")
		.append("where :fullprice between i.fromprice and i.endprice");
		Query query=getEntityManager().createQuery(sql.toString());
		query.setParameter("fullprice", fullprice);
		if(query.getResultList()!=null&&query.getResultList().size()>0){
			return query.getResultList();
		}
		return null;
	}
	//根据险种id查询单条险种信息
	public Insuretype getInsuretype(Long insuretypeid) {
		StringBuffer sql = new StringBuffer(
				"select t from Insuretype t where t.id=");
		sql.append(insuretypeid);
		Query query = getEntityManager().createQuery(sql.toString());
		if (query.getResultList().isEmpty()) {
			return null;
		}
		return (Insuretype) query.getSingleResult();
	}

	/**
	 * 保险服务器险种
	 * @param propertyFilterList
	 * @return
	 */
	public List<Object> queryPlatformInsure() {
		StringBuffer sql=new StringBuffer("select p.id insurersid,p.dieinsureamount MAXINSUREAMOUNT,p.premium premium, ")
		.append("p.insurecompanyname insurersname,p.id id,p.varname name from  platforminsurancetype p ");
		Query query=getEntityManager().createNativeQuery(sql.toString());
		if(query.getResultList()!=null&&query.getResultList().size()>0){
			return query.getResultList();
		}
		return null;
	}

}
