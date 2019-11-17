package cn.nova.bus.sale.model;

public class ScheduleDetail extends ScheduleAskCondition {
	private String departtime;
	
	private long scheduleplanid;
	
	private String schedulesynccode;
	
	private String worktype;
	
	private boolean islinework;
	
	private long flag;
	
	

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

	public String getSchedulesynccode() {
		return schedulesynccode;
	}

	public void setSchedulesynccode(String schedulesynccode) {
		this.schedulesynccode = schedulesynccode;
	}

	

	
	
}
