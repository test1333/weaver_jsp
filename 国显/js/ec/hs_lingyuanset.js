/**
 * ��Ԫ������ϵ-�����ڵ�
 *������ϵ����ѡ���������ϵ����������ά������Ϣ�Զ������������е���ϸ����
 *<script type="text/javascript" src="/hsdeveloper/hs_huodongset.js"></script>
 *<script type="text/javascript" src="/hsdeveloper/jquery.js"></script>
 * */

//������ϵ�ֶ�ID//5985
var setdocId = $("#field6098");
//��ϵ�����ֶ�ID
var txUpDateV="#field6146";
var txUpDateSpan=txUpDateV+"span";

//������ϵ���
var setMny = $("#field5891");
$(setMny).attr("readonly","readonly");
//��Ա��
var associatorPrice=$("#field5938");
var associatorPriceL=$("#p5938");
$(associatorPrice).attr("readonly","readonly");
//ѡ���Ա
var associatorSelect=$("#field6076");

//��Ա����
var asscaddNum="#p6225";
var asscaddNumV="#field6225";
//��Ա�����
var assMny="#p6226";
var assMnyV="#field6226";
//�������ѽ��
var assXiaoFeiMny="#p6227";
var assXiaoFeiMnyV="#field6227";
//�������ѽ���
var assJieYuMny="#p6228";
var assJieYuMnyV="#field6228";
//��ϵ������
var setChaPrice=$("#field6077");
$(setChaPrice).attr("readonly","readonly");

//�ۼ�����
var totalMny=$("#field6078");
$(totalMny).attr("readonly","readonly");
//����
var depositMny=$("#field5939");
//β��
var retainageMny=$("#field5932");
$(retainageMny).attr("readonly","readonly");
//��ȡѡ�е��ı�
var selectText=$(associatorSelect).find("option:selected").text();

//�Żݷ���
var xsyhL=$("#p6145");
var xsyhF=$("#field6145");
//��ϵ����
var txUpDateL=$("#p6146");
var txUpDateF=$("#pf6146");
//=================================================================================
//��һ��ϸ��
// ��Ʒ����
var pCode = "field6071_";
// ��ϸ���Ʒ����
var pName = "field6072_";
// ��ϸ���Ʒ��λ
var pUnit = "field6028_";
// ��ϸ���Ʒ����
var pPrice = "field6027_";
// ��ϸ���Ʒ����
var pNum = "field5894_";
// ��ϸ��Ӧ�ս��
var pRecivableMny = "field6029_";
// ��ϸ��ʵ�ս��
var pActualMny = "field6030_";
// ��ϸ��ע
var pRemarks = "field5898_";
//===================================================================================
//�ڶ���ϸ��
var pcode2=$("#6085_");
var pname2=$("#6086_");
//===================================================================================
/**
 * @��ϵΪ��ʱ��Ա״̬���ɲ���
 */
if($(setdocId).val()==""){
	//$(associatorSelect).attr("disabled",true);
}
/**
 * @author LiuFe
 * @��ϵѡ���������¼�
 */
$(setdocId).bind('propertychange', function() {
	getDetailValue(setdocId);
	//$(associatorSelect).attr("disabled",false);
});
/**
 * ��ϵ�����ֶ�ֵ�ı�ʱ�¼�
 */
$(txUpDateV).bind('propertychange', function() {
	getDetailValue(txUpDateV);
});
/**
 * @��װ��ϵ������ϸ���ֶ�
 * @setId:��ϵID
 */
function getDetailValue(setId){
	//��ȡ�ж���ϸ��ķ���ֵ���
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
 * @ͨ����ȡ������ϵIDֵ,ȥ���ݿ��ѯ����ϵ����ϸ���ܼ۸�,�ֱ���������ϵ�۸�ֵ,������ϵ�ڵ���ϸ������
 */
function setDetailField(value){
	$.ajax({
		type : "POST",
		url : "/hsdeveloper/hs_orderNode.jsp",
		data : {
			setdocId : $(value).val()
		// ѡ�����ϵ�ֶε�ID
		},
		success : function(detailSets) {
			//alert("��ȡ��ϸ���ֶ�ֵ�ɹ�");
			var data=detailSets.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			var datas=eval("("+data+")");
			var setAmount=0;
			//������̨����list����һ
			$.each(datas,function(i,item){
				/*
				 * ������:��ȡ����ϸ�������������ϸ������ݺ������ϸ�������������ѭ��; ÿ������һ�в���ȡ�к�
				 */
				addRow0(i);
				// ��ȡ�������е��к�
				var nowRow = parseFloat($G("indexnum0").value) - 1;
				// ƴ����ϸ�ֶε�dom����ID
				var pCodeDetail = "#" + pCode + nowRow;
				var pCodeDetailSpan = pCodeDetail + "span";
				var pNameDetail = "#" + pName + nowRow;
				var pNameDetailSpan = pNameDetail + "span";
				var pUnitDetail = "#" + pUnit + nowRow;
				var pPriceDetail = "#" + pPrice + nowRow;
				var pNumDetail = "#" + pNum + nowRow;
				//����ϸ���ֶθ�ֵ
				jQuery(pCodeDetail).val(item.pcode);
				jQuery(pCodeDetailSpan).html(item.productcode);
				jQuery(pNameDetail).val(item.pcode);
				jQuery(pNameDetailSpan).html(item.productname);
				$(pUnitDetail).attr("value", item.productunits);
				$(pPriceDetail).attr("value", item.productprice);
				$(pNumDetail).attr("value", item.productnum);
				setAmount=item.txprice;
			});
			//��ѯ������ص����ȸ��������ϵ�۸�ֵ
			//$(setMny).attr("disabled",false);
			$(setMny).attr("value",setAmount);
			//$(setMny).attr("disabled",true);
		},
		error : function() {
			alert("hs_orderNode.js:�_�����в��ɹ�,���ܿ������ݿ��ѯ������!");
		}
	});
}
/**
 * @�ж���ϸ���Ƿ����Ѵ��ڵ�����
 */
function deleteDetailField(){

	var chk=$("input[name='check_node_0']:checkbox").length;
	//���ֱ���ж�juery���﷨ʱ���ڣ�С��ֻ����gt()��eq()
	$("input[name='check_node_0']:checkbox").each(function(){
		$(this).attr("checked",true);
    });
	//alert("������ϵǰ,ϵͳ�Զ������ѡ�����ϵ��ϸ����,��һ����ȷ����ѡ��ϵ��ϸ���ݵ����");
	removeRow0(0);
	//alert("������ϵǰ��Ӧ��ˢ��ҳ�棡");
	//window.location.reload();
}
/**
 * �ж���ϸ���Ƿ�Ϊ��
 * @returns {Boolean}
 */
function getDetailTF(){

	var chk=$("input[name='check_node_0']:checkbox").length;
	//���ֱ���ж�juery���﷨ʱ���ڣ�С��ֻ����gt()��eq()
	if(chk > 0){
		return true;
    }else{
    	return false;
    }
}

/**
 * @��ϵ�۸�䶯�������۸��Զ���ʼ����
 */
$(setMny).bind("propertychange",function(){
	var setMny2=parseFloat($(setMny).val());//��ϵ���
	var cjMny2=parseFloat($(setChaPrice).val());//��۽��
	//��ȡѡ���˵�valueֵ
    selectValue=$(associatorSelect).val();
	if(selectValue==0){//�ǻ�Ա
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(0);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(setMny2+cjMny2)));
		//$(totalMny).attr("disabled",true);
	}else if(selectValue==1){
		var p_assPrice=parseFloat($(associatorPrice).val(sm * 0.9));//������ͨ��Ա��
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(p_assPrice);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val(parseFloat(cjMny2+p_assPrice));
		//$(totalMny).attr("disabled",true);
	}else if(selectValue==2){
		var bj_assPrice=parseFloat($(associatorPrice).val(sm * 0.8));//����׽��Ա��
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(bj_assPrice);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val(parseFloat(cjMny2+bj_assPrice));
		//$(totalMny).attr("disabled",true);
	}else if(selectValue==3){
		var jk_assPrice=parseFloat($(associatorPrice).val(sm * 0.8));//����𿨻�Ա��
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(jk_assPrice);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val(parseFloat(cjMny2+jk_assPrice));
		//$(totalMny).attr("disabled",true);
	}
});
/**
 * @��Աѡ���Ա���ͺ���ݻ�Ա���ͼ����Ա�۸�
 */
$(associatorSelect).bind('change', function() {
	$(xsyhL).hide();
	$(xsyhF).hide();
	var txMny=parseFloat($(setMny).val()).toFixed(2);//��ϵ���
	var cjMny=parseFloat($(setChaPrice).val()).toFixed(2);//��۽��
	//��ȡѡ�е��ı�
	var selectText=$(associatorSelect).find("option:selected").text();
	if(selectText=="��ͨ��Ա"){
		$(associatorPrice).val(txMny * 0.9);//��ͨ��Ա��
		var p_assMny = parseFloat($(associatorPrice).val()).toFixed(2);
		$(xsyhL).show();//�Żݷ���
		$(xsyhF).show();
		//$(xsyhF).attr("disabled",false);
		$("#field6145 option[text='9���Ż�']").remove();
		$(xsyhF).prepend("<option value=2>9���Ż�</option>");
		$(xsyhF).attr("value",2);//0=���Ż�,1=8��,2=9��,3=��ϵ����,4=null
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
		//��Ա����
		$(asscaddNum).show();
		$(asscaddNumV).show();
		$(asscaddNumV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//��Ա�����
		$(assMny).show();
		$(assMnyV).show();
		$(assMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//�������ѽ��
		$(assXiaoFeiMny).show();
		$(assXiaoFeiMnyV).show();
		$(assXiaoFeiMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//�������ѽ���
		$(assJieYuMny).show();
		$(assJieYuMnyV).show();
		$(assJieYuMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	}else if(selectText=="�׽��Ա"){
		$(associatorPrice).val(txMny * 0.8);//�׽��Ա��
		var bj_assMny = parseFloat($(associatorPrice).val()).toFixed(2);
		$(xsyhL).show();
		$(xsyhF).show();
		$(txUpDateL).hide();
		$(txUpDateF).hide();
		//$(xsyhF).attr("disabled",false);
		$("#field6145 option[text='8���Ż�']").remove();
		$(xsyhF).prepend("<option value=1>8���Ż�</option>");
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
		//��Ա����
		$(asscaddNum).show();
		$(asscaddNumV).show();
		$(asscaddNumV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//��Ա�����
		$(assMny).show();
		$(assMnyV).show();
		$(assMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//�������ѽ��
		$(assXiaoFeiMny).show();
		$(assXiaoFeiMnyV).show();
		$(assXiaoFeiMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//�������ѽ���
		$(assJieYuMny).show();
		$(assJieYuMnyV).show();
		$(assJieYuMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	}else if(selectText=="�ǻ�Ա"){
		//$(this).trigger("blur");
		$(xsyhL).hide();
		$(xsyhF).hide();
		$(txUpDateL).hide();
		$(txUpDateF).hide();
		//$(xsyhF).attr("disabled",false);
		$("#field6145 option[text='���Ż�']").remove();
		$(xsyhF).prepend("<option value=0>���Ż�</option>");
		$(xsyhF).attr("value",0);
		//$(xsyhF).attr("disabled",true);
		$(associatorPriceL).hide();
		$(associatorPrice).hide();
		//$(associatorPrice).val(0);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny)+parseFloat(txMny)).toFixed(2));
		//$(totalMny).attr("disabled",true);
		//��Ա����
		$(asscaddNum).hide();
		$(asscaddNumV).hide();
		$(asscaddNumV+"span").html("");
		//��Ա�����
		$(assMny).hide();
		$(assMnyV).hide();
		$(assMnyV+"span").html("");
		//�������ѽ��
		$(assXiaoFeiMny).hide();
		$(assXiaoFeiMnyV).hide();
		$(assXiaoFeiMnyV+"span").html("");
		//�������ѽ���
		$(assJieYuMny).hide();
		$(assJieYuMnyV).hide();
		$(assJieYuMnyV+"span").html("");
	}else if(selectText=="�𿨻�Ա"){
		
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
		//��Ա����
		$(asscaddNum).show();
		$(asscaddNumV).show();
		$(asscaddNumV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//��Ա�����
		$(assMny).show();
		$(assMnyV).show();
		$(assMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//�������ѽ��
		$(assXiaoFeiMny).show();
		$(assXiaoFeiMnyV).show();
		$(assXiaoFeiMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
		//�������ѽ���
		$(assJieYuMny).show();
		$(assJieYuMnyV).show();
		$(assJieYuMnyV+"span").html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	}
});
//��ϵ�����������ۼ����Ѽ۸�
$(setChaPrice).bind('propertychange', function() {
	
	var _smMny=$(setMny).val();
	var _scMny=$(setChaPrice).val();//��۽��
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
//����仯����β��
$(depositMny).bind('propertychange', function() {
		var total=parseFloat(($(totalMny).val()));
		var deposit=parseFloat(($(depositMny).val()));
		//$(retainageMny).attr("disabled",false);
		$(retainageMny).val((total-deposit).toFixed(2));
		//$(retainageMny).attr("disabled",true);
});
//�ۼƽ��ı�����β����ı�
$(totalMny).bind('propertychange', function() {
      var total=parseFloat($(totalMny).val());
	  var deposit=parseFloat($(depositMny).val());
	 // $(retainageMny).attr("disabled",false);
	  $(retainageMny).val((total-deposit).toFixed(2));
	 // $(retainageMny).attr("disabled",true);
});
//�Żݷ���ѡ�����¼�
$(xsyhF).bind('change',function(){
	var txMny1=parseFloat($(setMny).val()).toFixed(2);//��ϵ���
	var cjMny1=parseFloat($(setChaPrice).val()).toFixed(2);//��۽��
	if(($(xsyhF).find("option:selected").text())=="��ϵ����"){
		$(txUpDateL).show();
		$(txUpDateF).show();
		//$(associatorPrice).attr("disabled",false);
		$(associatorPrice).val(txMny1);
		//$(associatorPrice).attr("disabled",true);
		//$(totalMny).attr("disabled",false);
		$(totalMny).val((parseFloat(cjMny1)+parseFloat(txMny1)).toFixed(2));
	//	$(totalMny).attr("disabled",true);
	}else if(($(xsyhF).find("option:selected").text())=="8���Ż�"){
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
		//����ϵ����ѡ��8���Ż�ʱ,�ж���ϸ���Ƿ�Ϊ��,�����Ϊ��Ҫ�����ϸ�����ѡ��ԭʼ��ϵ����
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

//ҳ���ʼ��ʱ���û�Ա״̬
if(selectText=="�ǻ�Ա"){
	//$(this).trigger("blur");
	//�Żݷ���
	$(xsyhL).hide();
	$(xsyhF).hide();
	//������ϵ
	$(txUpDateL).hide();
	$(txUpDateF).hide();
	//��Ա��
	$(associatorPriceL).hide();
	$(associatorPrice).hide();
	//�Żݷ���Ĭ��ֵ
	$(xsyhF).attr("disabled",false);
	$(xsyhF).attr("value",0);
	//��Ա����
	$(asscaddNum).hide();
	$(asscaddNumV).hide();
	//��Ա�����
	$(assMny).hide();
	$(assMnyV).hide();
	//�������ѽ��
	$(assXiaoFeiMny).hide();
	$(assXiaoFeiMnyV).hide();
	//�������ѽ���
	$(assJieYuMny).hide();
	$(assJieYuMnyV).hide();
}else if(selectText=="��ͨ��Ա"){
	$(associatorSelect).attr("disabled",flase);
	//�Żݷ���
	$(xsyhL).show();
	$(xsyhF).show();
	//������ϵ
	$(txUpDateL).hide();
	$(txUpDateF).hide();
	//��Ա��
	$(associatorPriceL).show();
	$(associatorPrice).show();
	//�Żݷ���Ĭ��ֵ
	//$(xsyhF).attr("disabled",false);
	$(xsyhF).attr("value",2);
	//$(xsyhF).attr("disabled",true);
	//��Ա�����
	$(assMny).show();
	$(assMnyV).show();
	//�������ѽ��
	$(assXiaoFeiMny).show();
	$(assXiaoFeiMnyV).show();
	//�������ѽ���
	$(assJieYuMny).show();
	$(assJieYuMnyV).show();
	
}else if(selectText=="�׽��Ա"){
	$(associatorSelect).attr("disabled",flase);
	//�Żݷ���
	$(xsyhL).show();
	$(xsyhF).show();
	//������ϵ
	$(txUpDateL).hide();
	$(txUpDateF).hide();
	//��Ա��
	$(associatorPriceL).show();
	$(associatorPrice).show();
	//�Żݷ���Ĭ��ֵ
	//$(xsyhF).attr("disabled",false);
	$(xsyhF).attr("value",1);
	//$(xsyhF).attr("disabled",true);
	//��Ա�����
	$(assMny).show();
	$(assMnyV).show();
	//�������ѽ��
	$(assXiaoFeiMny).show();
	$(assXiaoFeiMnyV).show();
	//�������ѽ���
	$(assJieYuMny).show();
	$(assJieYuMnyV).show();
}else if(selectText=="�𿨻�Ա"){
	$(associatorSelect).attr("disabled",flase);
	//�Żݷ���
	$(xsyhL).show();
	$(xsyhF).show();
	$(xsyhF).attr("value",1);
	//��Ա��
	$(associatorPriceL).show();
	$(associatorPrice).show();
	//��Ա�����
	$(assMny).show();
	$(assMnyV).show();
	//�������ѽ��
	$(assXiaoFeiMny).show();
	$(assXiaoFeiMnyV).show();
	//�������ѽ���
	$(assJieYuMny).show();
	$(assJieYuMnyV).show();
}
/**
 * @author LiuFe
 * @���������ť�ﵽֻ����Ч��
 */
window.onload = function() {
	//hideBrowserButton("#field0000");	// ���ز��������ť
	//hideBrowserButton("#field0000");	// ���طֲ������ť
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
	window.status="���ж����ʶ�ͯ��Ӱ";
});
//������Ӱ��Ϣ��ϸ������ʱ��Ҫ��Ĭ�ϸ�ֵ
function clearDetailDefaultValue(){
	var startDate="#field6042_";
	var startTime="#field6043_";
	var endTime="#field6044_";
	var shoter="#field6045_";
	var shotAssociator="#field6046_";
	var nowRow = parseFloat($G("indexnum2").value) - 1;
	//��ʼ����
	var startDateId=startDate+nowRow;
	var startDateSpan=startDateId+"span";
	$(startDateId).attr("value","");
	$(startDateSpan).html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	//��ʼʱ��
	var startTimeId=startTime+nowRow;
	var startTimeSpan=startTimeId+"span";
	$(startTimeId).attr("value","");
	$(startTimeSpan).html("<img align=\"absMiddle\" src=\"http://192.168.3.5/images/BacoError.gif\"/>");
	//����ʱ��
	var endTimeId=endTime+nowRow;
	var endTimeSpan=endTimeId+"span";
	$(endTimeId).attr("value","");
	$(endTimeSpan).html("");
	//��Ӱʦ
	var shoterId=shoter+nowRow;
	var shoterSpan=shoterId+"span";
	$(shoterId).attr("value","");
	$(shoterSpan).html("");
	//����
	var shotAssociatorId=shotAssociator+nowRow;
	var shotAssociatorSpan=shotAssociatorId+"span";
	$(shotAssociatorId).attr("value","");
	$(shotAssociatorSpan).html("");
}

//������Ƭ�ڵ�����ʱ�Զ�����Ԥ��ѡƬ����
function yJSelectPhotoDate(){
	var yJSelectDate="#field6115_";
	var nowRow = parseFloat($G("indexnum3").value) - 1;
	var yJSelectPhotoDateId=yJSelectDate+nowRow;
	var yJSelectDateSpan=yJSelectPhotoDateId+"span";
	$(yJSelectPhotoDateId).attr("value",getEightDay());
	$(yJSelectDateSpan).html(getEightDay());
}
//ȡ��ǰ���ڵ�8�������
function getEightDay(){
	//ȡ��ǰ����
	var _newDate=new Date();
	//����ǰ�ռ�������
	_newDate.setDate(_newDate.getDate()+8);
	//ƴ�������ַ���
	var str=""+_newDate.getFullYear()+"-";
	//�·ݼǵ�Ҫ��1���ǵ�ǰ��
	str += (_newDate.getMonth()+1)+"-";
	str += _newDate.getDate();
	return str;
}
//��д��ϸ��ɾ������
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
					//��¼��ɾ���ľɼ�¼ id��
					if(jQuery(oTable.rows[rowsum1].cells[0]).children().length>0 && jQuery(jQuery(oTable.rows[rowsum1].cells[0]).children()[0]).children().length>1){
						if($G("deldtlid"+groupid).value!=''){
							//����ϸ
							$G("deldtlid"+groupid).value+=","+jQuery(oTable.rows[rowsum1].cells[0].children[0]).children()[1].value;
						}else{
							//����ϸ
							$G("deldtlid"+groupid).value=jQuery(oTable.rows[rowsum1].cells[0]).children().eq(0).children()[1].value;
						}
					}
					//���ύ��Ŵ���ɾ����ɾ������
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
        alert('��ѡ����Ҫɾ��������');
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