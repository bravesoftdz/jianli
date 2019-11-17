package controllers;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.Table;

import models.AccessLog;
import play.mvc.After;
import play.mvc.Before;
import play.mvc.Controller;
import play.mvc.Scope;
import util.AppConstant;
import util.JsonUtil;
import cn.nova.utils.commons.MethodResult;
public class BaseController extends Controller {
	@Before
	public static void AccessLogInterceptorIn(){
		StringBuilder sb = new StringBuilder("[Request in");
		sb.append(",ip=").append(request.remoteAddress);
		sb.append(",method=").append(request.url);
		sb.append(",params=").append(JsonUtil.toSimpleString(Scope.Params.current().all())).append("]");
		String logs = sb.toString();
		if(logs.length() > 256){
			logs = logs.substring(0,256);
		}
		play.Logger.info(logs);
	}
	
	protected static void renderResult(MethodResult methodResult) {
		renderText(JsonUtil.toFormatString(methodResult));
	}
	
	@After
	public static void AccessLogInterceptorOut(){
		StringBuilder sb = new StringBuilder("[Request out");
		sb.append(",ip=").append(request.remoteAddress);
		sb.append(",method=").append(request.url);
		play.Logger.info(sb.toString());	
	}
}
