<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var jtfhj="#field8090";//交通费合计
    var zsfhj="#field8091";//住宿费合计
    var cbfhj="#field8092";//餐补费合计
    var qtfhj="#field8093";//其他费合计
     var jtsehj="#field12141";//交通税额合计
    var zssehj="#field12142";//住宿税额合计
    var cbsehj="#field12143";//餐补税额合计
    var se_dt1="#field10758_";//税额
    var ws_dt1="#field10757_";//未税
    var bxje_dt1="#field8099_";//报销金额
    
        var fplx_dt4="#field12469_";//发票类型4
    var fphm_dt4="#field12470_";//发票号码4
    var sfcf_dt4="#field12472_";//是否重复4
    	   
       var fplx_dt5="#field12473_";//发票类型5
    var fphm_dt5="#field12474_";//发票号码5
    var sfcf_dt5="#field12476_";//是否重复5
    	   
       var fplx_dt6="#field12477_";//发票类型6
    var fphm_dt6="#field12478_";//发票号码6
    var sfcf_dt6="#field12480_";//是否重复6
    	   
    var fplx_dt7="#field12481_";//发票类型7
    var fphm_dt7="#field12482_";//发票号码7
    var sfcf_dt7="#field12484_";//是否重复7
	
	var djbh="#field8069";//单据编号
    jQuery(document).ready(function(){
    
       jQuery(jtfhj).bindPropertyChange(function () {
       	   addmoney();
       });
       jQuery(zsfhj).bindPropertyChange(function () {
       	    addmoney();
       });
       jQuery(cbfhj).bindPropertyChange(function () {
       	   addmoney();
       });
       jQuery(qtfhj).bindPropertyChange(function () {
       	   addmoney();
       });
       jQuery(jtsehj).bindPropertyChange(function () {
       	    addmoney2();
       });
       jQuery(zssehj).bindPropertyChange(function () {
       	   addmoney2();
       });
       jQuery(cbsehj).bindPropertyChange(function () {
       	   addmoney2();
       });
       	checkCustomize = function(){
			 var djbh_val = jQuery(djbh).val(); 
    		var indexnum3 = jQuery("#indexnum3").val();
    		 var countnum4=0;
    		 for(var index=0; index<indexnum3;index++){
    		 	 if(jQuery(fplx_dt4+index).length>0){
    		 	 	 countnum4=countnum4+1;
    		 	 	  var fplx_dt4_val=jQuery(fplx_dt4+index).val();
    		 	    	  var fphm_dt4_val=jQuery(fphm_dt4+index).val();
    		 	    	   var sfcf_dt4_val=jQuery(sfcf_dt4+index).val();
    		 	    	   if(fplx_dt4_val == "1" && fphm_dt4_val !=""){
    		 	    	   	   if(sfcf_dt4_val !=""&& sfcf_dt4_val != djbh_val){
    		 	    	   	    Dialog.alert("交通费 第"+countnum4+"行明细的发票号码（"+fphm_dt4_val+"）已在流程编号为（"+sfcf_dt4_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    			var indexnum4 = jQuery("#indexnum4").val();
    		 var countnum5=0;
    		 for(var index=0; index<indexnum4;index++){
    		 	 if(jQuery(fplx_dt5+index).length>0){
    		 	 	 countnum5=countnum5+1;
    		 	 	  var fplx_dt5_val=jQuery(fplx_dt5+index).val();
    		 	    	  var fphm_dt5_val=jQuery(fphm_dt5+index).val();
    		 	    	   var sfcf_dt5_val=jQuery(sfcf_dt5+index).val();
    		 	    	   if(fplx_dt5_val == "1" && fphm_dt5_val !=""){
    		 	    	   	   if(sfcf_dt5_val !=""&& sfcf_dt5_val != djbh_val ){
    		 	    	   	    Dialog.alert("住宿费第"+countnum5+"行明细的发票号码（"+fphm_dt5_val+"）已在流程编号为（"+sfcf_dt5_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    		
    			var indexnum5 = jQuery("#indexnum5").val();
    		 var countnum6=0;
    		 for(var index=0; index<indexnum5;index++){
    		 	 if(jQuery(fplx_dt6+index).length>0){
    		 	 	 countnum6=countnum6+1;
    		 	 	  var fplx_dt6_val=jQuery(fplx_dt6+index).val();
    		 	    	  var fphm_dt6_val=jQuery(fphm_dt6+index).val();
    		 	    	   var sfcf_dt6_val=jQuery(sfcf_dt6+index).val();
    		 	    	   if(fplx_dt6_val == "1" && fphm_dt6_val !=""){
    		 	    	   	   if(sfcf_dt6_val !=""&& sfcf_dt6_val != djbh_val){
    		 	    	   	    Dialog.alert("餐补费第"+countnum6+"行明细的发票号码（"+fphm_dt6_val+"）已在流程编号为（"+sfcf_dt6_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    			var indexnum6 = jQuery("#indexnum6").val();
    		 var countnum7=0;
    		 for(var index=0; index<indexnum6;index++){
    		 	 if(jQuery(fplx_dt7+index).length>0){
    		 	 	 countnum7=countnum7+1;
    		 	 	  var fplx_dt7_val=jQuery(fplx_dt7+index).val();
    		 	    	  var fphm_dt7_val=jQuery(fphm_dt7+index).val();
    		 	    	   var sfcf_dt7_val=jQuery(sfcf_dt7+index).val();
    		 	    	   if(fplx_dt7_val == "1" && fphm_dt7_val !=""){
    		 	    	   	   if(sfcf_dt7_val !=""&& sfcf_dt7_val != djbh_val){
    		 	    	   	    Dialog.alert("其他费用第"+countnum7+"行明细的发票号码（"+fphm_dt7_val+"）已在流程编号为（"+sfcf_dt7_val+"）的流程中使用，请检查");
    		 	 	  	      return false;
    		 	    	          }
    		 	    	  }
    		        }
    		}
    		return true;
       }
   });
   function addmoney(){
   	   var nodesnum0 = jQuery("#nodesnum0").val();
   	   if(nodesnum0>1){
   	   	 return;  
         }
   	   var jtfhj_val=jQuery(jtfhj).val();
   	   var zsfhj_val=jQuery(zsfhj).val();
   	   var cbfhj_val=jQuery(cbfhj).val();
   	   var qtfhj_val=jQuery(qtfhj).val();
   	   if(jtfhj_val==""){
   	   	  jtfhj_val = "0"; 
   	 }
   	 if(zsfhj_val==""){
   	   	  zsfhj_val = "0"; 
   	 }
   	 if(cbfhj_val==""){
   	   	  cbfhj_val = "0"; 
   	 }
   	 if(qtfhj_val==""){
   	   	  qtfhj_val = "0"; 
   	 }
   	 var money=accAdd(jtfhj_val,zsfhj_val);
   	 money=accAdd(money,cbfhj_val);
   	 money=accAdd(money,qtfhj_val);
   	 var indexnum0 = jQuery("#indexnum0").val();
   	 for(var index=0;index<indexnum0;index++){
 	  	 if (jQuery(bxje_dt1 + index).length > 0) {
 	  	 	 jQuery(bxje_dt1 + index).val(money);
 	  	 	 var bxje_dt1_val=jQuery(bxje_dt1 + index).val();
 	  	 	 var se_dt1_val=jQuery(se_dt1 + index).val();
 	  	 	 if(bxje_dt1_val==""){
   	   	  		bxje_dt1_val = "0"; 
   			 }
   			 if(se_dt1_val==""){
   	   	  		se_dt1_val = "0"; 
   	 		}
 	  	 	 var ws_dt1_val=accSub(bxje_dt1_val,se_dt1_val);
 	  	 	 jQuery(ws_dt1 + index).val(ws_dt1_val);
 	  	 	 jQuery(ws_dt1 + index+"span").text(ws_dt1_val);
 	  	 	 calSum(0);
 	  	 	 break;
 	  	 }
 	}
  }
    function addmoney2(){
   	   var nodesnum0 = jQuery("#nodesnum0").val();
   	   if(nodesnum0>1){
   	   	 return;  
         }
   	   var jtsehj_val=jQuery(jtsehj).val();
   	   var zssehj_val=jQuery(zssehj).val();
   	   var cbsehj_val=jQuery(cbsehj).val();
   	   if(jtsehj_val==""){
   	   	  jtsehj_val = "0"; 
   	 }
   	 if(zssehj_val==""){
   	   	  zssehj_val = "0"; 
   	 }
   	 if(cbsehj_val==""){
   	   	  cbsehj_val = "0"; 
   	 }
   	 var money=accAdd(jtsehj_val,zssehj_val);
   	 money=accAdd(money,cbsehj_val);
   	 var indexnum0 = jQuery("#indexnum0").val();
   	 for(var index=0;index<indexnum0;index++){
 	  	 if (jQuery(se_dt1 + index).length > 0) {
 	  	 	 jQuery(se_dt1 + index).val(money);
 	  	 	 var bxje_dt1_val=jQuery(bxje_dt1 + index).val();
 	  	 	 var se_dt1_val=jQuery(se_dt1 + index).val();
 	  	 	 if(bxje_dt1_val==""){
   	   	  		bxje_dt1_val = "0"; 
   			 }
   			 if(se_dt1_val==""){
   	   	  		se_dt1_val = "0"; 
   	 		}
 	  	 	 var ws_dt1_val=accSub(bxje_dt1_val,se_dt1_val);
 	  	 	 jQuery(ws_dt1 + index).val(ws_dt1_val);
 	  	 	 jQuery(ws_dt1 + index+"span").text(ws_dt1_val);
 	  	 	 calSum(0);
 	  	 	 break;
 	  	 }
 	}
  }
function accSub(arg1,arg2){
   var r1,r2,m,n;
    try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0}
     try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0}
       m=Math.pow(10,Math.max(r1,r2));
       //动态控制精度长度
       n=(r1>=r2)?r1:r2;
       return ((arg1*m-arg2*m)/m).toFixed(n);
}

 function accAdd(arg1,arg2){ 
    var r1,r2,m; try{r1=arg1.toString().split(".")[1].length}catch(e){r1=0} 
    try{r2=arg2.toString().split(".")[1].length}catch(e){r2=0} 
    m=Math.pow(10,Math.max(r1,r2)) 
    return (arg1*m+arg2*m)/m 
} 
</script>

