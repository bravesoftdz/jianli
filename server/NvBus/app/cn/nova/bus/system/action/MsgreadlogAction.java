package cn.nova.bus.system.action;

import cn.nova.bus.action.BaseAction;
import java.util.List;
import java.util.Map;

import cn.nova.bus.system.model.Msgreadlog;
import cn.nova.bus.system.service.MsgreadlogService;
import cn.nova.bus.system.service.impl.MsgreadlogServiceImpl;

public class MsgreadlogAction extends BaseAction{
	private MsgreadlogService msgreadlogservice;
	private List<Map<String, Object>> resultmap; 	
	private Msgreadlog msgreadlog;
	
	/**
	 * 查询最后一条需要提醒的升级日志
	 * @return
	 */
	public String QryUpgradereadlog(){
		msgreadlogservice = new MsgreadlogServiceImpl();
		setResultmap(msgreadlogservice.queryUpgradereadlog());		
		return "json";		
	}
	
	/**
	 * 查询升级日志表和日志读取记录表，用于判断是否需要弹窗提示
	 * @return
	 */
	public String isneedRead(){
		msgreadlogservice = new MsgreadlogServiceImpl();
		if(msgreadlogservice.isNeedReadMsg()){
			markSuccess();
		}else{
			markFailure();
		}
		return "json";		
	}
	
	/**
	 * 保存日志读取记录
	 * @return
	 */
	public String saveReadlog(){
		msgreadlogservice = new MsgreadlogServiceImpl();
		if(msgreadlogservice.savaMsgreadlog(msgreadlog)){
			markSuccess();
			msg ="保存信息阅读记录成功";
		}else{
			markFailure();
			msg ="保存信息阅读记录失败";
		}		
		return "json";
	}

	public List<Map<String, Object>> getResultmap() {
		return resultmap;
	}

	public void setResultmap(List<Map<String, Object>> resultmap) {
		this.resultmap = resultmap;
	}

	public Msgreadlog getMsgreadlog() {
		return msgreadlog;
	}

	public void setMsgreadlog(Msgreadlog msgreadlog) {
		this.msgreadlog = msgreadlog;
	}

}
