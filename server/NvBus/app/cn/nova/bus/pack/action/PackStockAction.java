package cn.nova.bus.pack.action;

import cn.nova.bus.action.BaseAction;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

import util.CurrentUtil;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.Packpickup;
import cn.nova.bus.pack.service.PackStockService;
import cn.nova.bus.pack.service.impl.PackStockServiceImpl;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackStockAction extends BaseAction{
	private List<Map<String, Object>> schedulelist;
	private List<Map<String, Object>> revenuelist;
	private List<Map<String, Object>>  havaPackdepartmap;
	
	private Pack pack;
	private boolean isfindbyreported;
	private String packids;
	private long scheduleid;
	private Long vehicleid;
	private Long routeid;
	private String stationids;
	private Date departdate;
	private String departinvoicesno;
	

	private Packpickup packpickup;
	private String packpickno;
	private long packpickupid;
	private int packpickups;
	private String param;

	//行包单号 李电志 2015年5月19日 10:23:00 
	private String packno;
	
	private Long vehiclereportid;
	private String flag_pack;
	

	private String singbillno;
	
	private PackStockService packStockService;
	private String pknos;
	/**
	 * 签发查询班次 
	 * @param propertyFilters
	 * @return
	 */
	public String querystockschedule(){
		packStockService = new PackStockServiceImpl();
		setSchedulelist(packStockService.queryschedule(ServletPropertyFilterUtil.buildFromHttpRequest(),departdate));
		return "json";
	}
	
	public String updatPackBy(){
		
		packStockService = new PackStockServiceImpl();
		if(packStockService.updatPackBy(singbillno,ServletPropertyFilterUtil.buildFromHttpRequest())){
			setMsg("更新成功");
			markSuccess();
		}else{
			setMsg("更新失败");
			markFail();
		}
		
		return "json";
	}
	  
	
	/**
	 * 查询报道车辆信息 李电志 2015年5月19日 09:20:37
	 * @return
	 */
	public String qrysendVehicle(){
		packStockService = new PackStockServiceImpl();
		try {
			Global global = CurrentUtil.getGlobal();
			setSchedulelist(packStockService.qrysendVehicle(departdate,param,global.getOrganization().getId()));
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "json";
	}
	
	
	public String qrysendSchedule() throws ServiceException{
		packStockService = new PackStockServiceImpl();
		Global global = CurrentUtil.getGlobal();
		setSchedulelist(packStockService.qrysendSchedule(departdate,param,global.getOrganization().getId()));
		return "json";
	}
	
	
	public String qrysendSchedulePlan(){
		packStockService = new PackStockServiceImpl();
		setSchedulelist(packStockService.qrysendSchedulePlan(departdate,param,isfindbyreported));
		return "json";
	}
	
	public String updatepackschedule(){
		Global global = CurrentUtil.getGlobal();
		try {
			packStockService = new PackStockServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if(packStockService.updatepack(packids, routeid, scheduleid, vehicleid, stationids,global.getUserinfo().getId(),new Date(),departdate)){
					setMsg("签发成功");
					markSuccess();
				}else{
					setMsg("签发失败");
					markFail();
				}
			}
		} catch (ServiceException ex) {			
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			setMsg("签发失败");
			markFail();
		}
		return "json";
		
		
	}
	
	/**
	 * 签发行包 2015年5月19日 09:21:07 李电志
	 * @return
	 */
	public String senderPack(){
		Global global = CurrentUtil.getGlobal();
		try {
			packStockService = new PackStockServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if(packStockService.senderPack(departdate, packno,
						vehiclereportid,scheduleid,global.getUserinfo().getId(),flag_pack)){
					setMsg("签发成功");
					markSuccess();
				}else{
					setMsg("签发失败");
					markFail();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			e.printStackTrace();
			setMsg("签发失败");
			markFail();
		}
		return "json";
		
	}
	
	
	//查询页面选择行包
	public String choosenSenderPack(){
		Global global = CurrentUtil.getGlobal();
		try {
			packStockService = new PackStockServiceImpl();
			if (global != null && global.getUserinfo().getId() > 0) {
				if(packStockService.choosenSenderPack(departdate, pknos,
						vehicleid,scheduleid,global.getUserinfo().getId(),flag_pack, routeid, global)){
					setMsg("签发成功");
					markSuccess();
				}else{
					setMsg("签发失败");
					markFail();
				}
			}
		} catch (ServiceException ex) {
			setMsg(ex.getMessage());
			markFail();
		} catch (Exception e) {
			e.printStackTrace();
			setMsg("签发失败");
			markFail();
		}
		return "json";
		
	}
	
	
	public String savepackpickup(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				
				if (packpickup != null) {
					if (packpickup.getId() != 0) {
						packpickup.setUpdateby(global.getUserinfo().getId());
						packpickup.setUpdatetime(new Date());
						setMsg("修改成功！");
					} else {
						packpickup.setCreateby(global.getUserinfo().getId());
						packpickup.setCreatetime(new Date());
						packpickup.setUpdateby(global.getUserinfo().getId());
						packpickup.setUpdatetime(new Date());
						setMsg("提领成功！");
					}
					packStockService = new PackStockServiceImpl();
					packpickup = packStockService.savepackpickup(packpickup,packpickno,packpickups,global.getUserinfo().getId());
					setPackpickupid(packpickup.getId());
					markSuccess();
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
	
	public String queryrevenue(){
		Global global = CurrentUtil.getGlobal();
		 SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		 Date date=null;
		 try {
			date=format.parse(format.format(new Date()));
		} catch (ParseException e) {
			play.Logger.error(e.getMessage(), e);
		}
		 packStockService = new PackStockServiceImpl();
		if (global != null && global.getUserinfo().getId() > 0) {
			setRevenuelist(packStockService.querysellbyrevenue(global.getUserinfo().getId(), date));
		}
		return "json";
	}
	
	public String havaPackdepart(){
		
		packStockService = new PackStockServiceImpl();
		setHavaPackdepartmap(packStockService.havaPackdepart(pack));
		
		return "json";
	}
	
	/**
	 * 取消签发、提领
	 * @param pack
	 * @return
	 * @throws ServiceException
	 */
	public String cancelPack(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				
				if (pack != null) {
					if (pack.getId() != 0) {
						pack.setUpdateby(global.getUserinfo().getId());
						pack.setUpdatetime(new Date());
						if(pack.getPacktype().equals("0")){
							setMsg("取消签发成功！");
						}else if(pack.getPacktype().equals("1")){
							setMsg("取消提领成功！");
						}
						markSuccess();
					} else {

					}
					packStockService = new PackStockServiceImpl();
					packStockService.cancelPack(pack);
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
	
	
	/**
	 * 查询该车辆下签发的行包信息 李电志 2015年5月19日 18:43:35
	 * @return
	 */
	public String querystockSendPack(){
		packStockService = new PackStockServiceImpl();
		try {
			setSchedulelist(packStockService.querystockSendPack(vehiclereportid,scheduleid,flag_pack));
		} catch (ServiceException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return "json";
	}
	
	public List<Map<String, Object>> getSchedulelist() {
		return schedulelist;
	}
	public void setSchedulelist(List<Map<String, Object>> schedulelist) {
		this.schedulelist = schedulelist;
	}

	public String getPackids() {
		return packids;
	}

	public void setPackids(String packids) {
		this.packids = packids;
	}

	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public Long getVehicleid() {
		return vehicleid;
	}

	public void setVehicleid(Long vehicleid) {
		this.vehicleid = vehicleid;
	}

	public Long getRouteid() {
		return routeid;
	}

	public void setRouteid(Long routeid) {
		this.routeid = routeid;
	}

	public String getStationids() {
		return stationids;
	}

	public void setStationids(String stationids) {
		this.stationids = stationids;
	}

	public Packpickup getPackpickup() {
		return packpickup;
	}

	public void setPackpickup(Packpickup packpickup) {
		this.packpickup = packpickup;
	}

	public long getPackpickupid() {
		return packpickupid;
	}

	public void setPackpickupid(long packpickupid) {
		this.packpickupid = packpickupid;
	}

	public List<Map<String, Object>> getRevenuelist() {
		return revenuelist;
	}

	public void setRevenuelist(List<Map<String, Object>> revenuelist) {
		this.revenuelist = revenuelist;
	}

	public Date getDepartdate() {
		return departdate;
	}

	public void setDepartdate(Date departdate) {
		this.departdate = departdate;
	}

	public Pack getPack() {
		return pack;
	}

	public void setPack(Pack pack) {
		this.pack = pack;
	}

	public String getPackpickno() {
		return packpickno;
	}

	public void setPackpickno(String packpickno) {
		this.packpickno = packpickno;
	}

	public String getDepartinvoicesno() {
		return departinvoicesno;
	}

	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}

	public String getSingbillno() {
		return singbillno;
	}

	public void setSingbillno(String singbillno) {
		this.singbillno = singbillno;
	}

	public int getPackpickups() {
		return packpickups;
	}

	public void setPackpickups(int packpickups) {
		this.packpickups = packpickups;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}
	
	public String getPackno() {
		return packno;
	}

	public void setPackno(String packno) {
		this.packno = packno;
	}

	public List<Map<String, Object>> getHavaPackdepartmap() {
		return havaPackdepartmap;
	}

	public void setHavaPackdepartmap(List<Map<String, Object>> havaPackdepartmap) {
		this.havaPackdepartmap = havaPackdepartmap;
	}

	

	public Long getVehiclereportid() {
		return vehiclereportid;
	}

	public void setVehiclereportid(Long vehiclereportid) {
		this.vehiclereportid = vehiclereportid;
	}

	public String getFlag_pack() {
		return flag_pack;
	}

	public void setFlag_pack(String flag_pack) {
		this.flag_pack = flag_pack;
	}

	public String getPknos() {
		return pknos;
	}

	public void setPknos(String pknos) {
		this.pknos = pknos;
	}

	public boolean isIsfindbyreported() {
		return isfindbyreported;
	}

	public void setIsfindbyreported(boolean isfindbyreported) {
		this.isfindbyreported = isfindbyreported;
	}
	
	
	
}
