/****
 * 初始化生成页面
 */
package controllers;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import models.MetaForm;
import util.AppContrast;
import util.CommonUtil;
import util.JsonUtil;
import bp.FileDataBP;
import bp.ReceiptDataBP;
import bp.UIBP;
import bpinterface.FileDataInterface;
import bpinterface.ReceiptDataInterface;
import bpinterface.UIInterface;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.serializer.SerializerFeature;

public class UIAction extends Application {
	//动态列表页面
	public static void dynamicList(String formkey) throws Exception{
		UIInterface uibp = new UIBP();
		MetaForm form = uibp.findFormByKey(formkey);
		int formtype = form.formtype.intValue();
		
		String title = form.listtitle;
		String editTitle = form.formtitle;
		String dgColumns = uibp.tableColumns(formkey);
		String options =  uibp.listModuleSettings(formkey);
		String queryHtml = uibp.conditionHtml(form.columnid);
		String operateHtml = uibp.operateHtml(formkey);
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
		if(formtype == AppContrast.FORM_FILE || formtype == AppContrast.FORM_RECEIPT){
			sb.append("<button class=\"btn btn-primary\" id=\"add\" type=\"button\"><span class=\"glyphicon glyphicon-plus\"></span> 新增</button>")
			.append("<button class=\"btn btn-primary\" id=\"modify\" type=\"button\"><span class=\"glyphicon glyphicon-edit\"></span> 修改</button>")
			.append("<button class=\"btn btn-primary\" id=\"delete\" type=\"button\"><span class=\"glyphicon glyphicon-trash\"></span> 删除</button>")
//动态生成扩展按钮	
			.append(operateHtml);
		}
		sb.append("<button class=\"btn btn-primary\" id=\"exportexcel\" type=\"button\"><span class=\"glyphicon glyphicon-export\"></span> 导出</button>");
		sb.append("<button class=\"btn btn-primary\" id=\"print\" type=\"button\"><span class=\"glyphicon glyphicon-print\"></span> 打印</button>");
		sb.append("</div>");
//数据列表
		sb.append("<div id=\"dataset\">").append("<table id=\"dg\"></table>").append("</div>");
//编辑弹出框
		if(form.formtype.intValue() == AppContrast.FORM_FILE){
			String editHtml = uibp.formHtml(formkey);
			sb.append("<div class=\"modal fade\" id=\"dynamicModal\" data-backdrop=\"static\" tabindex=\"-1\" role=\"dialog\" aria-labelledby=\"myModalLabel\" aria-hidden=\"true\">")
			.append("<div class=\"modal-dialog\">")
			.append("<div class=\"modal-content\">")
			.append("<div class=\"modal-header\">")
			.append("<button class=\"close\" type=\"button\" data-dismiss=\"modal\" aria-hidden=\"true\">&times;</button>")
			.append("<h4 class=\"modal-title\" id=\"myModalLabel\">").append(editTitle).append("</h4>")
			.append("</div>")
			.append("<div class=\"modal-body\">")
			.append("<form id=\"editform\">")
			.append("<div id=\"prompt\"></div>")
			.append("<div class=\"row\">")
//动态生成页面	
			.append(editHtml)
			.append("</div>")
			.append("</form>")
			.append("</div>")
			.append("<div class=\"modal-footer\">")
			.append("<button class=\"btn btn-primary\" id=\"save\" type=\"button\"><span class=\"glyphicon glyphicon-pencil\"></span> 保存</button>")
			.append("<button class=\"btn btn-primary\" type=\"button\" data-dismiss=\"modal\"><span class=\"glyphicon glyphicon-remove\"></span> 关闭</button>")
			.append("</div>")
			.append("</div>")
			.append("</div>")
			.append("</div>");
		}
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
		.append("<script src=\"/public/javascripts/dynamiclist.js\"></script>");
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

	//动态编辑页面
	public static void dynamicEdit(String formkey,Long id){
		UIInterface uibp = new UIBP();
		FileDataInterface filebp = new FileDataBP();
		ReceiptDataInterface receiptbp = new ReceiptDataBP();
		MetaForm form = uibp.findFormByKey(formkey);
		if(form.subcolumnid == null){
			throw new RuntimeException("ERROR.FORM.RECEIPT.SUBCOLUMN.MUST.NOT.NULL");
		}
		String title = form.formtitle;
		String editHtml = uibp.formHtml(formkey);
		String editortableColumns = uibp.editortableColumns(formkey);
//		String operateHtml = uibp.operateHtml(formkey);
		String defrowdata = uibp.defrowdata(formkey);
		Object model = new Object();
		Map<String, Object> data = new HashMap<String, Object>();
		data.put("total", 0);
		data.put("rows", new ArrayList());
		if(id != null) {
			model = filebp.findById(formkey, id);
			data = receiptbp.getlist(formkey,id);
		}
		
		String options = uibp.editModuleSettings(formkey);
		
		StringBuilder sb = new StringBuilder();
		sb.append("<!DOCTYPE html>")
		.append("<html>")
		.append("<head>")
		.append("<title>").append(title).append("</title>")
		.append("<meta charset=\"UTF-8\">")
		.append("<link rel=\"stylesheet\" media=\"screen\" href=\"/public/stylesheets/main.css\">")
		.append("<link rel=\"shortcut icon\" type=\"image/png\" href=\"/public/images/favicon.png\">")
		.append("<link rel=\"stylesheet\" href=\"/public/jquery-easyui-1.3.4/themes/default/easyui.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/jquery-easyui-1.3.4/themes/icon.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/bootstrap-3.0.3/css/bootstrap.min.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/bootstrap-3.0.3/css/bootstrap-datetimepicker.min.css\">")
		.append("<link rel=\"stylesheet\" href=\"/public/stylesheets/dynamicedit.css\">")
		.append("</head>")
		.append("<body>")
//操作
		.append("<div id=\"operate\">")
		.append("<span class=\"title\">操作</span>")
		.append("<button class=\"btn btn-primary\" id=\"save\" type=\"button\"><span class=\"glyphicon glyphicon-pencil\"></span> 保存</button>")
		.append("</div>");
//扩展按钮
//主表表单
		sb.append("<div id=\"main\" class=\"panel panel-default\">")
		.append("<div class=\"panel-collapse collapse in\" id=\"collapseOne\">")
		.append("<div class=\"panel-body\">")
		.append("<form id=\"editform\">");
//动态表单
		sb.append(editHtml);
		sb.append("</form>")
		.append("</div>")
		.append("</div>")
		.append("</div>")
//子表列表
		.append("<div id=\"dataset\">")
		.append("<table id=\"dg\"></table>")
		.append("</div>")
//子表按钮
		.append("<div id=\"toolbar\">")
		.append("<a class=\"easyui-linkbutton\" id=\"add\" href=\"javascript:void(0);\" data-options=\"iconCls:'icon-add',plain:true\">新增</a>")
		.append("<a class=\"easyui-linkbutton\" id=\"cancel\" href=\"javascript:void(0);\" data-options=\"iconCls:'icon-undo',plain:true\">撤消</a>")
		.append("<a class=\"easyui-linkbutton\" id=\"delete\" href=\"javascript:void(0);\" data-options=\"iconCls:'icon-remove',plain:true\">删除</a>")
		.append("</div>");
//扩展按钮
		
		sb.append("<script src=\"/public/javascripts/jquery-1.10.2.min.js\"></script>")
		.append("<script src=\"/public/jquery-easyui-1.3.4/jquery.easyui.min.js\"></script>")
		.append("<script src=\"/public/jquery-easyui-1.3.4/easyui-lang-zh_CN.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap.min.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap-datetimepicker.js\"></script>")
		.append("<script src=\"/public/bootstrap-3.0.3/js/bootstrap-datetimepicker.zh-CN.js\"></script>")
		.append("<script src=\"/public/javascripts/jquery.validate.min.js\"></script>")
		.append("<script src=\"/public/javascripts/extendValidation.js\"></script>")
		.append("<script src=\"/public/javascripts/json2.js\"></script>")
		.append("<script src=\"/public/javascripts/jquery.cookie.js\"></script>")
		.append("<script src=\"/public/javascripts/common.js\"></script>")
		.append("<script src=\"/public/javascripts/dynamicedit.js\"></script>");
		if(CommonUtil.isNotEmptyString(form.editpagejs)){
			sb.append("<script src=\"/public/javascripts/").append(form.editpagejs).append("\"></script>");
		}
		sb.append("<script type=\"text/javascript\">")
		.append("var form = ").append(JSON.toJSONString(form)).append(";")
		.append("var model = ").append(JSON.toJSONString(model,SerializerFeature.WriteDateUseDateFormat)).append(";")
		.append("var options = ").append(options).append(";")
//		.append("var data = ").append(JSON.toJSONString(data,SerializerFeature.WriteDateUseDateFormat)).append(";")
		.append("var data = ").append(JsonUtil.parseObject(data)).append(";")
		.append("var columns = ").append(editortableColumns).append(";")
		.append("var defrowdata = '").append(defrowdata).append("';")
		.append("</script>")
		.append("</body>")
		.append("</html>");
		renderHtml(sb.toString());
	}

}
