package cn.nova.bus.archive.action;

import cn.nova.bus.action.BaseAction;
import java.sql.Timestamp;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.persistence.Transient;

import util.CurrentUtil;
import cn.nova.bus.archive.model.Steward;
import cn.nova.bus.archive.model.Stewardworkexperience;
import cn.nova.bus.archive.service.StewardService;
import cn.nova.bus.archive.service.impl.StewardServiceImpl;
import cn.nova.bus.exception.ServiceException;
import cn.nova.bus.security.Global;
import cn.nova.utils.encode.ConversionUtil;
import cn.nova.utils.web.ServletPropertyFilterUtil;

public class StewardAction extends BaseAction{
	StewardService stewardservice;
	
	private Steward steward;
	private Stewardworkexperience stewardworkexperience;
	private long stewardid;
	private String pictures;
	private String isfinger;
	//返回结果
	private List<Map<String,Object>>  stewardmap;
	private List<Map<String,Object>>  workmap;
	private List<Map<String,Object>>  stewardpicture;
	private long stewadid;
	private long sworkid;
	private long delid;
	
	public String saveStewardFinger() {
		stewardservice = new StewardServiceImpl();
		Global global = CurrentUtil.getGlobal();
		try {
			if (global != null && global.getUserinfo().getId() > 0) {
				byte[] bb = ConversionUtil.toByteArr(pictures);
				steward.setFingerprint1(bb);
				stewardservice.saveStewardFinger(steward);
				msg = "添加成功！";
				markSuccess();  //成功
			}
		} catch (ServiceException se) {
			setMsg(se.getMessage());
			markFail();  //
		} catch (Exception ex) {
			ex.printStackTrace();
			msg = "操作失败！";
			markSuccess();  //成功
		}
		return "json";

	}
	public String queryStewardFinger(){
		stewardservice = new StewardServiceImpl();
		try{
			stewardpicture=(stewardservice.queryStewardFinger());			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "json";
	}
	public String saveSteward(){
		stewardservice = new StewardServiceImpl();
		Steward s = null;
		String show ="";
		try{
			Global global = CurrentUtil.getGlobal();

		byte[] pc=ConversionUtil.toByteArr(pictures);
		steward.setPicture(pc);		
		steward.setIsactive(true);
		if(steward.getId() != 0 ){
			steward.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			steward.setUpdateby(global.getUserinfo().getId());
			steward.setCreateby(global.getUserinfo().getId());
			steward.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			show="修改";
		}else{
			steward.setCreateby(global.getUserinfo().getId());
			steward.setCreatetime(new Timestamp(System.currentTimeMillis()));	
			steward.setUpdatetime(new Timestamp(System.currentTimeMillis()));
			steward.setUpdateby(global.getUserinfo().getId());
			show="保存";
		}
		s = stewardservice.saveSteward(steward);
		if(s!=null){
			stewadid = s.getId();
			setMsg(show+"成功");
			markSuccess();
		}else{
			setMsg(show+"失败");
			markFail();
		}
		}catch(ServiceException ex){
			setMsg(show+"失败" +ex.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String findSteward(){
		stewardservice = new StewardServiceImpl();
		try{
			 setStewardmap(stewardservice.querySteward(ServletPropertyFilterUtil.buildFromHttpRequest(),isfinger));			
		} catch (Exception e) {
				play.Logger.error(e.getMessage(), e);
		}
		
		return "json";
	}
	
	public String saveStewardWork(){
		stewardservice = new StewardServiceImpl();
		Stewardworkexperience swk =null;
		String show="";
		try{
			Global global = CurrentUtil.getGlobal();
			if(stewardworkexperience.getId() != 0){
				stewardworkexperience.setIsactive(true);
				stewardworkexperience.setUpdatetime(new Date());
				stewardworkexperience.setUpdateby(global.getUserinfo().getId());
				show="修改";
			}else{
				stewardworkexperience.setIsactive(true);
				stewardworkexperience.setCreateby(global.getUserinfo().getId());
				stewardworkexperience.setCreatetime(new Date());	
				stewardworkexperience.setUpdatetime(new Date());
				stewardworkexperience.setUpdateby(global.getUserinfo().getId());
				show = "保存";
			}
			swk = stewardservice.saveworkexperience(stewardworkexperience);
			if(swk != null){
				sworkid = swk.getId();
				setMsg(show+"成功");
				markSuccess();
			}else{
				setMsg(show+"失败");
				markFail();
			}
		}catch(Exception ex){
			setMsg(show+"失败");
			markFail();
		}
		return "json";
	}
	
	public String findStewardworkexperience(){
		stewardservice = new StewardServiceImpl();
		try{
			setWorkmap(stewardservice.queryWork(ServletPropertyFilterUtil.buildFromHttpRequest()));
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}

	public String delSteward(){
		stewardservice = new StewardServiceImpl();
		try {
			stewardservice.delSteward(stewardid);
			setMsg("删除乘务员成功");
			markSuccess();
		} catch (ServiceException e) {
			setMsg("删除乘务员失败，"+e.getExceptionMessage());
			markFail();
		}
		return "json";
	}
	
	public String delStewardwork(){
		stewardservice = new StewardServiceImpl();
		if(stewardservice.delworkexperience(delid)){
			setMsg("删除乘务员工作经验成功");
			markSuccess();
		}else{
			setMsg("删除乘务员工作经验失败，");
			markFail();
		}
		
		return "json";
	}
	
	public String findStewardPicture(){
		stewardservice = new StewardServiceImpl();
		try{
			setStewardpicture(stewardservice.findPicturebyId(ServletPropertyFilterUtil.buildFromHttpRequest()));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	//根据乘务员id查询乘务员
	public String findStewardBystewardid(){
		stewardservice = new StewardServiceImpl();
		try{
			setStewardmap(stewardservice.findStewardBystewardid(stewardid));			
		} catch (Exception e) {
			play.Logger.error(e.getMessage(), e);
		}
		return "json";
	}
	
	
	@Transient
	public Steward getSteward() {
		return steward;
	}

	public void setSteward(Steward steward) {
		this.steward = steward;
	}

	@Transient
	public Stewardworkexperience getStewardworkexperience() {
		return stewardworkexperience;
	}

	public void setStewardworkexperience(Stewardworkexperience stewardworkexperience) {
		this.stewardworkexperience = stewardworkexperience;
	}

	public List<Map<String, Object>> getStewardmap() {
		return stewardmap;
	}

	public void setStewardmap(List<Map<String, Object>> stewardmap) {
		this.stewardmap = stewardmap;
	}

	public List<Map<String, Object>> getWorkmap() {
		return workmap;
	}

	public void setWorkmap(List<Map<String, Object>> workmap) {
		this.workmap = workmap;
	}

	public long getStewardid() {
		return stewardid;
	}

	public void setStewardid(long stewardid) {
		this.stewardid = stewardid;
	}

	public long getDelid() {
		return delid;
	}

	public void setDelid(long delid) {
		this.delid = delid;
	}

	public String getPictures() {
		return pictures;
	}

	public void setPictures(String pictures) {
		this.pictures = pictures;
	}
	
	public List<Map<String, Object>> getStewardpicture() {
		return stewardpicture;
	}

	public long getStewadid() {
		return stewadid;
	}

	public void setStewadid(long stewadid) {
		this.stewadid = stewadid;
	}

	public long getSworkid() {
		return sworkid;
	}

	public void setSworkid(long sworkid) {
		this.sworkid = sworkid;
	}

	public void setStewardpicture(List<Map<String, Object>> stewardpicture) {
		this.stewardpicture = stewardpicture;
	}
	public String getIsfinger() {
		return isfinger;
	}
	public void setIsfinger(String isfinger) {
		this.isfinger = isfinger;
	}
	
}
