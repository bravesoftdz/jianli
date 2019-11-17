/**
 * @author lin
 */
//消息提示
function showMsg(msg) {
	$.messager.show({
		title: '消息提示',
		msg: msg,
		timeout: 1000,
		style:{
			right:'',
			top:document.body.scrollTop+document.documentElement.scrollTop,
			bottom:''
		}
	});
}

//警告消息
function alertMsg(msg) {
	$.messager.alert('重要提示',msg,'error');
}

//清除校验信息
function clearVerifymsg(element) {
	var spans = $(element).find('span.col-sm-3');
	$.each(spans, function(index, value){
		$(value).html('');
	});
}

//初始话化下拉列表
function initSelect(element, list) {
	$.each(list, function(index, value){
		$(element).append('<option value="'+value.id+'">'+value.name+'</option>');
	}); 
}

//刷新表格数据
function reloadDG() {
	var pager = $('#dg').datagrid('getPager');
	var ops = pager.pagination('options');
	var page = ops.pageNumber;
	var rows = ops.pageSize;
	$('#dg').datagrid('loadData', loadData(page, rows));
}


//表格数据初始化查询
function initDG() {
	var pager = $('#dg').datagrid('getPager');
	var ops = pager.pagination('options');
	var rows = ops.pageSize;
	$('#dg').datagrid('loadData', loadData(1, rows));
}

$(function(){
	//$('.form-control').css("width","90%");
	$('#messagebox').css("height","20px");
	$('#messagebox').css("color","red");
	$('#messagebox').css("font-size","14px");
	$('#messagebox').css("font-weight","bold");
	$('#messagebox').css("text-align","center");
	$('.operateDiv').css("padding-left","20px");
	$('.operateDiv a').css("margin-left","5px");
	empty1();
	screenResize();
	//取消
	$("#cancel").click(function(){
		$('#myModal').modal('hide');
		$('#editForm :radio').removeAttr("checked");
	});
	$('#myModal').on('hidden.bs.modal', function (e) {
		$('#editForm')[0].reset();
		$('#messagebox').html(''); 
		clearVerifymsg('#editForm');
	});
});

//利用后台验证消息显示到前台
function Validation(exp,obj){
	for(var i=exp.length-1;i>=0;i--){
		var object=$('#editForm input[name="'+exp[i].key+'"]');
		if(exp[i].key!="serverError"){
			var error=object.parent().prev().html();
			$('#messagebox').html(i18n(exp[i].message,error,exp[i].variables[0],exp[i].variables[1]))
			if(i==0){
			object.focus();
			}
		}else{
			showMsg(i18n(exp[i].message, exp[i].key));
			reloadDG();
		}
	}
}
function BusValidation(exp){
	var str="";
	for(var i=exp.length-1;i>=0;i--){
		var object=$('#editForm input[name="'+exp[i].key+'"]');
			if(exp[i].key!="serverError"){
				var error = object.parent().parent().next().html();
				if(error != null){
				str += error.split(":")[0] +",";
				}
			}
	}
	str = str.slice(0, -1);
	alertMsg(i18n(exp[0].message,str));
}
//时间插件
function initDatetimepicker(id) {
	$('#' + id).datetimepicker({
		format: 'yyyy-mm-dd hh:ii:ss',
		language:  'zh-CN',
        weekStart: 1,
        todayBtn:  0,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 0,
		maxView: 1,
		forceParse: 0
    });
}

//当前时间
function showDatetime(id){
	var now = new Date();  
	var year = now.getFullYear();       //年   
	var month = now.getMonth() + 1;     //月   
	month = month >= 10 ? month : ('0'+ month);
	var day = now.getDate();            //日
	day = day >= 10 ? day : ('0' + day);
	
	var hh = now.getHours(); //时
	hh = hh >= 10 ? hh : ('0' + hh);
	var mm = now.getMinutes(); //时
	mm = mm >= 10 ? mm : ('0' + mm);
	var ss = now.getSeconds(); //时
	ss = ss >= 10 ? ss : ('0' + ss);
	
	time = year + "-" + month + "-" + day + " " + hh + ":" + mm + ":" + ss;
	
	$('#'+id).val(time);
}

//日期插件
function initDatepicker(id) {
	$('#' + id).datetimepicker({
		format: 'yyyy-mm-dd',
		language:  'zh-CN',
        weekStart: 1,
        todayBtn:  0,
		autoclose: 1,
		todayHighlight: 1,
		startView: 2,
		minView: 2,
		maxView: 2,
		forceParse: 0
    });
}
//当前日期
function showDate(id){
	var now = new Date();  
  
	var year = now.getFullYear();       //年   
	var month = now.getMonth() + 1;     //月   
	month = month >= 10 ? month : ('0'+ month);
	var day = now.getDate();            //日
	day = day >= 10 ? day : ('0' + day);
	
	var date = year + "-" + month + "-" + day;
	$('#' + id).val(date);
}

function screenResize(){
	var queryheight = $('#query').height();
	var operate = $('#operate').height();
	$('body').css("overflow-x","hidden");
	number = queryheight+operate+100;
	var dt=$('#commonid').val();
	var ois = document.documentElement.clientHeight;
	var heightDG = ois -number;
	if(dt == "common"){
		$('#dg').css("height",heightDG/2);
		$('#dt').css("height",heightDG/2);
	}else{
		$('#dg').css("height",heightDG);
		//$('#dg').parent().css("height",heightDG+40);
	}
	DGHeight(heightDG);
}


function dataValidation(){
	var sstarttime = $('#sstarttime').val();
	var regex = new RegExp("^(?:(?!0000)[0-9]{4}-(?:(?:0[1-9]|1[0-2])-(?:0[1-9]|1[0-9]|2[0-8])|(?:0[13-9]|1[0-2])-(?:29|30)|(?:0[13578]|1[02])-31)|(?:[0-9]{2}(?:0[48]|[2468][048]|[13579][26])|(?:0[48]|[2468][048]|[13579][26])00)-02-29)$");
	if(sstarttime!=""){
		if(!regex.test(sstarttime)){
			alertMsg("请输入正确的日期格式");
			return;
		}
	}
	var  sstarttimes = new Date(sstarttime.replace(/-/g,   "/")); 
	var i = sstarttimes.getTime()/1000;
	if(sstarttime != "") {
		$('#shiporderStarttime').val(sstarttime + " 00:00:00");
	}else{
		$('#shiporderStarttime').val("");
	}
	var sendtime = $('#sendtime').val();
	if(sendtime!=""){
		if(!regex.test(sendtime)){
			alertMsg("请输入正确的日期格式");
			return;
		}
	}
	var  sendtimes = new Date(sendtime.replace(/-/g,   "/")); 
	var j = sendtimes.getTime()/1000;
	if(sendtime != "") {
		$('#shiporderEndtime').val(sendtime + " 23:59:59");
	}else{
		$('#shiporderEndtime').val("");
	}
	if(sstarttime!=""&&sendtime!=""){
		if(i>j){
			alertMsg("开始日期必须小于截止日期");
		}else{
			initDG();
		}
	}else{
		initDG();
	}
}
function empty1(){
    document.onkeydown = function(e){
        var ev = document.all ? window.event : e;
        if (ev.keyCode == 13) {
            return false;
        }
        var code;
        if (!e) {
            var e = window.event;
        }
        if (e.keyCode) {
            code = e.keyCode;
        }
        else 
            if (e.which) {
                code = e.which;
            }
        //BackSpace 8;
        if ((e.keyCode == 8) &&
        ((e.srcElement.type != "text" && e.srcElement.type != "textarea" && e.srcElement.type != "password") ||
        e.srcElement.readOnly == true)) {
        
            e.keyCode = 0;
            e.returnValue = false;
        }
        return true;
    };
}
function removeCheck(ary){
     $.each(function(i,o){
     	$(o).removeAttr("checked");
     });
}

function checkNull(str,value,flg){
	if(value !=""){
		if(flg == "1"){
			 $('#'+str).next().next().html("");
		}else if(flg == "2"){
			$('#'+str).parent().next().html("");
		}
	}
}

//查询快捷键
function keySearch(elements,callback){
	$.each(elements,function(){
		$(this).keydown(function(e){
			if(e.which == 13) {
				callback();
			}
		});
	});
}

//保存快捷键
function keySave(callback) {
	$(document).keydown(function(e){
		if( e.ctrlKey && e.which ==13) {
			callback();
		}
	});
}

function DGHeight(heightDG){
	//关联折叠按钮，调整页面高度
	$('#collapseOne').on('hidden.bs.collapse', function () {
			var ois = $('#query').height();
			var dt=$('#commonid').val();
			if(dt=="common"){
				$('#dg').datagrid('resize',{height:(heightDG+ois+36)/2});
				$('#dt').datagrid('resize',{height:(heightDG+ois+36)/2});
			}else{
				$('#dg').datagrid('resize',{height:heightDG+ois+36});
			}
	});
	$('#collapseOne').on('show.bs.collapse', function () {
		    var ois = $('#query').height();
			var dt=$('#commonid').val();
			if(dt=="common"){
			$('#dg').datagrid('resize',{height:heightDG/2});
			$('#dt').datagrid('resize',{height:heightDG/2});
			}else{
			$('#dg').datagrid('resize',{height:heightDG});
			}
	});
}

//焦点快捷键
function focusKey($items, isFirst){
    $.each($items, function(index, elem){
        var $action = $(this).next().find('.combo-text').hasClass('combo-text') ? $(this).next().find('.combo-text') : $(this);
        if (!isFirst) {
           // $action.unbind('keydown');修改解绑keydown事件，与自动完成冲突
        }
        //下面加判断
        if(isFirst){
        	 $action.bind('keydown', function(e){
                 var focus = $(this).hasClass('combo-text') ? $(this).parent().prev() : $(this);
                 if (e.which == 13) {
                     e.returnValue = false;
                     focusEnter($items, focus);
                 }
                 else 
                     if (e.which == 107) {
                         e.preventDefault();
                         focusPlus($items, focus);
                     }
             });
        }
    });
}

//焦点快捷键 Enter 跳至下一必输项
function focusEnter($items, next){
    var index = $items.index(next);
    if (next == null) {
        return;
    }
    var _next = $items.get(index + 1);
    var $_next = $(_next).next().find('.combo-text').hasClass('combo-text') ? $(_next).next().find('.combo-text') : $(_next);
    if ($(_next).hasClass('sp-required')) {
        $_next.focus();
    }
    else {
        focusEnter($items, _next);
    }
}

//焦点快捷键 + 跳至下一非必输项
function focusPlus($items, next){
    var index = $items.index(next);
    if (next == null) {
        return;
    }
    var _next = $items.get(index + 1);
    var $_next = $(_next).next().find('.combo-text').hasClass('combo-text') ? $(_next).next().find('.combo-text') : $(_next);
    
    if ($(_next).hasClass('sp-nonrequired')) {
        $_next.focus();
    }
    else {
        focusPlus($items, _next);
    }
}

//判断是否唯一,唯一return true,不唯一return false
function checkUnique(tablename,paramname,paramval){
	var d = true;
    $.ajax({
        url: '/checkUnique/',
        type: 'POST',
        dataType: 'json',
        data: {
            tablename: tablename,
            paramname: paramname,
            paramval: paramval,
            isbasedb:false
        },
        async: false,
        success: function(data){
            d = data.success;
        }
    });
    return d;
}
