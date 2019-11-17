package cn.nova.bus.pack.service.impl;

import java.math.BigDecimal;
import java.sql.Timestamp;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;
import org.codehaus.groovy.reflection.stdclasses.BigDecimalCachedClass;

import util.SystemException;
import util.UserTransaction;

import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.dao.PackWarehousingDao;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packarriver;
import cn.nova.bus.pack.service.PackService;
import cn.nova.bus.pack.service.PackWarehousingService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;


public class PackWarehousingServiceImpl implements PackWarehousingService {

	private UserTransaction usertransaction = new UserTransaction();
	private PackWarehousingDao packWarehousingDao = new PackWarehousingDao();
	
	public List<Map<String, Object>> query(List<PropertyFilter> propertyFilters){
		List<Map<String, Object>> result = ListUtil.listToMap(
				new Object[] { "ischoose", "id", "packtype", "goodtype",
						"sendstationid", "tostationid", "name", "scheduleid",
						"vehicleid", "departdate", "packno", "invoiceno",
						"sellby", "pieces", "weight", "volume", "packed",
						"shipprice", "packfee", "handfee", "unloadfee",
						"custodial", "transitfee", "insuredamount",
						"insurancefee", "insurance", "deliveryfee", "otherfee",
						"totalfee", "location", "packprice", "sender",
						"senderphone", "senderaddress", "consignee",
						"consigneephone", "consigneeaddress",
						"certificatetype", "certificateno", "shiptype",
						"paymethod", "valuables", "status", "packtturnoverid",
						"remak", "orgid", "createtime", "createby",
						"updatetime", "updateby", "integraterprice",
						"servicefee",

						"sendstationname", "tostationname", "schedulecode",
						"departtime", "vehiclecode", "entrypacker",
						"updatebyname", "signby", "signbyname", "signtime",
						"onlycode", "synccode", "orgname", "clientid",
						"mobilephone", "clientname", "clientaddress",
						"clientcode", "clientintegrater", "clienttype","singbillno",
						"zhuanyuntostationid","zhuanyuntostationname",
						"takename","takecertificateno","vcstatus","balancestatus","collectstatus","recyclestatus","goodsstatus","packedname"
						,"packarriverno","packarriverdate","packarriverstatus","packarriverid","packarrivercreatby","packarrivercreatetime"},
						packWarehousingDao.query(propertyFilters), new Object[] { Boolean.class,
						Long.class, String.class, String.class, Long.class,
						Long.class, String.class, Long.class, Long.class,
						Timestamp.class, String.class, String.class,
						Long.class, Short.class, BigDecimal.class,
						String.class, String.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, BigDecimal.class,
						BigDecimal.class, BigDecimal.class, String.class,
						BigDecimal.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, String.class,
						Boolean.class, String.class, Long.class, String.class,
						Long.class, Timestamp.class, Long.class,
						Timestamp.class, Long.class, BigDecimal.class,
						BigDecimal.class,

						String.class, String.class, String.class, String.class,
						String.class, String.class, String.class, Long.class,
						String.class, Timestamp.class, String.class,
						String.class, String.class, Long.class, String.class,
						String.class, String.class, String.class, Long.class,
						String.class, String.class,Long.class,String.class,
						String.class,String.class,String.class,String.class,
						String.class,String.class,String.class,String.class,String.class,Timestamp.class,String.class,Long.class,Long.class,Timestamp.class});
		return result;
	}

	/**
	 * 保存行包收讫单
	 */
	public Packarriver savePackWarehousing(Pack pack , Packarriver packarriver) throws ServiceException{
		
			PackService packService = new PackServiceImpl();
			if (pack.getId() == 0) {
				pack = packService.savePack(pack);
				packarriver.setPackid(pack.getId());
				packarriver.setCreatetime(new Date());
//				packarriver.setPackprice(BigDecimal.valueOf(10));
//				packarriver.setServicefee(BigDecimal.valueOf(3));
				try {
					usertransaction.begin();
					packarriver = (Packarriver)packWarehousingDao.merge(packarriver);
					usertransaction.commit();
				} catch (SystemException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
					try {
						usertransaction.rollback();
					} catch (SystemException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
				
			} else {
				pack = packService.savePack(pack,null);
				packarriver.setPackid(pack.getId());
				try {
					usertransaction.begin();
					packarriver = packWarehousingDao.getEntityManager().merge(packarriver);
					usertransaction.commit();
				} catch (SystemException e) {
					e.printStackTrace();
					try {
						usertransaction.rollback();
					} catch (SystemException e1) {
						// TODO Auto-generated catch block
						e1.printStackTrace();
					}
				}
			}
			
		return packarriver;
	}
	
	@SuppressWarnings("unchecked")
	@Override
	public Pack savePackWarehousing(Pack pack) throws ServiceException {
		if (pack.getId() == 0) {
			if (packWarehousingDao.checkpackno(pack.getPackno())) {
				throw new ServiceException("0444");
			}
			packWarehousingDao.save(pack);
		} else {
			packWarehousingDao.getEntityManager().merge(pack);
		}
		return pack;
	}

	//
	@Override
	public List<Map<String, Object>> queryPackno(String param,
			List<PropertyFilter> propertyFilters) {
		// TODO Auto-generated method stub
		return ListUtil.listToMap(new Object[] { "id", "name", "code",
				"consignee" },
				packWarehousingDao.queryPackno(param, propertyFilters),
				new Object[] { Long.class, String.class, String.class,
						String.class });
	}

	/**
	 * 条码扫描星行包单号修改其状态为入库状态
	 * 
	 * @param param
	 * @param propertyFilters
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public int packnoUpStatus(Pack pack) throws ServiceException {
		StringBuffer sb = new StringBuffer(
				"select p from  Pack p where packtype=1 and p.packno='" + pack.getPackno()
						+ "'");
		List<Object> list = packWarehousingDao.getEntityManager().createQuery(sb.toString()).getResultList();
		if (list==null || list.size()<=0) {
			return 0;
		}
		
		if (list.size()>=2){
			return -1;
		}
		Pack p = (Pack) list.get(0);
		if(p.getStatus().equals("0")){
			//已入仓
			return -2;
		}
		
		if(p.getStatus().equals("1")){
			//已入仓
			return -2;
		}
		if(p.getStatus().equals("2")){
			//已提领
			return -3;
		}
		if(p.getStatus().equals("3")){
			//已废弃
			return -4;
		}
		if(p.getSigntime()==null){
			//始发站未签发
			return -5;
		}
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		p.setStatus("0");
		p.setSellby(pack.getUpdateby());
		try {
			p.setDepartdate(dateFormat.parse(dateFormat.format(pack.getUpdatetime())));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			play.Logger.error(e.getMessage(), e);
		}
		p.setUpdateby(pack.getUpdateby());
		p.setUpdatetime(pack.getUpdatetime());
		
		packWarehousingDao.getEntityManager().merge(p);
		
		return 1;
	}

	public Packarriver whackpack(Packarriver packarriver) throws ServiceException {
		Packarriver p = (Packarriver) packWarehousingDao.get(Packarriver.class, packarriver.getId());
		Packarriver p2 = null;
		p2 = (Packarriver) p.clone();
		String status = p.getStatus();
		p.setStatus("1");//行包收讫单状态：0：未结算；1：已注销：2：已结算
		p.setUpdatetime(packarriver.getUpdatetime());
		p.setUpdateby(packarriver.getUpdateby());
		packWarehousingDao.getEntityManager().merge(p);

		p2.setId(0);
		p2.setStatus(status);
		p2.setPackid(p.getPackid());
		p2.setPackarriverno(packarriver.getPackarriverno());
		p2.setUpdateby(packarriver.getUpdateby());
		p2.setUpdatetime(new Date());
		packWarehousingDao.save(p2);

		return p2;
	}
}
