package models;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;
import java.util.UUID;

import javax.persistence.Entity;
import javax.persistence.Id;
import javax.persistence.Table;

import play.db.jpa.GenericModel;
import play.mvc.Http.Request;
import util.JsonUtil;
import util.TransactionUtil.TransactionType;

@Entity
@Table(name = "remotetransaction")
public class RemoteTransaction extends GenericModel{
	@Id
	public String id;
	public int status;
	public int type;
	public String requestjson;
	public String formip;
	public String toip;
	public Date createDate;
	
	public RemoteTransaction(){
		createDate = new Date();
	}
	
	public static RemoteTransaction makeRemoteTransaction(TransactionType transactionType){
		return makeRemoteTransaction(UUID.randomUUID().toString(), transactionType);
	}

	public static RemoteTransaction makeRemoteTransaction(String remoteTransactionId, TransactionType transactionType){
		RemoteTransaction remoteTransaction = new RemoteTransaction();
		remoteTransaction.id = remoteTransactionId;
		remoteTransaction.formip = Request.current().remoteAddress;
		remoteTransaction.type = transactionType.ordinal();
		remoteTransaction.createDate = new Date();
		return remoteTransaction;
	}
}
