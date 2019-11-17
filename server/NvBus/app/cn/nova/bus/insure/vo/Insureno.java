package cn.nova.bus.insure.vo;

import java.io.Serializable;

public class Insureno implements Serializable{ 
	private String etinsureno;
	private String insureno;
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
}
