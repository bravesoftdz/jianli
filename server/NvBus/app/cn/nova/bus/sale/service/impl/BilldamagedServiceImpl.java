package cn.nova.bus.sale.service.impl;

import java.util.List;
import java.util.Map;

import cn.nova.bus.bill.model.Billdamaged;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.common.ConstDefiniens;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.insure.model.Insuranceturnoverdetail;
import cn.nova.bus.insure.service.InsuranceturnoverdetailService;
import cn.nova.bus.insure.service.impl.InsuranceturnoverdetailServiceImpl;
import cn.nova.bus.sale.dao.BilldamagedDao;
import cn.nova.bus.sale.model.Ticketdeliver;
import cn.nova.bus.sale.model.Ticketturnoverdetail;
import cn.nova.bus.sale.service.BilldamagedService;
import cn.nova.bus.sale.service.TicketturnoverdetailService;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.commons.StringUtils;
import cn.nova.utils.orm.PropertyFilter;
import cn.nova.utils.orm.jpa.ListUtil;

@SuppressWarnings("unchecked")
public class BilldamagedServiceImpl implements BilldamagedService {

	
	private BilldamagedDao dao = new BilldamagedDao();

	
	private BilltypeService billtypeDao = new BilltypeServiceImpl();

	
	private TicketturnoverdetailService ticketturnoverdetailService = new TicketturnoverdetailServiceImpl();
	
	
	private InsuranceturnoverdetailService insuranceturnoverdetailService = new InsuranceturnoverdetailServiceImpl();
	
	
	private BillinuseService billinuseService = new BillinuseServiceImpl();
	
	/**
	 * 坏票登记
	 */
	@Override
	public boolean save(Billdamaged billdamaged, long recipients)
			throws ServiceException {
		if (billdamaged.getId() == 0) {
			Billtype billtype = billtypeDao.findById(billdamaged
					.getBilltypeid());
			String damagedstartno = StringUtils.strPad(new Long(billdamaged.getStartno()).toString(),
					(int) billtype.getTicketnolength(), 
					"0");
			String damagedendno = StringUtils.strPad(new Long(billdamaged.getEndno()).toString(),
					(int) billtype.getTicketnolength(), 
					"0");
			billinuseService.jumpBillinuse(recipients,billtype.getCode(),damagedstartno,billdamaged.getEndno()-billdamaged.getStartno()+1);

			if ("Insure".equals(billtype.getCode())) {
				Insuranceturnoverdetail ticketturnoverdetail = insuranceturnoverdetailService.getCurInsuranceturnoverdetail(recipients, damagedstartno);
				if("0".equals(ticketturnoverdetail.getTicketstartno())){
					ticketturnoverdetail.setTicketstartno(damagedstartno);
				}
				ticketturnoverdetail.setTicketendno(damagedendno);
				ticketturnoverdetail.setUpdateby(billdamaged.getUpdateby());
				ticketturnoverdetail.setUpdatetime(billdamaged.getUpdatetime());
				ticketturnoverdetail = (Insuranceturnoverdetail) dao.merge(ticketturnoverdetail);
				billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
			} else if ("Ticket".equals(billtype.getCode())) {
				Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService().getCurTicketturnoverdetail(recipients, damagedstartno);
				if("0".equals(ticketturnoverdetail.getTicketstartno())){
					ticketturnoverdetail.setTicketstartno(damagedstartno);
				}
				ticketturnoverdetail.setTicketendno(damagedendno);
				ticketturnoverdetail.setUpdateby(billdamaged.getUpdateby());
				ticketturnoverdetail.setUpdatetime(billdamaged.getUpdatetime());
				ticketturnoverdetail.setBilldamagednum((int) (ticketturnoverdetail.getBilldamagednum()+(billdamaged.getEndno()-billdamaged.getStartno()+1)));
				ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
				billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
			} else {
				billdamaged.setTurnoverdetailid(0);
			}
			return dao.save(billdamaged);
		} else {
			return dao.update(billdamaged);
		}
	}
	
	@Override
	public MethodResult saveOnedamaged(Billdamaged billdamaged, Long recipients) {
		MethodResult result = new MethodResult();
		if (billdamaged.getId() == 0) {
			Billtype billtype = billtypeDao.findById(billdamaged.getBilltypeid());
			Billinuse billinuse = (Billinuse) dao.get(Billinuse.class, billdamaged.getBillinuseid());
			String damagedstartno = StringUtils.strPad(new Long(billdamaged.getStartno()).toString(),
					(int) billtype.getTicketnolength(), "0");
			//若票号是当前票号之后的票
			if(billdamaged.getStartno() >= billinuse.getNextno()){
				result.setResult(0);
				result.setResultMsg("票号:" + billdamaged.getStartno() + " 为当前票号或当前票号之后的票号，请使用[登记]按钮功能进行坏票！");
				return result;
			}
			//判断是否票据已经使用
			if(dao.checkNoIsuse(damagedstartno)){
				result.setResult(0);
				result.setResultMsg("票号:" + billdamaged.getStartno() + " 已有使用记录，不允许做坏票登记处理！");
				return result;
			}
			if ("Insure".equals(billtype.getCode())) {
				Insuranceturnoverdetail ticketturnoverdetail = insuranceturnoverdetailService
						.getCurInsuranceturnoverdetail(recipients, damagedstartno);
				if ("0".equals(ticketturnoverdetail.getTicketstartno())) {
					ticketturnoverdetail.setTicketstartno(damagedstartno);
				}
				ticketturnoverdetail.setTicketendno(damagedstartno);
				ticketturnoverdetail.setUpdateby(billdamaged.getUpdateby());
				ticketturnoverdetail.setUpdatetime(billdamaged.getUpdatetime());
				ticketturnoverdetail = (Insuranceturnoverdetail) dao.merge(ticketturnoverdetail);
				billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
			} else if ("Ticket".equals(billtype.getCode())) {
				Ticketturnoverdetail ticketturnoverdetail = getTicketturnoverdetailService()
						.getCurTicketturnoverdetail(recipients, damagedstartno);
				if ("0".equals(ticketturnoverdetail.getTicketstartno())) {
					ticketturnoverdetail.setTicketstartno(damagedstartno);
				}
				ticketturnoverdetail.setTicketendno(damagedstartno);
				ticketturnoverdetail.setUpdateby(billdamaged.getUpdateby());
				ticketturnoverdetail.setUpdatetime(billdamaged.getUpdatetime());
				ticketturnoverdetail.setBilldamagednum((int) (ticketturnoverdetail.getBilldamagednum()
						+ (billdamaged.getEndno() - billdamaged.getStartno() + 1)));
				ticketturnoverdetail = (Ticketturnoverdetail) dao.merge(ticketturnoverdetail);
				billdamaged.setTurnoverdetailid(ticketturnoverdetail.getId());
			} else {
				billdamaged.setTurnoverdetailid(0);
			}
			dao.save(billdamaged);
			result.setResult(1); 
			return result;
		} else {
			dao.update(billdamaged);
			result.setResult(1);
			return result;
		}
	}

	@Override
	public boolean delete(Billdamaged billdamaged) {
		return dao.delete(billdamaged);
	}

	@Override
	public boolean delete(Long id) throws ServiceException {
		return dao.delete(Billdamaged.class, id);
	}

	@Override
	public List<Billdamaged> query() {
		return dao.query(Ticketdeliver.class, null);
	}

	@Override
	public Billdamaged getById(Long id) {
		return (Billdamaged) dao.get(Billdamaged.class, id);
	}

	/**
	 * 坏票登记查询
	 */
	@Override
	public List<Map<String, Object>> query(
			List<PropertyFilter> propertyFilterList) {
		return ListUtil.listToMap(new Object[] { Billdamaged.class,
				"billtypename", "recordname", "ticketname", "createname",
				"updatename" }, dao.query(propertyFilterList), new Object[] {
				Billdamaged.class, String.class, String.class, String.class,
				String.class, String.class });
	}

	public TicketturnoverdetailService getTicketturnoverdetailService() {
		return ticketturnoverdetailService;
	}

	public void setTicketturnoverdetailService(
			TicketturnoverdetailService ticketturnoverdetailService) {
		this.ticketturnoverdetailService = ticketturnoverdetailService;
	}

	public InsuranceturnoverdetailService getInsuranceturnoverdetailService() {
		return insuranceturnoverdetailService;
	}

	public void setInsuranceturnoverdetailService(
			InsuranceturnoverdetailService insuranceturnoverdetailService) {
		this.insuranceturnoverdetailService = insuranceturnoverdetailService;
	}

}
