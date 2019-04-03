<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var jkr="#field18471";//借款人
var bz_dt1="#field18514_";//币种明细1
var bz1_dt1="#disfield18514_";
var ybye_dt1="#field18515_";//原币金额 明细1
var yqje_dt1="#field18516_";//逾期金额 明细1
var kh="#field18785";//卡号
var jklcdh="#field18784";//借款流程单号
var yjkye_dt2="#field18518_";//原借款余额 明细2
var jkye_dt2="#field18519_";//借款余额 明细2
var jkid_dt2="#field18770_";//借款id 明细2
var sxfhqt_dt2="#field18527_";//手续费或其他 明细2
var zxwd_dt2="#field18521_";//在线文档 明细2
var scfj_dt2="#field18522_";//上传附件 明细2
jQuery(document).ready(function(){
	 checkCustomize = function(){ 
	      var indexnum1=  jQuery("#indexnum1").val();
		  var count=0;
		  for(var index=0;index<indexnum1;index++ ){
			   if(jQuery(sxfhqt_dt2+index).length>0){
				   count=count+1;
				   var  sxfhqt_dt2_val=jQuery(sxfhqt_dt2+index).val();
				   if(sxfhqt_dt2_val == ""){
					 sxfhqt_dt2_val = "0";   
				   }
				   if(Number(sxfhqt_dt2_val) != 0){
					 var zxwd_dt2_val=jQuery(zxwd_dt2+index).val();
					 var scfj_dt2_val=jQuery(scfj_dt2+index).val();
					 if(zxwd_dt2_val==""||scfj_dt2_val==""){
						 alert("第"+count+"行明细在线文档和上传附件必填，请填写");
						 return false;
					 }
				   }
			   }
		  }
		return true;
	 }
	 doUrl();
});
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
