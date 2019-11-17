package cn.nova.bus.pack.dao;

import java.util.List;

import javax.persistence.Query;

import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Goods;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.JPAPropertyFilterUtil;

@SuppressWarnings("rawtypes")
public class GoodsDao extends EntityManagerDaoSurport {
	@SuppressWarnings("unchecked")
	public List<Object> query(List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer("select ");
		sb.append("g.id,g.goodsno,g.num,g.customer,g.phone,g.idcardno");
		sb.append(",g.goodstype,g.pieces,g.location,g.pickupenddate,g.deposittiime");
		sb.append(",g.custodial,g.penalty,g.totalfee,g.consignee,g.status");
		sb.append(",g.pickuper,g.pickupdate,g.operator,g.remak,g.orgid");
		sb.append(",g.createtime,g.createby,g.updatetime,g.updateby");
		sb.append(",c.name as consigneename,o.name as operatorname");
		sb.append(" ,up.name as updatebyname,cr.name as createbyname,org.name as orgname, g.picture ");
		sb.append(" from Goods g left join Userinfo o on o.id=g.operator left join Userinfo c on c.id=g.consignee");
		sb.append(",Userinfo up,Userinfo cr,Organization org ");
		sb.append(" where cr.id=g.createby and up.id=g.updateby and org.id=g.orgid");

		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		Query query = getEntityManager().createNativeQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		return query.getResultList();
	}

	/**
	 * 作废操作
	 * 
	 * @param goods
	 * @return
	 * @throws ServiceException
	 */
	public boolean wasteGoods(Goods goods) {
		StringBuffer sb = new StringBuffer(
				"update Goods set status=:status,updateby=:updateby,updatetime=:updatetime where id=:id");
		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("status", goods.getStatus());
		query.setParameter("updateby", goods.getUpdateby());
		query.setParameter("updatetime", goods.getUpdatetime());
		query.setParameter("id", goods.getId());

		return query.executeUpdate() > 0 ? true : false;
	}

	/**
	 * 验证保管牌号是否存在
	 * 
	 * @param num
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean checkedGoodsNum(String num) {
		StringBuffer sb = new StringBuffer(
				"select g.id from Goods g where g.status='0' and g.num=:num");

		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("num", num);
		List<Object> list = query.getResultList();
		if (list == null || list.size() <= 0) {
			return false;
		}

		return true;

	}

	/**
	 * 验证票号是否已存在
	 * 
	 * @param num
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public boolean checkedGoodsNo(String goodsno) {
		// g.status='0' and
		// 查询小件寄存里面该单号有多少个使用了且未废弃的记录
		StringBuffer sb = new StringBuffer(
				"select g.id from Goods g where g.goodsno=:goodsno and status!=2");

		Query query = getEntityManager().createQuery(sb.toString());
		query.setParameter("goodsno", goodsno);
		List<Object> list = query.getResultList();

		if (list == null || list.size() <= 0) {
			// 没有
			return false;
		}

		// 查询票号领用表里有多少个领用记录使用过该票号
		sb = new StringBuffer("");
		sb.append(" select b.id from Billinuse b,Billtype bt ");
		sb.append(" where b.billtypeid=bt.id and bt.code='GoodsBill' ");
		sb.append(" and b.startno<=:goodsno and b.nextno>:goodsno ");

		query = getEntityManager().createQuery(sb.toString());
		query.setParameter("goodsno", Long.parseLong(goodsno));
		List<Object> list2 = query.getResultList();
		if (list2 == null || list2.size() <= 0) {
			// 寄存表里有使用记录，但领用表里没有一个使用过该票号的记录，则是当前正在使用批次号的
			return true;
		}
		
		if(list.size()==list2.size()){
			//相等，新的批次号的票号
			return false;
		}else{
			//寄存票号数据错误
		}

		return true;

	}

	/**
	 * 查找寄存单号
	 * 
	 * @param param
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public List<Object> queryGgoodsno(String param,
			List<PropertyFilter> propertyFilters) {
		StringBuffer sb = new StringBuffer();
		sb.append(" select g.id,g.goodsno as name,g.num as code,g.customer as customer,g.idcardno as idcardno");
		sb.append(" from Goods g where 1=1 ");

		sb.append(PropertyFilter.toJpql(propertyFilters, true));

		sb.append(" and (g.goodsno like '%").append(param)
				.append("%' or g.num like '%").append(param).append("%')");

		Query query = getEntityManager().createQuery(sb.toString());
		JPAPropertyFilterUtil.setParameter(query, propertyFilters);

		List<Object> result = query.getResultList();

		return result;
	}
}
