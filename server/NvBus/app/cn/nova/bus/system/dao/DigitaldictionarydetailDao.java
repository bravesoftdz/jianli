package cn.nova.bus.system.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.system.model.Digitaldictionarydetail;


public class DigitaldictionarydetailDao extends
		EntityManagerDaoSurport<Digitaldictionarydetail> {

	public List<Digitaldictionarydetail> find(String tablename, String columnname) {         //查询是否存在行包单号
		StringBuffer sql = new StringBuffer(
				"select ddd  from Digitaldictionary dd, Digitaldictionarydetail ddd")
		.append(" where dd.id=ddd.digitaldictionary.id")
		.append(" and dd.tablename='" + tablename + "'")
		.append(" and dd.columnname='" + columnname + "'");
		List<Digitaldictionarydetail> digitaldictionarydetails= super.find(sql.toString());
		return digitaldictionarydetails;
	}
	
	public List<Pack> checkpackno(String packno) {
		StringBuffer sql = new StringBuffer(
				"select p from Pack p")
		.append(" where p.packno = '" + packno + "'");
		Query query = super.getEntityManager().createQuery(sql.toString());
		List<Pack> pack = (List<Pack>) query.getResultList();
		return pack;
	}
	
	public List<Digitaldictionarydetail> isExistPackType(String newPackType){
		StringBuffer sql=new StringBuffer(" select id,orderno,code from Digitaldictionarydetail  where digitaldictionaryid=80 and value='");
		sql.append(newPackType).append("' ");
		Query query = new EntityManagerDaoSurport().getEntityManager().createQuery(sql.toString());
		List<Digitaldictionarydetail> digitaldictionarydetails = (List<Digitaldictionarydetail>) query.getResultList();
		return digitaldictionarydetails;
	}
	
	public List<Digitaldictionarydetail> findLastPackType(){
		String sql="  select d from Digitaldictionarydetail d where d.digitaldictionary.id=80 and  d.orderno=(select max(dd.orderno)  from Digitaldictionarydetail dd where dd.digitaldictionary.id=80 )  ";
		Query query = new EntityManagerDaoSurport().getEntityManager().createQuery(sql);
		List<Digitaldictionarydetail> digitaldictionarydetails = (List<Digitaldictionarydetail>) query.getResultList();
		return digitaldictionarydetails;
	}
	
	/**
	 * 根据表名、列名、code查询得到digitaldictionarydetail对象
	 * @param tablename：表名
	 * @param columnname：列名
	 * @param detailCode：code
	 * @return
	 */
	public Digitaldictionarydetail qryDigitaldictionarydetail(String tablename, String columnname, String detailCode) {
		StringBuffer sql = new StringBuffer();
		sql.append("select dd from Digitaldictionary d, Digitaldictionarydetail dd ")
			.append(" where d.tablename = :tablename ")
			.append("  and d.columnname = :columnname ")
			.append("  and dd.digitaldictionary.id = d.id ")
			.append("  and dd.code = :detailCode ");
			
		Query query = new EntityManagerDaoSurport().getEntityManager().createQuery(sql.toString());
		query.setParameter("tablename", tablename);
		query.setParameter("columnname", columnname);
		query.setParameter("detailCode", detailCode);
		
		List<Digitaldictionarydetail> list = query.getResultList();
		return (list != null && list.size() > 0) ? list.get(0) : null;
	}
}
