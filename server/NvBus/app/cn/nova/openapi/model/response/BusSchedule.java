package cn.nova.openapi.model.response;


/**
 * @author Mark
 *
 */
public class BusSchedule extends BaseResponseModel {
	public Long id;
	public String departorgcode;
	public String schedulecode;
	public String departorgname;
	public String departtime;
	public String endtime;
	public String seattype;
	public int residualnumber;
	public int isaddschedule;
	public int islineschedule;
	public Double fullprice;
	public Double discountprice;
	public Double studentprice;
	public Double halfprice;
	public String reachstationcode;
	public String reachstationname;
	public String endstationname;
	public int runtime;
	public int rundistance;
	public String vehicletype;
	public int iscansell;
	public String waitingroom;
	public String ticketentrance;
}
