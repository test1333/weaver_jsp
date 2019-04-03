/**
 * 零元体验套系-订单节点
 *主表套系名称选择后会根据套系基本档案中维护的信息自动带出到流程中的明细表中
 *<script type="text/javascript" src="/hsdeveloper/hs_huodongset.js"></script>
 *<script type="text/javascript" src="/hsdeveloper/jquery.js"></script>
 * */

//主表套系字段ID//5985
var setdocId = $("#field6098");
//套系升级字段ID
var txUpDateV="#field6146";
var txUpDateSpan=txUpDateV+"span";

//主表套系金额
var setMny = $("#field5891");
$(setMny).attr("readonly","readonly");
//会员价
var associatorPrice=$("#field5938");
var associatorPriceL=$("#p5938");
$(associatorPrice).attr("readonly","readonly");
//选择会员
var associatorSelect=$("#field6076");

//会员卡号
var asscaddNum="#p6225";
var asscaddNumV="#field6225";
//会员卡金额
var assMny="#p6226";
var assMnyV="#field6226";
//本次消费金额
var assXiaoFeiMny="#p6227";
var assXiaoFeiMnyV="#field6227";
//本次消费结余
var assJieYuMny="#p6228";
var assJieYuMnyV="#field6228";
//套系外消费
var setChaPrice=$("#field6077");
$(setChaPrice).attr("readonly","readonly");

//累计消费
var totalMny=$("#field6078");
$(totalMny).attr("readonly","readonly");
//定金
var depositMny=$("#field5939");
//尾款
var retainageMny=$("#field5932");
$(retainageMny).attr("readonly","readonly");
//获取选中的文本
var selectText=$(associatorSelect).find("option:selected").text();

//优惠方案
var xsyhL=$("#p6145");
var xsyhF=$("#field6145");
//套系升级
var txUpDateL=$("#p6146");
var txUpDateF=$("#pf6146");
//=================================================================================
//第一明细表
// 产品编码
var pCode = "field6071_";
// 明细表产品名称
var pName = "field6072_";
// 明细表产品单位
var pUnit = "field6028_";
// 明细表产品单价
var pPrice = "field6027_";
// 明细表产品数量
var pNum = "field5894_";
// 明细表应收金额
var pRecivableMny = "field6029_";
// 明细表实收金额
var pActualMny = "field6030_";
// 明细表备注
var pRemarks = "field5898_";
//===================================================================================
//第二明细表
var pcode2=$("#6085_");
var pname2=$("#6086_");
//===================================================================================
/**
 * @套系为空时会员状态不可操作
 */
if($(setdocId).val()==""){
	//$(associatorSelect).attr("disabled",true);
}
/**
 * @author LiuFe
 * @套系选择后产生的事件
 */
$(setdocId).bind('propertychange', function() {
	getDetailValue(setdocId);
	//$(associatorSelect).attr("disabled",false);
});
/**
 * 套系升级字段值改变时事件
 */
$(txUpDateV).bind('propertychange', function() {
	getDetailValue(txUpDateV);
});
/**
 * @封装套系带出明细表字段
 * @setId:套系ID
 */
function getDetailValue(setId){
	//获取判断明细表的返回值结果
	var tfv=getDetailTF();
	if($(setId).val()!=""){
		if(tfv){
			deleteDetailField();
			setDetailField(setId);
		}else{
			setDetailField(setId);
		}
	}else if($(setId).val()==""){
		if(tfv){
		    deleteDetailField();
		    if($(setdocId).val() !=""){
		    	setDetailField(setdocId);
		    }
		}else{
		}
	}
}
/**
 * @通过获取到的套系ID值,去数据库查询该套系的明细和总价格,分别给主表的套系价格赋值,带出套系内的明细行数据
 */
function setDetailField(value){
	$.ajax({
		type : "POST",
		url : "/hsdeveloper/hs_orderNode.jsp",
		data : {
			setdocId : $(value).val()
		// 选择的套系字段的ID
		},
		success : function(detailSets) {
			//alert("获取明细表字段值成功");
			var data=detailSets.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			var datas=eval("("+data+")");
			var setAmount=0;
			//遍历后台传的list方法一
			$.each(datas,function(i,item){
				/*
				 * 第三步:获取到明细表的总行数和明细表的内容后根据明细表的总行数进行循环; 每次增加一行并获取行号
				 */
				addRow0(i);
				// 获取新增加行的行号
				var nowRow = parseFloat($G("indexnum0").value) - 1;
				// 拼接明细字段的dom对象ID
				var pCodeDetail = "#" + pCode + nowRow;
				var pCodeDetailSpan = pCodeDetail + "span";
				var pNameDetail = "#" + pName + nowRow;
				var pNameDetailSpan = pNameDetail + "span";
				var pUnitDetail = "#" + pUnit + nowRow;
				var pPriceDetail = "#" + pPrice + nowRow;
				var pNumDetail = "#" + pNum + nowRow;
				//给明细表字段赋值
				jQuery(pCodeDetail).val(item.pcode);
				jQuery(pCodeDetailSpan).html(item.productcode);
				jQuery(pNameDetail).val(item.pcode);
				jQuery(pNameDetailSpan).html(item.productname);
				$(pUnitDetail).attr("value", item.productunits);
				$(pPriceDetail).attr("value", item.productprice);
				$(pNumDetail).attr("value", item.productnum);
				setAmount=item.txprice;
			});
			//查询结果返回的首先给主表的套系价格赋值
			//$(setMny).attr("disabled",false);
			$(setMny).attr("value",setAmount);
			//$(setMny).attr("disabled",true);
		},
		error : function() {
			alert("hs_orderNode.js:腳本執行不成功,可能可能数据库查询有问题!");
		}
	});
}
/**
 * @判断明细行是否有已存在的数据
 */
function deleteDetailField(){

	var chk=$("input[name='check_node_0']:checkbox").length;
	//如果直接判断juery的语法时大于，小于只能用gt()或eq()
	$("input[name='check_node_0']:checkbox").each(function(){
		$(this).attr("checked",true);
    });
	//alert("更换套系前,系统自动清空已选择的套系明细内容,下一步请确认已选套系明细内容的清楚");
	removeRow0(0);
	//alert("更换套系前，应该刷新页面！");
	//window.location.reload();
}
/**
 * 判断明细表是否为空
 * @returns {Boolean}
 */
function getDetailTF(){

	var chk=$("input[name='check_node_0']:checkbox").length;
	//如果直接判断juery的语法时大于，小于只能用gt()或eq()
	if(chk > 0){
		return true;
    }else{
    	return false;
    }
}

/**
 * @套系价格变动后其他价格自动开始计算
 */
$(setMny).bind("propertychange",function(){
	var setMny2=parseFloat($(setMny).val());//套系金额
	var cjMny2=parseFloat($(setChaPrice).val());//差价金额
	//获取选中了的value值
    selectValue=$(associatorSelect).val();
	if(selectValue==0){//非会员
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(0);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(setMny2+cjMny2)));
		//$(totalMny).attr("disabled",true);
	}else if(selectValue==1){
		var p_assPrice=parseFloat($(associatorPrice).val(sm * 0.9));//计算普通会员价
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(p_assPrice);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val(parseFloat(cjMny2+p_assPrice));
		//$(totalMny).attr("disabled",true);
	}else if(selectValue==2){
		var bj_assPrice=parseFloat($(associatorPrice).val(sm * 0.8));//计算白金会员价
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(bj_assPrice);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val(parseFloat(cjMny2+bj_assPrice));
		//$(totalMny).attr("disabled",true);
	}else if(selectValue==3){
		var jk_assPrice=parseFloat($(associatorPrice).val(sm * 0.8));//计算金卡会员价
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(jk_assPrice);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val(parseFloat(cjMny2+jk_assPrice));
		//$(totalMny).attr("disabled",true);
	}
});
/**
 * @会员选择会员类型后根据会员类型计算会员价格
 */
$(associatorSelect).bind('change', function() {
	$(xsyhL).hide();
	$(xsyhF).hide();
	var txMny=parseFloat($(setMny).val()).toFixed(2);//套系金额
	var cjMny=parseFloat($(setChaPrice).val()).toFixed(2);//差价金额
	//获取选中的文本
	var selectText=$(associatorSelect).find("option:selected").text();
	if(selectText=="普通会员"){
		$(associatorPrice).val(txMny * 0.9);//普通会员价
		var p_assMny = parseFloat($(associatorPrice).val()).toFixed(2);
		$(xsyhL).show();//优惠方案
		$(xsyhF).show();
		//$(xsyhF).attr("disabled",false);
		$("#field6145 option[text='9折优惠']").remove();
		$(xsyhF).prepend("<option value=2>9折优惠</option>");
		$(xsyhF).attr("value",2);//0=无优惠,1=8折,2=9折,3=套系升级,4=null
		$(xsyhF).attr("disabled",true);
		$(xsyhF).trigger("blur");
		$(txUpDateF).hide();
		$(txUpDateL).hide();
		$(associatorPriceL).show();
		$(associatorPrice).show();
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(parseFloat( p_assMny).toFixed(2));
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny) + parseFloat(p_assMny)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		//会员卡号
		$(asscaddNum).show();
		$(asscaddNumV).show();
		$(asscaddNumV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//会员卡金额
		$(assMny).show();
		$(assMnyV).show();
		$(assMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//本次消费金额
		$(assXiaoFeiMny).show();
		$(assXiaoFeiMnyV).show();
		$(assXiaoFeiMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//本次消费结余
		$(assJieYuMny).show();
		$(assJieYuMnyV).show();
		$(assJieYuMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	}else if(selectText=="白金会员"){
		$(associatorPrice).val(txMny * 0.8);//白金会员价
		var bj_assMny = parseFloat($(associatorPrice).val()).toFixed(2);
		$(xsyhL).show();
		$(xsyhF).show();
		$(txUpDateL).hide();
		$(txUpDateF).hide();
		//$(xsyhF).attr("disabled",false);
		$("#field6145 option[text='8折优惠']").remove();
		$(xsyhF).prepend("<option value=1>8折优惠</option>");
		$(xsyhF).attr("value",1);
		$(xsyhF).attr("disabled",true);
		$(xsyhF).trigger("blur");
		$(associatorPriceL).show();
		$(associatorPrice).show();
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val( parseFloat(bj_assMny).toFixed(2));
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny)+parseFloat(bj_assMny)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		//会员卡号
		$(asscaddNum).show();
		$(asscaddNumV).show();
		$(asscaddNumV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//会员卡金额
		$(assMny).show();
		$(assMnyV).show();
		$(assMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//本次消费金额
		$(assXiaoFeiMny).show();
		$(assXiaoFeiMnyV).show();
		$(assXiaoFeiMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//本次消费结余
		$(assJieYuMny).show();
		$(assJieYuMnyV).show();
		$(assJieYuMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	}else if(selectText=="非会员"){
		//$(this).trigger("blur");
		$(xsyhL).hide();
		$(xsyhF).hide();
		$(txUpDateL).hide();
		$(txUpDateF).hide();
		//$(xsyhF).attr("disabled",false);
		$("#field6145 option[text='无优惠']").remove();
		$(xsyhF).prepend("<option value=0>无优惠</option>");
		$(xsyhF).attr("value",0);
		//$(xsyhF).attr("disabled",true);
		$(associatorPriceL).hide();
		$(associatorPrice).hide();
		//$(associatorPrice).val(0);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny)+parseFloat(txMny)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		//会员卡号
		$(asscaddNum).hide();
		$(asscaddNumV).hide();
		$(asscaddNumV+"span").html("");
		//会员卡金额
		$(assMny).hide();
		$(assMnyV).hide();
		$(assMnyV+"span").html("");
		//本次消费金额
		$(assXiaoFeiMny).hide();
		$(assXiaoFeiMnyV).hide();
		$(assXiaoFeiMnyV+"span").html("");
		//本次消费结余
		$(assJieYuMny).hide();
		$(assJieYuMnyV).hide();
		$(assJieYuMnyV+"span").html("");
	}else if(selectText=="金卡会员"){
		
		$(xsyhL).show();
		$(xsyhF).show();
		$(associatorPriceL).show();
		$(associatorPrice).show();
		$("#field6145 option[value='0']").remove();
		$("#field6145 option[value='2']").remove();
		$(xsyhF).attr("disabled",false);
		$(xsyhF).attr("value",0);
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(txMny);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(txMny)+parseFloat(cjMny)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		//会员卡号
		$(asscaddNum).show();
		$(asscaddNumV).show();
		$(asscaddNumV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//会员卡金额
		$(assMny).show();
		$(assMnyV).show();
		$(assMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//本次消费金额
		$(assXiaoFeiMny).show();
		$(assXiaoFeiMnyV).show();
		$(assXiaoFeiMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//本次消费结余
		$(assJieYuMny).show();
		$(assJieYuMnyV).show();
		$(assJieYuMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	}
});
//套系外消费联动累计消费价格
$(setChaPrice).bind('propertychange', function() {
	
	var _smMny=$(setMny).val();
	var _scMny=$(setChaPrice).val();//差价金额
	var sv=$(associatorSelect).val();
	if(sv == 0){
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(_scMny)+parseFloat(_smMny)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		$(totalMny).trigger("blur");
	}else if(sv == 1){
		var _assPTPrice = $(associatorPrice).val();
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(_scMny)+parseFloat(_assPTPrice)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		$(totalMny).trigger("blur");
	}else if(sv = 2){
	    var _assPLPrice = $(associatorPrice).val();
	   // $(totalMny).attr("disabled",false);
	    $(totalMny).val((parseFloat(_scMny)+parseFloat(_assPLPrice)).toFixed(2));
	  //  $(totalMny).attr("disabled",true);
	    $(totalMny).trigger("blur");
	}else if(sv = 3){
		
	}
});
//定金变化决定尾款
$(depositMny).bind('propertychange', function() {
		var total=parseFloat(($(totalMny).val()));
		var deposit=parseFloat(($(depositMny).val()));
		//$(retainageMny).attr("disabled",false);
		$(retainageMny).val((total-deposit).toFixed(2));
		//$(retainageMny).attr("disabled",true);
});
//累计金额改变联动尾款金额改变
$(totalMny).bind('propertychange', function() {
      var total=parseFloat($(totalMny).val());
	  var deposit=parseFloat($(depositMny).val());
	 // $(retainageMny).attr("disabled",false);
	  $(retainageMny).val((total-deposit).toFixed(2));
	 // $(retainageMny).attr("disabled",true);
});
//优惠方案选择后的事件
$(xsyhF).bind('change',function(){
	var txMny1=parseFloat($(setMny).val()).toFixed(2);//套系金额
	var cjMny1=parseFloat($(setChaPrice).val()).toFixed(2);//差价金额
	if(($(xsyhF).find("option:selected").text())=="套系升级"){
		$(txUpDateL).show();
		$(txUpDateF).show();
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(txMny1);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny1)+parseFloat(txMny1)).toFixed(2));
	//	$(totalMny).attr("disabled",true);
	}else if(($(xsyhF).find("option:selected").text())=="8折优惠"){
		$(associatorPrice).val(txMny1 * 0.8);
		var assMny1 = parseFloat($(associatorPrice).val()).toFixed(2);
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val( parseFloat(assMny1).toFixed(2));
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny1)+parseFloat(assMny1)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		$(txUpDateL).hide();
		$(txUpDateF).hide();
		//从套系升级选回8折优惠时,判断明细表是否为空,如果不为空要清空明细表后再选回原始套系内容
		$(txUpDateV).val("");
		$(txUpDateSpan).html("");
		if($(setdocId).val()!="" && $(txUpDateV).val()==""){
			setDetailField(setdocId);
		}
	}else{
		$(txUpDateL).hide();
		$(txUpDateF).hide();
	}
});

//页面初始化时设置会员状态
if(selectText=="非会员"){
	//$(this).trigger("blur");
	//优惠方案
	$(xsyhL).hide();
	$(xsyhF).hide();
	//更新套系
	$(txUpDateL).hide();
	$(txUpDateF).hide();
	//会员价
	$(associatorPriceL).hide();
	$(associatorPrice).hide();
	//优惠方案默认值
	$(xsyhF).attr("disabled",false);
	$(xsyhF).attr("value",0);
	//会员卡号
	$(asscaddNum).hide();
	$(asscaddNumV).hide();
	//会员卡金额
	$(assMny).hide();
	$(assMnyV).hide();
	//本次消费金额
	$(assXiaoFeiMny).hide();
	$(assXiaoFeiMnyV).hide();
	//本次消费结余
	$(assJieYuMny).hide();
	$(assJieYuMnyV).hide();
}else if(selectText=="普通会员"){
	$(associatorSelect).attr("disabled",flase);
	//优惠方案
	$(xsyhL).show();
	$(xsyhF).show();
	//更新套系
	$(txUpDateL).hide();
	$(txUpDateF).hide();
	//会员价
	$(associatorPriceL).show();
	$(associatorPrice).show();
	//优惠方案默认值
	//$(xsyhF).attr("disabled",false);
	$(xsyhF).attr("value",2);
	//$(xsyhF).attr("disabled",true);
	//会员卡金额
	$(assMny).show();
	$(assMnyV).show();
	//本次消费金额
	$(assXiaoFeiMny).show();
	$(assXiaoFeiMnyV).show();
	//本次消费结余
	$(assJieYuMny).show();
	$(assJieYuMnyV).show();
	
}else if(selectText=="白金会员"){
	$(associatorSelect).attr("disabled",flase);
	//优惠方案
	$(xsyhL).show();
	$(xsyhF).show();
	//更新套系
	$(txUpDateL).hide();
	$(txUpDateF).hide();
	//会员价
	$(associatorPriceL).show();
	$(associatorPrice).show();
	//优惠方案默认值
	//$(xsyhF).attr("disabled",false);
	$(xsyhF).attr("value",1);
	//$(xsyhF).attr("disabled",true);
	//会员卡金额
	$(assMny).show();
	$(assMnyV).show();
	//本次消费金额
	$(assXiaoFeiMny).show();
	$(assXiaoFeiMnyV).show();
	//本次消费结余
	$(assJieYuMny).show();
	$(assJieYuMnyV).show();
}else if(selectText=="金卡会员"){
	$(associatorSelect).attr("disabled",flase);
	//优惠方案
	$(xsyhL).show();
	$(xsyhF).show();
	$(xsyhF).attr("value",1);
	//会员价
	$(associatorPriceL).show();
	$(associatorPrice).show();
	//会员卡金额
	$(assMny).show();
	$(assMnyV).show();
	//本次消费金额
	$(assXiaoFeiMny).show();
	$(assXiaoFeiMnyV).show();
	//本次消费结余
	$(assJieYuMny).show();
	$(assJieYuMnyV).show();
}
/**
 * @author LiuFe
 * @隐藏浏览按钮达到只读的效果
 */
window.onload = function() {
	//hideBrowserButton("#field0000");	// 隐藏部门浏览按钮
	//hideBrowserButton("#field0000");	// 隐藏分部浏览按钮
};
function hideBrowserButton(fieldId){
	var fieldObj = window.document.getElementById(fieldId);
	var browserObj = fieldObj.previousSibling;
	for (var i = 0; i < 5; i++)
	{
		if (browserObj.nodeName == "BUTTON")
		{
			browserObj.style.display = "none";
			break;
		}
		browserObj = browserObj.previousSibling ;
	}
}

$(document).ready(function(){
	window.status="韩尚儿国际儿童摄影";
});
//控制摄影信息明细表新增时不要有默认赋值
function clearDetailDefaultValue(){
	var startDate="#field6042_";
	var startTime="#field6043_";
	var endTime="#field6044_";
	var shoter="#field6045_";
	var shotAssociator="#field6046_";
	var nowRow = parseFloat($G("indexnum2").value) - 1;
	//开始日期
	var startDateId=startDate+nowRow;
	var startDateSpan=startDateId+"span";
	$(startDateId).attr("value","");
	$(startDateSpan).html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	//开始时间
	var startTimeId=startTime+nowRow;
	var startTimeSpan=startTimeId+"span";
	$(startTimeId).attr("value","");
	$(startTimeSpan).html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	//结束时间
	var endTimeId=endTime+nowRow;
	var endTimeSpan=endTimeId+"span";
	$(endTimeId).attr("value","");
	$(endTimeSpan).html("");
	//摄影师
	var shoterId=shoter+nowRow;
	var shoterSpan=shoterId+"span";
	$(shoterId).attr("value","");
	$(shoterSpan).html("");
	//助理
	var shotAssociatorId=shotAssociator+nowRow;
	var shotAssociatorSpan=shotAssociatorId+"span";
	$(shotAssociatorId).attr("value","");
	$(shotAssociatorSpan).html("");
}

//后期修片节点增行时自动计算预计选片日期
function yJSelectPhotoDate(){
	var yJSelectDate="#field6115_";
	var nowRow = parseFloat($G("indexnum3").value) - 1;
	var yJSelectPhotoDateId=yJSelectDate+nowRow;
	var yJSelectDateSpan=yJSelectPhotoDateId+"span";
	$(yJSelectPhotoDateId).attr("value",getEightDay());
	$(yJSelectDateSpan).html(getEightDay());
}
//取当前日期的8天后日期
function getEightDay(){
	//取当前日期
	var _newDate=new Date();
	//给当前日加上天数
	_newDate.setDate(_newDate.getDate()+8);
	//拼接日期字符串
	var str=""+_newDate.getFullYear()+"-";
	//月份记得要加1才是当前月
	str += (_newDate.getMonth()+1)+"-";
	str += _newDate.getDate();
	return str;
}
//重写明细表删除方法
function removeRow0(groupid,isfromsap){
	try{
var flag = false;
	var ids = document.getElementsByName("check_node_"+groupid);
	for(i=0; i<ids.length; i++) {
		if(ids[i].checked==true) {
			flag = true;
			break;
		}
	}
	if(isfromsap){flag=true;}
    if(flag) {
		if(isfromsap || _isdel()){
		var oTable=$G('detailFieldTable6072');
		var len = document.forms[0].elements.length;
		var curindex=parseInt($G("nodesnum"+groupid).value);
		var i=0;
		var rowsum1 = 0;
		var objname = "check_node_"+groupid;
		for(i=len-1; i >= 0;i--) {
			if (document.forms[0].elements[i].name==objname){
				rowsum1 += 1;
			}
		}
		for(i=len-1; i>=0; i--) {
			if(document.forms[0].elements[i].name==objname){
				if(document.forms[0].elements[i].checked==true){
					var nodecheckObj;
						var delid;
					try{
						for(var cc=0; cc<jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children().length; cc++){
							if(jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc].tagName=="INPUT"){
								nodecheckObj = jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children().eq(0).children()[cc];
						delid = nodecheckObj.value;
							}
						}
					}catch(e){}
					//记录被删除的旧记录 id串
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//老明细
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//新明细
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//从提交序号串中删除被删除的行
					var submitdtlidArray=$G("submitdtlid"+groupid).value.split(',');
					$G("submitdtlid"+groupid).value="";
					var k;
					for(k=0; k<submitdtlidArray.length; k++){
						if(submitdtlidArray[k]!=delid){
							if($G("submitdtlid"+groupid).value==''){
								$G("submitdtlid"+groupid).value = submitdtlidArray[k];
							}else{
								$G("submitdtlid"+groupid).value += ","+submitdtlidArray[k];
							}
						}
					}
					detailFieldTable6072.deleteRow(rowsum1);
					detailFieldTable6028.deleteRow(rowsum1);
					detailFieldTable5894.deleteRow(rowsum1);
					detailFieldTable5898.deleteRow(rowsum1);
					curindex--;
				}
				rowsum1--;
			}
		}
		$G("nodesnum"+groupid).value=curindex;
			calSum(groupid);
}
}else{
        alert('请选择需要删除的数据');
		return;
    }	}catch(e){}
	try{
		var indexNum = jQuery("span[name='detailIndexSpan0']").length;
		for(var k=1; k<=indexNum; k++){
			jQuery("span[name='detailIndexSpan0']").get(k-1).innerHTML = k;
		}
	}catch(e){}
}
function _isdel(){
    return true;
} 