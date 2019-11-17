package cn.nova.bus.pay.param;

import java.io.Serializable;

/**
  	dep_time	出发时间	String 	出发时间	必填	yyyy-mm-dd HH:mm:ss
	distance	距离	Integer	距离	可选	km 
	last_place_name	到达目的地	String	到达目的地	必填	上海
	start_city_name	出发城市	String	出发城市	必填	杭州
	start_province_name	出发省份	String	出发省份	可选	上海
	start_station_id	出发车站ID 	String	出发车站ID 	可选	1111
	start_station_name	出发车站名称	String 	出发车站名称	必填	上海虹桥车站
	to_station_city_name 	到达车站城市名称	String 	到达车站城市名称	可选	杭州
	to_station_id	到达车站ID	String 	到达车站ID	可选	111
	to_station_name	到达车站名称	String 	到达车站名称	可选	杭州总站
	to_station_province_name	到达车站省份	String 	到达车站省份	可选	浙江
	terminal	终点站名称	String 	终点站名称	可选	宁波
	bus_number	车次编号	String 	车次编号	可选	PT222
	start_station_address	车站地址	String 	车站地址	可选	xxx
 */

public class TvmBusLineInfo implements Serializable{
	private static final long serialVersionUID = 1L;
	
	private String dep_time;
	private Integer distance;
	private String last_place_name;
	private String start_city_name;
	private String start_province_name;
	private String start_station_id;
	private String start_station_name;
	private String to_station_city_name;
	private String to_station_id;
	private String to_station_name;
	private String to_station_province_name;
	private String terminal;
	private String bus_number;
	private String start_station_address;
	public String getDep_time() {
		return dep_time;
	}
	public void setDep_time(String dep_time) {
		this.dep_time = dep_time;
	}
	public Integer getDistance() {
		return distance;
	}
	public void setDistance(Integer distance) {
		this.distance = distance;
	}
	public String getLast_place_name() {
		return last_place_name;
	}
	public void setLast_place_name(String last_place_name) {
		this.last_place_name = last_place_name;
	}
	public String getStart_city_name() {
		return start_city_name;
	}
	public void setStart_city_name(String start_city_name) {
		this.start_city_name = start_city_name;
	}
	public String getStart_province_name() {
		return start_province_name;
	}
	public void setStart_province_name(String start_province_name) {
		this.start_province_name = start_province_name;
	}
	public String getStart_station_id() {
		return start_station_id;
	}
	public void setStart_station_id(String start_station_id) {
		this.start_station_id = start_station_id;
	}
	public String getStart_station_name() {
		return start_station_name;
	}
	public void setStart_station_name(String start_station_name) {
		this.start_station_name = start_station_name;
	}
	public String getTo_station_city_name() {
		return to_station_city_name;
	}
	public void setTo_station_city_name(String to_station_city_name) {
		this.to_station_city_name = to_station_city_name;
	}
	public String getTo_station_id() {
		return to_station_id;
	}
	public void setTo_station_id(String to_station_id) {
		this.to_station_id = to_station_id;
	}
	public String getTo_station_name() {
		return to_station_name;
	}
	public void setTo_station_name(String to_station_name) {
		this.to_station_name = to_station_name;
	}
	public String getTo_station_province_name() {
		return to_station_province_name;
	}
	public void setTo_station_province_name(String to_station_province_name) {
		this.to_station_province_name = to_station_province_name;
	}
	public String getTerminal() {
		return terminal;
	}
	public void setTerminal(String terminal) {
		this.terminal = terminal;
	}
	public String getBus_number() {
		return bus_number;
	}
	public void setBus_number(String bus_number) {
		this.bus_number = bus_number;
	}
	public String getStart_station_address() {
		return start_station_address;
	}
	public void setStart_station_address(String start_station_address) {
		this.start_station_address = start_station_address;
	}
	
}
