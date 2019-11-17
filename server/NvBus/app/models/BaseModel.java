/**
 * 
 */
package models;

import java.util.Date;

import javax.persistence.MappedSuperclass;

import play.db.jpa.GenericModel;

/**
 *	基本model类
 */
@SuppressWarnings("serial")
@MappedSuperclass
public class BaseModel extends GenericModel {
	
	public Date createtime;
	public Date updatetime;
	public Long createby;
	public Long updateby;
	
	public void createStamp() throws Exception{
		this.createtime = new Date();
		//this.createby = CurrentUtil.getUserId();
		this.updatetime = new Date();
		//this.updateby = CurrentUtil.getUserId();
	}
	
	public void updateStamp() throws Exception{
		this.updatetime = new Date();
		//this.updateby = CurrentUtil.getUserId();
	}
	
	public void createStamp(boolean issysuser) throws Exception{
		this.createtime = new Date();
		if(issysuser){
			this.createby = 0L;
		}else{
//			this.createby = CurrentUtil.getUserId();
		}
		updateStamp(issysuser);
	}
	
	public void updateStamp(boolean issysuser) throws Exception{
		this.updatetime = new Date();
		if(issysuser){
			this.updateby = 0L;
		}else{
//			this.updateby = CurrentUtil.getUserId();
		}
	}
	
	public void stamp() throws Exception{
		if(this.createby == null){
			createStamp();
		}else{
			updateStamp();
		}		
	}
}
