package cn.nova.bus.pack.dao;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class PackdepartinvoicesDao extends EntityManagerDaoSurport<Packdepartinvoices> {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {

		
		return null;
	}

	public boolean updatePackdepById(Packdepartinvoices packdepartinvoices){
				
		StringBuffer sql = new StringBuffer();
		
		sql.append(" update Packdepartinvoices pd set pd.pieces=:pieces,pd.shipprice=:shipprice,pd.packfee=:packfee,pd.handfee=:handfee,pd.custodial=:custodial, ")
		.append(" pd.transitfee=:transitfee,pd.insuredamount=:insuredamount,pd.insurancefee=:insurancefee,pd.deliveryfee=:deliveryfee,pd.otherfee=:otherfee, ")
		.append(" pd.packprice=:packprice,pd.servicefee=:servicefee,pd.totalfee=:totalfee,pd.balanceamount=:balanceamount ")
		.append(" where pd.id=:id ");
		Query query = getEntityManager().createQuery(sql.toString());
		query.setParameter("pieces",packdepartinvoices.getPieces());
		query.setParameter("shipprice",packdepartinvoices.getShipprice());
		query.setParameter("packfee",packdepartinvoices.getPackfee());
		query.setParameter("handfee",packdepartinvoices.getHandfee());
		query.setParameter("custodial",packdepartinvoices.getCustodial());
		query.setParameter("transitfee",packdepartinvoices.getTransitfee());
		query.setParameter("insuredamount",packdepartinvoices.getInsuredamount());
		query.setParameter("insurancefee",packdepartinvoices.getInsurancefee());
		query.setParameter("deliveryfee",packdepartinvoices.getDeliveryfee());
		query.setParameter("otherfee",packdepartinvoices.getOtherfee());
		query.setParameter("packprice",packdepartinvoices.getPackprice());
		query.setParameter("servicefee",packdepartinvoices.getServicefee());
		query.setParameter("totalfee",packdepartinvoices.getTotalfee());
		query.setParameter("balanceamount",packdepartinvoices.getBalanceamount());
		query.setParameter("id",packdepartinvoices.getId());
		int result = query.executeUpdate();
		return result> 0 ? true : false;
		
	}
	
}
