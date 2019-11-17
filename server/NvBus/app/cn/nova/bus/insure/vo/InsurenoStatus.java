package cn.nova.bus.insure.vo;

import java.io.Serializable;

public class InsurenoStatus implements Serializable{ 
	private String etinsureno;
	private String insureno;
	private String status;
	private String message;
	public String getEtinsureno() {
		return etinsureno;
	}
	public void setEtinsureno(String etinsureno) {
		this.etinsureno = etinsureno;
	}
	public String getInsureno() {
		return insureno;
	}
	public void setInsureno(String insureno) {
		this.insureno = insureno;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
}
