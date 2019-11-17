package util;

public class EpayUrlApi {
	// 获取平台订单号
	public final static String EPAY_GET_PAYORDERNO = "/payorderno";
	// 支付服务器支付接口
	public final static String EPAY_PAYMONEY = "/pays/createpayparam1";
	// 查询支付结果接口
	public final static String EPAY_QUERYPAYRESULT = "/pays/queryPayResult";
	// 退款接口
	public final static String EPAY_REFUNDMONEY = "/refundMoney/1";
	// 将票的信息推送给飞猪接口
	public final static String EPAY_THREE_CREATEORDER = "/three/createorder";
	// 通知出票结果接口
	public final static String EPAY_THREE_BOOKORDER = "/three/bookorder";
	//查询通知出票结果的结果接口
	public final static String EPAY_QUERY_BOOKORDERRESULT = "/three/isbookticket";
	

	// 返回UrL
	public static String allUrl(String ip, String url) {
		return ip + url;
	}

}
