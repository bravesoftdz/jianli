var operatorid;
$(function(){
	screencount();
	$('body').css({"overflow-x":"auto","overflow-y":"hidden"});
	var ois = screen.height;
	var indexHight = $('body').css("height");
	if(indexHight!=null){
		$('#tabs').css("height",indexHight);
	}
	$('.leftTree').css("height",ois-98);
    $("#mtree li").find(".firstMenu").removeClass("fir_show");
//    $('#tabs').tabs({
//		tools: '#tools',
//		toolPosition: 'left',
//		width:$(window).width()-145,
//		height:$(window).height()
//    });
    $('.leftTree').hover(function(){},function(){
    	levelmenu();
    });
//    $('.subMenu').hover(function(){},function(){
//    	//levelmenu();
//    });
    $('.subMenu').mouseover(function(){    	
    	entermenu(publickey);  	    		
    });
    $('.subMenu').mouseleave(function(){
        leavemenu(publickey);	
    });
})
function screencount(){
	var ary = $('.countclass');
	$.each(ary,function(i,o){
		if($(o).val()>18){
			$(o).next().css("background","#047CF4");
		}
		if($(o).val()<19){
			$(o).next().css("background","#047CF4 url(/public/images/back.png) no-repeat right");
		}
		if($(o).val()>36){
			$(o).next().css("background","#047CF4");
			$(o).next().css("width","650px");
			var width = Math.ceil( $(o).val()/18 )*200 + 50 + "px";
			$(o).next().css("width", width);
		}
	});
}
function mouseEvent(obj){
    $(obj).hover(function(){
        $(this).find(".firstMenu").addClass("fir_show");
        $(this).find(".subMenu").show();
    },function(){
        $(this).find(".firstMenu").removeClass("fir_show");
        $(this).find(".subMenu").hide();
    });
    $('.subMenu').hover(function(){},function(){
    	levelmenu();
    });
}
var pr = null;
function f(element,parentid,menuid,functionregid,parameter){
//    if (!isEmpty(menuid)) {
//        if (!isPrivileged(userid, menuid)) {
//            return;
//        }
//    }
//    $('#tabs').css("display", "block");
//    $('#tableWrap').css("display", "none");
//    $("#mtree li").find(".firstMenu").removeClass("fir_show");
//    $("#mtree li").find(".subMenu").hide();
	if(functionregid==18){
		pr = parameter;
	}
    var functionkey = getfunctionkey(functionregid)
    getkeyvalue(functionkey,parameter,parentid);
   // addTab(menuname,menuurl);
}

//调整tab页尺寸
function resizeTab(){
    var tab = $('#tabs').tabs('getSelected');
    var panel = tab.panel('panel');
    $(panel).removeAttr('style');
    $(tab).removeAttr('style').attr('style', 'padding:0 15px 0 0');
}
//添加tab页
function addTab(title,href) {
	if ($('#tabs').tabs('exists', title)) {//标签页是否存在,存在刷新,不存在添加
		var tab = $('#tabs').tabs('select', title);
    }else{
		var contens = '<div class="iframe" style="width:100%;height:99%;">' +
	    '<iframe src="' +
	    href +
	    '" style="width:100%;height:100%;border:0;"></iframe></div>';
		 $('#tabs').tabs('add', {
		        title: title,
		        content: contens,
		        fit: true,
		        closable: true,
		        selected: true
	    });
	}
}

//添加tab页
function refreshTab(title,href) {
	var tab = $('#tabs').tabs('getTab',title);
	var contens = '<div class="iframe" style="width:100%;height:99%;">' +
    '<iframe src="' +
    href +
    '" style="width:100%;height:100%;border:0;"></iframe></div>';
	 $('#tabs').tabs('update', {
	        tab: tab,
	        options: {
				content: contens
			}
    });
}
function close(title){
	var tab = $('#tabs').tabs('getTab',title);
	var index = $('#tabs').tabs('getTabIndex', tab);
	$('#tabs').tabs('close', index);

}

//菜单项单击触发事件
function menuHandler(item){
	var t = $('#tabs');
	var item = item.text;
	if(item=="关闭所有页") {
		var tabs = t.tabs('tabs');
		for(var i = tabs.length - 1; i >= 0; i--) {
			if(tabs[i].panel('options').title != "主页"){
				t.tabs('close', i);
			}
		}
	}else if(item=="关闭当前页") {
		var tab = t.tabs('getSelected');
		if(tab.panel('options').title!="主页"){
			var index = t.tabs('getTabIndex', tab);
			t.tabs('close', index);
	    }
	}else if(item == "刷新当前页") {
		var tab = t.tabs('getSelected');
		var src = tab.find('iframe')[0].src;
		tab.find('iframe')[0].contentWindow.location.href=src;//刷新tab页
	}
}
function indexf(obj,url,title){
	parent.f(obj,url,title);
}
function esc(){
	var functionkey = getfunctionkey(18);
    getkeyvalue(functionkey,pr); 
}	

/*判断字符串是否为空*/
function isEmpty(str) {
	if(str == null || str == "") {
		return true;
	}else{
		return false;
	}
}
/*判断是否有权限*/
function isPrivileged(userid,menuid) {
	var d = null;
    $.ajax({
        url: "/userinfo/isprivileged",
        type: "POST",
        dataType: "json",
        async: false,
        data: {
            "userid": userid,
            "menuid": menuid
        },
        success: function(data){
            d = data;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
                $.messager.alert('提示', exp[0].message, 'error');
            }
        }
    });
    return d;
}

function getfunctionkey(id){
	var d = null;
    $.ajax({
        url: "/getfunctionkey",
        type: "POST",
        dataType: "json",
        async: false,
        data: {
        	id:id
        },
        success: function(data){
            d = data.message;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
                $.messager.alert('提示', exp[0].message, 'error');
            }
        }
    });
    return d;
}
var publickey = null;
function getindex(id){
	publickey = id;
	var ids = $('.ids');
	$.each(ids,function(i,o){
		var data = $(o).val();
		if(data == id){
			screencount();
			$(o).parent().find('.subMenu').show();
		}
	});
}

function moveindex(){
	$('.subMenu').hide();
}
