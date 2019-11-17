/**
 * @author lin
 */
var myview = $.extend({}, $.fn.datagrid.defaults.view, {
    renderFooter: function(target, container, frozen){
        var opts = $.data(target, 'datagrid').options;
        var rows = $.data(target, 'datagrid').footer || [];
        var fields = $(target).datagrid('getColumnFields', frozen);
        var table = ['<table class="datagrid-ftable" cellspacing="0" cellpadding="0" border="0"><tbody>'];
         
        for(var i=0; i<rows.length; i++){
            var style = ' style="background-color:#ccc;"';
            table.push('<tr class="datagrid-row" datagrid-row-index="' + i + '"' + style + '>');
            table.push(this.renderRow.call(this, target, fields, frozen, i, rows[i]));
            table.push('</tr>');
        }
         
        table.push('</tbody></table>');
        $(container).html(table.join(''));
    }
});
var plugin = new Object();
$(function(){
	//只读控制
	$('.self-readonly').attr('readonly','readonly');
	
	var ary =$('.self-date');
	$.each(ary,function(i,o){
		fillDate($(o));
	});
	
	$('#searchform :input.self-multi').each(function(){
		digitSelect($(this));
	});
	
	//为日期和自动完成绑定控件
	bindControl(options);
	
	
	//查询条件中自动完成默认值
	var $combos = $('#searchfrom :input.self-combo');
	$.each($combos,function(){
		var defaultvalue = $(this).attr('defaultvalue');
		if(defaultvalue){
			$(this).combogrid('setValue',defaultvalue);
		}
	});
	
	if(plugin.init){
		plugin.init();
	}
	
	//初始化表格
	$('#dg').datagrid({
		columns: columns,
		rownumbers: true,
		pagination: true,
		striped: true,
		showFooter: true,
		view:myview
	});
	
	//定义分页条
	$('#dg').datagrid('getPager').pagination({
		beforePageText:'第',
		afterPageText:'页    共 {pages} 页',
		displayMsg:'当前显示 {from} - {to} 条记录   共 {total} 条记录',
		onSelectPage:function(pageNumber, pageSize){
			$('#dg').datagrid('loadData', getPage(pageNumber, pageSize, true));
		}
	});
	
	//条件查询
	$('#search').click(function(){
		//查询时数字校验
		if(!validSearch()){
			return false;
		}
		
		initTable();
	});
	
	$('#exportexcel').click(function(){
		//查询时数字校验
		if(!validSearch()){
			return false;
		}
		var params = getSearchParams();
		outExcel(params);
	});
	
	//添加
	$('#add').click(function(){
		$('#dg').datagrid('clearSelections');
		if(form.formtype == 1){//档案
			var $combos = $('#editform :input.self-combo');
			$.each($combos,function(){
				var defaultvalue = $(this).attr('defaultvalue');
				if(defaultvalue){
					$(this).combogrid('setValue',defaultvalue);
				}
				
			});
			$('#dynamicModal').modal('show');
			
			if(plugin.add){
				plugin.add();
			}
		}else{//单据
			var href = '/ui/dynamicedit?formkey=' + form.formkey;
			parent.addTab(form.formtitle,href);	
		}
	});
	
	
	//修改赋值
	$('#modify').click(function(){
		var row = $('#dg').datagrid('getSelected');
		if(!row){
			return false;
		}
		
		$('#dg').datagrid('clearSelections');
		var currentindex = $('#dg').datagrid('getRowIndex',row);
		$('#dg').datagrid('selectRow',currentindex);
		
		if(form.formtype == 1){//档案
			$('#dynamicModal').modal('show');
			
			var $elements = $('#editform :input[name]');
			$.each($elements,function(){
				var name = $(this).attr('name');
				var field = name.split('#')[1].split('!')[1];
				var length = $(this).attr("class");
				length = length==null?0:length.split("self-date").length;
				if(length==2){
					$(this).val(row[field].split(" ")[0]);
				}else{
					if($(this).is(':checkbox')){
						$(this).val([row[field]?1:0]);
					}else if($(this).hasClass('combo-value')){
						$(this).prev().prev().val(row[field+'__display']);
						$(this).val(row[field]);
					}else{
						$(this).val(row[field]);
					}
				}
			});
			
			if(plugin.modify){
				plugin.modify();
			}
		}else{//单据
			var href = '/ui/dynamicedit?formkey=' + form.formkey + "&id=" + row.id;
			parent.addTab(form.formtitle,href);	
		}
	});
	
	//删除
	$('#delete').click(function(){
		var rows = $('#dg').datagrid('getSelections');
		if(rows.length <= 0){
			return false;
		}
		var idArr = [];
		$.each(rows,function(idx,obj){
			idArr.push(obj.id);
		});
		var idStr = idArr.join(',');
		$.messager.confirm('提示','是否确认删除?',function(r){
			if(r){
				var url;
				if(form.formtype == 1){//档案
					url = '/data/delete';
				}else{//单据
					url = '/data/multidelete';
				}
				$.ajax({
					url: url,
					type: 'POST',
					dataType: 'json',
					data: {formkey:form.formkey,ids:idStr},
					success: function(data){
						showMsg(data.message);
						reloadTable();
					},
					error: function(){
						alertMsg('服务器异常!')
					}
				});
			}
		});
	});
	
	//保存
	$('#save').click(function(){
		//提交时必填、数字、格式校验
		if(!validSubmit()){
			return false;
		}
		
		if(plugin.save){
			var flag = plugin.save();
			if(!flag){
				return false;
			}
		}
		
		var $elements = $('#editform :input[name]:enabled');
		var params = new Object();
		$.each($elements,function(){
			var name = $(this).attr('name');
			var value;
			if($(this).is(':checkbox')){
				value = $(this).is(':checked')?true:false;
			}else{
				value = $(this).val();
			}
			params[name] = value;
		});
		params = JSON.stringify(params);
		$.ajax({
			url: '/data/save',
			type: 'POST',
			dataType: 'json',
			data: {formkey:form.formkey,params:params},
			success: function(data){
				showMsg(data.message);
				$('#dynamicModal').modal('hide');
				reloadTable();
			},
			error: function(XMLHttpRequest, textStatus, errorThrown){
				if (XMLHttpRequest.status == 550) {
	                var exp = JSON.parse(XMLHttpRequest.responseText);
	                showMsg(exp[0].message);
	            }
			}
		});
	});
	
	//模态框关闭事件
	$('#dynamicModal').on('hidden.bs.modal', function (e) {
		clearForm();
	});
	
	//必填、数字、格式校验离焦事件
	validEvent();
});

//初始化多选下拉框
function digitSelect($element){
	var width= $element.parent().width();
	$element.multiselect({
		includeSelectAllOption: true,
		selectAllText: '全选',
		nonSelectedText: '请选择',
		nSelectedText:'项已选择',
		selectedClass: null,
		dropRight:true,
		buttonClass:'form-control btn-sm',
		buttonWidth:width,
        maxHeight: 300
    });
	$element.next().find('button').css("height","30px");
	$element.next().find('button').next().width(width);
	
	
}

//为日期和自动完成绑定控件
function bindControl(options){
	//日期
	for(var i = 0; i < options['datetimepicker'].length; i++){
		var item = options['datetimepicker'][i];
		var format = item['format'];
		format = format.replace(/m/g,"i").replace(/H/g,"h").replace(/M/g,"m");
		var start = 2;
		var min = 0;
		var max = 4;
		if(format == 'yyyy-mm-dd'){
			min = 2;
		}else if(format == 'hh:ii' || format == 'hh:ii:ss'){
			start = 1;
			max = 1;
		}
		$('#'+item['id']).datetimepicker({
			format: format,
			language:  'zh-CN',
	        weekStart: 1,
	        todayBtn:  1,
			autoclose: 1,
			todayHighlight: 1,
			startView: start,
			minView: min,
			maxView: max,
			forceParse: 0
	    });
	}
	
	//自动完成
	for(var i = 0; i < options['combogrid'].length; i++){
		var item = options['combogrid'][i];
		var textfield = item['textfield'];
		var $this = $('#' + item['id']);
		var fieldid = $this.attr('name').split('#')[0];
		//获取过滤字段参数
		var $domains;
		if(item['id'].charAt(0) == "s"){
			$domains = $('#searchform :input.self-domain');
		}else if(item['id'].charAt(0) == "e"){
			$domains = $('#editform :input.self-domain');
		}
		var params = new Object();
		params['_text']="";
		$.each($domains,function(){
			var name;
			var value;
			if($(this).is(':checkbox')){
				name = $(this).attr('name');
				value = $(this).is(':checked')?1:0;
			}else if($(this).hasClass('self-combo')){
				var $real = $(this).next().find('.combo-value');
				name = $real.attr('name');
				value = $real.val();
			}else{
				name = $(this).attr('name');
				value = $(this).val();
			}
			params[name] = value;
		});
		combogrid($this,item);
		
	}
}

function combogrid($this,item){
	var flag = true;
	$this.combogrid({
		panelWidth: item['panelwidth'],
		idField: item['idfield'],
		textField: item['textfield'],
		hasDownArrow: false,
		columns: JSON.parse(item['columns']),
		onSelect: function(index,row){
			//关联字段赋值
			var relations = item['relations'].split(',');
			for(var j = 0; j < relations.length; j++){
				var id = relations[j].split('-')[0];
				var value = relations[j].split('-')[1];
				$('#' + id).val(row[value]);
			}
			$this.next().find(".combo-cursor").val(row[item['idfield']])
			
			//清空错误消息提示
			$('#prompt').html('');
			flag = false;
		},
		onChange:function(nowValue,oldValue){
			//获取过滤字段参数
			var $domains;
			if(item['id'].charAt(0) == "s"){
				$domains = $('#searchform :input.self-domain');
			}else if(item['id'].charAt(0) == "e"){
				$domains = $('#editform :input.self-domain');
			}
			var params = new Object();
			params['_text']="";
			$.each($domains,function(){
				var name;
				var value;
				if($(this).is(':checkbox')){
					name = $(this).attr('name');
					value = $(this).is(':checked')?1:0;
				}else if($(this).hasClass('self-combo')){
					var $real = $(this).next().find('.combo-value');
					name = $real.attr('name');
					value = $real.val();
				}else{
					name = $(this).attr('name');
					value = $(this).val();
				}
				params[name] = value;
			});
			var $this = $(this);
			var fieldid = $this.attr('comboname').split('#')[0];
			if(flag){
				params['_text']=nowValue;
				$this.combogrid('grid').datagrid('loadData',getData(fieldid,JSON.stringify(params)));
			}
			//如果输入为空或者查询结果为空则清空关联字段值
			var data = $this.combogrid('grid').datagrid('getData');
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(nowValue);
			if(isEmpty || data.rows.length <= 0) {
				var relations = item['relations'].split(',');
				for(var j = 0; j < relations.length; j++){
					var id = relations[j].split('-')[0];
					var value = relations[j].split('-')[1];
					$('#' + id).val('');
				}
				$this.next().find(".combo-cursor").val("");
				//错误消息提示
				if($this.hasClass('self-required')){
					var title = $this.parents('div.form-group:first').find('span.title').text();
					$('#prompt').html(title + '不能为空')
				}
			}
			flag = true;
		}
	});
	snt($this);
}

//调整样式
function snt($element){
    var obj = $element.combo('textbox');
	obj.removeClass("validatebox-text").removeAttr('style').css("background", "##CCE8CF")
    	.parent().removeClass("combo").removeAttr('style').css("width", "100%");
    if(obj.parent().prev().hasClass('form-control')){
		if(obj.parent().prev().hasClass('input-sm')){
        	obj.addClass("input-sm");
		}
    	obj.addClass("form-control");
    	obj.css("display", "inline-block");
    }
}

//必填、数字、格式校验离焦事件
function validEvent(){
	$('#editform :input.self-required').each(function(){
		var $element = $(this);
		var title = $element.parents('div.form-group:first').find('span.title').text();
		if($element.hasClass('self-combo')){
			$element.combogrid('textbox').blur(function(){
				var value = $element.combogrid('getValue');
				var regex = new RegExp("^\\s*$");
				var isEmpty = regex.test(value);
				if(isEmpty){
					$('#prompt').html(title + '不能为空');
				}else{
					$('#prompt').html('');
				}
			});
		}else{
			$element.blur(function(){
				var value = $element.val();
				var regex = new RegExp("^\\s*$");
				var isEmpty = regex.test(value);
				if(isEmpty){
					$('#prompt').html(title + '不能为空');
				}else{
					$('#prompt').html('');
				}
			});
		}
	});
	
	$('#editform :input.self-number').blur(function(){
		var title = $(this).parents('div.form-group:first').find('span.title').text();
		var value = $(this).val();
		if(isNaN(value)){
			$('#prompt').html(title + '只能是数字')
		}else{
			$('#prompt').html('')
		}
	});
	
	$('#editform :input.self-check').blur(function(){
		var title = $(this).parents('div.form-group:first').find('span.title').text();
		var value = $(this).val();
		var format = $(this).attr('format');
		var regex = new RegExp(format);
		var flag = regex.test(value);
		if(!flag){
			$('#prompt').html(title + '格式有误');
		}else{
			$('#prompt').html('');
		}
	});

	$('#searchform :input.self-number').blur(function(){
		var title = $(this).parents('div.form-group:first').find('span.title').text();
		var value = $(this).val();
		if(isNaN(value)){
			showMsg(title + '只能是数字');
		}
	});
	
	$('#searchform :input.self-check').blur(function(){
		var title = $(this).parents('div.form-group:first').find('span.title').text();
		var value = $(this).val();
		var format = $(this).attr('format');
		var regex = new RegExp(format);
		var flag = regex.test(value);
		if(!flag){
			showMsg(title + '格式有误');
		}
	});
}

//查询时数字校验
function validSearch(){
	var d = true;
	$('#searchform :input.self-number,#searchform :input.self-check').each(function(){
		var $element = $(this);
		var title = $element.parents('div.form-group:first').find('span.title').text();
		var value = $element.val();
		if($element.hasClass('self-number')){
			if(isNaN(value)){
				showMsg(title + '只能是数字');
				d = false;
				return false;//跳出循还
			}
		}
		if($element.hasClass('self-check')){
			var format = $(this).attr('format');
			var regex = new RegExp(format);
			var flag = regex.test(value);
			if(!flag){
				showMsg(title + '格式有误');
				d = false;
				return false;//跳出循还
			}
		}
	});
	return d;
}

//提交时必填、数字、格式校验
function validSubmit(){
	var d = true;
	$('#editform :input.self-required,#editform :input.self-number,#editform :input.self-check').each(function(){
		var $element = $(this);
		var title = $element.parents('div.form-group:first').find('span.title').text();
		var value;
		if($element.hasClass('self-combo')){
			value = $element.combogrid('getValue');
		}else{
			value = $element.val();
		}
		if($element.hasClass('self-required')){
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(value);
			if(isEmpty){
				$('#prompt').html(title + '不能为空');
				d = false;
				return false;//跳出循还
			}
		}
		if($element.hasClass('self-number')){
			if(isNaN(value)){
				$('#prompt').html(title + '只能是数字')
				d = false;
				return false;//跳出循还
			}
		}
		if($element.hasClass('self-check')){
			var format = $(this).attr('format');
			var regex = new RegExp(format);
			var flag = regex.test(value);
			if(!flag){
				$('#prompt').html(title + '格式有误');
				d = false;
				return false;//跳出循还
			}
		}
	});
	return d;
}

//获取查询参数
function getSearchParams(){
	var params = new Object();
	var $elements = $('#searchform :input[name]');
	$.each($elements,function(){
		var name = $(this).attr('name');
		if(name == "multiselect"){
			return true;
		}
		var value;
		if($(this).is(':checkbox')){
			value = $(this).is(':checked')?1:0;
		}else{
			value = $(this).val();
		}
		if($(this).hasClass("self-multi")){
			value = $(this).val();
			if(value){
				value = value.join("&");
			}else{
				value = '';
			}
		}
		if(params[name] || params[name] == ""){
			params[name] += '&' + value;
		}else{
			params[name] = value;
		}
	});
	params = JSON.stringify(params);
	return params;
}

function fillDate(obj){
	$(obj).val(date());
}

function date(){
	var now = new Date(); 
	var year = now.getFullYear();       //年   
	var month = now.getMonth() + 1;     //月   
	month = month >= 10 ? month : ('0'+ month);
	var day = now.getDate();            //日
	day = day >= 10 ? day : ('0' + day);
	var date = year + "-" + month + "-" + day;
	return date;
}

//自动完成获取数据
function getData(fieldid,params){
	var d = null;
	$.ajax({
		url : "/data/auto",
		type : "POST",
		dataType : "json",
		data : {fieldid:fieldid,params:params},
		async: false,  
		success : function(data) {
			d = data;
		},
		error : function (XMLHttpRequest, textStatus, errorThrown) {
			if(XMLHttpRequest.status==550){
				var exp = JSON.parse(XMLHttpRequest.responseText);
				alertMsg(i18n(exp[0].message));
			}
			var str = '{"total":0, "rows":[]}';
			d = JSON.parse(str);
	    }
	});
	return d;
}

function outExcel(params){
	var d = null;
	$.cookie("params",params,{path:"/"});
	var p = JSON.stringify(params);
	window.location="/excel/list?"+"&formkey="+form.formkey+"&url="+form.listtitle;
	
	$.cookie("params",null);
}

/**
 * 表格分页查询
 */
function getPage(page, rows, isPagination){
	isPagination = isPagination || false;
	var params = getSearchParams();
	var d = null
    $.ajax({
        url: "/data/page",
        type: "POST",
        async: false,
		dataType: 'JSON',
        data: {
            formkey: form.formkey,
            params: params,
			page: page,
			rows: rows,
			isPagination: isPagination
        },
        success: function(data){
            d = data;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
            }
            d = {
                "total": 0,
                "rows": []
            };
        }
    });
	return d;
}

/**
 * 查询表格数据,默认跳转第一页
 */
function initTable(){
    var pagerOpts = $('#dg').datagrid('getPager').pagination('options');
    $('#dg').datagrid('getPager').pagination({
        pageNumber: 1
    });
    var rows = pagerOpts.pageSize;
    $('#dg').datagrid('loadData', getPage(1, rows));
}

/**
 * 刷新表格数据
 */
function reloadTable(){
	var pagerOpts = $('#dg').datagrid('getPager').pagination('options');
	var page = pagerOpts.pageNumber;
	var rows = pagerOpts.pageSize;
	$('#dg').datagrid('loadData',getPage(page,rows));
}

/**
 * 清空表单数据
 */
function clearForm(){
	var $elements = $('#editform :input[name][type="hidden"]');
    $.each($elements, function(){
        $(this).val('');
    });
    var $combos = $('#editform :input.self-combo');
    $.each($combos, function(){
        $(this).combogrid('clear');
    });
    $('#prompt').html('');
    $('#editform')[0].reset();
}