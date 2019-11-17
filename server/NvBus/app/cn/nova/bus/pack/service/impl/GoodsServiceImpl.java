package cn.nova.bus.pack.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.OutputStream;
import java.math.BigDecimal;
import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import play.Play;
import util.CurrentUtil;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.exception.BusinessException;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.GoodsDao;
import cn.nova.bus.pack.dao.PacktturnoverdetailDao;
import cn.nova.bus.pack.model.Goods;
import cn.nova.bus.pack.model.Packtturnoverdetail;
import cn.nova.bus.pack.service.GoodsService;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class GoodsServiceImpl implements GoodsService {

	
	private GoodsDao goodsDao = new GoodsDao();

	
	//private BillinventoryService billinventoryService = new BillinventoryServiceImpl();

	
	private BilltypeService billtypeService = new BilltypeServiceImpl();
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();

	@Override
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters) {

		return ListUtil.listToMap(new Object[] { "id", "goodsno", "num",
				"customer", "phone", "idcardno", "goodstype", "pieces",
				"location", "pickupenddate", "deposittiime", "custodial",
				"penalty", "totalfee", "consignee", "status", "pickuper",
				"pickupdate", "operator", "remak", "orgid", "createtime",
				"createby", "updatetime", "updateby", "consigneename",
				"operatorname", "createbyname", "updatebyname", "orgname", "picture" },
				goodsDao.query(propertyFilters), new Object[] { Long.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, Integer.class,
						String.class, Timestamp.class, Timestamp.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						Long.class, String.class, String.class,
						Timestamp.class, Long.class, String.class, Long.class,
						Timestamp.class, Long.class, Timestamp.class,
						Long.class, String.class, String.class, String.class,
						String.class, String.class, String.class });
	}

	@SuppressWarnings("unchecked")
	@Override
	public Goods saveGoods(Goods goods) throws ServiceException {
		

		if (goods.getId() == 0) {
			Billtype billtype = billtypeService
					.findByCode(ConstDefiniens.GoodsBill);

			Billinuse billinuse = billinuseService.getBilluse(billtype.getId(),
					goods.getUpdateby(), new Long(goods.getGoodsno()));
			if (billinuse == null || "2".equals(billinuse.getStatus())) {
				// 您的票据已经用完
				throw new ServiceException("0143");
			}

			if (goodsDao.checkedGoodsNum(goods.getNum())) {
				// 该保管牌号正在使用中
				throw new ServiceException("0445");
			}
			//将图片路径存到数据库
			if (goods.getPicture() != null) {  
				goods.setPicture(uploadGoodsPicture(goods.getPicture()));
			}
			// if (goodsDao.checkedGoodsNo(goods.getGoodsno())) {
			// //该票号已被使用
			// throw new ServiceException("0288");
			// }

			//
			// Billinventory bt =
			// billinventoryService.qryBillinventory(goods.getOrgid(),
			// ConstDefiniens.GoodsBill);
			//
			// if (bt == null || bt.getAvailableenno() <
			// bt.getAvailablestartno()) {
			// // 您的票据已经用完
			// throw new ServiceException("0143");
			// }
			// String balanceno = bt.getAvailablestartno() + "";
			// goods.setGoodsno(balanceno);
			play.Logger.info("小件营收缴款开始——————————————————————————————————————————");
			PacktturnoverdetailDao dao = new PacktturnoverdetailDao();

			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			Date now = new Date();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
			propertyFilters.add(new PropertyFilter("EQD_t!moneydate", now));
			propertyFilters.add(new PropertyFilter("EQL_t!sellby", CurrentUtil.getGlobal().getUserinfo().getId()));
			propertyFilters.add(new PropertyFilter("EQS_t!paymethod", "0"));
			List<Packtturnoverdetail> list = dao.qryPacktturnoverdetailBypackno(propertyFilters);// 查到某操作员某天的营收缴款
			Packtturnoverdetail packtturnoverdetail = null;
			if (list != null && list.size() > 0) { // 若之前有相关营收
				packtturnoverdetail = list.get(0);
				if("0".equals(packtturnoverdetail.getTicketstartno())){
					packtturnoverdetail.setTicketstartno(goods.getGoodsno());
				}
				//packtturnoverdetail.setPaymethod("0");
				packtturnoverdetail.setTicketendno(goods.getGoodsno());// 结束票号
				packtturnoverdetail.setPickups(packtturnoverdetail.getPickups() + goods.getPieces()); // 件数
				packtturnoverdetail.setTicketnum(packtturnoverdetail.getTicketnum() + 1);
				if (goods.getTotalfee() != null) {
					if (packtturnoverdetail.getPickupamount() == null) {
						packtturnoverdetail.setPickupamount(goods.getTotalfee());// 合计金额
						packtturnoverdetail.setMoneypayable(goods.getTotalfee());// 合计金额
					} else {
						packtturnoverdetail
								.setPickupamount(goods.getTotalfee().add(packtturnoverdetail.getPickupamount()));// 合计金额
						packtturnoverdetail
								.setMoneypayable(goods.getTotalfee().add(packtturnoverdetail.getMoneypayable()));// 合计金额
					}

				}
				if (goods.getCustodial() != null) { // 保管费
					if (packtturnoverdetail.getCustodial() == null) {
						packtturnoverdetail.setCustodial(goods.getCustodial());
					} else {
						packtturnoverdetail.setCustodial(goods.getCustodial().add(packtturnoverdetail.getCustodial()));
					}
				}
				// 寄存不会产生滞纳金
				// if (goods.getPenalty() != null) { // 滞纳金
				// packtturnoverdetail.setCustodial(goods.getPenalty().add(packtturnoverdetail.getCustodial()));
				// }
				packtturnoverdetail.setUpdatetime(now);

			} else { // 若之前没有相关营收
				packtturnoverdetail = new Packtturnoverdetail();// 今天还未存在营收缴款
				packtturnoverdetail.setPaymethod("0");
				packtturnoverdetail.setMoneydate(now); // 票款日期
				packtturnoverdetail.setSellby( CurrentUtil.getGlobal().getUserinfo().getId());// 办理员
				packtturnoverdetail.setTicketstartno(goods.getGoodsno());// 起始票号
				packtturnoverdetail.setTicketendno(goods.getGoodsno());// 结束票号
				packtturnoverdetail.setPickups(goods.getPieces());// 件数
				if (goods.getTotalfee() == null) {
					packtturnoverdetail.setPickupamount(BigDecimal.valueOf(0));// 提领金额
					packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));// 应缴款
				} else {
					packtturnoverdetail.setPickupamount(goods.getTotalfee());
					packtturnoverdetail.setMoneypayable(goods.getTotalfee());
					packtturnoverdetail.setCustodial(goods.getTotalfee());// 保管费
				}
				packtturnoverdetail.setIsturnover(false); // 未缴款
				packtturnoverdetail.setIsaudit(false); // 未审核
				packtturnoverdetail.setTicketnum(1);
				packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
				packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));
				packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));
				packtturnoverdetail.setOrgid(goods.getOrgid());
				packtturnoverdetail.setDatafrom("2");// 小件寄存
				packtturnoverdetail.setCreateby( CurrentUtil.getGlobal().getUserinfo().getId());
				packtturnoverdetail.setCreatetime(now);
				packtturnoverdetail.setUpdateby( CurrentUtil.getGlobal().getUserinfo().getId());
				packtturnoverdetail.setUpdatetime(now);
			}
			packtturnoverdetail = (Packtturnoverdetail) goodsDao.merge(packtturnoverdetail);
			play.Logger.info("小件营收缴款结束——————————————————————————————————————————");
			goodsDao.save(goods);
		} else {
			//从库里获取小件的对象
			Goods goodspicture = (Goods) goodsDao.get(Goods.class, goods.getId());
			if (goodspicture.getPicture() != null) {
				int index = goodspicture.getPicture().lastIndexOf("\\");
				int index1 = goods.getPictureName().lastIndexOf("\\");
				//如果修改时图片后面的信息和库里面的不相等，则进行图片地址的修改
				if (!goodspicture.getPicture().substring(index + 1).equals(goods.getPictureName().substring(index1 + 1))) {
					goods.setPicture(uploadGoodsPicture(goods.getPicture()));
				} else {
					goods.setPicture(goodspicture.getPicture());   //如果地址相同，则保存原来库里面的
				}
			} else {   //如果数据库里面没有图片，相当于上传图片
				goods.setPicture(uploadGoodsPicture(goods.getPicture()));
			}
			
			if (goods.getStatus() != null && goods.getStatus().equals("1")) {
				goodsDao.getEntityManager().merge(goods);
				pickupGoods(goods);
			} else {
				// 修改操作
				// if (goodsDao.checkedGoodsNo(goods.getGoodsno())) {
				// //该票号已被使用
				// throw new ServiceException("0288");
				// }

				Billtype billtype = billtypeService
						.findByCode(ConstDefiniens.GoodsBill);

				Billinuse billinuse = billinuseService.getBilluse(
						billtype.getId(), goods.getUpdateby(),
						new Long(goods.getGoodsno()));
				if (billinuse == null || "2".equals(billinuse.getStatus())) {
					// 您的票据已经用完
					throw new ServiceException("0143");
				}

				Goods goods2 = new Goods();
				goods2.setStatus("2");

				goods2.setUpdateby(goods.getUpdateby());
				goods2.setUpdatetime(goods.getUpdatetime());
				goods2.setId(goods.getId());

				if (goodsDao.wasteGoods(goods2)) {
					goods.setId(0);
					goodsDao.save(goods);
				} else {
					// 作废时失败
				}
			}
		}
		return goods;
	}
	/**
	 * 小件寄存的提领
	 */
	public Goods pickupGoods(Goods goods) throws ServiceException {
		
		// 小件寄存信息插入行包营收缴款明细表

		play.Logger.info("行包提领营收缴款开始——————————————————————————————————————————");
		if (goods.getPenalty() != null && goods.getPenalty().compareTo(BigDecimal.ZERO)>0) { // 如果有滞纳金才会产生营收

			PacktturnoverdetailDao dao = new PacktturnoverdetailDao();
			List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
			Date now = new Date();
			propertyFilters.clear();
			propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
			propertyFilters.add(new PropertyFilter("EQD_t!moneydate", now));
			propertyFilters.add(new PropertyFilter("EQL_t!sellby", goods.getOperator()));
			List<Packtturnoverdetail> list = dao.qryPacktturnoverdetailBypackno(propertyFilters);// 查到某操作员某天的营收缴款
			Packtturnoverdetail packtturnoverdetail = null;
			if (list != null && list.size() > 0) { // 若之前有相关营收
				packtturnoverdetail = list.get(0);
				packtturnoverdetail.setTicketendno(goods.getGoodsno());// 结束票号
//				packtturnoverdetail.setPickups(packtturnoverdetail.getPickups()
//				 + goods3.getPieces()); // 件数
				packtturnoverdetail.setTicketnum(packtturnoverdetail.getTicketnum() + 1);
				if (goods.getTotalfee() != null) {
					if (packtturnoverdetail.getPickupamount() == null) {
						packtturnoverdetail.setPickupamount(goods.getPenalty());// 提领金额
						packtturnoverdetail.setMoneypayable(goods.getPenalty());// 合计金额
					} else {
						packtturnoverdetail
								.setPickupamount(goods.getPenalty().add(packtturnoverdetail.getPickupamount()));// 提领金额
						packtturnoverdetail
								.setMoneypayable(goods.getPenalty().add(packtturnoverdetail.getMoneypayable()));// 合计金额
					}
				}
				packtturnoverdetail.setCustodial(goods.getPenalty().add(packtturnoverdetail.getCustodial()));
				packtturnoverdetail.setUpdatetime(now);
				packtturnoverdetail.setUpdateby(goods.getOperator());
			} else { // 若之前没有相关营收
				packtturnoverdetail = new Packtturnoverdetail();// 今天还未存在营收缴款
				packtturnoverdetail.setPaymethod("0");
				packtturnoverdetail.setMoneydate(goods.getPickupdate()); // 提领日期
				packtturnoverdetail.setSellby(goods.getOperator());// 办理员
				packtturnoverdetail.setTicketstartno(goods.getGoodsno());// 起始票号
				packtturnoverdetail.setTicketendno(goods.getGoodsno());// 结束票号
				//packtturnoverdetail.setPickups(goods.getPieces());// 件数
				if (goods.getTotalfee() == null) {
					packtturnoverdetail.setPickupamount(BigDecimal.valueOf(0));// 提领金额
					packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));// 应缴款
				} else {
					packtturnoverdetail.setPickupamount(goods.getPenalty());
					packtturnoverdetail.setMoneypayable(goods.getPenalty());
					packtturnoverdetail.setCustodial(BigDecimal.valueOf(0));// 保管费
				}
				packtturnoverdetail.setIsturnover(false); // 未缴款
				packtturnoverdetail.setIsaudit(false); // 未审核
				packtturnoverdetail.setTicketnum(1);
				packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
				packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));
				packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));
				packtturnoverdetail.setOrgid(goods.getOrgid());
				packtturnoverdetail.setDatafrom("2");// 小件寄存
				packtturnoverdetail.setCreateby(goods.getOperator());
				packtturnoverdetail.setCreatetime(now);
				packtturnoverdetail.setUpdateby(goods.getOperator());
				packtturnoverdetail.setUpdatetime(now);
			}
			packtturnoverdetail = (Packtturnoverdetail) goodsDao.merge(packtturnoverdetail);
			play.Logger.info("行包提领营收缴款结束——————————————————————————————————————————");
		}
		return goods;

	}
	@Override
	public boolean wasteGoods(Goods goods_) throws ServiceException {
		boolean bol = goodsDao.wasteGoods(goods_);
		play.Logger.info("行包作废营收缴款开始——————————————————————————————————————————");
		Goods goods = (Goods) goodsDao.get(Goods.class, goods_.getId());
		PacktturnoverdetailDao dao = new PacktturnoverdetailDao();
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate", now));
		propertyFilters.add(new PropertyFilter("EQL_t!sellby", goods.getOperator()));
		List<Packtturnoverdetail> list = dao.qryPacktturnoverdetailBypackno(propertyFilters);// 查到某操作员某天的营收缴款
		Packtturnoverdetail packtturnoverdetail = null;
		if (list != null && list.size() > 0) { // 若之前有相关营收
			packtturnoverdetail = list.get(0);
//			packtturnoverdetail.setTicketendno(goods.getGoodsno());// 结束票号
			packtturnoverdetail.setPickups(packtturnoverdetail.getPickups()
			 - goods.getPieces()); // 件数
			packtturnoverdetail.setTicketnum(packtturnoverdetail.getTicketnum() + 1);
			if (goods.getTotalfee() != null) {
				if (packtturnoverdetail.getPickupamount() == null) {
					packtturnoverdetail.setPickupamount(goods.getCustodial().negate());// 提领金额
					packtturnoverdetail.setMoneypayable(goods.getCustodial().negate());// 合计金额
				} else {
					packtturnoverdetail
//							.setPickupamount(goods.getPenalty().subtract(packtturnoverdetail.getPickupamount()));// 提领金额
					.setPickupamount(packtturnoverdetail.getPickupamount().subtract(goods.getCustodial()));
					
					packtturnoverdetail.setMoneypayable(packtturnoverdetail.getMoneypayable().subtract(goods.getCustodial()));
//							.setMoneypayable(goods.getPenalty().subtract(packtturnoverdetail.getMoneypayable()));// 合计金额
				}
			}
			packtturnoverdetail.setCustodial(packtturnoverdetail.getCustodial().subtract(goods.getCustodial()));
			packtturnoverdetail.setUpdatetime(now);

		} else { // 若之前没有相关营收
			packtturnoverdetail = new Packtturnoverdetail();// 今天还未存在营收缴款

			packtturnoverdetail.setMoneydate(goods.getPickupdate()); // 提领日期
			packtturnoverdetail.setSellby(goods.getOperator());// 办理员
			packtturnoverdetail.setTicketstartno("0");// 起始票号
			packtturnoverdetail.setTicketendno("0");// 结束票号
			packtturnoverdetail.setPickups(1);// 件数
			if (goods.getTotalfee() == null) {
				packtturnoverdetail.setPickupamount(BigDecimal.valueOf(0));// 提领金额
				packtturnoverdetail.setMoneypayable(BigDecimal.valueOf(0));// 应缴款
			} else {
				packtturnoverdetail.setPickupamount(goods.getPenalty().negate());
				packtturnoverdetail.setMoneypayable(goods.getPenalty().negate());
				packtturnoverdetail.setCustodial(BigDecimal.valueOf(0).negate());// 保管费
			}
			packtturnoverdetail.setIsturnover(false); // 未缴款
			packtturnoverdetail.setIsaudit(false); // 未审核
			packtturnoverdetail.setTicketnum(1);
			packtturnoverdetail.setShipprice(BigDecimal.valueOf(0));
			packtturnoverdetail.setServicefee(BigDecimal.valueOf(0));
			packtturnoverdetail.setPackprice(BigDecimal.valueOf(0));
			packtturnoverdetail.setOrgid(goods.getOrgid());
			packtturnoverdetail.setDatafrom("2");// 小件寄存
			packtturnoverdetail.setCreateby(goods.getOperator());
			packtturnoverdetail.setCreatetime(now);
			packtturnoverdetail.setUpdateby(goods.getOperator());
			packtturnoverdetail.setUpdatetime(now);
		}
		packtturnoverdetail = (Packtturnoverdetail) goodsDao.merge(packtturnoverdetail);
		
		
		play.Logger.info("行包作废营收缴款结束——————————————————————————————————————————");
		return bol;
	}

	public List<Map<String, Object>> queryGgoodsno(String param,
			List<PropertyFilter> propertyFilters) {
		return ListUtil.listToMap(new Object[] { "id", "name", "code",
				"customer", "idcardno" },
				goodsDao.queryGgoodsno(param, propertyFilters), new Object[] {
						Long.class, String.class, String.class, String.class,
						String.class });
	}

	

	/**
	 * 上传图片
	 */
	@Override
	public String uploadGoodsPicture(String picture) {

		//获取存入的图片
		if (picture != null) {
			try {
				//获取项目的路径
				File playfile = Play.applicationPath;
				byte[] pc=ConversionUtil.toByteArr(picture);
				String uuidName;
				uuidName = UUID.randomUUID().toString().replace("-", "").toUpperCase() + ".jpg";
				File file = new File(playfile.toString() + "/public/packPicture/");
				if (!file.exists()) {
					file.mkdirs();
				}
				file = new File(file.toString() + "/" + uuidName);
				OutputStream os = new FileOutputStream(file);
				os.write(pc);
				os.close();
//				return "/public/packPicture/" + uuidName;
				return uuidName;
			} catch (Exception e) {
				e.printStackTrace();
				throw new BusinessException("图片上传错误");
			}
		}
		return null;
	}
	
	
	
	/**
	 * 下载图片，获取图片的名字
	 */
	@Override
	public String downloadGoodsPicture(long id) {
		Goods goods = (Goods) goodsDao.get(Goods.class, id);
		return goods.getPicture();
//		if (goods.getPicture() != null) {
//			int index = goods.getPicture().lastIndexOf("/");
//			String pictureName = goods.getPicture().substring(index + 1);
//			return pictureName;
//		}
//		return null;
	}




}
