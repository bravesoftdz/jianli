/*2016-4-18 yzw 运费结算明细表*/
var columns = [[ ],[ ]];
var fields = "";
$(function() {
	document.getElementById('query').reportClassName = 'controllers.report.QueryBalanceItemAction';
	initDatepicker('startdate');
	initDatepicker('enddate');
	showDatetime1("startdate");
    showDatetime1("enddate");
    digitSelect($('#branchorgid'));
    findbranchorgs("branchorgid","findBranchOrganization"); //寻找分公司
    digitSelect($('#orgid'));
    findbranchorg("branchorgid","orgid","findOrganization"); //寻找下属机构
    autocomplete($('#unitid'),'unit', 'id', 'name', null, null,null);
    autocomplete($('#vehicleno'),'vehicle','vehicleno','vehicleno',null,null,null);

	//导出
	$('#exportexcel').click(function(){
		params = getSearchParams();
		outExcel(params,"/exportexcel/queryBalanceItem?reportClassName=");
    });
	// 条件查询
	$('#search').click(function() {
		//机构不能为空
		if($('#orgid').val() == null){
			showMsg('请选择机构');
			return;
		}
		//判断开始时间是否小于结束时间
		if($('#startdate').val()>$('#enddate').val())
		{
			showMsg('开始时间不能大于结束时间');
			return;
		}
		//原始载入--开始
		columns = [[],[]];
		$('#dg').datagrid({
			pageSize: 50,
			pageList: [50,100,150,200,500,1000],
			method : 'POST',
			fit : true,
			columns : columns,
			rownumbers : true,
			pagination : false,
			striped : true,
			singleSelect : true,
			showFooter: true,
			height:function(){return document.body.clientHeight;},
			onLoadSuccess : onLoadSuccess
		});
		var item = $('#dg').datagrid('getRows');  
        if (item) {  
            for (var i = item.length - 1; i >= 0; i--) {  
                var index = $('#dg').datagrid('getRowIndex', item[i]);  
                $('#dg').datagrid('deleteRow', index);  
            }  
        };  
		columns = loadDataHead(null,null);
		// 初始化表格
		$('#dg').datagrid({
			pageSize: 50,
			pageList: [50,100,150,200,500,1000],
			method : 'POST',
			fit : true,
			columns : columns,
			rownumbers : true,
			pagination : false,
			striped : true,
			singleSelect : true,
			showFooter: true,
			onLoadSuccess : onLoadSuccess
		});
		var pager = $('#dg').datagrid('getPager');
	    pager.pagination({
	        beforePageText: '第',
	        afterPageText: '页    共 {pages} 页',
	        displayMsg: '当前显示 {from} - {to} 条记录   共 {total} 条记录',
	        onSelectPage: function(pageNumber, pageSize){
	            $('#dg').datagrid('loadData', loadData(pageNumber, pageSize));
	        }
	    });
	    scrollShow($("#dg"));
		//原始载入--结束
		var pager = $('#dg').datagrid('getPager');
		$('#dg').datagrid('loadData', loadData(1, null));
	});
});	
/*载入后*/
function onLoadSuccess(data){
}
/*加载列表表头*/
function loadDataHead(pagenum, pagesize){
  var cd = [[],[]];//返回结果
  var d;
  $.ajax({
      url: "/ui/report/queryBalanceItemData",
      type: "POST",
      dataType: "json",
      data: {
     	 params: getSearchParams()
       },
      async: false,
      success: function(data){
    	  var arr = []; //对象转数组用
          var sa = data[0]; //首行
          var sz = data[data.length-1]; //末行
          var count = 0; //表头个数
          for (var key in sa){
        	  arr[sa[key]] = key;
        	  count++;
          }
          var list = [[]];//
          var num = 0;//一级表头计数
          var num2 = 0;//二级表头数
          fields = '';
          for(var i=0;i<count;i++){
        	  if(fields==''){
        		  fields = arr[i];
        	  }
        	  else{
        		  fields = fields + ',' + arr[i];
        	  }
        	  list[i] = arr[i].split('|');
        	  //合并行的数据
        	  if(list[i][1]==undefined){
        		  cd[0][num] = {title:list[i][0], field: arr[i], width:90, align:'center', rowspan:2, colspan:1, rowStart: 0, colStart: i }
        		  num++;
        	  }
        	  //不合并行的数据
        	  else{
        		  if(i==0 || (i>0 && list[i][0]!=list[i-1][0]) ){
	            	  cd[0][num] = {title:list[i][0], width:90, align:'center', rowspan:1, colspan:1, rowStart: 0, colStart:i  }
	            	  num++;
        		  }else if(i>0 && list[i][0]==list[i-1][0] ){
	            	  cd[0][num-1]['colspan'] = cd[0][num-1]['colspan']+1;
	            	  cd[0][num-1]['align'] = 'center';
        		  }
        		  //二级表头
	              cd[1][num2] = {title:list[i][1] , field: arr[i], width:90, align:'center', rowspan:1, colspan:1, rowStart: 1, colStart: i } 
	              num2++;
        	  }
        	  
          } //结束for
      },
      error: function(XMLHttpRequest, textStatus, errorThrown){
          if (XMLHttpRequest.status == 550) {
              var exp = JSON.parse(XMLHttpRequest.responseText);
              showMsg(i18n(exp[0].message));
          }
          var str = '{"total":0, "rows":[]}';
          d = JSON.parse(str);
      }
  });
  return cd;
}
/*加载列表数据*/
function loadData(pagenum, pagesize){
  $('#page').val(pagenum);
  $('#pagesize').val(pagesize);
  var d = null;
  $.ajax({
      url: "/ui/report/queryBalanceItemData",
      type: "POST",
      dataType: "json",
      data: {
     	 params: getSearchParams(),
     	 page: pagenum,
     	 pagesize: pagesize
       },
      async: false,
      success: function(data){
          d = data;
          d = data.slice(1, [data.length-1]);
      },
      error: function(XMLHttpRequest, textStatus, errorThrown){
          if (XMLHttpRequest.status == 550) {
              var exp = JSON.parse(XMLHttpRequest.responseText);
              showMsg(i18n(exp[0].message));
          }
          var str = '{"total":0, "rows":[]}';
          d = JSON.parse(str);
      }
  });
  return d;
}
/*获取查询参数*/
function getSearchParams() {
	var params = new Object();
	var $elements = $('#searchform :input[name]');
	$.each($elements, function() {
		var name = $(this).attr('name');
		if (name == "multiselect") {
			return true;
		}
		var value;
		if ($(this).is(':checkbox')) {
			value = $(this).is(':checked') ? 1 : 0;
		} else {
			value = $(this).val();
		}
		if ($(this).hasClass("self-multi")) {
			value = $(this).val();
			if (value) {
				value = value.join("&");
			} else {
				value = '';
			}
		}
		if (params[name] || params[name] == "") {
			params[name] += '&' + value;
		} else {
			params[name] = value;
		}
	});
	params.fresh = 1;
	params = JSON.stringify(params);
	return params;
}
function getData(type,text) {
    var d = null;
    $.ajax({  
        url: "/common/auto",
        type: "POST",
        dataType: "json",
        data: {
            type: type,
            text: text
        },
        async: false,
        success: function(data){
            d = data;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
				alertMsg(i18n(exp[0].message));
            }
        }
    });
    return d;
}
//初始化多选下拉框,支持多选
function digitSelect($element){
	var width= $element.parent().width();
	$element.multiselect({
		includeSelectAllOption: true,
		selectAll: true,
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

//分公司(机构type=4)--父级 findBranchOrganization
function findbranchorgs(childid, type, params){
		$("#"+childid).multiselect('dataprovider', []);
		var selectdata  = [];
		var ary = findBydata('4',type,params);
		var dataary = new Array();
		$.each(ary.rows,function(j,n){
			selectdata[j] = {label: n.name, value: n.id}; 
			$('#'+childid).multiselect('select', n.id);
		});
		$("#"+childid).multiselect('dataprovider', selectdata);
//		$.each(ary.rows,function(j,n){
//			$('#'+childid).multiselect('select', n.id);
//		});
}
//所属机构（父级机构type=4）--子级 findOrganization
function findbranchorg(parentid, childid, type, params){
	$("#"+childid).multiselect('dataprovider',[]);
	$("#"+parentid).change(function(){
		var selectdata = [];
		var data = $(this).val();
		if(data!=null){
			var ids = null;
			$.each(data, function(i,o){
				if(i==0){
					ids = o;
				}else{
					ids = ids + "," + o;
				}
			});
			var ary = findBydata(ids,type);
			var dataary  = new Array();
			$.each(ary.rows, function(j, n){
				selectdata[j] = {label:n.name, value:n.id};
				$("#"+childid).multiselect('select', n.id);
			});
			$("#"+childid).multiselect('dataprovider',selectdata);
			$.each(ary.rows, function(j, n){
				$('#'+childid).multiselect('select', n.id);
			});
		}else{
			$("#"+childid).multiselect('dataprovider', []);
		}
	});
}

function findBydata(ids,type,params){
	var url = '';
	var data = {ids:ids};
	if (type=='findBranchOrganization'){
		url = '/linkage/findBranchOrganization'; //分公司
	} else if (type=='findOrganization') {
		url = '/linkage/findOrganization'; //所属机构
	} else{
		//
	}
	    var d = null;
	    $.ajax({
	        url: url,
	        type: "POST",
	        dataType: "json",
	        data: data,
	        async: false,
	        success: function(data){
	            d = data;
	        },
	        error: function(XMLHttpRequest, textStatus, errorThrown){
	            if (XMLHttpRequest.status == 550) {
	                var exp = JSON.parse(XMLHttpRequest.responseText);
	                showMsg(i18n(exp[0].message));
	            }
	            var str = '{"total":0, "rows":[]}';
	            d = JSON.parse(str);
	        }
	    });
	    return d;
}
/**/
function showDatetime1(id){
    var now = new Date();
    var year = now.getFullYear(); //年   
    var month = now.getMonth() + 1; //月   
    month = month >= 10 ? month : ('0' + month); 
    var day = now.getDate(); //日 
    day = day >= 10 ? day : ('0' + day);
    
    time = year + "-" + month + "-" + day;
    $('#' + id).val(time);
}
/**/
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
		maxView: 4,
		forceParse: 1,
		timepicker:false
    });
}	
/*导出excel*/
function outExcel(params,paths){
	var titles = '',
		url = document.title,
		reportClassName = document.getElementById('query').reportClassName;
	url = /.*\.html$/.test(url) ? url.substring(0,url.length-5) : url;
	var mergeCells = '';
	$.cookie("params",params,{path:"/"});
	var steps = 0;	//碰到当前表头为跨行表头则后面的子表头顺延，即子表头的colStart向后推迟
	var excelColumns;
	if (typeof exportColumns !== 'undefined' && exportColumns) {
		excelColumns = exportColumns;
	} else {
		excelColumns = columns;
	}
	for (var i = excelColumns.length - 1, leni = excelColumns.length; i >= 0; i--) {
		//获取表头
		for(var j = 0, lenj = excelColumns[i].length; j < lenj; j ++){
			if(excelColumns[i][j].hidden){
				continue;
			}
			//每一个title都包括行宽和列高，格式为title:colStart:rowStart:cols:rows
			var ele = excelColumns[i][j];
			var rowspan = ele.rowspan? ele.rowspan: 1,
				colspan = ele.colspan? ele.colspan: 1;	
			titles += ele.title + ':' + ele.colStart + ":" + ele.rowStart + ':' + colspan + ":"  + rowspan + ',';
		}
	}

	// 获取所有要合并的表头单元格
	if (typeof merges !== 'undefined' && merges) {
		$.each(merges, function(index, ele){
			var rowspan = ele.rowspan? ele.rowspan: 1,
				colspan = ele.colspan? ele.colspan: 1;
			mergeCells += getColNumByField(ele.field)+":"+ele.index+":"+colspan+":"+rowspan+",";
		})
	}
	// 获取所有要合并的数据单元格
	if (typeof mergeSpecial !== 'undefined' && mergeSpecial) {
		$.each(mergeSpecial, function(index, ele){
			var rowspan = ele.rowspan? ele.rowspan: 1,
				colspan = ele.colspan? ele.colspan: 1;
			mergeCells += getColNumByField(ele.field)+":"+ele.index+":"+colspan+":"+rowspan+",";
		});
	}
	mergeCells = mergeCells.substring(0, mergeCells.length - 1);
	titles = titles.substring(0, titles.length-1);
	// 存在特殊字符%，必须进行转义
	titles = encodeURIComponent(titles);
	window.location.href=paths+reportClassName+"&titles="+titles+"&url="+url+"&mergeCells="+mergeCells;
}
function scrollShow(datagrid) {  
	datagrid.prev(".datagrid-view2").children(".datagrid-body").html("<div style='width:" + datagrid.prev(".datagrid-view2").find(".datagrid-header-row").width() + "px;border:solid 0px;height:1px;'></div>");  
}  
