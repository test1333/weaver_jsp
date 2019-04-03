<script type="text/javascript">

	var qj_id = "#field8668"; // 选择月度日常消耗品采购相关流程
	var Name_id = "field6938_"; // 商品名称
	var super_id = "field11172_"; // 供应商
	var qjxxID_id = "field6953_"; // 计划数量
	var qjxx_id = "field6954_"; // 计划单价
	var ycgsl_id = "field6956_"; // 已采购数量
	var unitname = "field6944_";//单位
	var catename = "field8519_";//所属类别
	var AvailableNumbers = "field9523_";//可采购数量
	var brand= "field6948_";//品牌
	var model = "field6949_";//型号
	var conf = "field6950_";//配置
	var bxfw= "field11047_";//保修范围
	var xbnf = "field8514_";//续保年费
	var ppb = "field11049_";
	var xhb = "field11050_";
	var pzb = "field11051_";
	var bxfwb = "field11052_";
	var xbnfb = "field11053_";	
	var sfyxjyz = "field11048_";
	var flag_s = "field11080";
       	var plannum = "field6953_";//计划数量
	var purchasenum = "field6945_";//采购数量
	var haspurchasenum = "field6956_";//已采购数量
			
      var jhyzf = "field14557_";//计划运杂费
      var sjyzf = "field14556_";//实际运杂费
      	  
	var planprice = "field6954_";//计划单价
    var purchaseprice = "field6943_"; //采购单价
    	var flag_d = "field11048_"; //明细flag
      var flag = "field11044";//flag

	var tmp_1 = "1231231";
jQuery(document).ready(function () {
       var flag_s_val =jQuery("#"+flag_s).val();
      if(flag_s_val == '1'){
              jQuery("#field8668_browserbtn").attr('disabled',true);
      	   yourFunction1();
      }
        jQuery(qj_id).bindPropertyChange(function (){ 
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var qj_id_val = jQuery(qj_id).val();
			xhr.open("GET","/seahonor/purchase/jsp/PlanPurchaseOrder.jsp?id="+qj_id_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);
							//25###签字水笔###63###3.00@@@24###饮水机###222###300.00@@@
							//alert("text= " + text);
							if(text != tmp_1){
								tmp_1 = text;   //这是判断二次触发的方法，

							var text_arr = text.split("@@@");						
							for(var i=0;i<text_arr.length-1;i++){
								addRow0(0);

								var tmp_arr = text_arr[i].split("###");						
								jQuery("#"+Name_id+i).val(tmp_arr[0]);//存放id							
								jQuery("#"+Name_id+i+"span").text(tmp_arr[1]);//存放名称
								jQuery("#"+qjxxID_id+i).val(tmp_arr[2]);
								jQuery("#"+qjxxID_id+i+"span").text(tmp_arr[2]);					
								jQuery("#"+ycgsl_id+i).val(tmp_arr[8]);
								jQuery("#"+ycgsl_id+i+"span").text(tmp_arr[8]);							
                                                            
							    var AvailableNumbers_val = Number(tmp_arr[2])-Number(tmp_arr[8]);
							    jQuery("#"+AvailableNumbers+i).val(AvailableNumbers_val);
							    jQuery("#"+AvailableNumbers+i+"span").text(AvailableNumbers_val);
							    jQuery("#"+qjxx_id+i).val(tmp_arr[3]);
								jQuery("#"+qjxx_id+i+"span").text(tmp_arr[3]);
								jQuery("#"+unitname+i).val(tmp_arr[5]);
								jQuery("#"+unitname+i+"span").text(tmp_arr[4]); 
                                                       jQuery("#"+catename+i).val(tmp_arr[7]);
								jQuery("#"+catename+i+"span").text(tmp_arr[6]);
								jQuery("#"+brand+i).val(tmp_arr[9]);
									jQuery("#"+ppb+i).val(tmp_arr[9]);
								jQuery("#"+model+i).val(tmp_arr[10]);
										jQuery("#"+xhb+i).val(tmp_arr[10]);
								jQuery("#"+conf+i).val(tmp_arr[11]);
									jQuery("#"+pzb+i).val(tmp_arr[11]);
								jQuery("#"+bxfw+i).val(tmp_arr[12]);
										jQuery("#"+bxfwb+i).val(tmp_arr[12]);
								jQuery("#"+xbnf+i).val(tmp_arr[13]);								
										jQuery("#"+xbnfb+i).val(tmp_arr[13]);	
														
							     	jQuery("#"+super_id+i).val(tmp_arr[14]);//存放id					
								jQuery("#"+super_id+i+"span").text(tmp_arr[15]);//存放名称
								jQuery("#"+jhyzf+i).val(tmp_arr[16]);//存放id		
								jQuery("#"+jhyzf+i+"span").text(tmp_arr[16]);//存放名称


							}
								jQuery("#"+flag_s).val('1');
							
						}
					}	
				}
			}
			xhr.send(null);			
		}
		   jQuery("#field8668_browserbtn").attr('disabled',true);
	        yourFunction1();
            
		//这是E7中的格式 功能是鼠标失效
		//jQuery(qj_id).parent().find(".Browser").attr('disabled',true);
	});

       
	checkCustomize = function() {
		var result = true;
		for(var index = 0; index<200; index++){
			if(jQuery("#"+flag_d+index).length>0){
				var flag_d_val = jQuery("#"+flag_d+index).val();
				if("1" == flag_d_val){
					jQuery("#"+flag).val("1");
			       }
			}else{
				index = 201;
	      	}
         	}
         	var index11=1;
		for(var index = 0; index<200; index++){
		       
			if(result){ 
				if(jQuery("#"+plannum+index).length>0){
					
					var plannum_val = jQuery("#"+plannum+index).val();
					var purchasenum_val = jQuery("#"+purchasenum+index).val();
					var haspurchasenum_val = jQuery("#"+haspurchasenum+index).val();
                                 var sfyxjyz_val = jQuery("#"+sfyxjyz+index).val();
                                  var jhyzf_val = jQuery("#"+jhyzf+index).val();
                                   var sjyzf_val = jQuery("#"+sjyzf+index).val();
                                 //alert(sfyxjyz_val);
					//alert("haspurchasenum_val="+haspurchasenum_val);
					var temp = Number(plannum_val)-Number(haspurchasenum_val);
					//alert("temp="+temp);

				
					var planprice_val = jQuery("#"+planprice+index).val();
					var purchaseprice_val = jQuery("#"+purchaseprice+index).val();
					
					//if (parseInt(purchasenum_val) > parseInt(plannum_val)) {
					//效果是一样的
					if (Number(purchasenum_val)<=0) {	
						result = false;
						alert("第"+index11+"行中：入库数量不能小于0");
						return result;
					}
					if (Number(purchasenum_val) > Number(temp)) {	
						result = false;
						alert("第"+index11+"行中：入库数量不应大于可采购数量，请您核对后提交。");
						return result;
					}
					if (Number(purchaseprice_val) > Number(planprice_val) && sfyxjyz_val !='1'){
						result = false;
						alert("第"+index11+"行中：入库单价不应大于计划单价，请您核对后提交。");
						return result;
					}
					
					if (Number(sjyzf_val) > Number(jhyzf_val) && sfyxjyz_val !='1'){
						result = false;
						alert("第"+index11+"行中：实际运杂费不应大于计划运杂费，请您核对后提交。");
						return result;
					}
					index11=index11+1;
					
				}else{
					index = 201;
				}
			}else{
				index = 201;
			}
		}	
		/*if(result == false) alert("采购数量大于计划数量或者采购单价大于计划单价！");*/
		return result;
	}
})
  function yourFunction1(){
    for(var index =0;index <100;index ++){
        if(jQuery("#"+Name_id+index).length>0){
            bindchange(index);
        }else{
        index  = 101;    
      }
     }
   }
function bindchange(index){
       jQuery("#"+sfyxjyz+index).bindPropertyChange(function () {
            var sfyxjyz_val= jQuery("#"+sfyxjyz+index).val();
             if(sfyxjyz_val == '0'){
                var ppb_val= jQuery("#"+ppb+index).val();
              var xhb_val= jQuery("#"+xhb+index).val();
               var pzb_val= jQuery("#"+pzb+index).val();
                var bxfwb_val= jQuery("#"+bxfwb+index).val();
                 var xbnfb_val= jQuery("#"+xbnfb+index).val();
                 	jQuery("#"+brand+index).val(ppb_val);					
			jQuery("#"+model+index).val(xhb_val);
			jQuery("#"+conf+index).val(pzb_val);
			jQuery("#"+bxfw+index).val(bxfwb_val);
			jQuery("#"+xbnf+index).val(xbnfb_val);
			
			jQuery("#"+brand+index+"_readonlytext").text(ppb_val);					
			jQuery("#"+model+index+"_readonlytext").text(xhb_val);
			jQuery("#"+conf+index+"_readonlytext").text(pzb_val);
			jQuery("#"+bxfw+index+"_readonlytext").text(bxfwb_val);
			jQuery("#"+xbnf+index+"_readonlytext").text(xbnfb_val);
             }
             if(sfyxjyz_val == '1'){
                 
			
			jQuery("#"+brand+index+"_readonlytext").text('');					
			jQuery("#"+model+index+"_readonlytext").text('');
			jQuery("#"+conf+index+"_readonlytext").text('');
			jQuery("#"+bxfw+index+"_readonlytext").text('');
			jQuery("#"+xbnf+index+"_readonlytext").text('');
             }
           
       })
}
</script>




































