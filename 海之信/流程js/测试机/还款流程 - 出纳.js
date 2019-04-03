<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	
var sqrq="#field15723";//申请日期
var jkbz="#field15724";//借款币种
var jkr="#field15722";//借款人
var bz_dt1="#field16965_";//币种明细1
var bz1_dt1="#disfield16965_";
var ybye_dt1="#field16724_";//原币金额 明细1
var yqje_dt1="#field16725_";//逾期金额 明细1
var hkbz_dt2="#field15737_";//还款币种明细1
var dishkbz_dt2="#disfield15737_";//还款币种明细1	
var	jkje_dt2="#field16726_";//借款金额明细1	
var bchkje_dt2="#field16727_";//本次还款金额明细1
var cnskje_dt2="#field16718_";//出纳收款金额金额明细1		
var hkbz_dt3="#field16362_";//还款币种明细1
var dishkbz_dt3="#disfield16362_";//还款币种明细1	
var	jkje_dt3="#field16729_";//借款金额明细1	
var bchkje_dt3="#field16730_";//本次还款金额明细1
var cnskje_dt3="#field16720_";//出纳收款金额金额明细1			
jQuery(document).ready(function(){
	
	 setTimeout('getData()',500);
	  checkCustomize = function () {
		var indexnum1=  jQuery("#indexnum1").val();
		for(var i=0;i<indexnum1;i++){
			if(jQuery(bchkje_dt2+i).length>0){
				var bchkje_dt2_val=jQuery(bchkje_dt2+i).val().replace(/,/g,'');
				var cnskje_dt2_val=jQuery(cnskje_dt2+i).val().replace(/,/g,'');
				if(bchkje_dt2_val == ""){
					bchkje_dt2_val = "0";
				}
				if(cnskje_dt2_val == ""){
					cnskje_dt2_val = "0";
				}
				if(Number(cnskje_dt2_val)>Number(bchkje_dt2_val)){
				 alert("存在出纳收款金额大于本次还款金额的情况，请检查");
					return false;
				}
			}
		}	
		var indexnum2=  jQuery("#indexnum2").val();
		for(var i=0;i<indexnum2;i++){
			if(jQuery(bchkje_dt3+i).length>0){
				var bchkje_dt3_val=jQuery(bchkje_dt3+i).val().replace(/,/g,'');
				var cnskje_dt3_val=jQuery(cnskje_dt3+i).val().replace(/,/g,'');
				if(bchkje_dt3_val == ""){
					bchkje_dt3_val = "0";
				}
				if(cnskje_dt3_val == ""){
					cnskje_dt3_val = "0";
				}
				if(Number(cnskje_dt3_val)>Number(bchkje_dt3_val)){
				 alert("存在出纳收款金额大于本次还款金额的情况，请检查");
					return false;
				}
			}
		}
			return true;
	  }
	
 });
 

 
 
function getData(){
	var jkr_val = jQuery(jkr).val();
	 var jkbz_val=jQuery(jkbz).val();
	var nodesnum0 = jQuery("#nodesnum0").val();
   
    doUrl();
    
}


function doUrl(){
  	var indexnum0=  jQuery("#indexnum0").val();
  	for(var i=0;i<indexnum0;i++){
  	   if(jQuery(bz_dt1+i).length>0){
  	   	   var jkr_val=jQuery(jkr).val();
  	       var ybye_val=jQuery(ybye_dt1+i).val();
  	       var bz_val=jQuery(bz_dt1+i).val();
  	       var typex="";
  	       var url="";
  	       if(Number(ybye_val) !=0){
	  	       ybye_val=Number(ybye_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
	  	       typex="1,"+jkr_val+","+bz_val;
	  	       url="<a href=\"javascript:showInfo(\'"+typex+"\')\">"+ybye_val+"</a>";
	  	       jQuery(ybye_dt1+i+"span").html(url);
  	       }
  	        var yqje_val=jQuery(yqje_dt1+i).val();
  	        if(Number(yqje_val) !=0){
  	        	yqje_val=Number(yqje_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
  	        	typex="2,"+jkr_val+","+bz_val;
  	        	url="<a href=\"javascript:showInfo(\'"+typex+"\')\">"+yqje_val+"</a>";
  	        	jQuery(yqje_dt1+i+"span").html(url);
  	        }
  	       
  	      
        }		   
    }
}




function addDate(date,days){ 
    var d=new Date(date); 
    d.setDate(d.getDate()+days); 
    var m=d.getMonth()+1; 
    return d.getFullYear()+'-'+m+'-'+d.getDate(); 
}
 
function showInfo(typex) {

		var title = "";
		var url = "/seahonor/expenses/forward.jsp?typex="+typex;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
	
		diag_vote.show();
		
}   
</script>
