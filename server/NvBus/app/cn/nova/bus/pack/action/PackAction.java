package cn.nova.bus.pack.action;

import java.sql.Timestamp;
import java.text.ParseException;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import util.SystemException;
import util.UserTransaction;
import cn.nova.bus.action.BaseAction;
import cn.nova.bus.balance.service.impl.BalanceServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.pack.model.Pack;
import cn.nova.bus.pack.model.PackBalance;
import cn.nova.bus.pack.model.PackIntegraterPay;
import cn.nova.bus.pack.model.Packdepartinvoices;
import cn.nova.bus.pack.model.Packreturnback;
import cn.nova.bus.pack.service.PackService;
import cn.nova.bus.pack.service.PackStockService;
import cn.nova.bus.pack.service.PackreturnbackService;
import cn.nova.bus.pack.service.impl.PackServiceImpl;
import cn.nova.bus.pack.service.impl.PackStockServiceImpl;
import cn.nova.bus.pack.service.impl.PackreturnbackServiceImpl;
import cn.nova.bus.pack.vo.PackStockVO;
import cn.nova.bus.security.Global;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class PackAction extends BaseAction{

	private List<Map<String, Object>> packlist;
	private List<Map<String, Object>> adjustresultlist;
	private Pack pack;
	private Packreturnback preturnback;
	private PackStockVO packStockVo;
	private PackIntegraterPay packIntegraterPay;
	private long packid;
	private int distance;// 行包里程
	private float weight;// 行包重量
	private long pieces;// 行包件数
	private float shipprice;// 托运费
	private float handfee;// 中转费

	private float toweight;// 最大公里
	private float fee;// 每件单价
	private float feekg;// 超重每千克单价

	private String param;

	private String billinusestatus;
	private long billinusenextno;
	private long billinusenextform;
	private String billtypecode;
	
	private String departinvoicesno;
	
	private Date startdate;
	private Date enddate;
	private long scheduleid;

	private List<Map<String, Object>> schedulemap;// 线路
	private List<Map<String, Object>> helpmap;// 登陆站点相关的站点

	private String msg;
//	private long flag;
	

	private PackService packService;
	private PackreturnbackService packreturnbackService;
	private PackStockService packStockService;
	//private PackIntegraterPayService packIntegraterPayService;
	private List<Map<String, Object>> qryPackBalancelist;
	private String newPackType;//新的行包包装类型
	private String packbalanceno;
	private Date senddepartdate;
	private Date sendenddate;
	private String status;
	private PackBalance packbalance;
	private Date arriverdate;
	private long vehicleid;
	private long unitid;
	private Date arriverenddate;
	private Long packbalanceid;
	private String ids;
	private String packno;
	private String isbukai;
	private String isreprint;
	private int tflag;
	private List<Map<String, Object>> qryPackArrive;
	private String packarriverno;
	private long packarriverid;
	private long packdepartinvoiceid;
	private String datatype;
	private List<Map<String, Object>> packBalanced;
	
	private String unitname;
	private Packdepartinvoices packdepartinvoices;
	private List<Map<String, Object>> qryPackDayBalance;
	
	private long orgid;//客户端用户的组织机构
	/**
	 * 行包结账单的注销
	 * @return
	 */
	public String cancelPackBalanced() {
		packService = new PackServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			packService.cancelPackBalanced(packbalanceid, global);
			setMsg("注销成功!");
			markSuccess();
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("注销失败！" + e.getMessage());
			markFail();
		}
		return "json";
	}
	/**
	 * 根据结账id查询明细
	 * @return
	 */
	public String qryDetail(){
		packService = new PackServiceImpl();
		packBalanced = packService.qryDetail(packbalanceid);
		return "json";
	}
	
	/**
	 * 行包已结账查询
	 * @return
	 */
	public String queryPackBalanced(){
		packService = new PackServiceImpl();
		packBalanced = packService.queryPackBalanced(senddepartdate,sendenddate,status,packbalanceno,datatype,unitname);
		return "json";
	}
	
	/**
	 * 行包结算单注销
	 * @return
	 */
	public String canclePackBalance(){
		Global global = CurrentUtil.getGlobal();
		try {
			packService = new PackServiceImpl();
			packService.canclePackBalance(packarriverid,tflag,packdepartinvoiceid,global);
			markSuccess();
			setMsg("注销成功！");
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
			setMsg("操作失败！"+ e.getMessage());
			markFail();
		}
		return "json";
	}
	
	/**
	 * 通过单号判断其状态
	 * @return
	 */
	public String qryBalanceByNo(){
		try {
			packService = new PackServiceImpl();
			msg = packService.qryBalanceByNo(departinvoicesno,tflag);
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	/**
	 * 根据单号查询行包结算单
	 */
	public String qryPackBalance(){
		packService = new PackServiceImpl();
		qryPackBalancelist = packService.qryPackBalance(packbalanceno,senddepartdate,sendenddate,status,ids,vehicleid,orgid);
		return "json";
	}
	/**
	 * 保存行包结算单
	 * @return
	 * @throws ServiceException 
	 */
	public String savePackBalance() throws ServiceException{
		packService = new PackServiceImpl();
		Global global = CurrentUtil.getGlobal();
		
		try {
			packbalance.setIds(packbalance.getIds().substring(0,packbalance.getIds().length()-1));
			PackBalance pb = packService.savePackBalance(global, packbalance);
			packbalanceno = pb.getPackbalanceno();
			setPackbalanceid(pb.getId());
			setMsg("结算成功！");
			markSuccess();
		} catch (Exception e) {
			setMsg("结算失败！"+e.getMessage());
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
  
		return "json"; 
	}
	/**
	 * 出库查询
	 * @return
	 */
	public String qryPackArrive(){
		packService = new PackServiceImpl();
		qryPackArrive = packService.qryPackArrive(departinvoicesno,arriverdate,vehicleid,status,arriverenddate,ids);
		return "json";
	}
	
	
	public String saveNewPackType(){
		packService = new PackServiceImpl();
		Global global = CurrentUtil.getGlobal();
		
		packService.saveNewPackType(global,newPackType);
		
		return "json";
	}

	public String listPack() {
		packService = new PackServiceImpl();
		setPacklist(packService.query(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		return "json";
	}

	/**
	 * 行包退票
	 * @return
	 */
	public String returnback(){
//		UserTransaction tr = new UserTransaction();
		Global global = CurrentUtil.getGlobal();
		boolean b = false;
		packService = new PackServiceImpl();
		packreturnbackService = new PackreturnbackServiceImpl();
		try{
//			tr.begin();
			packService.updatePackStatus(preturnback.getPackid()+"", "5");
			
			preturnback.setCreateby(CurrentUtil.getGlobal().getUserinfo().getId());
			preturnback.setCreatetime(new Date());
			preturnback.setUpdateby(CurrentUtil.getGlobal().getUserinfo().getId());
			preturnback.setUpdatetime(new Date());
			b = packreturnbackService.save(preturnback,global);
			if (b) {
				setMsg("行包退票成功！");
				markSuccess();
//				tr.commit();
			} else {
				setMsg("行包退票失败！");
				markFail();
			}
		} catch(Exception e){
			setMsg("行包退票失败！");
			markFail();
			play.Logger.error(e.getMessage(), e);
		}
		
		return "json";
	}
	
	public String listTotalPack() {
		packService = new PackServiceImpl();
		packStockService =  new PackStockServiceImpl();
		Global global = CurrentUtil.getGlobal();
		
		List<Map<String, Object>>  result = packService.queryTotal(global,startdate,enddate,scheduleid,isbukai);
		setPacklist(result);
		if (result != null && result.size() > 1) {
			try {
				setPackStockVo(packStockService.querystockscheduleBy(global,
						departinvoicesno, isbukai, isreprint, result,
						ServletPropertyFilterUtil.buildFromHttpRequest()));
			} catch (ServiceException e) {
				// TODO Auto-generated catch block
				play.Logger.error(e.getMessage(), e);
			}
		}
		
		return "json";
	}

	public String adjustPackinfo(){
		
		packService = new PackServiceImpl();
		Global global = CurrentUtil.getGlobal();
		setAdjustresultlist(packService.adjustPackinfo(global,startdate,enddate,scheduleid));		
		return "json";
	}

	public String savePack() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (pack != null) {
					if (pack.getId() != 0) {
						pack.setUpdateby(global.getUserinfo().getId());
						pack.setUpdatetime(new Date());
						setMsg("修改成功！");
					} else {
						pack.setCreateby(global.getUserinfo().getId());
						pack.setCreatetime(new Date());
						pack.setUpdateby(global.getUserinfo().getId());
						pack.setUpdatetime(new Date());
						setMsg("添加成功！");
					}
					packService = new PackServiceImpl();
					pack = packService.savePack(pack,packIntegraterPay);
					setPackid(pack.getId());
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

	public String savepaymentrecycle(){
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				packService = new PackServiceImpl();
				pack = packService.savepaymentrecycle(global,pack);
				setPackid(pack.getId());
				setMsg("操作成功！");
				markSuccess();
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
	
	public String wastePack() {
		Global global = CurrentUtil.getGlobal();
		try {
			pack.setUpdateby(global.getUserinfo().getId());
			pack.setUpdatetime(new Date());
			packService = new PackServiceImpl();
			packService.wastePack(pack, global.getUserinfo().getId());
			setMsg("废弃成功");
			markSuccess(); // 成功
		} catch (ServiceException e) {
			setMsg("废弃失败，" + e.getExceptionMessage());
			markFail(); // 
		}
		return "json";
	}

	public String queryPackfee() {
		Global global = CurrentUtil.getGlobal();
		if (global != null && global.getUserinfo().getId() > 0) {
			packService = new PackServiceImpl();
			Map<String, Float> packfees = packService.getShipprice(global
					.getUserinfo().getOrgid(), distance, weight, pieces);
			shipprice = packfees.get("TYF") == null ? 0 : packfees.get("TYF");
			//中转费*中转件数
			handfee = packfees.get("ZXF") == null ? 0 : packfees.get("ZXF") * pieces;

		}
		return "json";
	}

	public String queryDistance() {
		packService = new PackServiceImpl();
		setDistance(packService.queryDistance(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		return "json";
	}

	public String queryschedule() {
		packService = new PackServiceImpl();
		setSchedulemap(packService.queryschedule(param,
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String queryclient() {
		packService = new PackServiceImpl();
		setSchedulemap(packService.queryclient(param,
				ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}
	private long routeid;
	
	public long getRouteid() {
		return routeid;
	}
	public void setRouteid(long routeid) {
		this.routeid = routeid;
	}
	public String querytostation() {
		Global global = CurrentUtil.getGlobal();
		if (global != null && global.getUserinfo().getId() > 0) {
			packService = new PackServiceImpl();
			setHelpmap(packService.querystation(param, global.getOrganization()
					.getStation().getId(),routeid));
		}

		return "json";
	}

	/**
	 * 修改行包领用票据
	 */
	public String updateBillinuse() {
		try {
			Global global = CurrentUtil.getGlobal();
			if (global != null && global.getUserinfo().getId() > 0) {
				packService = new PackServiceImpl();
				packService.updateBillinuse(global.getUserinfo().getId(),
						billtypecode, billinusestatus, billinusenextno,
						billinusenextform);
				setMsg(""); // 成功
				markSuccess(); // 成功
			}
		} catch (ServiceException e) {
			setMsg("修改行包领用票据失败，" + e.getExceptionMessage());
			markFail(); // 成功
		}
		return "json";
	}

	/**
	 * 重打受理单时新添加一条记录同时把重打的数据改为废弃状态
	 */
	public String whackpack() {
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				if (pack != null) {
					pack.setUpdatetime(new Date());
					pack.setUpdateby(global.getUserinfo().getId());
					packService = new PackServiceImpl();
					pack = packService.whackpack(pack);
					setPackid(pack.getId());
					setMsg("");
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

	/**                                                          
	 * 行包转移                                                  
	 * @return                                                   
	 */                                                          
	public String transferPack(){                                
		Global global = CurrentUtil.getGlobal();                   
		try {                                                      
			if (global != null && global.getUserinfo().getId() > 0) {
				if (pack != null) {                                    
					packService = new PackServiceImpl();                 
					packService.transferPack(global,pack);               
					setMsg("行包转移操作成功!");                         
					markSuccess();                                       
				}                                                      
			}                                                        
		} catch (ServiceException ex) {                            
			setMsg(ex.getMessage());                                 
			markFail();                                              
		} catch (Exception ex) {                                   
			play.Logger.error(ex.getMessage(), ex);                  
			setMsg("行包转移操作失败！");                            
			markFail();                                              
		}                                                          
		return "json";                                             
	}  
	
	public String qryPackMonthBalance(){
		packService = new PackServiceImpl();
		setQryPackBalancelist(packService.qryPackMonthBalance(ServletPropertyFilterUtil
				.buildFromHttpRequest()));
		return "json"; 
	}
	
	
	
	public String qryPackDayBalance() {
		packService = new PackServiceImpl();
		setQryPackDayBalance(packService
				.qryPackDayBalance(ServletPropertyFilterUtil.buildFromHttpRequest()));
		return "json";
	}

	public String packDayBalanceaudit() {
		packService = new PackServiceImpl();
		Global global = CurrentUtil.getGlobal();
		packdepartinvoices = packService.qryPackDayBalancequery(packdepartinvoices);
		if (global != null && global.getUserinfo().getId() > 0) {	
			if (packdepartinvoices != null && packdepartinvoices.getId()>0) {
				if(packdepartinvoices.isIsaudit()){
					setMsg("该结算单号已审核！");
					markFail();
				}else{
					//更新
					packService.packDayBalanceaudit(global,packdepartinvoices);
					setMsg("单号 : "+packdepartinvoices.getDepartinvoicesno()+" 审核成功！");
					markSuccess();
				}
			}else{
				//单号不存在
				setMsg("该结算单号不存在！");
				markFail();
			}
		}
		return "json";
	}
	
	public List<Map<String, Object>> getQryPackDayBalance() {
		return qryPackDayBalance;
	}
	public void setQryPackDayBalance(List<Map<String, Object>> qryPackDayBalance) {
		this.qryPackDayBalance = qryPackDayBalance;
	}
	public Packdepartinvoices getPackdepartinvoices() {
		return packdepartinvoices;
	}
	public void setPackdepartinvoices(Packdepartinvoices packdepartinvoices) {
		this.packdepartinvoices = packdepartinvoices;
	}
	public List<Map<String, Object>> getPacklist() {
		return packlist;
	}

	public void setPacklist(List<Map<String, Object>> packlist) {
		this.packlist = packlist;
	}
	
	
	@Transient
	public Pack getPack() {
		return pack;
	}

	public void setPack(Pack pack) {
		this.pack = pack;
	}

	public long getPackid() {
		return packid;
	}

	public void setPackid(long packid) {
		this.packid = packid;
	}

	public String getMsg() {
		return msg;
	}

	public void setMsg(String msg) {
		this.msg = msg;
	}

//	public long getFlag() {
//		return flag;
//	}
//
//	public void setFlag(long flag) {
//		this.flag = flag;
//	}

	public int getDistance() {
		return distance;
	}

	public void setDistance(int distance) {
		this.distance = distance;
	}

	public List<Map<String, Object>> getSchedulemap() {
		return schedulemap;
	}

	public void setSchedulemap(List<Map<String, Object>> schedulemap) {
		this.schedulemap = schedulemap;
	}

	public List<Map<String, Object>> getHelpmap() {
		return helpmap;
	}

	public void setHelpmap(List<Map<String, Object>> helpmap) {
		this.helpmap = helpmap;
	}

	public float getToweight() {
		return toweight;
	}

	public void setToweight(float toweight) {
		this.toweight = toweight;
	}

	public float getFee() {
		return fee;
	}

	public void setFee(float fee) {
		this.fee = fee;
	}

	public float getFeekg() {
		return feekg;
	}

	public void setFeekg(float feekg) {
		this.feekg = feekg;
	}

	public float getWeight() {
		return weight;
	}

	public void setWeight(float weight) {
		this.weight = weight;
	}

	public long getPieces() {
		return pieces;
	}

	public void setPieces(long pieces) {
		this.pieces = pieces;
	}

	public float getShipprice() {
		return shipprice;
	}

	public void setShipprice(float shipprice) {
		this.shipprice = shipprice;
	}

	public long getBillinusenextno() {
		return billinusenextno;
	}

	public void setBillinusenextno(long billinusenextno) {
		this.billinusenextno = billinusenextno;
	}

	public String getBillinusestatus() {
		return billinusestatus;
	}

	public void setBillinusestatus(String billinusestatus) {
		this.billinusestatus = billinusestatus;
	}

	public String getParam() {
		return param;
	}

	public void setParam(String param) {
		this.param = param;
	}

	public String getBilltypecode() {
		return billtypecode;
	}

	public void setBilltypecode(String billtypecode) {
		this.billtypecode = billtypecode;
	}

	public long getBillinusenextform() {
		return billinusenextform;
	}

	public void setBillinusenextform(long billinusenextform) {
		this.billinusenextform = billinusenextform;
	}



	public float getHandfee() {
		return handfee;
	}


	public void setHandfee(float handfee) {
		this.handfee = handfee;
	}


	public PackIntegraterPay getPackIntegraterPay() {
		return packIntegraterPay;
	}

	public void setPackIntegraterPay(PackIntegraterPay packIntegraterPay) {
		this.packIntegraterPay = packIntegraterPay;
	}


	public PackStockVO getPackStockVo() {
		return packStockVo;
	}


	public void setPackStockVo(PackStockVO packStockVo) {
		this.packStockVo = packStockVo;
	}

	public Packreturnback getPreturnback() {
		return preturnback;
	}

	public void setPreturnback(Packreturnback preturnback) {
		this.preturnback = preturnback;
	}

	public String getDepartinvoicesno() {
		return departinvoicesno;
	}


	public void setDepartinvoicesno(String departinvoicesno) {
		this.departinvoicesno = departinvoicesno;
	}


	public Date getStartdate() {
		return startdate;
	}


	public void setStartdate(Date startdate) {
		this.startdate = startdate;
	}


	public Date getEnddate() {
		return enddate;
	}


	public void setEnddate(Date enddate) {
		this.enddate = enddate;
	}


	public long getScheduleid() {
		return scheduleid;
	}

	public void setScheduleid(long scheduleid) {
		this.scheduleid = scheduleid;
	}

	public String getNewPackType() {
		return newPackType;
	}

	public void setNewPackType(String newPackType) {
		this.newPackType = newPackType;
	}
	public String getPackbalanceno() {
		return packbalanceno;
	}
	public void setPackbalanceno(String packbalanceno) {
		this.packbalanceno = packbalanceno;
	}
	public Date getSenddepartdate() {
		return senddepartdate;
	}
	public void setSenddepartdate(Date senddepartdate) {
		this.senddepartdate = senddepartdate;
	}
	public Date getSendenddate() {
		return sendenddate;
	}
	public void setSendenddate(Date sendenddate) {
		this.sendenddate = sendenddate;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public PackBalance getPackbalance() {
		return packbalance;
	}
	public void setPackbalance(PackBalance packbalance) {
		this.packbalance = packbalance;
	}
	public Date getArriverdate() {
		return arriverdate;
	}
	public void setArriverdate(Date arriverdate) {
		this.arriverdate = arriverdate;
	}
	public long getVehicleid() {
		return vehicleid;
	}
	public void setVehicleid(long vehicleid) {
		this.vehicleid = vehicleid;
	}
	public long getUnitid() {
		return unitid;
	}
	public void setUnitid(long unitid) {
		this.unitid = unitid;
	}
	public Date getArriverenddate() {
		return arriverenddate;
	}
	public void setArriverenddate(Date arriverenddate) {
		this.arriverenddate = arriverenddate;
	}
	public Long getPackbalanceid() {
		return packbalanceid;
	}
	public void setPackbalanceid(Long packbalanceid) {
		this.packbalanceid = packbalanceid;
	}
	public List<Map<String, Object>> getQryPackBalancelist() {
		return qryPackBalancelist;
	}
	public void setQryPackBalancelist(List<Map<String, Object>> qryPackBalancelist) {
		this.qryPackBalancelist = qryPackBalancelist;
	}
	public String getIds() {
		return ids;
	}
	public void setIds(String ids) {
		this.ids = ids;
	}
	public String getPackno() {
		return packno;
	}
	public void setPackno(String packno) {
		this.packno = packno;
	}
	public int getTflag() {
		return tflag;
	}
	public void setTflag(int tflag) {
		this.tflag = tflag;
	}
	public List<Map<String, Object>> getQryPackArrive() {
		return qryPackArrive;
	}
	public void setQryPackArrive(List<Map<String, Object>> qryPackArrive) {
		this.qryPackArrive = qryPackArrive;
	}
	public String getIsbukai() {
		return isbukai;
	}
	public void setIsbukai(String isbukai) {
		this.isbukai = isbukai;
	}
	public String getIsreprint() {
		return isreprint;
	}

	public void setIsreprint(String isreprint) {
		this.isreprint = isreprint;
	}

	public String getPackarriverno() {
		return packarriverno;
	}

	public void setPackarriverno(String packarriverno) {
		this.packarriverno = packarriverno;
	}

	public List<Map<String, Object>> getAdjustresultlist() {
		return adjustresultlist;
	}

	public void setAdjustresultlist(List<Map<String, Object>> adjustresultlist) {
		this.adjustresultlist = adjustresultlist;
	}

	public long getPackarriverid() {
		return packarriverid;
	}

	public void setPackarriverid(long packarriverid) {
		this.packarriverid = packarriverid;
	}

	public long getPackdepartinvoiceid() {
		return packdepartinvoiceid;
	}

	public void setPackdepartinvoiceid(long packdepartinvoiceid) {
		this.packdepartinvoiceid = packdepartinvoiceid;
	}

	public String getDatatype() {
		return datatype;
	}

	public void setDatatype(String datatype) {
		this.datatype = datatype;
	}

	public List<Map<String, Object>> getPackBalanced() {
		return packBalanced;
	}

	public void setPackBalanced(List<Map<String, Object>> packBalanced) {
		this.packBalanced = packBalanced;
	}

	public String getUnitname() {
		return unitname;
	}

	public void setUnitname(String unitname) {
		this.unitname = unitname;
	}
	public long getOrgid() {
		return orgid;
	}
	public void setOrgid(long orgid) {
		this.orgid = orgid;
	}
	

}
