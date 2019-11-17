package cn.nova.bus.balance.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.balance.dao.BalancedeductitemDao;
import cn.nova.bus.balance.model.Balancedeductitem;
import cn.nova.bus.balance.model.Balancedeductitemdistance;
import cn.nova.bus.balance.model.Balancedeductitemprice;
import cn.nova.bus.balance.service.BalancedeductitemService;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Printtemplatetype;
import cn.nova.bus.system.model.Printtemplatetypeitem;
import cn.nova.bus.system.service.PrinttemplatetypeService;
import cn.nova.bus.system.service.impl.PrinttemplatetypeServiceImpl;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class BalancedeductitemServiceImpl implements BalancedeductitemService {

	
	private BalancedeductitemDao balancedeductitemDao = new BalancedeductitemDao();

	
	private PrinttemplatetypeService printtemplatetypeService = new PrinttemplatetypeServiceImpl();

	@Override
	public List<Map<String, Object>> qryDeductitem(
			List<PropertyFilter> propertyFilterList, long balancedeductitemid) {
		return ListUtil.listToMap(new Object[] { Balancedeductitem.class,
				"createname", "updatename", "orgname" },
				balancedeductitemDao.queryBalancedeductitem(propertyFilterList,
						balancedeductitemid), new Object[] {
						Balancedeductitem.class, String.class, String.class,
						String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Balancedeductitem saveDeductitem(Balancedeductitem balancedeductitem)
			throws ServiceException {
		if (balancedeductitemDao.isExistbyName(balancedeductitem)) {
			// 该扣费项目名称已经存在
			throw new ServiceException("0146");
		}
		if (balancedeductitem.getId() > 0
				&& balancedeductitem.getId() == balancedeductitem.getParentid()) {
			// 所属扣费项目不能为自身！
			throw new ServiceException("0153");
		}
		if (balancedeductitem.getParentid()>0){
			Balancedeductitem pbi = (Balancedeductitem) balancedeductitemDao
			.get(Balancedeductitem.class,
					balancedeductitem.getParentid());
			if(!pbi.isIsticketpriceitem()){
				balancedeductitem.setCode(pbi.getCode());
			}else{
				balancedeductitem.setIsticketpriceitem(pbi.isIsticketpriceitem());
			}
		}	
		
		// 自动生成扣费项目编码
		if (balancedeductitem.getCode() == null
				|| balancedeductitem.getCode().equals("")) {
				String code = StringUtils.toJP(balancedeductitem.getName());
				balancedeductitem.setCode(code);
		}
		if (balancedeductitem.getId() == 0) {
			if (balancedeductitem.isIsaddprintitem()) {
				Printtemplatetypeitem pp = new Printtemplatetypeitem();
				Printtemplatetype pt = new Printtemplatetype();
				pt.setId(balancedeductitem.getPrinttemplatetypeitemid());
				pp.setIslist(false);
				pp.setItemcode(balancedeductitem.getCode());
				pp.setItemname(balancedeductitem.getName());
				pp.setItemtype("0");// 项目数据类型（0普通、1数值、2日期、3纯数字） 取数据字典
				pp.setPrinttemplatetype(pt);
				printtemplatetypeService.addItem(pp);
			}
		} else {
			if (balancedeductitem.getPrinttemplatetypeitemid() > 0) {
				Printtemplatetypeitem pp = balancedeductitemDao
						.qryPrinttemplatetypeitem(
								balancedeductitem.getPrinttemplatetypeitemid(),
								balancedeductitem.getCode());
				if (pp == null) {
					pp = new Printtemplatetypeitem();
					Printtemplatetype pt = new Printtemplatetype();
					pt.setId(balancedeductitem.getPrinttemplatetypeitemid());
					pp.setIslist(false);
					pp.setItemcode(balancedeductitem.getCode());
					pp.setItemname(balancedeductitem.getName());
					pp.setItemtype("0");// 项目数据类型（0普通、1数值、2日期、3纯数字） 取数据字典
					pp.setPrinttemplatetype(pt);
					printtemplatetypeService.addItem(pp);
				}
			}
		}
		return balancedeductitemDao.getEntityManager().merge(balancedeductitem);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delDeductitem(Balancedeductitem balancedeductitem)
			throws ServiceException {
		Balancedeductitem obj = (Balancedeductitem) balancedeductitemDao.get(
				Balancedeductitem.class, balancedeductitem.getId());
		if (obj.getIsaudited() && obj.getIsauditpass()) {
			// 该扣费项目已经审核通过不允许删除
			throw new ServiceException("0147");
		}
		if (balancedeductitemDao.existBalancedeductitemApply(balancedeductitem)) {
			// 该扣费项目已经应用不允许删除
			throw new ServiceException("0317");
		}
		if (balancedeductitemDao.isExistChildItem(balancedeductitem.getId())) {
			// 该扣费项目已被使用！
			throw new ServiceException("0152");
		}
		obj.setUpdatetime(new Date());
		obj.setIsactive(false);
		obj.setUpdateby(balancedeductitem.getUpdateby());
		balancedeductitemDao.getEntityManager().merge(obj);
		return true;
	}

	@Override
	public List<Map<String, Object>> createTree(long orgid) {
		return ListUtil.listToMap(new Object[] { Balancedeductitem.class },
				balancedeductitemDao.createTree(orgid),
				new Object[] { Balancedeductitem.class });
	}

	@Override
	public List<Map<String, Object>> qryDeductitemdetail(
			long balancedeductitemid) {
		return ListUtil.listToMap(new Object[] { "aboutid", "abouttype",
				"startvalue", "endvalue", "deductmoney", "createby",
				"createtime" },
				balancedeductitemDao.qryDeductitemdetail(balancedeductitemid),
				new Object[] { Long.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, Long.class,
						Timestamp.class });
	}

	@Override
	public Balancedeductitemdistance saveDeductitemdistance(
			Balancedeductitemdistance balancedeductitemdistance)
			throws ServiceException {
		if (balancedeductitemDao
				.isExistAboutDistance(balancedeductitemdistance)) {
			throw new ServiceException("0155");
		}
		if (balancedeductitemDao
				.isExistBalancedeductitemprice(balancedeductitemdistance
						.getBalancedeductitem().getId())) {
			// 已经存在里程票价扣费，不能再添加其他相关！
			throw new ServiceException("0157");
		}
		return balancedeductitemDao.getEntityManager().merge(
				balancedeductitemdistance);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delaboutDistance(long id) throws ServiceException {
		Balancedeductitemdistance obj = (Balancedeductitemdistance) balancedeductitemDao
				.get(Balancedeductitemdistance.class, id);
		balancedeductitemDao.delete(obj);
		return true;
	}

	@Override
	public Balancedeductitemprice saveBalancedeductitemprice(
			Balancedeductitemprice balancedeductitemprice)
			throws ServiceException {
		if (balancedeductitemDao.isExistAboutPrice(balancedeductitemprice)) {
			throw new ServiceException("0156");
		}
		if (balancedeductitemDao
				.isExistBalancedeductitemdistance(balancedeductitemprice
						.getBalancedeductitem().getId())) {
			// 已经存在里程相关扣费，不能再添加其他相关！
			throw new ServiceException("0158");
		}
		return balancedeductitemDao.getEntityManager().merge(
				balancedeductitemprice);
	}

	@SuppressWarnings("unchecked")
	@Override
	public boolean delaboutPrice(long id) throws ServiceException {
		Balancedeductitemprice obj = (Balancedeductitemprice) balancedeductitemDao
				.get(Balancedeductitemprice.class, id);
		balancedeductitemDao.delete(obj);
		return true;
	}

	/*
	 * qryBalancedeductitem方法：<br/> <br/>
	 * 
	 * @param balancedeductitem
	 * 
	 * @return
	 * 
	 * @see
	 * cn.nova.bus.balance.service.BalancedeductitemService#qryBalancedeductitem(cn.nova.bus.balance.model.Balancedeductitem
	 * )
	 * 
	 * @exception
	 */
	@Override
	public Balancedeductitem qryBalancedeductitem(
			Balancedeductitem balancedeductitem) {
		return balancedeductitemDao
				.qryBalancedeductitembyName(balancedeductitem);
	}

	@Override
	public Balancedeductitem savePackDuctitem(long createby, long orgid) {
		String packcode = "packfee";
		Balancedeductitem bit = balancedeductitemDao
				.qryBalancedeductitemByCode(orgid, packcode);
		if (bit != null) {
			return bit;
		}
		Balancedeductitem bi = new Balancedeductitem();
		bi.setCode(packcode);
		bi.setCreateby(createby);
		bi.setCreatetime(new Date());
		bi.setDeductmoney(new BigDecimal(0));
		bi.setDeducttype("4");// 手工输入
		bi.setDescription("");
		bi.setIsactive(true);
		bi.setIsaddprintitem(true);
		bi.setIsaudited(true);
		bi.setIsauditpass(true);
		bi.setIsdeductbeforebalance(false);
		bi.setIsticketpriceitem(false);
		bi.setName("行包扣费");
		bi.setOrgid(orgid);
		bi.setParentid(0);
		bi.setUpdateby(createby);
		bi.setUpdatetime(new Date());

		Printtemplatetypeitem pp = new Printtemplatetypeitem();
		Printtemplatetype pt = new Printtemplatetype();
		pt.setId(3);
		pp.setIslist(false);
		pp.setItemcode(bi.getCode());
		pp.setItemname(bi.getName());
		pp.setItemtype("0");// 项目数据类型（0普通、1数值、2日期、3纯数字） 取数据字典
		pp.setPrinttemplatetype(pt);
		try {
			printtemplatetypeService.addItem(pp);
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		return balancedeductitemDao.getEntityManager().merge(bi);
	}

}
