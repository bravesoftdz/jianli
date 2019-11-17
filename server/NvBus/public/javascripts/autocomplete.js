//
//自动补全
function autocomplete($com,type,idField,textField,setConnect,clearConnect){
	setConnect = setConnect || function(){};
	clearConnect = clearConnect || function(){};
	var flag = true;
	var array = commonColumn(getData(type,1));
	$com.combogrid({
		panelWidth:array[1],
		idField: idField,
		textField: textField,
		hasDownArrow:false,
		columns: array[0],
		onSelect:function(rowIndex,rowData){
			setConnect(rowIndex,rowData);
			flag = false;
		},
		onChange:function(nowValue,oldValue){
			var data = commonData(getData(type,nowValue));
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(nowValue);
			if(isEmpty || data.rows.length <= 0) {
				clearConnect();
			}
			if(flag && !isEmpty) {
				$com.combogrid('grid').datagrid('loadData', data);
			}
			flag = true;
		}
	});
	snt($com);
}
//结算单位自动完成
function Blanceorgautocomplete($com,type,idField,textField,setConnect,clearConnect){
	setConnect = setConnect || function(){};
	clearConnect = clearConnect || function(){};
	var flag = true;
	var array = commonColumn(getBlanceorgData(type,1));
	$com.combogrid({
		panelWidth:array[1],
		idField: idField,
		textField: textField,
		hasDownArrow:false,
		columns: array[0],
		onSelect:function(rowIndex,rowData){
			setConnect(rowIndex,rowData);
			flag = false;
		},
		onChange:function(nowValue,oldValue){
			var data = commonData(getBlanceorgData(type,nowValue));
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(nowValue);
			if(isEmpty || data.rows.length <= 0) {
				clearConnect();
			}
			if(flag && !isEmpty) {
				$com.combogrid('grid').datagrid('loadData', data);
			}
			flag = true;
		}
	});
	snt($com);
}
//自动补全 目的站
function autoEndstation($com,setConnect,clearConnect) {
	setConnect = setConnect || function(){};
	clearConnect = clearConnect || function(){};
	var flag = true;
	$com.combogrid({
		idField: 'stationname',
		textField: 'stationname',
		hasDownArrow:false,
		columns: [[{
            field: 'stationname',
            title: '目的站',
            halign: 'center',
            width:80
        }, {
            field: 'transferstationname',
            title: '中转站',
            halign: 'center',
            width:80
        }, {
            field: 'routename',
            title: '线路',
            halign: 'center',
            width:80
        }, {
            field: 'schedulecode',
            title: '班次',
            halign: 'center',
            width:50
        }, {
            field: 'departtime',
            title: '发车时间',
            halign: 'center',
            width:45
        }]],
        panelWidth:415,
		onSelect:function(rowIndex,rowData){
			setConnect(rowIndex,rowData);
			flag = false;
		},
		onChange:function(nowValue,oldValue){
			var data = getEndstation(nowValue);
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(nowValue);
			if(isEmpty || data.rows.length <= 0) {
				clearConnect();
			}
			if(flag && !isEmpty) {
				$com.combogrid('grid').datagrid('loadData', data);
			}
			flag = true;
		}
	});
	snt($com);
}
//自动补全 车牌号
function autoVehicleno($com,setConnect,clearConnect){
	setConnect = setConnect || function(){};
	clearConnect = clearConnect || function(){};
	var flag = true;
	var array = commonColumn(getVehicleno(1));
	$com.combogrid({
		panelWidth:array[1],
        idField:'name',
        textField: 'name',
        hasDownArrow: false,
        showHeader:false,
        columns: array[0],
		onSelect:function(rowIndex,rowData){
			setConnect(rowIndex,rowData);
			flag = false;
		},
		onChange:function(nowValue,oldValue){
			var data = commonData(getVehicleno(nowValue));
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(nowValue);
			if(isEmpty || data.rows.length <= 0) {
				clearConnect();
			}
			var str = new RegExp ("^[A-Za-z]{1,4}$");
	        var isValid=str.test(nowValue);
	    	var objs = $com.combogrid('grid');
			var s = objs.parent().parent().parent().parent().parent();
	        if(isValid){
	        	s.css("display","block");
                if (flag && !isEmpty) {
		        	$com.combogrid('grid').datagrid('loadData', data);
                }
                flag = true;
	        }else{
				s.css("display", "none");
	        }
		}
	});
	snt($com);
}

//调整样式
function snt($com){
    var obj = $com.combo('textbox');
    
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

//动态表头
function commonColumn(obj) {
	var column = '[[';
	var sNumber = 0;
	var len = (obj == null)?0:obj.nameslist.length;
	for(var i=0;i<len;i++) {
		if(obj.fieldslist[i].slice(-1) == ' ') {//field最后一个字符为空格,则该列隐藏
			column += '{"field":"'+obj.nameslist[i]+'","hidden":"true"},';
		}else{
			column += '{"field":"'+obj.nameslist[i]+'","title":"'+obj.fieldslist[i]+'","width":'+obj.fieldswidthlist[i]+'},';
			sNumber = sNumber+obj.fieldswidthlist[i];
		}
	}
	if(len > 0) {
		column = column.slice(0,-1);
	}
	column += ']]';
	
	column = JSON.parse(column);
	var array = new Array();
	array[0] = column;
	array[1] = sNumber+obj.fieldswidthlist[0];
	return array;
}

//列表数据
function commonData(obj) {
	var data = '';
	if(obj == null) {
		data = '{"total":"0","rows":[]}';
		data = JSON.parse(data);
		return data;
	}
	data = '{"total":"'+obj.resultcount+'","rows":[';
	var len = obj.resultslist.length;
	for(var i=0;i<len;i++) {
		data += '{'
		for(var j=0;j<obj.nameslist.length;j++) {
			data += '"' + obj.nameslist[j] + '":"' + mergeNull(obj.resultslist[i][j]) + '",';
		}
		data = data.slice(0,-1);
		data += '},';
	}
	if(len > 0) {
		data = data.slice(0,-1);
	}
	data += ']}';
	data = JSON.parse(data);
	return data;
}

function mergeNull(str) {
	if (str == null) {
        return "";
    }
    return str;
}

function getBlanceorgData(type,text) {
    var d = null;
    $.ajax({  
        url: "/selfautocomplete",
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

function getData(type,text) {
    var d = null;
    $.ajax({  
        url: "/selfcompletion",
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

function getEndstation(text){
    var d = null;
    $.ajax({  
        url: "/selfcompletion/endstation",
        type: "POST",
        dataType: "json",
        data: {
            text: text
        },
        async: false,
        success: function(data){
            d = data;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
            }
        }
    });
    return d;
}

function getVehicleno(text) {
	var d = null;
    $.ajax({
        url: "/selfcompletion/province",
        type: "POST",
        dataType: "json",
        data: {
            'text': text
			
        },
        async: false,
        success: function(data){
            d = data;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
            }
        }
    });
    return d;
}
function autocompletePrint($com,type,text,setConnect){
	$com.combobox({
	    valueField:'id',
	    textField:'name',
	    data:commonPrintData(getData(type,text))
	});
	//snt($com);
}
//列表数据
function commonPrintData(obj) {
	var data = '[';
	var len = (obj == null)?0:obj.resultslist.length;
	for(var i=0;i<len;i++) {
		if(i==0){
			data += '{'
				for(var j=0;j<obj.nameslist.length;j++) {
						data += '"' + obj.nameslist[j] + '":"' + mergeNull(obj.resultslist[i][j]) + '",';
				}
				data +='"selected":true';
				data += '},';
		}else{
			data += '{'
				for(var j=0;j<obj.nameslist.length;j++) {
						data += '"' + obj.nameslist[j] + '":"' + mergeNull(obj.resultslist[i][j]) + '",';
				}
				data =data.slice(0,-1);
				data += '},';
		}
	}
	if(len > 0) {
		data = data.slice(0,-1);
	}
	data += ']';
	data = JSON.parse(data);
	return data;
}
function autoschedule($com,endstationid,setConnect,clearConnect){
	setConnect = setConnect || function(){};
	clearConnect = clearConnect || function(){};
	var array = commonColumn(getschedule(endstationid,1));
	var flag = true;
	$com.combogrid({
		panelWidth: array[1],
		idField: 'code',
		textField: 'code',
		hasDownArrow:false,
		columns: array[0],
		onSelect:function(rowIndex,rowData){
			setConnect(rowIndex,rowData);
			flag = false;
		},
		onChange:function(nowValue,oldValue){
			var data = commonData(getschedule(endstationid,nowValue));
			var regex = new RegExp("^\\s*$");
			var isEmpty = regex.test(nowValue);
			if(isEmpty || data.rows.length <= 0) {
				clearConnect();
			}
			if(flag && !isEmpty) {
				$com.combogrid('grid').datagrid('loadData', data);
			}
			flag = true;
		}
	});
	snt($com);
}
function getschedule(endstationid,text) {
	var d = null;
    $.ajax({
        url: "/selfcompletion/schedule",
        type: "POST",
        dataType: "json",
        data: {
        	'endstationid':endstationid,
            'seachtext': text
			
        },
        async: false,
        success: function(data){
            d = data;
        },
        error: function(XMLHttpRequest, textStatus, errorThrown){
            if (XMLHttpRequest.status == 550) {
                var exp = JSON.parse(XMLHttpRequest.responseText);
            }
        }
    });
    return d;
}