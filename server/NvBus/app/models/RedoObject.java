package models;

import java.util.Date;
import java.util.Map;

import util.JsonUtil;
import cn.nova.bus.dispatch.model.Seatreserve;
import cn.nova.bus.security.Global;

public class RedoObject {
	public Seatreserve seatreserve;
	public String seatnos;
	
	public Map<String, String> requestMap;
	public String ip;
	
	public long checkstationid;
	public  String ticketno;
	public  Global global;
	public  int iscancelold;
	
	public int triggerTimes;
	public int cursorTimes;
	public Date createDate;
	public boolean isRemote;
	
	public RedoObject(){
		init();
	}
	
	public RedoObject(long checkstationid, String ticketno,Global global,int iscancelold){
		this.checkstationid = checkstationid;
		this.ticketno = ticketno;
		this.global = global;
		this.iscancelold = iscancelold;
	}
	
	public RedoObject(Map<String, String> requestMap, String ip){
		init();
		this.requestMap = requestMap;
		this.ip = ip;
	}
	
	public RedoObject(Map<String, String> requestMap, String ip, boolean isRmote){
		init();
		this.requestMap = requestMap;
		this.ip = ip;
		this.isRemote = isRmote;
	}
	
	public RedoObject(Seatreserve seatreserve, String seatnos){
		init();
		this.seatreserve = seatreserve;
		this.seatnos = seatnos;
	}
	
	private void init(){
		triggerTimes = 1;
		createDate = new Date();
	}
	
	public boolean isTouched(){
		return triggerTimes == cursorTimes;
	}
	
	public void nextTrigger(){
		cursorTimes = 0;
		triggerTimes = triggerTimes * 2;
	}
	
	public String toJson(){
		return JsonUtil.toSimpleString(this);
	}
	
	public static RedoObject parseFromString(String str){
		return JsonUtil.parseObject(str, RedoObject.class);
	}
	
	public void incrementCursorTimes(){
		this.cursorTimes++;
	}
	
	public void setIp(String ip){
		if(!ip.startsWith("http")){
			ip = "http://" + ip;
		}
		this.ip = ip;
	}
}
