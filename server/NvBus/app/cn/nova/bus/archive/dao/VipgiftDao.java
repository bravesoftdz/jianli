package cn.nova.bus.archive.dao;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.archive.model.Vipgift;
import cn.nova.bus.archive.model.Vipgiftdetail;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

/**
 * 会员礼品管理
 * @author Administrator
 *
 */
@SuppressWarnings("rawtypes")
public class VipgiftDao extends EntityManagerDaoSurport{

	
	
	/**
	 * 查询会员礼品（及明细）信息
	 * @param startdate
	 * @param enddate
	 * @param vipgrade
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipgiftlist(Date startdate,Date enddate,String vipgrade,float beginamount,float endamount) {
		StringBuilder sql = new StringBuilder(
			" select TRIM(TO_CHAR(wm_concat( distinct dd.value || '(' || vd.needamount || ')' ))) as vipgradename," )
		.append(" TRIM(TO_CHAR(wm_concat( distinct vd.vipgrade))) as vipgrade,"  )
		.append(" TRIM(TO_CHAR(wm_concat( distinct vd.needamount))) as needamount," )
		.append(" v.id,v.name,v.valuation,v.quantity ,"  )
		.append(" v.startdate,v.enddate,v.remarks,v.createtime,v.updatetime,"  )
		.append(" cu.name createname,uu.name updatename,cu.id as createby  "  )
		.append(" from vipgift v, vipgiftdetail vd,digitaldictionary d,"  )
		.append(" digitaldictionarydetail dd,userinfo cu,userinfo uu"  )
		.append(" where v.id = vd.vipgiftid and d.columnname = 'grade'"  )
		.append(" and vd.vipgrade = dd.code and d.tablename = 'vip' "  )
		.append(" and v.createby=cu.id and v.updateby=uu.id "  )
		.append(" and d.id = dd.digitaldictionaryid ")
		.append(" and (( :startdate >= v.startdate and :startdate <= v.enddate ")
		.append(" 	or :enddate >= v.startdate and :enddate <= v.enddate ) ")
		.append(" or (v.startdate > :startdate and v.enddate < :enddate) ) ");
		if (!vipgrade.equals("")){
			String grade="'";
			char[] b = new char[vipgrade.length()-2];
			for(int j =1 ;j<vipgrade.length()-1;j++){
				b[j-1]=vipgrade.charAt(j);
			}
			String types =  new String(b);		
			String[] objects= types.split(",");
			for(int i =0; i<objects.length;i++){
				String vipgradeid =objects[i];	
				grade=grade+vipgradeid+"'";
				if(i+1!=objects.length){
					grade=grade+",'";
				}else{
					break;
				}
			}
			sql.append(" and vd.vipgrade in ("+grade+")");
		}
		if(beginamount >=0  ){
			sql.append(" and vd.needamount >= "+beginamount);
		}
		if(endamount>0){
			sql.append(" and vd.needamount <= "+endamount);
		}
		sql.append(" group by v.id,v.name,v.valuation,v.quantity, "+
				 " v.startdate,v.enddate,v.remarks,v.createtime,v.updatetime,cu.name ,uu.name,cu.id ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);			
		return query.getResultList();
	}			
	
	@SuppressWarnings("unchecked")
	public Vipgift existVipgift(String name){
		Map<String,Object> map = new HashMap<String, Object>();		
		map.put("name", name);		
		//map.put("isactive", true);
		List<Vipgift> vipgift = find(Vipgift.class, map);
		return vipgift!=null && vipgift.size()>0?vipgift.get(0):null;
	}
	
	/**
	 * 查询礼品明细表
	 * @param vipgrade
	 * @param id
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Vipgiftdetail> existVipgiftdetail(String vipgrade,long id){
		Map<String,Object> map = new HashMap<String, Object>();		
		map.put("vipgiftid", id);	
		if(vipgrade!=null){
			map.put("vipgrade", vipgrade);
		}
		return find(Vipgiftdetail.class, map);		
	}	

	/**
	 * 删除已经添加的明细
	 * @param detail
	 * @return
	 */
	public boolean deldetail(long vipgiftid){
		String sql = "delete Vipgiftdetail v  where v.vipgiftid = "+vipgiftid;
		int resultnum = execute(sql);		
		if(resultnum > 0){
			return true;
		}else{
			return false;			
		}
	}	
	
	
	@SuppressWarnings("unchecked")
	public List<Object> queryVipGrade(long vipgiftid) {
		StringBuilder sql = new StringBuilder("");
		if(vipgiftid != 0){
			sql.append(" select nvl2(vd.id,1,0) as ischecked, nvl(vd.needamount,0) needamount ");
		}else{
			sql.append(" select 0 as ischecked, 0 as needamount ");
		}
		sql.append(" ,dd.value gradename,dd.code vipgrade from digitaldictionary d,digitaldictionarydetail dd ");
		if(vipgiftid != 0){
			sql.append(" left join vipgiftdetail vd on vd.vipgrade = dd.code and vd.vipgiftid = "+vipgiftid );
		}
		sql.append(" where d.columnname = 'grade' and d.id = dd.digitaldictionaryid and d.tablename = 'vip' order by dd.code ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		return query.getResultList();
	}
	
	/**
	 * 查询礼品出入库明细
	 * @param vipgiftid
	 * @param quantity 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findStorageDetail(String vipgiftname,String operation,long createby,Date startdate,Date enddate){
		StringBuilder sql = new StringBuilder("");
		boolean isqueryexchange=false;
		for(int i=0;i<operation.length();i++){
			if(operation.charAt(i)=='2'){
				isqueryexchange = true;
			} 
		}				     

		if(isqueryexchange){
			sql.append(" select a.vipgiftname, a.oprationname, a.cretaname,a.beforestoragequantity,")
			.append("a.quantity,a.afterstoragequantity, a.remarks,a.createtime,a.vipamount ")
			.append(" from ( ");
		}		
		//查询礼品出入库表
		sql.append(" select v.name vipgiftname, dd.value oprationname,cu.name cretaname,")
		.append("vl.beforestoragequantity,vl.quantity,vl.afterstoragequantity,vl.remarks,")
		.append("vl.createtime,0 vipamount ")
		.append(" from vipgift v,")
		.append(" vipgiftstoragelog vl,userinfo cu, digitaldictionary d,digitaldictionarydetail dd")
		.append(" where v.id=vl.vipgiftid and vl.createby=cu.id and vl.operation = dd.code ")
		.append(" and vl.operation in "+ operation)
		.append(" and dd.code in (0,1) ")
		.append(" and d.id=dd.digitaldictionaryid and d.tablename='vipgift' and d.columnname='operationtype' ")
		.append(" and vl.createtime >= :startdate and vl.createtime <= :enddate ");	
		if(!vipgiftname.equals("")){
			sql.append(" and v.name = '"+vipgiftname+"' ");
		}
		if(createby != 0){
			sql.append(" and cu.id = "+createby);
		}
		if(isqueryexchange){
			//查询积分兑换表
			sql.append(" union ")
			.append(" (select v.name vipgiftname,dd.value oprationname,cu.name cretaname,")
			.append(" vl.quantity+vl.remainstoragequantity beforestoragequantity,vl.quantity,")
			.append(" vl.remainstoragequantity afterstoragequantity,vl.remarks,")
			.append(" vl.createtime,vl.vipamount")
			.append(" from vipgift v ,vipgiftexchangelog vl,  userinfo cu,")
			.append(" digitaldictionary d, digitaldictionarydetail dd")
			.append(" where v.id = vl.vipgiftid and vl.createby = cu.id")
			.append(" and vl.createtime >= :startdate and vl.createtime <= :enddate ")			
			.append(" and d.id = dd.digitaldictionaryid and d.tablename = 'vipgift'")
			.append(" and d.columnname = 'operationtype' and dd.code='2' ");
			if(!vipgiftname.equals("")){
				sql.append(" and v.name = '"+vipgiftname+"' ");
			}
			if(createby != 0){
				sql.append(" and cu.id = "+createby);
			}
			sql.append(" ) ) a order by a.vipgiftname, a.createtime desc");			
		}else{
			sql.append("  order by v.name ,vl.createtime desc");
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("startdate", startdate);
		query.setParameter("enddate", enddate);	
		return query.getResultList();
	}
	
	/**
	 * 查询当前日期内 可供兑换的会员礼品信息
	 * @param name
	 * @param enddate
	 * @param vipgrade
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipgiftinfo(String name,long vipgrade) {
		StringBuilder sql = new StringBuilder(
		"select v.id,v.name ,v.quantity,vd.vipgrade,vd.needamount from vipgift v,vipgiftdetail vd")
		.append(" where v.id=vd.vipgiftid  and v.quantity > 0 and v.enddate >= sysdate ");
		if(!name.equals("")){
			sql.append(" and v.name = '"+name+"'");
		}
		if(vipgrade!=0){
			sql.append(" and vd.vipgrade = "+vipgrade);
		}
		Query query = getEntityManager().createNativeQuery(sql.toString());		
		return query.getResultList();
	}
	
	/**
	 * 根据卡号，获取vip卡信息
	 * @param name
	 * @param enddate
	 * @param vipgrade
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryVipbyCardno(String cardno) {
		StringBuilder sql = new StringBuilder(
		"select c.name customername,dd.value gragename,v.vipamount,v.vipgrade,v.money,v.id vipid,c.id customerid")
		.append(" from vip v,customer c, digitaldictionary d,digitaldictionarydetail dd")
		.append(" where v.customerid = c.id and v.vipgrade=dd.code and d.id=dd.digitaldictionaryid")
		.append(" and d.columnname = 'grade' and d.tablename = 'vip' and v.status='0' ")
		.append(" and v.vipcardno = "+cardno);
		Query query = getEntityManager().createNativeQuery(sql.toString());		
		return query.getResultList();
	}
	
	
	/**
	 * 查询礼品兑换明细
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> findExchangelogDetail(List<PropertyFilter> propertyFilterList){
		StringBuilder sql = new StringBuilder(
				"select vt.name vipgiftname,v.vipcardno, c.name customername,c.mobilephone,")
		.append(" dd.value gragename,dd1.value statusname,vg.quantity,vg.vipamount,vg.createtime,")
		.append(" cby.name createbyname,vg.remarks")
		.append(" from vip v,customer c,vipgiftexchangelog vg,vipgift vt, digitaldictionary d,")
		.append(" digitaldictionarydetail dd,digitaldictionary d1,digitaldictionarydetail dd1,userinfo cby")
		.append(" where v.customerid = c.id and v.vipgrade=dd.code and d.id=dd.digitaldictionaryid")
		.append(" and d.columnname = 'grade' and d.tablename = 'vip' and v.id=vg.vipid and v.status = dd1.code")
		.append(" and d1.id=dd1.digitaldictionaryid and vg.createby=cby.id and d1.columnname = 'status' ")
		.append(" and d1.tablename = 'card' and vt.id=vg.vipgiftid ");			
		sql.append(PropertyFilter.toJpql(propertyFilterList, true));
		sql.append(" order by vg.createtime desc ");
		Query query = getEntityManager().createNativeQuery(sql.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilterList);
		return query.getResultList();		
	}
	
}
