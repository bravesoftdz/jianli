package cn.nova.bus.pack.dao;

import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PacktturnoverdetailDao extends EntityManagerDaoSurport<Packtturnoverdetail> {

	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		
		StringBuffer sb = new StringBuffer();
		
		sb.append(" select wm_concat(ptd.id),")
       .append(" decode(sum(ptd.ISTURNOVER),count(ptd.ISTURNOVER),wm_concat(ptd.PACKTTURNOVERID), 0),")
       .append(" trunc(ptd.MONEYDATE),")
       .append(" ptd.SELLBY,")
       .append(" min(ptd.TICKETSTARTNO),")
       .append(" max(ptd.TICKETENDNO),")
       .append(" decode(sum(ptd.ISTURNOVER),count(ptd.ISTURNOVER),max(ptd.TURNOVERTIME),''),")
//       .append(" max(ptd.TURNOVERTIME),")
       .append(" decode(sum(ptd.ISAUDIT),count(ptd.ISAUDIT),max(ptd.AUDITTIME),''),")
       //.append(" max(ptd.AUDITTIME),")
       .append(" sum(ptd.SENDPACKS),")
       .append(" sum(ptd.SENDPACKAMOUNT),")
       .append(" sum(ptd.PICKUPS),")
       .append(" sum(ptd.PICKUPAMOUNT),")
       .append(" sum(ptd.MONEYPAYABLE),")
       .append(" decode(sum(ptd.ISTURNOVER),count(ptd.ISTURNOVER),1,0),")
       .append(" decode(sum(ptd.ISAUDIT),count(ptd.ISAUDIT),1,0),")
       .append(" ptd.BATCHNO,")
       .append(" sum(ptd.SHIPPRICE),")
       .append(" sum(ptd.PACKFEE),")
       .append(" sum(ptd.UNLOADFEE),")
       .append(" sum(ptd.HANDFEE),")
       .append(" sum(ptd.CUSTODIAL),")
       .append(" sum(ptd.TRANSITFEE),")
       .append(" sum(ptd.INSUREDAMOUNT),")
       .append(" sum(ptd.INSURANCEFEE),")
       .append(" sum(ptd.INSURANCE),")
       .append(" sum(ptd.DELIVERYFEE),")
       .append(" sum(ptd.SERVICEFEE),")
       .append(" sum(ptd.OTHERFEE),")
       .append(" sum(ptd.PACKPRICE),")
       .append(" ptd.ORGID,")
       .append(" ptd.DATAFROM,")
       .append(" ptd.CREATEBY,")
       .append(" ptd.UPDATEBY,")
       .append(" sum(ptd.CANCELNUM),")
       .append(" sum(ptd.RETURNNUM),")
       .append(" sum(ptd.TICKETNUM),")
       .append(" sum(ptd.RETURNHANDCHARGE),")
       .append(" sum(ptd.RETURNMONEY),")
       .append(" org.name as orgname,")
       .append(" did.value as datafromname,")
       .append(" usl.name as sellbyname,")
       .append(" cre.name as createbyname,")
       .append(" upd.name as updatebyname,")
       .append(" 0 as ischoose ")
		.append(" from Packtturnoverdetail  ptd,Organization  org,Userinfo  usl,Userinfo cre,Userinfo upd,Digitaldictionary di,Digitaldictionarydetail did ")
		.append(" where 1 = 1 and ptd.orgid=org.id and ptd.sellby=usl.id and ptd.createby=cre.id and ptd.updateby=upd.id ")
		.append(" and di.tablename='packtturnoverdetail' and di.columnname='datafrom' and did.digitaldictionaryid = di.id and ptd.datafrom=did.code ")
		.append(PropertyFilter.toJpql(propertyFilterList, true))
		.append(" group by ptd.moneydate ,")
     //  .append(" ptd.PACKTTURNOVERID,")
       .append(" ptd.SELLBY,")
       .append(" ptd.BATCHNO,")
       .append(" ptd.ORGID,")
       .append(" ptd.DATAFROM,")
       .append(" ptd.CREATEBY,")
       .append(" ptd.UPDATEBY,")
       .append(" org.name,")
       .append(" did.value,")
       .append(" usl.name,")
       .append(" cre.name,")
       .append(" upd.name   ")
        .append(" order by ptd.moneydate ");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		List<Object> list = query.getResultList();
		return list;

	}
	
	public boolean updatePacktturnoverdetail(long sellby,String newpackno,String oldpackno){
		StringBuffer sb = new StringBuffer();
		sb.append(" update packtturnoverdetail ptd set ptd.ticketstartno=:newpackno,ptd.ticketendno=:newpackno where ptd.sellby=:sellby and ptd.datafrom='0' and ptd.ticketstartno=:oldpackno ");
		Query query = getEntityManager().createNativeQuery(sb.toString());
		query.setParameter("newpackno",newpackno );
		query.setParameter("sellby",sellby );
		query.setParameter("oldpackno",oldpackno );
		
		return query.executeUpdate()>0?true:false;
	}

	public List<Packtturnoverdetail> qryPacktturnoverdetailBypackno(List<PropertyFilter> propertyFilters, boolean isOtherSellby) {
StringBuffer sb = new StringBuffer();
		
		if (isOtherSellby){
			sb.append(" select t from Packtturnoverdetail t where 1=1 and t.datafrom='1' ");
		}else{
			sb.append(" select t from Packtturnoverdetail t where 1=1 and t.datafrom='0' ");
		}	
		
		sb.append(PropertyFilter.toJpql(propertyFilters, true));
		Query query = getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		List<Packtturnoverdetail> packtturnoverdetail = query.getResultList();
		return  packtturnoverdetail;
	}
	public List<Packtturnoverdetail> qryPacktturnoverdetailBypackno(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();
				
					sb.append(" select t from Packtturnoverdetail t where 1=1 and t.datafrom='2' ");
				
				sb.append(PropertyFilter.toJpql(propertyFilters, true));
				Query query = getEntityManager().createQuery(sb.toString());
				JPAPropertyFilterUtil.setParameter(query, propertyFilters);
				List<Packtturnoverdetail> packtturnoverdetail = query.getResultList();
				return  packtturnoverdetail;
			}

}
