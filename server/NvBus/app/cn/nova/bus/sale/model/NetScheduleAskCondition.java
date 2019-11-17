package cn.nova.bus.sale.model;

import java.io.Serializable;
import java.util.Date;

/**
 * 班次查询条件类
 * @author ice
 *
 */
public class NetScheduleAskCondition implements Serializable {
	private static final long serialVersionUID = 5775448520936437220L;
	private Date departDate;
	private String departStationcode;
	private String reachStationcode;
	private String orgcode;
	private String sellway;
	
	private String districtcode;//按区域查询发车站的班次
	
	
	/**
	 * 
	 * @param departDate 发车日期
	 */
	public void setDepartDate(Date deaprtDate) {
		this.departDate = deaprtDate;
	}
	
	/**
	 * 
	 * @return 发车日期
	 */
	public Date getDepartDate() {
		return departDate;
	}
	

	public void setDepartStationcode(String departStationcode) {
		this.departStationcode = departStationcode;
	}

	public String getDepartStationcode() {
		return departStationcode;
	}

	public void setReachStationcode(String reachStationcode) {
		this.reachStationcode = reachStationcode;
	}

	public String getReachStationcode() {
		return reachStationcode;
	}

	public void setSellway(String sellway) {
		this.sellway = sellway;
	}

	public String getSellway() {
		return sellway;
	}

	public String getOrgcode() {
		return orgcode;
	}

	public void setOrgcode(String orgcode) {
		this.orgcode = orgcode;
	}

	public String getDistrictcode() {
		return districtcode;
	}

	public void setDistrictcode(String districtcode) {
		this.districtcode = districtcode;
	}

}
