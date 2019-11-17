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
 * 发车站信息
 */
@Entity
public class ParamDepartStationOut implements Serializable {
	private static final long serialVersionUID = -29586580147015974L;
	@Id
	private String stationcode;  //发车站点编码
	private String stationname;//发车站点名称
	private String province;       //所属省（编码）
	private String provincename;   //所属省名称
	private String city;           //所属市（编码）
	private String cityname;       //所属市名称
	private String address;        //发车站点地址  可为空
	private Date updatetime;       //更新时间
	
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
	public String getAddress() {
		return address;
	}
	public void setAddress(String address) {
		this.address = address;
	}
	public Date getUpdatetime() {
		return updatetime;
	}
	public void setUpdatetime(Date updatetime) {
		this.updatetime = updatetime;
	}
}
