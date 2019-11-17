package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackWarehousingDao extends EntityManagerDaoSurport{
	/**
	 * 查询到货入仓
	 * @param propertyFilters
	 * @return
	 */
	public List<Object> query(List<PropertyFilter> propertyFilters) {

		StringBuffer sql = new StringBuffer("select ")
				.append("0 as ischoose ,p.id,p.packtype,p.goodtype,p.sendstationid,p.tostationid,p.name,")
				.append("p.scheduleid,p.vehicleid,p.departdate,p.packno,p.invoiceno,p.sellby,")
				.append("p.pieces,p.weight,p.volume,p.packed,p.shipprice,p.packfee,p.handfee,p.unloadfee,")
				.append("p.custodial,p.transitfee,p.insuredamount,p.insurancefee,p.insurance,")
				.append("p.deliveryfee,p.otherfee,p.totalfee,p.location,p.packprice,p.sender,")
				.append("p.senderphone,p.senderaddress,p.consignee,p.consigneephone,p.consigneeaddress,")
				.append("p.certificatetype,p.certificateno,p.shiptype,p.paymethod,p.valuables,p.status,")
				.append("p.packtturnoverid,p.remak,p.orgid,p.createtime,p.createby,p.updatetime,p.updateby,p.integraterprice,p.servicefee,")
				.append("f.name as sendstationname,e.name as tostationname,s.code as schedulecode,cast(s.starttime as varchar2(5)) as departtime,v.vehicleno as vehiclecode,")
//				.append(" c.name as sellbyname,u.name as updatebyname,")
				.append(" p.entrypacker entrypacker,u.name as updatebyname,")
				.append(" p.signby,us.name as signbyname,p.signtime,p.onlycode,p.synccode,org.name orgname")
				.append(" ,cnt.id as clientid ,cnt.mobilephone,cnt.name as clientname,cnt.address as clientaddress,")
				.append(" cnt.code as clientcode,cnt.integrater as clientintegrater,cnt.type as clienttype,p.singbillno,")
				.append(" p.zhuanyuntostationid,zy.name zhuanyuntostationname,p.takename,p.takecertificateno,dd.value as vcstatus,p.balancestatus as balancestatus,p.collectstatus as collectstatus,p.recyclestatus as recyclestatus,p.goodsstatus as goodsstatus,dd2.value as packedname")
				.append(" ,pa.packarriverno packarriverno,pa.arriverdate packarriverdate,pa.status packarriverstatus,pa.id packarriverid,pa.createby as packarrivercreatby,pa.createtime as packarrivercreatetime ")
				.append(" from pack p")
				.append(" left join Station f on f.id=p.sendstationid")
				.append(" left join Station e on e.id=p.tostationid")
				.append(" left join Station zy on zy.id=p.zhuanyuntostationid")
				.append(" left join Schedule s on s.id=p.scheduleid ")
				.append(" left join Vehicle v on v.id=p.vehicleid")
//				.append(" left join Userinfo c on c.id=p.sellby ")
				.append(" left join Userinfo u on u.id=p.updateby")
				.append(" left join Userinfo us on us.id=p.signby")
				.append(" left join Client cnt on cnt.id=p.clientid")
				.append(" left join packarriver pa on pa.packid=p.id")
				.append(" ,Organization org, digitaldictionary d,digitaldictionarydetail dd ,digitaldictionary d2,digitaldictionarydetail dd2  where 1=1 and org.id=p.orgid ")
				.append(" and d.id=dd.digitaldictionaryid and d.tablename='pack' and d.columnname='status'  and p.status=dd.code")
				.append(" and d2.id=dd2.digitaldictionaryid and d2.tablename='pack' and d2.columnname='packed' and p.packed=dd2.code")
				.append(" ")
				.append(PropertyFilter.toJpql(propertyFilters, true))
				.append(" and p.status = 4 ")//到货库存
				.append(" order by case vcstatus when '发货库存' then 1 when '到货库存' then 2 end,createtime desc");
  
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> list = query.getResultList();
		return list;
	}

	/**
	 * 根据条件查询行包单号
	 * @param param
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryPackno(String param,List<PropertyFilter> propertyFilters){
		StringBuffer sb = new StringBuffer("select p.id,p.packno as name,p.sender as code,p.consignee as consignee from Pack p where 1=1");
		sb.append(" and (p.packno like '%").append(param)
			.append("%')");
		
		sb.append(PropertyFilter.toJpql(propertyFilters,true));
		
		Query query = getEntityManager().createQuery(sb.toString());
		
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);
		
		List<Object> list = query.getResultList();
		
		
		
		return list;
	}
	
	/**
	 * 验证单号是否已存在
	 * @param packno
	 * @return
	 */
	public boolean checkpackno(String packno){
		StringBuffer sb = new StringBuffer("select p.id Pack p where p.packtype='2' and p.status!='3' and p.packno=:packno");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("packno", packno);
		
		
		
		List<Object> list = query.getResultList();
		if(list==null || list.size()>0){
			return false;
		}
		return true;
	}
	
}
