package cn.nova.bus.checkticket.dao;

import java.util.Date;

import javax.persistence.Query;

import cn.nova.bus.base.model.Station;
import cn.nova.bus.base.model.Tickettype;
import cn.nova.bus.base.model.Vehicle;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.system.model.Organization;

@SuppressWarnings("rawtypes")
public class RemoteCheckTicketDao extends EntityManagerDaoSurport {
	
	public Organization getOrganization(String orgcode) {
		StringBuilder sql = new StringBuilder("select o from Organization o")
				.append(" where  o.isactive=1 and o.code=:orgcode");
		Query query = em.createQuery(sql.toString());
		query.setParameter("orgcode", orgcode);
		return (Organization) query.getSingleResult();
	}
	
	public Tickettype getTickettype(String code) {
		StringBuilder sql = new StringBuilder("select o from Tickettype o")
				.append(" where  o.isactive=1 and o.code=:code");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		return (Tickettype) query.getSingleResult();
	}
	
	public Vehicle getVehicle(String vehicleno) {
		StringBuilder sql = new StringBuilder("select o from Vehicle o")
				.append(" where  vehicleno=:vehicleno");
		Query query = em.createQuery(sql.toString());
		query.setParameter("vehicleno", vehicleno);
		return (Vehicle) query.getSingleResult();
	}
	
	public Station getStation(String code) {
		StringBuilder sql = new StringBuilder("select o from Station o")
				.append(" where  code=:code");
		Query query = em.createQuery(sql.toString());
		query.setParameter("code", code);
		return (Station) query.getSingleResult();
	}
	
	public void deleteRemoteCheck(String ticketno, Long departorgid, Date departdate){
		StringBuilder sql = new StringBuilder(
				"delete from RemoteTicketsell t where t.ticketno=:ticketno ")
		.append(" and t.departorgid=:departorgid and t.departdate =:departdate");
		Query query = em.createQuery(sql.toString());
		query.setParameter("ticketno", ticketno);
		query.setParameter("departorgid", departorgid);
		query.setParameter("departdate", departdate);
		query.executeUpdate();
	}
}
