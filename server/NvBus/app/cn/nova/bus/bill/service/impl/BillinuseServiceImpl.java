package cn.nova.bus.bill.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.dao.BillinuseDao;
import cn.nova.bus.bill.dao.BillinventoryDao;
import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billinventory;
import cn.nova.bus.bill.model.Billlog;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilllogService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.common.ParamterConst;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.log.dao.OperationlogDao;
import cn.nova.bus.log.model.Operationlog;
import cn.nova.bus.sale.dao.BilldamagedDao;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.bus.sale.service.impl.TicketturnoverdetailServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.bus.system.dao.UserinfoDao;
import cn.nova.bus.system.model.Userinfo;
import cn.nova.bus.system.service.ParameterService;
import cn.nova.bus.system.service.impl.ParameterServiceImpl;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;
import util.CurrentUtil;

/**
 * @author 蒋伟
 * 
 */

public class BillinuseServiceImpl implements BillinuseService {
	
	private Billdamaged billdamaged;
	
	private BilldamagedDao billdamageddao = new BilldamagedDao();
	
	private BillinuseDao dao = new BillinuseDao();
	
	private BilllogService billlogService = new BilllogServiceImpl();
	
	private BillinventoryDao billinventoryDao = new BillinventoryDao();
	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private UserinfoDao userinfoDao = new UserinfoDao();

	private OperationlogDao operationlogDao = new OperationlogDao();
	private ParameterService parameterService = new ParameterServiceImpl();
	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	private BilltypeService billtypeDao = new BilltypeServiceImpl();

	@Override
	public Long save(Billinuse billinuse) {
		if (billinuse.getId() <= 0) {
			billinuse = dao.merge(billinuse);
			// 领用就建的库存表所要写的日志
			Billlog inusebilllog = new Billlog();
			inusebilllog.setCreateby(billinuse.getCreateby());
			inusebilllog.setCreatetime(billinuse.getCreatetime());
			inusebilllog.setBillinventoryid(billinuse.getBillinventoryid());
			inusebilllog.setOperationtype("2");// 领用
			inusebilllog.setStartno(billinuse.getStartno());
			inusebilllog.setEndno(billinuse.getEndno());
			inusebilllog.setLoguser(new Userinfo());
			inusebilllog.getLoguser().setId(billinuse.getRecipients());
			// 领用后修改库存表可用号码信息
			Billinventory billinventory = billinventoryDao.get(
					Billinventory.class, billinuse.getBillinventoryid());
			if (billinuse.getStartno() >= 0) {
				if (billinventory.getAvailablestartno() == billinuse
						.getStartno()
						&& billinventory.getAvailableenno() > billinuse
								.getEndno()) {
					billinventory.setAvailablestartno(billinuse.getEndno() + 1);

				} else if (billinventory.getAvailablestartno() == billinuse
						.getStartno()
						&& billinventory.getAvailableenno() == billinuse
								.getEndno()) {
					billinventory.setAvailablestartno(0);
					billinventory.setAvailableenno(0);
				} else if (billinventory.getAvailablestartno() < billinuse
						.getStartno()
						&& billinventory.getAvailableenno() == billinuse
								.getEndno()) {
					billinventory.setAvailableenno(billinuse.getStartno() - 1);

				} else if (billinventory.getAvailablestartno() < billinuse
						.getStartno()
						&& billinventory.getAvailableenno() > billinuse
								.getEndno()) {
					/**
					 * 领用时取中间段数据时所要操作内容
					 */
					// begin 填入库存 表拆分后的新增的库存 信息
					Billinventory newbillinventory = new Billinventory();
					newbillinventory.setAdder(billinuse.getCreateby());
					newbillinventory.setCreateby(billinuse.getCreateby());
					newbillinventory.setCreatetime(new Timestamp(System
							.currentTimeMillis()));
					newbillinventory.setUpdateby(billinuse.getCreateby());
					newbillinventory.setUpdatetime(new Timestamp(System
							.currentTimeMillis()));
					newbillinventory
							.setAvailablestartno(billinuse.getEndno() + 1);
					newbillinventory.setAvailableenno(billinventory
							.getAvailableenno());
					newbillinventory.setPutinstartno(billinuse.getEndno() + 1);
					newbillinventory.setPutinendno(billinventory
							.getPutinendno());
					newbillinventory.setBilltypeid(billinventory
							.getBilltypeid());
					newbillinventory.setStorageid(billinventory.getStorageid());
					newbillinventory.setBatchno(billinventory.getBatchno());
					newbillinventory.setPutintype("2");
					newbillinventory.setIsactive(true);
					newbillinventory.setOrgid(billinuse.getOrgid());

					/** 先将领 用产生的新库存数据存入数据库，获得ID好记录日志 **/
					newbillinventory = billinventoryDao.merge(newbillinventory);

					/** 领用拆分库存后的新数据日志 **/
					Billlog inventorybilllog = new Billlog();
					inventorybilllog
							.setCreateby(newbillinventory.getCreateby());
					inventorybilllog.setCreatetime(newbillinventory
							.getCreatetime());
					inventorybilllog.setBillinventoryid(newbillinventory
							.getId());
					inventorybilllog.setOperationtype(newbillinventory
							.getPutintype());
					inventorybilllog.setStartno(newbillinventory
							.getPutinstartno());
					inventorybilllog.setEndno(newbillinventory.getPutinendno());
					inusebilllog.setLoguser(new Userinfo());
					inusebilllog.getLoguser().setId(billinuse.getRecipients());
					billlogService.save(inventorybilllog);
					/** end **/
					/** 领用拆分库存后，更新原来库存的信息 **/
					billinventory.setPutinendno(billinuse.getEndno());
					billinventory.setAvailableenno(billinuse.getStartno() - 1);

					/** end **/

				}
			}
			//billinventory.setAdder(billinuse.getCreateby());
			billinventory.setUpdateby(billinuse.getCreateby());
			billinventory.setUpdatetime(new Timestamp(System
					.currentTimeMillis()));
			billinventoryDao.update(billinventory);
			inusebilllog = billlogService.save(inusebilllog);
			return inusebilllog.getId();
		} else {
			dao.merge(billinuse);
			return (long)0;
		}
	}

	@Override
	public Billinuse findById(Long id) {
		return dao.get(Billinuse.class, id);
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Billinuse.class,
				"availablecount", "count", "storagename", "billtypename",
				"parvalue", "recipientsname", "recipientscode","dicvalue","status" },
				dao.query(propertyFilterList), new Object[] { Billinuse.class,
						Long.class, Long.class, String.class, String.class,
						BigDecimal.class, String.class, String.class,String.class,String.class });
	}

	/**
	 * 退领时选择中间断的号码时的操作
	 */
	@Override
	public boolean backinuse(Billinuse billinuse, Billinuse newbillinuse) {
		// 退领所要写的日志
		Billlog inusebilllog = new Billlog();
		inusebilllog.setCreateby(billinuse.getCreateby());
		inusebilllog.setCreatetime(billinuse.getCreatetime());
		inusebilllog.setBillinventoryid(billinuse.getBillinventoryid());
		inusebilllog.setOperationtype("3");// 退领
		// 退领 拆分表数据后，退领 的开始=原领 用的结束号码+1
		inusebilllog.setStartno(billinuse.getEndno() + 1);
		// 退领 拆分表数据后，退领 的结束号码=新生成的领 用数据的的开始号码-1
		inusebilllog.setEndno(newbillinuse.getStartno() - 1);
		inusebilllog.setLoguser(null);
		billlogService.save(inusebilllog);
		// update原有的领用信息
		dao.update(billinuse);
		// 退领后，产生的新的领 用信息，保存
		Billinuse inuse = dao.merge(newbillinuse);
		Billlog billlog = new Billlog();//保存退领后产生一条新的领用信息的操作的日志
		billlog.setCreateby(inuse.getUpdateby());
		billlog.setCreatetime(new Timestamp(System.currentTimeMillis()));
		billlog.setBillinventoryid(inuse.getBillinventoryid());
		billlog.setOperationtype("2");// 领用
		billlog.setStartno(inuse.getStartno());
		billlog.setEndno(inuse.getEndno());
		billlog.setLoguser(null);
		billlogService.save(billlog);

		/**
		 * begin 填入库存 表拆分后的新增的库存 信息
		 */
		// // 查询原领用时的库存信息
		// Billinventory billinventory =
		// billinventoryDao.get(Billinventory.class,
		// billinuse.getBillinventoryid());
		//
		// Billinventory newbillinventory = new Billinventory();
		// newbillinventory.setAdder(newbillinuse.getCreateby());
		// newbillinventory.setCreateby(newbillinuse.getCreateby());
		// newbillinventory
		// .setCreatetime(new Timestamp(System.currentTimeMillis()));
		// newbillinventory.setUpdateby(newbillinuse.getCreateby());
		// newbillinventory
		// .setUpdatetime(new Timestamp(System.currentTimeMillis()));
		// newbillinventory.setAvailablestartno(billinuse.getEndno() + 1);
		// newbillinventory.setAvailableenno(newbillinuse.getStartno() - 1);
		// newbillinventory.setPutinstartno(billinuse.getEndno() + 1);
		// newbillinventory.setPutinendno(newbillinuse.getStartno() - 1);
		// newbillinventory.setBilltypeid(newbillinuse.getBilltypeid());
		// // 设置仓库
		// newbillinventory.setStorageid(billinventory.getStorageid());
		// // 批次
		// newbillinventory.setBatchno(billinventory.getBatchno());
		// // 退领 产生的新的库存信息
		// newbillinventory.setPutintype("3");
		// newbillinventory.setIsactive(true);
		// newbillinventory.setOrgid(newbillinuse.getOrgid());

		/** 先将退领产生的新库存数据存入数据库，获得ID好记录日志 **/
		Billinventory newbillinventory = saveBillinventory(billinuse,
				billinuse.getEndno()+1, newbillinuse.getStartno()-1);

		/** 领用拆分库存后的新数据日志 **/
		Billlog inventorybilllog = new Billlog();
		inventorybilllog.setCreateby(newbillinventory.getCreateby());
		inventorybilllog.setCreatetime(newbillinventory.getCreatetime());
		inventorybilllog.setBillinventoryid(newbillinventory.getId());
		inventorybilllog.setOperationtype("0");
		inventorybilllog.setStartno(newbillinventory.getPutinstartno());
		inventorybilllog.setEndno(newbillinventory.getPutinendno());
		inventorybilllog.setLoguser(null);
		billlogService.save(inventorybilllog);
		/** end **/
		return true;
	}

	public boolean backinuse(Billinuse billinuse, long startno, long endno) {

		Billinventory inventory = saveBillinventory(billinuse, startno, endno);
		Billlog billlog = new Billlog();//保存退领后入库的操作日志
		billlog.setCreateby(inventory.getCreateby());
		billlog.setCreatetime(new Timestamp(System.currentTimeMillis()));
		billlog.setBillinventoryid(inventory.getId());
		billlog.setOperationtype("0");// 入库
		billlog.setStartno(inventory.getPutinstartno());
		billlog.setEndno(inventory.getPutinendno());
		billlog.setLoguser(null);
		billlogService.save(billlog);

		// 退领所要写的日志
		Billlog inusebilllog = new Billlog();
		inusebilllog.setCreateby(billinuse.getUpdateby());
		inusebilllog.setCreatetime(new Timestamp(System.currentTimeMillis()));
		inusebilllog.setBillinventoryid(billinuse.getBillinventoryid());
		inusebilllog.setOperationtype("3");// 退领
		inusebilllog.setStartno(startno);
		inusebilllog.setEndno(endno);
		inusebilllog.setLoguser(null);
		billlogService.save(inusebilllog);
		// update原有的领用信息f
		return dao.update(billinuse);
	}

	private Billinventory saveBillinventory(Billinuse billinuse, long startno,
			long endno) {
		/**
		 * begin 填入库存 表拆分后的新增的库存 信息
		 */
		Billinventory inventory = billinventoryDao.get(Billinventory.class,
				billinuse.getBillinventoryid());// 获取退票的库存信息，将退领的这段票号插入到库库当中
		Billinventory billinventory = null;
		Long inventoryid = billinventoryDao.isContinuous(inventory.getBatchno(), inventory.getBilltypeid(), endno +1);
		if(inventoryid != 0){
			billinventory = billinventoryDao.get(Billinventory.class, inventoryid);
			billinventory.setId(billinventory.getId());
			billinventory.setAvailableenno(billinventory.getAvailableenno());
			billinventory.setAvailablestartno(billinventory.getAvailablestartno() - (endno - startno + 1));
			billinventory.setPutinendno(billinventory.getPutinendno());
			billinventory.setPutinstartno(billinventory.getPutinstartno());
		} else {
			billinventory = new Billinventory();
			billinventory.setId(0);
			billinventory.setAvailableenno(endno);
			billinventory.setAvailablestartno(startno);
			billinventory.setPutinendno(endno);
			billinventory.setPutinstartno(startno);
		}
		billinventory.setAdder(billinuse.getUpdateby());
		billinventory.setBatchno(inventory.getBatchno());
		billinventory.setBilltypeid(inventory.getBilltypeid());
		billinventory.setCreateby(billinuse.getUpdateby());
		billinventory.setCreatetime(new Timestamp(System.currentTimeMillis()));
		billinventory.setDescription(null);
		billinventory.setIsactive(true);
		billinventory.setOrgid(billinuse.getOrgid());
		billinventory.setPutintype("0");
		billinventory.setStorageid(inventory.getStorageid());
		billinventory.setUpdateby(billinuse.getUpdateby());
		billinventory.setUpdatetime(new Timestamp(System.currentTimeMillis()));
		return billinventoryDao.merge(billinventory);
	}

	/**
	 * 票证退领 ice 20120417重写
	 * @param billinuseid
	 * @param backstartno
	 * @param backendno
	 * @param userid
	 * @return
	 */
	public boolean backinuse(long billinuseid,long backstartno,long backendno,long userid) throws ServiceException{
		Date now = new Date();
		Billinuse billinuse = findById(billinuseid);
		if(billinuse==null){
			//找不到该领用记录
			throw new ServiceException("0363");
		}
		if(billinuse.getNextno()>backstartno){
			//退票起始号码不能小于当前号码
			throw new ServiceException("0364");
		}
		if(billinuse.getEndno()<backendno){
			//退票结束号码不能大于领用结束号码
			throw new ServiceException("0365");
		}
		if(backstartno>backendno){
			//退票起始号码不能大于退票结束号码
			throw new ServiceException("0366");
		}
		Userinfo userinfo = userinfoDao.get(Userinfo.class, userid);
		
		//退领日志
		Billlog inusebilllog = new Billlog();
		inusebilllog.setCreateby(userid);
		inusebilllog.setCreatetime(now);
		inusebilllog.setBillinventoryid(billinuse.getBillinventoryid());
		inusebilllog.setOperationtype("3");// 退领
		inusebilllog.setStartno(backstartno);
		inusebilllog.setEndno(backendno);
		inusebilllog.setLoguser(userinfo);
		billlogService.save(inusebilllog);
		
		//退领入库
		Billinventory newbillinventory = new Billinventory();
		newbillinventory.setAdder(userid);
		newbillinventory.setAvailableenno(backendno);
		newbillinventory.setAvailablestartno(backstartno);
		Billinventory billinventory = billinventoryDao.get(Billinventory.class, billinuse.getBillinventoryid());
		newbillinventory.setBatchno(billinventory.getBatchno());
		newbillinventory.setBilltypeid(billinventory.getBilltypeid());
		newbillinventory.setCreateby(userid);
		newbillinventory.setCreatetime(now);
		newbillinventory.setDescription(billinventory.getDescription());
		newbillinventory.setIsactive(true);
		newbillinventory.setOrgid(billinventory.getOrgid());
		newbillinventory.setPutinendno(backendno);
		newbillinventory.setPutinstartno(backstartno);
		newbillinventory.setPutintype("0");//退领后的票据入库也要当作入库操作，状态由原来3该为0
		newbillinventory.setStorageid(billinventory.getStorageid());
		newbillinventory.setUpdateby(userid);
		newbillinventory.setUpdatetime(now);
		newbillinventory = billinventoryDao.merge(newbillinventory);
		
		//退领入库日志
		Billlog inventorybilllog = new Billlog();
		inventorybilllog.setCreateby(userid);
		inventorybilllog.setCreatetime(now);
		inventorybilllog.setBillinventoryid(newbillinventory.getId());
		inventorybilllog.setOperationtype("0");
		inventorybilllog.setStartno(newbillinventory.getPutinstartno());
		inventorybilllog.setEndno(newbillinventory.getPutinendno());
		inventorybilllog.setLoguser(userinfo);
		billlogService.save(inventorybilllog);		
		
		if(billinuse.getEndno()>backendno){
			//后面部分还是该领用者领用
			Billinuse newbillinuse = new Billinuse();
			newbillinuse.setBillinventoryid(billinuse.getBillinventoryid());
			newbillinuse.setBilltypeid(billinuse.getBilltypeid());
			newbillinuse.setCreateby(userid);
			newbillinuse.setCreatetime(new Date());
			newbillinuse.setEndno(billinuse.getEndno());
			newbillinuse.setIsactive(true);
			newbillinuse.setNextno(backendno+1);
			newbillinuse.setOrgid(billinuse.getOrgid());
			newbillinuse.setRecipients(billinuse.getRecipients());
			newbillinuse.setStartno(backendno+1);
			newbillinuse.setStatus("0");
			newbillinuse.setUpdateby(userid);
			newbillinuse.setUpdatetime(newbillinuse.getCreatetime());
			dao.merge(newbillinuse);

			Billlog billlog = new Billlog();//保存退领后产生一条新的领用信息的操作的日志
			billlog.setCreateby(userid);
			billlog.setCreatetime(now);
			billlog.setBillinventoryid(newbillinuse.getBillinventoryid());
			billlog.setOperationtype("2");// 领用
			billlog.setStartno(newbillinuse.getStartno());
			billlog.setEndno(newbillinuse.getEndno());
			billlog.setLoguser(userinfo);
			billlogService.save(billlog);
		}
		
		billinuse.setEndno(backstartno-1);
		if(billinuse.getNextno()==billinuse.getEndno()+1){
			billinuse.setStatus("2");
		}
		
		billinuse.setUpdateby(userid);
		billinuse.setUpdatetime(now);
		dao.merge(billinuse);
		return true;
	}
		
	@SuppressWarnings("rawtypes")
	@Override
	public List query(String sql) {
		return dao.find(sql);
	}

	// 初始化当前使用票据 2011-04-14 ice
	public MethodResult initBillNo(Billinuse billinuse ) {
		Global global = CurrentUtil.getGlobal();
		MethodResult methodResult = new MethodResult();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		propertyFilters.add(new PropertyFilter("EQL_t!billtypeid", billinuse
				.getBilltypeid()));
		propertyFilters.add(new PropertyFilter("EQL_t!recipients", billinuse
				.getRecipients()));
		propertyFilters.add(new PropertyFilter("EQB_t!isactive", true));
		propertyFilters.add(new PropertyFilter("NOEQS_t!status", "2"));// 状态
																		// 0-没有使用、1正在使用、2已经用完
																		// 取数据字典

		
		List<Billinuse> billinuses = (List<Billinuse>) dao.query(
				Billinuse.class, propertyFilters);
	
		if (billinuses == null || billinuses.size() == 0) {
			ServiceException serviceException = new ServiceException("0052");
			methodResult.setObject(null);
			methodResult.setResult(-1);
			methodResult.setResultMsg(serviceException.getExceptionMessage());
			return methodResult;
		} else {
			Billinuse curuseBillinuse = null;
			for (Billinuse _billinuse : billinuses) {
				if (_billinuse.getStatus().equals("1")) {
					curuseBillinuse = _billinuse;
					
				}		
				//当0024参数开启式并且票据类型是车票and输入的票号和当前数据库nextno不一致(如果以一致走原逻辑)and輸入的票號大於零and輸入的票号大于当前票段的startno并且小于endno
				if((parameterService.findParamValue(ParamterConst.Param_0024, _billinuse.getOrgid())).equals("1")&&
						billinuse.getBilltypeid()==1&&billinuse.getNextno()!=_billinuse.getNextno()
							&&billinuse.getNextno()>0 && billinuse.getNextno()< _billinuse.getEndno() &&billinuse.getNextno()>_billinuse.getStartno() ){
								if (_billinuse.getStatus().equals("0")) {
									// 更新状态
									_billinuse.setStatus("1");
									for (Billinuse _billinuse2 : billinuses) {
										if (_billinuse != _billinuse2
												&& _billinuse2.getStatus().equals("1")) {
											_billinuse2.setStatus("0");
											break;
										}
									}
								}
								play.Logger.info("数据库当前票号："+_billinuse.getNextno()+",输入票号："+billinuse.getNextno());
								if (_billinuse.getNextno() > billinuse.getNextno()) {//如果数据库当前票号>输入的当前票号，
									break;
								}
								
								billdamaged =new Billdamaged();
								//坏票登记表
								billdamaged.setCreateby(_billinuse.getRecipients());
								billdamaged.setCreatetime(new Date());
								billdamaged.setStartno(_billinuse.getNextno());
								billdamaged.setEndno(billinuse.getNextno()-1);
								billdamaged.setAmount(billinuse.getNextno()-_billinuse.getNextno());
								billdamaged.setDamageddscribe("因重置车票跳号所产生的坏票");
								billdamaged.setBilltypeid(_billinuse.getBilltypeid());
								billdamaged.setBillinuseid(_billinuse.getId());
								billdamaged.setTicketoutletsid(global.getTicketoutlets().getId());
								billdamaged.setUpdateby(_billinuse.getRecipients());
								billdamaged.setUpdatetime(new Date());
								billdamaged.setRecordby(_billinuse.getRecipients());
								billdamaged.setRecordip(global.getIpAddress());
								billdamaged.setRecordtime(new Date());
								
								Billtype billtype = billtypeDao.findById(billdamaged
										.getBilltypeid());
								String damagedstartno = StringUtils.strPad(new Long(billdamaged.getStartno()).toString(),
										(int) billtype.getTicketnolength(), 
										"0");
								String damagedendno = StringUtils.strPad(new Long(billdamaged.getEndno()).toString(),
										(int) billtype.getTicketnolength(), 
										"0");
								Ticketturnoverdetail ticketturnoverdetail = ticketturnoverdetailService.getCurTicketturnoverdetail(_billinuse.getRecipients(), damagedstartno);
								if("0".equals(ticketturnoverdetail.getTicketstartno())){
									ticketturnoverdetail.setTicketstartno(damagedstartno);
								}
								ticketturnoverdetail.setTicketendno(damagedendno);
								ticketturnoverdetail.setUpdateby(billdamaged.getUpdateby());
								ticketturnoverdetail.setUpdatetime(billdamaged.getUpdatetime());
								ticketturnoverdetail.setBilldamagednum((int) (ticketturnoverdetail.getBilldamagednum()+(billdamaged.getEndno()-billdamaged.getStartno()+1)));
								ticketturnoverdetail = (Ticketturnoverdetail) billdamageddao.merge(ticketturnoverdetail);
								billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
								billdamageddao.save(billdamaged);
								_billinuse.setNextno(billinuse.getNextno());
								//curuseBillinuse.setStatus("1");
								dao.save(_billinuse);
							methodResult.setObject(_billinuse);
							methodResult.setResult(MethodResult.SUCCESS);	
							Operationlog operationLog = new Operationlog();
							operationLog.setIp(global.getIpAddress());
							String module = "";
							if(1 == billinuse.getBilltypeid()){
								module = "售票管理->重置车票票号";
							}else if (3 == billinuse.getBilltypeid()){
								module = "售票管理->重置保险票号";
							}else{
								module = "售票管理->重置票号";
							}
							operationLog.setContent(global.getUserinfo().getName() + "操作" + module +"当前输入的票号："+ billinuse.getNextno()
									+"当前数据库的Nextno："+_billinuse.getNextno()+"坏票数："+billdamaged.getAmount()
									+"坏票的起始票号："+"_billinuse.getNextno()"+"坏票结束票号："+billinuse.getNextno()
								+ (methodResult.getResult() == MethodResult.SUCCESS ? "成功":"失败") );
							operationLog.setOperatetime(new Date());
							operationLog.setModule(module);
							operationLog.setOperation("重置票号");
							operationLog.setSessionid("无session");
							operationLog.setUserid(global.getUserinfo().getId());
		//					JPA.em().merge(operationLog);
							operationlogDao.merge(operationLog);
							return methodResult;
							
						}				
						if (billinuse.getNextno() == _billinuse.getNextno()) {
							// 找到对应的票段
							if (_billinuse.getStatus().equals("0")) {
								// 更新状态
								_billinuse.setStatus("1");
								for (Billinuse _billinuse2 : billinuses) {
									if (_billinuse != _billinuse2
											&& _billinuse2.getStatus().equals("1")) {
										_billinuse2.setStatus("0");
										break;
									}
								}
							}
							methodResult.setObject(_billinuse);
							methodResult.setResult(MethodResult.SUCCESS);
							//增加操作保存日志 add by tianhb 2018年4月18日 begin
							//Global global = CurrentUtil.getGlobal();
							Operationlog operationLog = new Operationlog();
							operationLog.setIp(global.getIpAddress());
		//					String billtype = "";
							String module = "";
							if(1 == billinuse.getBilltypeid()){
		//						billtype = "车票 ";
								module = "售票管理->重置车票票号";
							}else if (3 == billinuse.getBilltypeid()){
		//						billtype = "保险票 ";
								module = "售票管理->重置保险票号";
							}else{
		//						billtype = billinuse.getBilltypeid() + " ";
								module = "售票管理->重置票号";
							}
							operationLog.setContent(global.getUserinfo().getName() + "操作" + module + billinuse.getNextno()
								+ (methodResult.getResult() == MethodResult.SUCCESS ? "成功":"失败") );
							operationLog.setOperatetime(new Date());
							operationLog.setModule(module);
							operationLog.setOperation("重置票号");
							operationLog.setSessionid("无session");
							operationLog.setUserid(global.getUserinfo().getId());
		//					JPA.em().merge(operationLog);
							operationlogDao.merge(operationLog);
							//增加操作保存日志 add by tianhb 2018年4月18日 end
							return methodResult;
						}
					 }	
			if (curuseBillinuse == null) {
				curuseBillinuse = billinuses.get(0);
			}
			ServiceException serviceException = new ServiceException("0053");
			methodResult.setResult(MethodResult.FAILURE);
			methodResult.setObject(curuseBillinuse);
			methodResult.setResultMsg(serviceException.getExceptionMessage()
					+ curuseBillinuse.getNextno());
		}
		return methodResult;

	}

	

	/**
	 * 往后跳号，一般用于打印时调用
	 * @param billtypecode
	 * @param startbillno
	 * @param jumpnum
	 * @return
	 * @throws ServiceException 
	 */
	public Billinuse jumpBillinuse(long userid,String billtypecode,String startbillno,long jumpnum) throws ServiceException{
		//判断当前票号是否正确
		Global global = CurrentUtil.getGlobal();
		Billtype billtype = billtypeService.findByCode(billtypecode);
		Billinuse billinuse = new Billinuse();
		billinuse.setBilltypeid(billtype.getId());
		billinuse.setRecipients(userid);
		billinuse.setNextno(new Long(startbillno));
		MethodResult ticketno_methodResult = initBillNo(billinuse);
		if(ticketno_methodResult.getResult()!=1||((Billinuse)ticketno_methodResult.getObject()).getNextno()!=new Long(startbillno)){
			throw new ServiceException("0170"); //传入的当前票号与数据库不一致
		}
		else{
			billinuse = (Billinuse)ticketno_methodResult.getObject();
		}
		//判断当前票号剩余票数是否足够
		if(billinuse.getEndno()-billinuse.getNextno()+1<jumpnum){
			throw new ServiceException("0171"); //当前票段剩余票数不够打印
		}
		else if(billinuse.getEndno()-billinuse.getNextno()+1==jumpnum){
			billinuse.setStatus("2"); //已经使用完
		}
		billinuse.setNextno(billinuse.getNextno()+jumpnum);
		billinuse.setUpdatetime(new Date());
		billinuse.setUpdateby(userid);
		return dao.merge(billinuse);
	}
	
	/*
	 * getBilluse方法：<br/> <br/>
	 * 
	 * @param billtypeid
	 * 
	 * @param recipients
	 * 
	 * @param billno
	 * 
	 * @return
	 * 
	 * @see cn.nova.bus.bill.service.BillinuseService#getBilluse(long, long,
	 * long)
	 * 
	 * @exception
	 */
	@Override
	public Billinuse getBilluse(long billtypeid, long recipients, long billno) {
		return dao.getBilluse(billtypeid, recipients, billno);
	}

	public UserinfoDao getUserinfoDao() {
		return userinfoDao;
	}

	public void setUserinfoDao(UserinfoDao userinfoDao) {
		this.userinfoDao = userinfoDao;
	}
}
