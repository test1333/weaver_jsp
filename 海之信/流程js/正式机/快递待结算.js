<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
        var CourierCompanyFee = "#field7028";//快递公司费用
	var ActualTotalFee = "#field7029";//实际总费用
	var qj_id = "#field7038"; // 获取快递公司
	var Name_id = "field7031_"; // 寄件人
	var qjxxID_id = "field7032_"; // 寄件日期
	var Money_id = "field7033_"; // 快递费用
        var Moneyold_id = "field11077_"; // 快递费用old
	var ActualFee_id = "field7034_"; // 实际费用
	var ReceiverAdd_id = "field7035_"; // 收件地址·
	var val_id = "#field7039";//传值
	var flag_id ="#field11059";
        var kn_id = "field10252_";
        var val_detail_id = "field11079_";
        var state1_id = "field11060_";
        var state1_disid = "disfield11060_";
        var explain_id = "field11078_";
	//String val = Util.null2String(rs.getString("val"));
        var flag2_id ="#field11081";

	// 延迟加载1000s
        var flag2_id_val = jQuery(flag2_id).val();
        if(flag2_id_val != '1'){
	setTimeout("testa()",1000);
        }

		//$(qj_id).bindPropertyChange(function (){   这是e8中的格式
    //    $(qj_id).bindPropertyChange(function (){ 

    function testa(){ 
                var flag_id_val = jQuery(flag_id).val();
                if(flag_id_val !='1'){
                
		var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			//var qj_id_val = jQuery(qj_id).val();
			var val_id_val = jQuery(val_id).val();
			//alert("val_id_val="+val_id_val);
			xhr.open("GET","/seahonor/express/jsp/InsertCourierCompany.jsp?val="+val_id_val, false);//通过流程按钮选择的值，通过jquery把值传到jsp页面中去。
			xhr.onreadystatechange = function () {

						if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;//responseText方法是什么作用    
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
							//alert("text= " + text);

							var text_arr = text.split("@@@");
							var sum = 0;

							for(var i=0;i<text_arr.length-1;i++){

								addRow0(0);

								var tmp_arr = text_arr[i].split("###");
							
								jQuery("#"+Name_id+i).val(tmp_arr[0]);
								//document.getElementById(Name_id+i).readOnly=true;
								jQuery("#"+Name_id+i+"span").text(tmp_arr[1]);

								jQuery("#"+qjxxID_id+i).val(tmp_arr[2]);
								jQuery("#"+qjxxID_id+i+"span").text(tmp_arr[2]);

								jQuery("#"+Money_id+i).val(tmp_arr[3]);			
								jQuery("#"+Money_id+i+"span").text("");
                                                                jQuery("#"+Moneyold_id+i).val(tmp_arr[3]);
                                                                jQuery("#"+Moneyold_id+i+"span").text(tmp_arr[3]);

								jQuery("#"+ActualFee_id+i).val(tmp_arr[4]);
								//这是去掉必填号的
								jQuery("#"+ActualFee_id+i+"span").text("");

								//获得总得实际总费用	
								sum =Number(sum)+Number(jQuery("#"+ActualFee_id+i).val());
								//alert("sum="+sum);

                                                                jQuery("#"+kn_id+i).val(tmp_arr[5]);			
								jQuery("#"+kn_id+i+"span").text(tmp_arr[5]);

								jQuery("#"+ReceiverAdd_id+i).val(tmp_arr[6]);
								jQuery("#"+ReceiverAdd_id+i+"span").text(tmp_arr[6]);

                                                                jQuery("#"+val_detail_id+i).val(tmp_arr[7]);
								jQuery("#"+val_detail_id+i+"span").text(tmp_arr[7]);
                                                                
                                                                 jQuery("#"+state1_id +i).val(tmp_arr[8]);
								 jQuery("#"+state1_disid +i).val(tmp_arr[8]);

							}	

                                                                 jQuery(flag_id).val('1');

								//给实际总费用赋值
								jQuery("#field7029").val(sum);
								jQuery("#field7029span").text(sum);
								
								jQuery("#field7028").val(sum);
								jQuery("#field7028span").text(sum);
calSum(0);
						}
					}
				}
			xhr.send(null);
		}
           }
         bindchange();
	}

function bindchange(){
    for(var index =0;index <900;index ++){
        if(jQuery("#"+ActualFee_id+index).length>0){
           var state_val =  jQuery("#"+state1_id +index).val();
            if(state_val != "2" ){
             ismeth(index );
            }
        }else{
          index = 901;
        }
    }
}

function ismeth(index){

   jQuery("#"+ActualFee_id+index).bindPropertyChange(function () {
    var ActualFee_val= jQuery("#"+ActualFee_id+index).val();
              var Moneyold_val= jQuery("#"+Moneyold_id+index).val();
    if(Number(ActualFee_val) != Number(Moneyold_val)){
       jQuery("#"+state1_id +index).val("1");
       jQuery("#"+state1_disid +index).val("1")
   }else{
     jQuery("#"+state1_id +index).val("0");
       jQuery("#"+state1_disid +index).val("0")
   }
  })
}

 jQuery(document).ready(function() {
      setTimeout("read()",1000);
      dodetail();
   checkCustomize = function() {
       for(var index =0;index <900;index ++){
           if(jQuery("#"+state1_id+index).length>0){
                var state_val =  jQuery("#"+state1_id +index).val();
                var explain = jQuery("#"+explain_id +index).val();
                 if( state_val =="1" &&  explain  == "" ){
                      alert("异常状态的快递，需填写异常说明");
                      return false;
                 }
            }else{
             index = 901;
           }
       }
      jQuery(flag2_id).val('1');
      var CourierCompanyFee_val = jQuery(CourierCompanyFee).val();
        var ActualTotalFee_val = jQuery(ActualTotalFee).val();
             var result = true;
		if (Number(CourierCompanyFee_val) > Number(ActualTotalFee_val)) {
			result = false;
			alert("快递结算费用大于行政登记费用，请核对后再申请！");
		}

		return result;
    }
 })
 function dodetail(){
 var indexnum0 = jQuery("#indexnum0").val(); 	 
   	 for(var index=0;index<indexnum0;index++){
   	 	 	 if (jQuery("#"+ActualFee_id+ index).length > 0) {
   	 	 	 	  var ActualFee_val= jQuery("#"+ActualFee_id+index).val();
              var Moneyold_val= jQuery("#"+Moneyold_id+index).val(); 
               if(Number(ActualFee_val) != Number(Moneyold_val)){
      		 jQuery("#"+state1_id +index).val("1");
     		  jQuery("#"+state1_disid +index).val("1")
   		}else{
      		 jQuery("#"+state1_id +index).val("0");
      		 jQuery("#"+state1_disid +index).val("0")
        }
   	 	     }
        }
}
function ismeth2(index){

   jQuery("#"+ActualFee_id+index).bindPropertyChange(function () {
    var ActualFee_val= jQuery("#"+ActualFee_id+index).val();
              var Moneyold_val= jQuery("#"+Moneyold_id+index).val();
    if(Number(ActualFee_val) != Number(Moneyold_val)){
       jQuery("#"+state1_id +index).val("1");
       jQuery("#"+state1_disid +index).val("1")
   }else{
       jQuery("#"+state1_id +index).val("0");
       jQuery("#"+state1_disid +index).val("0")

   }
  })
}



 function read(){
  var flag2_id_val1 = jQuery(flag2_id).val();
  if(flag2_id_val1 == '1'){  
    for(var index =0;index<900;index ++){
      if(jQuery("#"+state1_id +index).length>0){
       var state_val =  jQuery("#"+state1_id +index).val();
        if( state_val !="1"&& state_val != "2" ){
         document.getElementById(Money_id+index).readOnly=true;
         document.getElementById(ActualFee_id+index).readOnly=true;
         ismeth2(index );
        } 
        
     }else{
       index = 901;
     }
     }
  
  }
 }

</script>















































































