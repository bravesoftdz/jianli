package util;

public class RemoteApi {
	public final static String FIND_SCHEDULE = "/remote/schedule";
	public final static String FIND_SCHEDULEDETAIL = "/remote/scheduledetail";
	public final static String FIND_STOWAGESCHEDULEDETAIL = "/remote/stowagescheduledetail";
	public final static String FIND_STOWAGENETSCHEDULE = "/remote/stowagenetschedule";
	public final static String FIND_NETSOLDNUM = "/remote/netsoldnum";
	public final static String SELL_TICKET = "/remote/sell/ticket";
	public final static String LOCK_SEAT_Worktype3= "/remote/seat/lockWorktype3";//跨区配载到中心锁座
	public final static String LOCK_SEAT = "/remote/seat/lock";
	public final static String LOCK_SEAT_JXS = "/remote/seat/lockjx";
	public final static String CHANGE_TICKET_NO = "/remote/change/ticket/no";
	public final static String FIND_SCHEDULE_SEATS = "/remote/schedule/seats";
	public final static String FIND_TICKET_PRICES = "/remote/ticket/prices";
	public final static String UNLOCK_SEAT = "/remote/seat/unlock";
	public final static String UNLOCK_SEAT3 = "/remote/seat/unlockworktype3";//跨区配载班次到中心
	public final static String FIND_SCHEDULE_STOPS = "/remote/schedule/stops";
	public final static String FIND_SECTION_TICKET = "/remote/section/ticket";
	public final static String MODIFY_NETSCHDULE_STATUS = "/remote/scheduleplan/status";
	public final static String FIND_SECTION_TICKET_AND_CHECK_PRICE = "/remote/section/ticketp";
	public final static String FIND_SECTION_STATION_CENTER_SEATSINFO = "/remote/center/seatsinfo";//跨区配载班次综合调度-座位信息
	
	public final static String RETURN_TICKETS = "/remote/return/tickets";
	public final static String SCHEDULE_RETURN_TICKET = "/remote/schedule/return/tickets";
	public final static String FIND_TICKET_JXS = "/remote/tickets/jxs";

	public final static String SCHEDULE_CANCEL_TICKET = "/remote/schedule/cancel/tickets";
	public final static String CANCEL_TICKETS = "/remote/cancel/tickets";

	public final static String MIX_CHECK_TICKET = "/remote/mix/check";
	public final static String CANEL_CHECK_TICKET = "/remote/cancel/check";
	public final static String FIND_SEAT_INFO = "/remote/seat";
	public final static String FIND_SEAT_COUNT = "/remote/seatcount";
	public final static String QRY_ORG_SELL = "/remote/org/sell";
	public final static String CHECK_TICKET_SELL = "/remote/check/sell";
	public final static String CANCEL_REMOTE_CHECK = "/remote/check/cancel";
	public final static String FIND_TICKET_SELL = "/remote/ticket/sell";
	public final static String FIND_TICKET_SELL_BY_ORDERNO = "/remote/ticketsell/order";
	
	public final static String SEAT_RESERVE = "/remote/seat/reserve";
	public final static String CANCEL_RESERVE = "/remote/cancel/reserve";
	
	public final static String SCHEDULE_SELL_TICKET = "/remote/schedule/sell/ticket";
	public final static String SCHEDULE_SELL_TICKET3 = "/remote/schedule/sell/ticket3";
	public final static String CHECK_SEATNUM_MODIFY = "/remote/checkseatnummodify";//校验跨区配载班次是否能修改坐位
	
	public final static String NET_SEAT_RESERVE = "/remote/seat/netBookReserve";//联网订票
	
	public final static String CHANGE_TICKETS_O2L = "/remote/return/changeticket_O2L";//异售本改为本地票
	public final static String SCHEDULE_CHANGE_TICKET = "/remote/schedule/return/ticketschange3";//跨区配载改签
	
	public final static String UPDATE_SEATNUMS = "/remote/scheduleplan/updateseatnums";//综合调度，修改座位数
	
	public final static String SYNC_SCHEDULEPLAN = "/remote/syncscheduleplan";//综合调度-同步班次计划 
	
}
