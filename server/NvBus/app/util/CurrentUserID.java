package util;

public class CurrentUserID {
	
	private static long id;
	
	private static long orgid;

	public static long getId() {
		return id;
	}

	public static void setId(long id) {
		CurrentUserID.id = id;
	}

	public static long getOrgid() {
		return orgid;
	}

	public static void setOrgid(long orgid) {
		CurrentUserID.orgid = orgid;
	}
	
	
}
