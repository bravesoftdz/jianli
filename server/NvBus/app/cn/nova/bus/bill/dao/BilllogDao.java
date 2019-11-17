package cn.nova.bus.bill.dao;

import java.util.List;

import cn.nova.bus.bill.model.Billlog;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.utils.orm.PropertyFilter;

/**
 * @author 蒋伟
 * 
 */
@SuppressWarnings("rawtypes")
public class BilllogDao extends EntityManagerDaoSurport<Billlog> {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilterList) {
		StringBuilder sql = new StringBuilder(
				"select b,dic.value as typename,u.name as operator, bl.name as logname ");
		sql.append(" from  Billlog b left join b.loguser as bl, Userinfo u, Digitaldictionarydetail dic,Digitaldictionary dig");
		sql.append("  where dig.columnname='operationtype' and dig.tablename='billlog' and dic.digitaldictionary.id=dig.id ");
		sql.append(" and dic.code=b.operationtype and u.id=b.createby");
        return super.find(sql.toString(),propertyFilterList,new String[]{"b.createtime"});
	}
}
