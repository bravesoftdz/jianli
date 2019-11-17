package cn.nova.bus.pack.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Packdepartinvoicespack;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackdepartinvoicespackDao extends EntityManagerDaoSurport<Packdepartinvoicespack> {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {

		
		return null;
	}

	public boolean deletePackdepartPack(long departinvoicesid){
		
		StringBuffer sql = new StringBuffer();
		sql.append(" delete from packdepartinvoicespack pdp where pdp.packdepartinvoicesid=:packdepartinvoicesid ");
		
		Query query = this.getEntityManager().createNativeQuery(sql.toString());
		query.setParameter("packdepartinvoicesid",departinvoicesid);
		
		return query.executeUpdate()>0?true:false;
	}
	
	
}
