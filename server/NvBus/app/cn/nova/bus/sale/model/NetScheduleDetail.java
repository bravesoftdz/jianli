package cn.nova.bus.sale.model;

public class NetScheduleDetail extends NetScheduleAskCondition{
	
	private String departtime;
	
	private String schedulesynccode;
	
	private long scheduleplanid;
	
	private String worktype;
	
	private long flag;
	
	private boolean islinework;
	
	

	public long getFlag() {
		return flag;
	}

	public void setFlag(long flag) {
		this.flag = flag;
	}

	public String getDeparttime() {
		return departtime;
	}

	public void setDeparttime(String departtime) {
		this.departtime = departtime;
	}

	public String getSchedulesynccode() {
		return schedulesynccode;
	}

	public void setSchedulesynccode(String schedulesynccode) {
		this.schedulesynccode = schedulesynccode;
	}

	public long getScheduleplanid() {
		return scheduleplanid;
	}

	public void setScheduleplanid(long scheduleplanid) {
		this.scheduleplanid = scheduleplanid;
	}

	public String getWorktype() {
		return worktype;
	}

	public void setWorktype(String worktype) {
		this.worktype = worktype;
	}

	public boolean isIslinework() {
		return islinework;
	}

	public void setIslinework(boolean islinework) {
		this.islinework = islinework;
	}
	
}
