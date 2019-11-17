/****
 * 初始化生成页面
 */
package controllers.report;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import models.MetaForm;
import util.AppContrast;
import util.CommonUtil;
import util.JsonUtil;
import util.report.MetaUtils;

import bp.ReceiptDataBP;
import bp.report.FileDataBP;
import bp.report.UIBP;
import bpinterface.ReceiptDataInterface;
import bpinterface.report.FileDataInterface;
import bpinterface.report.UIInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

import controllers.Application;

public class UIAction extends Application {
	//动态列表页面
	public static void dynamicList(String formkey) throws Exception{
		UIInterface uibp = new UIBP();
		MetaForm form = MetaUtils.findFormByKey(formkey);
		
		String title = form.listtitle;
		String queryHtml = uibp.conditionHtml(form.columnid);
		String dgColumns = uibp.tableColumns(formkey);
		String options =  uibp.listModuleSettings(formkey);
		StringBuilder sb = new StringBuilder();
		sb.append("<!DOCTYPE html>")
		.append("<html>")
		.append("<head>")
		.append("<title>").append(title).append("</title>")
		.append("<meta charset=\"UTF-8\">")
		.append("<link rel=\"stylesheet\" media=\"screen\" href=\"/public/stylesheets/main.css\">")
		.append("<link rel=\"shortcut icon\" type=\"image/png\" href=\"/public/images/favicon.png\">")
		.append("<link rel=\"stylesheet\" href=\"/public/jquery-easyui-1.3.4/themes/default/easyui.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/bootstrap-3.0.3/css/bootstrap.min.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/bootstrap-3.0.3/css/bootstrap-datetimepicker.min.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/bootstrap-3.0.3/css/bootstrap-multiselect.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/stylesheets/dynamiclist.css\">")
		.append("</head>")
//弹出框位置		
		.append("<style>")
		.append(".modal-dialog{margin-top:").append(form.margintop).append("px}")
		.append("</style>")
		
		.append("<body>")
//查询条件
		.append(queryHtml);
//操作按钮
		sb.append("<div id=\"operate\">")
		.append("<span class=\"title\">操作</span>")
		.append("<button class=\"btn btn-primary\" id=\"search\" type=\"button\"><span class=\"glyphicon glyphicon-search\"></span> 查询</button>");
//		sb.append("<button class=\"btn btn-primary\" id=\"order\" type=\"button\"><span class=\"glyphicon glyphicon-order\"></span> 排序</button>");
		sb.append("<button class=\"btn btn-primary\" id=\"exportexcel\" type=\"button\"><span class=\"glyphicon glyphicon-export\"></span> 导出</button>");
		sb.append("<button class=\"btn btn-primary\" id=\"print\" type=\"button\"><span class=\"glyphicon glyphicon-print\"></span> 打印</button>");
		sb.append("</div>");
//数据列表
		sb.append("<div id=\"dataset\">").append("<table id=\"dg\"></table>").append("</div>");

		//导出文件弹出框
		sb.append("<div class=\"modal fade\" id=\"exportModal\" data-backdrop=\"static\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">")
		.append("<div class=\"modal-dialog\">")
		.append("<div class=\"modal-content\">")
		.append("<div class=\"modal-header\">")
		.append("<button class=\"close\" type=\"button\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>")
		.append("<h4 class=\"modal-title\" id=\"myModalLabel\">编辑导出文件</h4>")
		.append("</div>")
		.append("<div class=\"modal-body\">")
		.append("<div id=\"prompt\"></div>")
		.append("<div class=\"row\">")
		.append("<div class=\"col-xs-12\">")
		.append("<div class=\"form-group\">")
		.append("<label for=\"e_orgid\" class=\"col-xs-2 control-label\"><span class=\"mark\">*</span><span class=\"title\">文件名</span></label>")
		.append("<div class=\"col-xs-6\">")
		.append("<input type=\"text\" name=\"para.orgid\" id=\"exporturl\" class=\"form-control input-sm\">")
		.append("</div>")
		.append("<span class=\"col-xs-4\"></span>")
		.append("</div>")
		.append("</div>")
		.append("</div>")
		.append("</div>")
		.append("<div class=\"modal-footer\">")
		.append("<button class=\"btn btn-primary\" id=\"exportsave\" type=\"button\"><span class=\"glyphicon glyphicon-pencil\"></span> 确定</button>")
		.append("</div>")
		.append("</div>")
		.append("</div>")
		.append("</div>");
		
		sb.append("<script src=\"/public/javascripts/jquery-1.10.2.min.js\"></script>")
		.append("<script src=\"/public/jquery-easyui-1.3.4/jquery.easyui.min.js\"></script>")
		.append("<script src=\"/public/jquery-easyui-1.3.4/easyui-lang-zh_CN.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap.min.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap-datetimepicker.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap-datetimepicker.zh-CN.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap-multiselect.js\"></script>")
		.append("<script src=\"/public/javascripts/jquery.validate.min.js\"></script>")
		.append("<script src=\"/public/javascripts/extendValidation.js\"></script>")
		.append("<script src=\"/public/javascripts/json2.js\"></script>")
		.append("<script src=\"/public/javascripts/jquery.cookie.js\"></script>")
		.append("<script src=\"/public/javascripts/common.js\"></script>")
		.append("<script src=\"/public/javascripts/report/jquery.jqprint-0.3.js\"></script>")
		.append("<script src=\"/public/javascripts/report/jquery-migrate-1.1.0.js\"></script>")
		.append("<script src=\"/public/javascripts/report/dynamiclist.js\"></script>");
		if(CommonUtil.isNotEmptyString(form.listpagejs)){
			sb.append("<script src=\"/public/javascripts/").append(form.listpagejs).append("\"></script>");
		}
		
		sb.append("<script type=\"text/javascript\">")
		.append("var form = ").append(JSON.toJSONString(form)).append(";")
		.append("var columns = ").append(dgColumns).append(";")
		.append("var options = ").append(options).append(";")
		.append("</script>")
		.append("</body>")
		.append("</html>");
		renderHtml(sb.toString());
	}
	
	//动态列页面刷新
	public static void refurbishDynamicList(String formkey,String params) throws Exception{
		UIInterface uibp = new UIBP();
		String dgColumns = uibp.tableColumns(formkey);
		renderText(dgColumns);
	}

}
