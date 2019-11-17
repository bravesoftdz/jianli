package cn.nova.bus.insure.service.impl;

import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.LockModeType;

import cn.nova.bus.insure.dao.InsuranceturnoverdetailDao;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsuranceturnoverdetailService;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")

public class InsuranceturnoverdetailServiceImpl implements
		InsuranceturnoverdetailService {


	private InsuranceturnoverdetailDao dao = new InsuranceturnoverdetailDao();

	@Override
	public boolean save(Insuranceturnoverdetail detail) {
		if (detail.getId() == 0) {
			return dao.save(detail);
		} else {
			return dao.update(detail);
		}
	}

	@SuppressWarnings("rawtypes")
	@Override
	public Insuranceturnoverdetail getInsuranceturnoverdetail(Long seller,
			long startno) {
		List list = dao.getList(seller, startno);
		if (!list.isEmpty()) {
			Insuranceturnoverdetail detail = dao.getInsuranceturnoverdetail(
					seller, startno);
			if (detail != null) {
				return detail;
			}
		}
		return null;
	}

	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Insuranceturnoverdetail.class,
				"sellername", "createname", "updatename", "ischoose","cashsellnum","cashsellmoney","cashreturnnum","cashreturnmoney","cashmoneypayable" },
				dao.query(propertyFilterList), new Object[] {
						Insuranceturnoverdetail.class, String.class,
						String.class, String.class, Boolean.class,long.class,BigDecimal.class,long.class,BigDecimal.class,BigDecimal.class });
	}

	@Override
	public Insuranceturnoverdetail getById(long id) {
		return (Insuranceturnoverdetail) dao.get(LockModeType.READ,Insuranceturnoverdetail.class,
				id);
	}

	@Override
	public List<Map<String, Object>> queryReturnInsuranceno(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "premium",
				"insuranceno" }, dao.queryReturnInsur(buildFromHttpRequest),
				new Object[] { BigDecimal.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryCancelInsuranceno(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "premium",
				"insuranceno" }, dao.queryCancelInsur(buildFromHttpRequest),
				new Object[] { BigDecimal.class, String.class });
	}

	@Override
	public List<Map<String, Object>> queryBillInsuranceno(
			List<PropertyFilter> buildFromHttpRequest) {
		return ListUtil.listToMap(new Object[] { "startno",
				"endno" }, dao.queryBillInsur(buildFromHttpRequest),
				new Object[] { String.class, String.class });
	}

	@Override
	public Insuranceturnoverdetail getCurInsuranceturnoverdetail(long sellerid,
			String startvoucherno) {
		List<PropertyFilter> propertyFilters = new ArrayList<PropertyFilter>();
		Date now = new Date();
		//插入或修改应缴款表
		propertyFilters.clear();
		propertyFilters.add(new PropertyFilter("EQB_t!isturnover", false));
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(now);
		calendar.set(calendar.get(Calendar.YEAR), 
					calendar.get(Calendar.MONTH), 
					calendar.get(Calendar.DAY_OF_MONTH), 
					0,0, 0);
		propertyFilters.add(new PropertyFilter("EQD_t!moneydate",calendar.getTime()));
		propertyFilters.add(new PropertyFilter("EQL_t!seller",sellerid));
		List<Insuranceturnoverdetail> insuranceturnoverdetails = dao.find(Insuranceturnoverdetail.class, propertyFilters);
		boolean neednew = true;
		Insuranceturnoverdetail insuranceturnoverdetail=null;
		if(insuranceturnoverdetails!=null&&insuranceturnoverdetails.size()>0){
			if(startvoucherno!=null&&!startvoucherno.equals("0")){
				for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
					if(new Long(_ticketturnoverdetail.getTicketendno()).longValue()+1L==new Long(startvoucherno)){
						insuranceturnoverdetail=_ticketturnoverdetail;
						neednew=false;
						break;
					}
				}
				if(neednew){
					for (Insuranceturnoverdetail _ticketturnoverdetail : insuranceturnoverdetails) {
						if("0".equals(_ticketturnoverdetail.getTicketstartno())){
							insuranceturnoverdetail=_ticketturnoverdetail;
							neednew=false;
							break;
						}
					}
				}
			}
			else{
				insuranceturnoverdetail=insuranceturnoverdetails.get(0);
				neednew=false;
			}
		}
		if(neednew){
			insuranceturnoverdetail = new Insuranceturnoverdetail();
			insuranceturnoverdetail.setMoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setSellmoney(new BigDecimal(0));
			insuranceturnoverdetail.setSellnum(0);
			insuranceturnoverdetail.setUpdateby(sellerid);
			insuranceturnoverdetail.setUpdatetime(now);
			insuranceturnoverdetail.setCancelnum(0);
			insuranceturnoverdetail.setCancelmoney(new BigDecimal(0));
			insuranceturnoverdetail.setNonvouchermoneypayable(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashmoney(new BigDecimal(0));
			insuranceturnoverdetail.setNoncashnum(0);
			insuranceturnoverdetail.setCreateby(sellerid);
			insuranceturnoverdetail.setCreatetime(now);
			insuranceturnoverdetail.setEticketnum(0);
			insuranceturnoverdetail.setMoneydate(now);
			insuranceturnoverdetail.setReturnhandcharge(new BigDecimal(0));
			insuranceturnoverdetail.setReturnmoney(new BigDecimal(0));
			insuranceturnoverdetail.setReturnnum(0);
			insuranceturnoverdetail.setSeller(sellerid);
			insuranceturnoverdetail.setTicketturnover(null);
			insuranceturnoverdetail.setIsturnover(false);
			insuranceturnoverdetail.setTurnovertime(null);
		
			if(startvoucherno==null){
				insuranceturnoverdetail.setTicketstartno("0");
				insuranceturnoverdetail.setTicketendno("0");
			}
			else{
				insuranceturnoverdetail.setTicketstartno(startvoucherno);
			}
		}
		//ticketturnoverdetail.setTicketendno 由调用者设置
		//其它字段改变也由调用者设置
		//ticketturnoverdetail.setMoneypayable(ticketturnoverdetail.getMoneypayable().subtract(totalreturnmoney));
		return insuranceturnoverdetail;
	}
	
}
