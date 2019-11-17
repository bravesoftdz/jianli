package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.checkticket.model.Departinvoices;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packtturnover;
import cn.nova.bus.pack.service.PacktturnoverService;
import cn.nova.bus.pack.service.impl.PacktturnoverServiceImpl;
import cn.nova.bus.pack.vo.PackDeparVO;
import cn.nova.bus.pack.vo.PacktturnoverVO;
import cn.nova.bus.query.service.impl.PackQueryServiceImpl;
import cn.nova.bus.report.service.impl.TicketTurnOverReportServiceImpl;
import cn.nova.bus.sale.service.impl.TicketturnoverServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackPaymentAction extends BaseAction{
	private List<Map<String, Object>> revenuelist;
	private List<Map<String, Object>> packturnoverMap;
	private List<Map<String, Object>> packtturnMap;
	
	private List<Map<String, Object>> packManualaddquery;
	private List<Map<String, Object>> packManualMakeuplist;
	
	private Packtturnover packtturnover;
	private PackDeparVO packDeparvo;
	private long packtturnoverid;
	
	private String pactturnoverdetailid;
	
	private long packtturndetailid;
	
	private Long userid;
	private String orgid;
	private Date fromdate;
	private Date enddate;
	
	private String packdatafrom;
	
	private List<Map<String, Object>> resultmap;
	private int querytype; // 长短款标志
	private String title;
	
	private String packno;
	private String packdepartinvoicesno;
	private Packdepartinvoices packdepartinvoices;
	
	private PacktturnoverService packtturnoverService;
	
	
	
	private Pack pack;
	
	
	

	public String query(){
		packtturnoverService = new PacktturnoverServiceImpl();
		setRevenuelist(packtturnoverService.query(orgid, userid, fromdate,enddate));
		return "json";
	}
	
	public String savePacktturnover() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (packtturnover != null) {
					if (packtturnover.getId() != 0) {
						packtturnover.setUpdateby(global.getUserinfo().getId());
						packtturnover.setUpdatetime(new Date());
						packtturnover.setReceiptip(global.getIpAddress());
						setMsg("重缴款成功！");
						markSuccess();
					} else {
						packtturnover.setCreateby(global.getUserinfo().getId());
						packtturnover.setCreatetime(new Date());
						packtturnover.setUpdateby(global.getUserinfo().getId());
						packtturnover.setUpdatetime(new Date());
						packtturnover.setReceiptip(global.getIpAddress());
						setMsg("缴款成功！");
						markSuccess();
					}
					packtturnoverService = new PacktturnoverServiceImpl();
					packtturnover = packtturnoverService.savePacktturnover(packtturnover,pactturnoverdetailid);
					setPacktturnoverid(packtturnover.getId());
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	public String savePacktturnoverAll() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				
				packtturnover.setReceiptip(global.getIpAddress());
				packtturnover.setCreateby(global.getUserinfo().getId());
				packtturnover.setCreatetime(new Date());
				packtturnover.setUpdateby(global.getUserinfo().getId());
				packtturnover.setUpdatetime(new Date());
				setMsg("缴款成功！");
				markSuccess();
					
				packtturnoverService = new PacktturnoverServiceImpl();
				packtturnover = packtturnoverService.savePacktturnover(packtturnover,pactturnoverdetailid);
				setPacktturnoverid(packtturnover.getId());
				
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	public String auditPacktturnover() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				
				setMsg("审核成功！");
				markSuccess();
					
				packtturnoverService = new PacktturnoverServiceImpl();
				packtturnover = packtturnoverService.auditPacktturnover(global,pactturnoverdetailid);
				
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}
	
	/**
	 * 日营收单查询
	 * @return
	 */
	public String queryRevenueOfDay(){
		try {
			packtturnoverService = new PacktturnoverServiceImpl();
			setPackturnoverMap(packtturnoverService.queryRevenueOfDay(packdatafrom,ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	public String queryPackErrorReport() {
		try {
			packtturnoverService = new PacktturnoverServiceImpl();
			Map<String, Object> returndatas = packtturnoverService
					.queryTicketErrorReport(
							ServletPropertyFilterUtil.buildFromHttpRequest(),
							querytype,packdatafrom);
			setResultmap((List<Map<String, Object>>)returndatas.get("resultmap"));
			setTitle(returndatas.get("title")+"");
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			e.getMessage();
		}
		return "json";
	}
	
	public String qryPacktturnoverinfo(){
		try {
			packtturnoverService = new PacktturnoverServiceImpl();
			setPacktturnMap(packtturnoverService.qryPacktturnoverinfo(packtturndetailid));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	public String packManualMakeup(){
		packtturnoverService =  new PacktturnoverServiceImpl();
		setPackManualMakeuplist(packtturnoverService.packManualMakeup(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	
	public String findpackAndDepinfo() {
		packtturnoverService = new PacktturnoverServiceImpl();
		List list = packtturnoverService.findpackAndDepinfo(packno);
		if (list.size() < 2) {
			setMsg(" 该单号不存在！");
			markFail();
		}else{
			setPackManualaddquery(packtturnoverService.findpackAndDepinfo(packno));
			markSuccess();
		}
		return "json";
	}
	public String packManualsave() {

		packtturnoverService = new PacktturnoverServiceImpl();
		Global global = CurrentUtil.getGlobal();

		try {
			if (global != null && global.getUserinfo().getId() > 0) {

				setMsg("保存成功！");
				markSuccess();
				packtturnoverService.packManualsave(global, packDeparvo);
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception ex) {
			play.Logger.error(ex.getMessage(), ex);
			setMsg("操作失败！");
			markFail();
		}
		return "json";
	}

	public String packManualdel() {

		packtturnoverService = new PacktturnoverServiceImpl();

		Boolean bn = packtturnoverService.packManualdel(packdepartinvoices);
		if (bn = true) {
			setMsg("删除数据成功！");
			markSuccess();
			packtturnoverService.packManualdel(packdepartinvoices);
		}
		return "json";
	}
	
	public List<Map<String, Object>> getRevenuelist() {
		return revenuelist;
	}

	public void setRevenuelist(List<Map<String, Object>> revenuelist) {
		this.revenuelist = revenuelist;
	}

	public Long getUserid() {
		return userid;
	}

	public void setUserid(Long userid) {
		this.userid = userid;
	}

	public String getOrgid() {
		return orgid;
	}

	public void setOrgid(String orgid) {
		this.orgid = orgid;
	}

	public Date getFromdate() {
		return fromdate;
	}

	public void setFromdate(Date fromdate) {
		this.fromdate = fromdate;
	}

	public Date getEnddate() {
		return enddate;
	}

	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}

	public Packtturnover getPacktturnover() {
		return packtturnover;
	}

	public void setPacktturnover(Packtturnover packtturnover) {
		this.packtturnover = packtturnover;
	}

	public long getPacktturnoverid() {
		return packtturnoverid;
	}

	public void setPacktturnoverid(long packtturnoverid) {
		this.packtturnoverid = packtturnoverid;
	}

	public String getPactturnoverdetailid() {
		return pactturnoverdetailid;
	}

	public void setPactturnoverdetailid(String pactturnoverdetailid) {
		this.pactturnoverdetailid = pactturnoverdetailid;
	}

	public List<Map<String, Object>> getPackturnoverMap() {
		return packturnoverMap;
	}

	public void setPackturnoverMap(List<Map<String, Object>> packturnoverMap) {
		this.packturnoverMap = packturnoverMap;
	}

	public String getPackdatafrom() {
		return packdatafrom;
	}

	public void setPackdatafrom(String packdatafrom) {
		this.packdatafrom = packdatafrom;
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public int getQuerytype() {
		return querytype;
	}

	public void setQuerytype(int querytype) {
		this.querytype = querytype;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public long getPacktturndetailid() {
		return packtturndetailid;
	}

	public void setPacktturndetailid(long packtturndetailid) {
		this.packtturndetailid = packtturndetailid;
	}

	public List<Map<String, Object>> getPacktturnMap() {
		return packtturnMap;
	}

	public void setPacktturnMap(List<Map<String, Object>> packtturnMap) {
		this.packtturnMap = packtturnMap;
	}

	public List<Map<String, Object>> getPackManualaddquery() {
		return packManualaddquery;
	}

	public void setPackManualaddquery(List<Map<String, Object>> packManualaddquery) {
		this.packManualaddquery = packManualaddquery;
	}

	public List<Map<String, Object>> getPackManualMakeuplist() {
		return packManualMakeuplist;
	}

	public void setPackManualMakeuplist(
			List<Map<String, Object>> packManualMakeuplist) {
		this.packManualMakeuplist = packManualMakeuplist;
	}

	public Pack getPack() {
		return pack;
	}

	public void setPack(Pack pack) {
		this.pack = pack;
	}

	public Packdepartinvoices getPackdepartinvoices() {
		return packdepartinvoices;
	}

	public void setPackdepartinvoices(Packdepartinvoices packdepartinvoices) {
		this.packdepartinvoices = packdepartinvoices;
	}

	public PackDeparVO getPackDeparvo() {
		return packDeparvo;
	}

	public void setPackDeparvo(PackDeparVO packDeparvo) {
		this.packDeparvo = packDeparvo;
	}

	public String getPackno() {
		return packno;
	}

	public void setPackno(String packno) {
		this.packno = packno;
	}

	public String getPackdepartinvoicesno() {
		return packdepartinvoicesno;
	}

	public void setPackdepartinvoicesno(String packdepartinvoicesno) {
		this.packdepartinvoicesno = packdepartinvoicesno;
	}

	public PacktturnoverService getPacktturnoverService() {
		return packtturnoverService;
	}

	public void setPacktturnoverService(PacktturnoverService packtturnoverService) {
		this.packtturnoverService = packtturnoverService;
	}

}
