/**
 * 
 */
package cn.nova.bus.sale.remote.param;

import java.io.Serializable;
import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Id;

/**
 * @author ice
 *
 */
@Entity
public class ParamStationOut implements Serializable {
	private static final long serialVersionUID = -4417613214998401561L;
	@Id
	private String stationcode;  //站点编码
	private String stationname;//客运站名称
	private String province;       //所属省（编码）
	private String provincename;   //所属省名称
	private String city;           //所属市（编码）
	private String cityname;       //所属市名称
	private Date updatetime;       //更新时间
	private String jianpin;
	
	public String getJianpin() {
		return jianpin;
	}
	public void setJianpin(String jianpin) {
		this.jianpin = jianpin;
	}
	public String getStationcode() {
		return stationcode;
	}
	public void setStationcode(String stationcode) {
		this.stationcode = stationcode;
	}
	public String getStationname() {
		return stationname;
	}
	public void setStationname(String stationname) {
		this.stationname = stationname;
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getProvincename() {
		return provincename;
	}
	public void setProvincename(String provincename) {
		this.provincename = provincename;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCityname() {
		return cityname;
	}
	public void setCityname(String cityname) {
		this.cityname = cityname;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
}
