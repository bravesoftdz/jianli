package cn.nova.bus.bill.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.bill.model.Billinuse;
import cn.nova.bus.bill.model.Billtype;
import cn.nova.bus.bill.service.BillinuseService;
import cn.nova.bus.bill.service.BilltypeService;
import cn.nova.bus.bill.service.impl.BillinuseServiceImpl;
import cn.nova.bus.bill.service.impl.BilltypeServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.commons.MethodResult;
import cn.nova.utils.web.ServletPropertyFilterUtil;

/**
 * 票据领用、退领、当前使用票据初始化
 * 
 * @author 蒋伟
 * @version 0.1
 */
public class BillinuseAction extends BaseAction{
	private List<Map<String, Object>> billinusemap;
	private Billinuse billinuse;
	private Long backstartno;
	private Long backendno;

	// 票据类型编码
	private String billtypecode;
	private long curbillno;
	private long curbillnum;
	private int billlength;
	private Long id;

	private BillinuseService billinuseService = new BillinuseServiceImpl();

	public String initBillNo() {
		// 取出票据类型id及长度
		BilltypeService billtypeService = new BilltypeServiceImpl();
		Billtype billtype = billtypeService.findByCode(billtypecode);
		setBilllength((int) billtype.getTicketnolength());
		billinuse.setBilltypeid(billtype.getId());
		Global global = CurrentUtil.getGlobal();
		billinuse.setRecipients(global.getUserinfo().getId());
		MethodResult methodResult = billinuseService.initBillNo(billinuse);
		if (methodResult.getResult() == 1) {
			setCurbillno(((Billinuse) methodResult.getObject()).getNextno());
			setCurbillnum(((Billinuse) methodResult.getObject()).getEndno()
					- ((Billinuse) methodResult.getObject()).getNextno() + 1);
			markSuccess();
		} else {
			markFlag(methodResult.getResult());
			if (methodResult.getObject() != null) {
				setCurbillno(((Billinuse) methodResult.getObject()).getNextno());
				setCurbillnum(((Billinuse) methodResult.getObject()).getEndno()
						- ((Billinuse) methodResult.getObject()).getNextno()
						+ 1);
			} else {
				setCurbillno(0);
				setCurbillnum(0);
			}
			setMsg(methodResult.getResultMsg());
		}
		return "json";
	}

	public String save() {
		Global global = CurrentUtil.getGlobal();

		msg = "操作成功！";
		markSuccess();
		if (billinuse != null) {
			// 领用
			billinuse.setIsactive(true);
			billinuse.setOrgid(global.getOrganization().getId());
			billinuse.setNextno(billinuse.getStartno());
			billinuse.setCreateby(global.getUserinfo().getId());
			billinuse.setStatus("0");
			billinuse.setCreatetime(new Timestamp(System.currentTimeMillis()));
			billinuse.setUpdateby(global.getUserinfo().getId());
			billinuse.setUpdatetime(new Timestamp(System.currentTimeMillis()));

			setId(billinuseService.save(billinuse));
		}
		return "json";
	}

	public String backinuse() {
		Global global = CurrentUtil.getGlobal();
		/*
		// 退领
		msg = "操作成功！";
		flag = 1;
		if (billinuse.getId() > 0) {

			billinuse = billinuseService.findById(billinuse.getId());
			billinuse.setUpdateby(global.getUserinfo().getId());
			billinuse.setUpdatetime(new Timestamp(System.currentTimeMillis()));

			if (billinuse.getNextno() == backstartno
					&& billinuse.getEndno() > backendno) {
				billinuse.setNextno(backendno + 1);
			} else if (billinuse.getNextno() < backstartno
					&& billinuse.getEndno() == backendno) {
				billinuse.setEndno(backstartno - 1);
			} else if (billinuse.getNextno() == backstartno
					&& billinuse.getEndno() == backendno) {
				billinuse.setEndno(backstartno - 1);
				// 当下个可用号与退领的start号相同时，而且结束号与领用结束号相等时，
				// 那该领用信息内的票据全被 领用
				billinuse.setStatus("2");
			} else if (billinuse.getNextno() < backstartno
					&& billinuse.getEndno() > backendno) {

				// 处于中间的退领号
				// 将一条领用数据拆分成两条
				Billinuse newbillinuse = new Billinuse();
				newbillinuse.setBillinventoryid(billinuse.getBillinventoryid());
				newbillinuse.setBilltypeid(billinuse.getBilltypeid());
				newbillinuse.setCreateby(global.getUserinfo().getId());
				newbillinuse.setCreatetime(new Timestamp(System
						.currentTimeMillis()));
				newbillinuse.setRecipients(billinuse.getRecipients());
				newbillinuse.setUpdateby(global.getUserinfo().getId());
				newbillinuse.setUpdatetime(new Timestamp(System
						.currentTimeMillis()));
				newbillinuse.setEndno(billinuse.getEndno());
				newbillinuse.setStartno(backendno + 1);
				newbillinuse.setIsactive(true);
				newbillinuse.setNextno(backendno + 1);

				newbillinuse.setStatus("0");
				newbillinuse.setOrgid(global.getOrganization().getId());
				// 修改原来的那条
				billinuse.setEndno(backstartno - 1);
				// 当下个可用号与退领的start号相同时，则该领用的号全被全光了
				// 没用光的在拆分后的令一个领用信息中
				if (billinuse.getNextno() == backstartno) {
					billinuse.setStatus("2");
				}
				if (!billinuseService.backinuse(billinuse, newbillinuse)) {
					msg = "操作失败！";
					flag = -1;
				}
				return "json";
			}

		}
		if (!billinuseService.backinuse(billinuse, backstartno, backendno)) {
			msg = "操作失败！";
			flag = -1;
		}
		*/
		try {
			msg = "操作失败！";		
			if (billinuseService.backinuse(billinuse.getId(), backstartno, backendno,global.getUserinfo().getId())) {
				msg = "退领成功";
				markSuccess();
			}
		} catch (ServiceException e) {
			markFail();
			msg = msg + e.getExceptionMessage();
		}
		return "json";
	}

	public Long getBackstartno() {
		return backstartno;
	}

	public void setBackstartno(Long backstartno) {
		this.backstartno = backstartno;
	}

	public Long getBackendno() {
		return backendno;
	}

	public void setBackendno(Long backendno) {
		this.backendno = backendno;
	}

	public String list() {
		try {
			setBillinusemap(billinuseService.query(ServletPropertyFilterUtil
					.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public List<Map<String, Object>> getBillinusemap() {
		return billinusemap;
	}

	public void setBillinusemap(List<Map<String, Object>> billinusemap) {
		this.billinusemap = billinusemap;
	}

	public Billinuse getBillinuse() {
		return billinuse;
	}

	public void setBillinuse(Billinuse billinuse) {
		this.billinuse = billinuse;
	}

	/**
	 * @param billtypecode
	 *            the billtypecode to set
	 */
	public void setBilltypecode(String billtypecode) {
		this.billtypecode = billtypecode;
	}

	/**
	 * @return the billtypecode
	 */
	public String getBilltypecode() {
		return billtypecode;
	}

	/**
	 * @param curbillnum
	 *            the curbillnum to set
	 */
	public void setCurbillnum(long curbillnum) {
		this.curbillnum = curbillnum;
	}

	/**
	 * @return the curbillnum
	 */
	public long getCurbillnum() {
		return curbillnum;
	}

	/**
	 * @param curbillno
	 *            the curbillno to set
	 */
	public void setCurbillno(long curbillno) {
		this.curbillno = curbillno;
	}

	/**
	 * @return the curbillno
	 */
	public long getCurbillno() {
		return curbillno;
	}

	/**
	 * @param billlength
	 *            the billlength to set
	 */
	public void setBilllength(int billlength) {
		this.billlength = billlength;
	}

	/**
	 * @return the billlength
	 */
	public int getBilllength() {
		return billlength;
	}

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

}
