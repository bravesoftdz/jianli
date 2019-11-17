package cn.nova.bus.checkticket.action;

import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;

import cn.nova.bus.action.BaseAction;
import cn.nova.bus.checkticket.model.Outstationcheck;
import cn.nova.bus.checkticket.model.Outstationupmoney;
import cn.nova.bus.checkticket.service.OutstationupmoneyService;
import cn.nova.bus.checkticket.service.impl.OutstationupmoneyServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class OutstationupmoneyAction extends BaseAction{
	private List<Map<String, Object>> outstationupmoneylist;
	private List<Map<String, Object>> listmap;
	private List<Map<String, Object>> arriverStationCheckList;
	private Outstationcheck ots;
	private Outstationupmoney outstationupmoney;// 添加、修改、删除
  	private long outstationupmoneyid; // 添加修改结果回传

	private OutstationupmoneyService outstationupmoneyService;
	private Date departdate;
	private long vehicleid;
	private String cardno;
	private long id;
	private long vehiclereportid;

	public String listOutstationupmoney() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		setOutstationupmoneylist(outstationupmoneyService
				.query(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}

	public String saveOutstationupmoney() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (outstationupmoney != null) {
					if (outstationupmoney.getId() != 0) {
						outstationupmoney.setUpdateby(global.getUserinfo()
								.getId());
						outstationupmoney.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						outstationupmoney.setCreateby(global.getUserinfo()
								.getId());
						outstationupmoney.setCreatetime(new Date());
						outstationupmoney.setUpdateby(global.getUserinfo()
								.getId());
						outstationupmoney.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					outstationupmoney = outstationupmoneyService
							.saveOutstationupmoney(outstationupmoney);
					setOutstationupmoneyid(outstationupmoney.getId());
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

	public String deleteOutstationupmoney() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		try {
			outstationupmoneyService.deleteOutstationupmoney(outstationupmoney);
			setMsg("删除成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除失败，" + e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String queryOutstationcheck() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		setListmap(outstationupmoneyService
				.queryOutstationcheck(ServletPropertyFilterUtil
						.buildFromHttpRequest()));
		return "json";
	}
	
	public String queryDepartinvoices() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		setListmap(outstationupmoneyService.queryDepartinvoices(departdate,vehicleid,cardno,global));
		return "json";
	}
	
	public String saveOutstationcheck() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (ots != null) {
					if (ots.getId() != 0) {
						ots.setUpdateby(global.getUserinfo()
								.getId());
						ots.setUpdatetime(new Date());
						setMsg("修改成功！");
						markSuccess();
					} else {
						ots.setCreateby(global.getUserinfo()
								.getId());
						ots.setCreatetime(new Date());
						ots.setUpdateby(global.getUserinfo()
								.getId());
						ots.setUpdatetime(new Date());
						setMsg("添加成功！");
						markSuccess();
					}
					ots = outstationupmoneyService
							.saveOutstationcheck(ots);
					setOutstationupmoneyid(ots.getId());
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
	
	public String delOutstationcheck() {
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		try {
			outstationupmoneyService.delOutstationcheck(id);
			setMsg("删除成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除失败，" + e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String qryVehicledriverreport(){
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		setListmap(outstationupmoneyService.qryVehicledriverreport(departdate,vehiclereportid));
		return "json";
	}
	
	public String qryArriveStationCheck(){
		outstationupmoneyService = new OutstationupmoneyServiceImpl();
		setArriverStationCheckList(outstationupmoneyService.qryArriveStationCheck(departdate,vehicleid));
		return "json";
	}
	
	
	public List<Map<String, Object>> getListmap() {
		return listmap;
	}

	public void setListmap(List<Map<String, Object>> listmap) {
		this.listmap = listmap;
	}

	public List<Map<String, Object>> getOutstationupmoneylist() {
		return outstationupmoneylist;
	}

	public void setOutstationupmoneylist(
			List<Map<String, Object>> outstationupmoneylist) {
		this.outstationupmoneylist = outstationupmoneylist;
	}

	public Outstationupmoney getOutstationupmoney() {
		return outstationupmoney;
	}

	public void setOutstationupmoney(Outstationupmoney outstationupmoney) {
		this.outstationupmoney = outstationupmoney;
	}

	public long getOutstationupmoneyid() {
		return outstationupmoneyid;
	}

	public void setOutstationupmoneyid(long outstationupmoneyid) {
		this.outstationupmoneyid = outstationupmoneyid;
	}

	public Outstationcheck getOts() {
		return ots;
	}

	public void setOts(Outstationcheck ots) {
		this.ots = ots;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public String getCardno() {
		return cardno;
	}

	public void setCardno(String cardno) {
		this.cardno = cardno;
	}

	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public List<Map<String, Object>> getArriverStationCheckList() {
		return arriverStationCheckList;
	}

	public void setArriverStationCheckList(List<Map<String, Object>> arriverStationCheckList) {
		this.arriverStationCheckList = arriverStationCheckList;
	}
}