var d = null;
function ValidationClass(clazz){
	var falg = true;
	var istrue = false;
	var regex = new RegExp(/[(\ )]+/);
		var object = $('.'+clazz);
		$.each(object,function(i,n){
			var value = $(n).val();
			if(regex.test(value)){
				istrue = true;
				return;
			}
		})
		if(istrue){
				falg = false;
		}
		if(d !=null){
			if(!d){
				falg = false;
			}
		}
		return falg;
}


function ValidationAfter(clazz){
	var regex1 = new RegExp(/[(\ )]+/);
	var regex2 = new RegExp("^[\s\S]+$");
	var object = $('.'+clazz);
	$.each(object,function(i,n){
		$(n).keyup(function(){
			if(n.id != ""){
				if(clazz == "ValidationAfter"){
					var value = $(this).val();
					var istrue = regex1.test(value);
					if(istrue){
							$(this).parent().next().css('color','red');
							$(this).parent().next().html("请不要输入特殊字符");
					}else{
						$(this).parent().next().html("");
					}
				}
				if(clazz == "required"){
					var value = $(this).val();
					var istrue = regex2.test(value);
					if(istrue){
							$(this).parent().next().css('color','red');
							var text = $(this).parent().prev().text();
							$(this).parent().next().html("请输入"+text);
					}else{
						$(this).parent().next().html("");
					}
				}
			}else{
				var value = $(this).parent().find('.combo-value').val();
				var istrue = regex1.test(value);
				if(istrue){
					$(this).parent().parent().next().css('color','red');
					$(this).parent().parent().next().html("请不要输入特殊字符");
				}else{
					$(this).parent().parent().next().html("");
				}
			}
		});
	});
}
//自动完成的唯一性验证
function ValidationAuto(value){
	value.blur(function(){
		var name = $(this).parent().find(".combo-value")[0].name;
		var value = $(this).parent().find(".combo-value").val();
		var objec = this;
		d = AjaxFunction(name,value,objec);
	});
}
