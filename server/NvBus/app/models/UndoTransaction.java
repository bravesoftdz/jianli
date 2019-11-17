package models;

import java.util.Date;

import util.JsonUtil;

public class UndoTransaction{
	public String id;
	public String ip;
	public int triggerTimes;
	public int cursorTimes;
	public Date createDate;
	
	public UndoTransaction(){
		triggerTimes = 1;
		createDate = new Date();
	}
	
	public UndoTransaction(String id, String ip){
		this.id = id;
		this.ip = ip;
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
	
	public static UndoTransaction parseFromString(String str){
		return JsonUtil.parseObject(str, UndoTransaction.class);
	}
	
	public void incrementCursorTimes(){
		this.cursorTimes++;
	}
}
