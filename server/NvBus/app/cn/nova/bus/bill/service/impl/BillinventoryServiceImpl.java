/**
 * <b>项目名：</b>NvBusEJB<br/>
 * <b>包名：</b>cn.nova.bus.bill.service.impl<br/>
 * <b>文件名：</b>BillinventoryServiceImpl.java<br/>
 * <b>版本信息：</b>0.1<br/>
 * <b>日期：</b> 2011-7-13 下午02:38:39 <br/>
 * <b>Copyright (c)</b> 2011深圳市南凌科技发展有限公司-版权所有<br/>
 */
package cn.nova.bus.bill.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import javax.persistence.Query;

import cn.nova.bus.bill.dao.BillinventoryDao;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billlog;
import cn.nova.bus.bill.model.Billstorage;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BillinventoryService;
import cn.nova.bus.bill.service.BilllogService;
import cn.nova.bus.bill.service.BillstorageService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.dao.EntityManagerDaoSurport;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.IDAO;
import cn.nova.utils.orm.jpa.ListUtil;

/**
 * @author 
 * 
 */
/**
 * <b>类描述：票据库存</b> <b>类名称：BillinventoryServiceImpl</b><br/>
 * <b>创建人：</b><a href="mailto:lijinhui@nova.net.cn">李金辉</a><br/>
 * <b>创建时间：</b>2011-7-13 下午02:38:39 <br/>
 * <b>关键修改：</b><br/>
 * <b>修改时间：</b><br/>
 * <b>修改人：</b><br/>
 */

public class BillinventoryServiceImpl implements BillinventoryService {

	private BillstorageService billstorageService = new BillstorageServiceImpl();

	private BillinventoryDao dao = new BillinventoryDao();
	
	private IDAO idao = new EntityManagerDaoSurport();
	
	private BilllogService billlogService = new BilllogServiceImpl();

	private BillinuseService billinuseservice = new BillinuseServiceImpl();

	private ParameterService parameterService = new ParameterServiceImpl();
	@Override
	public Billinventory save(Billinventory billinventory) {
		if (billinventory.getId() <= 0) {
			return dao.merge(billinventory);
		} else {
			return dao.merge(billinventory);
		}
	}

	@Override
	public Billinventory save(Billinventory billinventory, Long start, Long end)
			throws ServiceException {
		// 入库机构改为票库所属机构
		Billstorage bs = billstorageService.findById(billinventory
				.getStorageid());
		billinventory.setOrgid(bs.getOrgid());

		if (billinventory.getId() <= 0) {
			if (dao.isExist(billinventory.getBilltypeid(),
					billinventory.getBatchno(),
					billinventory.getPutinstartno(),
					billinventory.getPutinendno())) {
				throw new ServiceException("票库号："
						+ billinventory.getPutinstartno() + "-"
						+ billinventory.getPutinendno(), "0246");
			}
			//addby dongy 18249 财务管理 + 票据库存（重复的票据号码不能重复入库）
			Userinfo updateby = (Userinfo) idao.get(Userinfo.class, billinventory.getUpdateby());
			// 票据入库时，不同批次号的票号段是否可以重复使用，0不可以，1可以，默认0
			String param0089 = parameterService.findParamValue(ParamterConst.Param_0089, updateby.getOrgid());
			if (!param0089.equals("1")) {// 不是1 不可以重复使用 走校验票号是否重复
				if (dao.isExist(billinventory.getBilltypeid(), billinventory.getPutinstartno(),
						billinventory.getPutinendno())) {
					throw new ServiceException(
							"票库号：" + billinventory.getPutinstartno() + "-" + billinventory.getPutinendno(), "0246");
				}
			}
			billinventory = dao.merge(billinventory);
			Billlog newbilllog = new Billlog();
			newbilllog.setCreateby(billinventory.getCreateby());
			newbilllog.setCreatetime(billinventory.getCreatetime());
			newbilllog.setBillinventoryid(billinventory.getId());
			newbilllog.setOperationtype(billinventory.getPutintype());
			// 入库的起始号就是库表数据的结束号
			newbilllog.setStartno(billinventory.getPutinstartno());
			// 入库的起始号就是库表数据的开始号
			newbilllog.setEndno(billinventory.getPutinendno());
			billlogService.save(newbilllog);
			return billinventory;
		} else {
			Billlog newbilllog = new Billlog();
			newbilllog.setCreateby(billinventory.getUpdateby());
			newbilllog.setCreatetime(billinventory.getUpdatetime());
			newbilllog.setBillinventoryid(billinventory.getId());
			newbilllog.setOperationtype("1");// 出库
			newbilllog.setStartno(start);
			newbilllog.setEndno(end);
			billlogService.save(newbilllog);
			return dao.merge(billinventory);
		}
	}

	@Override
	public Billinventory findById(Long id) {
		return dao.get(Billinventory.class, id);
	}

	@SuppressWarnings("rawtypes")
	public boolean delete(Long id) throws ServiceException {
		String inusesql = "select r from Billinuse r where r.billinventoryid='"
				+ id + "'";
		List list = billinuseservice.query(inusesql);
		if (list.size() > 0) {
			throw new ServiceException("0342");
		}
		Billinventory billinventory = findById(id);
		billinventory.setIsactive(false);
		String sql = "select b from Billinventory b where ("
				+ billinventory.getPutinstartno()
				+ " between b.putinstartno and b.putinendno) "
				+ " and b.batchno= '" + billinventory.getBatchno() + "'"
				+ " and b.billtypeid=" + billinventory.getBilltypeid();
		List inventorylist = billinuseservice.query(sql);
		if (inventorylist.size() > 1) {
			throw new ServiceException("0343");
		}
		return dao.update(billinventory);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { "count", "availablecount",
				"typename", "parvalue", "ticketnolength", "storagename",
				"username", "putintypename", "orgname", "id", "batchno",
				"putinendno", "putinstartno", "availableenno",
				"availablestartno", "createtime", "billtypeid", "storageid",
				"numperbox" }, dao.query(propertyFilterList), new Object[] {
				Long.class, Long.class, String.class, BigDecimal.class,
				Long.class, String.class, String.class, String.class,
				String.class, Long.class, String.class, Long.class, Long.class,
				Long.class, Long.class, Timestamp.class, Long.class,
				Long.class, Long.class });
	}

	@Override
	public boolean save(Billinventory billinventory,
			Billinventory newbillinventory) {
		newbillinventory = dao.merge(newbillinventory);
		/** 出库拆分库存后的新数据日志 **/
		Billlog newbilllog = new Billlog();
		newbilllog.setCreateby(newbillinventory.getCreateby());
		newbilllog.setCreatetime(newbillinventory.getCreatetime());
		newbilllog.setBillinventoryid(newbillinventory.getId());
		newbilllog.setOperationtype(newbillinventory.getPutintype());
		// 分表后，出库的起始号就是原库表数据的结束号+1
		newbilllog.setStartno(newbillinventory.getPutinstartno());
		// 分表后，出库的起始号就是新库表数据的开始号-1
		newbilllog.setEndno(newbillinventory.getPutinendno());
		/** end **/
		/** 出库拆分库存后的原数据日志 **/
		//拆分之后的日志保存到新的newbillinventory对应的日志中
//		Billlog oldbilllog = new Billlog();
//		oldbilllog.setCreateby(billinventory.getUpdateby());
//		oldbilllog.setCreatetime(billinventory.getUpdatetime());
//		oldbilllog.setBillinventoryid(billinventory.getId());
//		oldbilllog.setOperationtype("1");
//		// 分表后，出库的起始号就是原库表数据的结束号+1
//		oldbilllog.setStartno(newbillinventory.getPutinstartno());
//		// 分表后，出库的起始号就是新库表数据的开始号-1
//		oldbilllog.setEndno(newbillinventory.getPutinendno());
//		billlogService.save(oldbilllog);
		billlogService.save(newbilllog);
		return dao.update(billinventory);
	}

	// 直接取入库的票据进行打印
	@Override
	public Billinventory qryBillinventory(long orgid, String billtype)
			throws ServiceException {
		return dao.qryBillinventory(orgid, billtype);
	}

}
