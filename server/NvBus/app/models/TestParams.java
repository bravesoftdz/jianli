package models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.SequenceGenerator;
import javax.persistence.Table;

import play.Play;
import play.db.jpa.GenericModel;
import util.AppConstant;
import util.JsonUtil;
import util.RedisUtil;
import util.RedisUtil.RedisDBApp;

public class TestParams{
	public int sellTicket;
	public int cancelTicket;
	public int returnTicket;
	
	public int reserveSeat;
	public int cancelSeat;
	
	public int mixCheck;
	public int cancelCheck;
	
	public int remoteSellTicket;
	public int remoteCancelTicket;
	public int remoteReturnTicket;
	
	private void saveTestParams4Cache(){
		String jsonParams = JsonUtil.toSimpleString(this);
		RedisUtil.set(RedisDBApp.temp, "TestParams4RemoteCallB" + AppConstant.getValue("app.maccode"), jsonParams);
	}
	
	public static TestParams getNewest(){
		String jsonParams = RedisUtil.get(RedisDBApp.temp, "TestParams4RemoteCallB" + AppConstant.getValue("app.maccode"));
		TestParams tp = null;
		if(jsonParams == null){
			tp = new TestParams();
			tp.saveTestParams4Cache();
		}else{
			try{
				tp = JsonUtil.parseObject(jsonParams, TestParams.class);
			}catch(Exception e){
				tp = new TestParams();
				tp.saveTestParams4Cache();
			}
		}
		return tp;
	}
	
	
	public void save(){
		saveTestParams4Cache();
	}
}
