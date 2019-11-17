package models;

import java.io.Serializable;
import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.Date;

public class HeartBeatTime implements Serializable{

	public Date starttime;
	public Date endtime;

	public HeartBeatTime(Date currentTime) {
		this.starttime = currentTime;
		this.endtime = currentTime;
	}

	public HeartBeatTime() {

	}

}
