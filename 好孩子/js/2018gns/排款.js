<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var dpkid_dt1="#field16164_";//带排款明细id
var xx_dt1="#field16165_";  //详细
var jhfkzje = "#field12321";  //计划付款总金额
var pzfkzje = "#field12323";  //批准付款总金额
var sjfkzje = "#field12324";  //实际付款总金额
jQuery(document).ready(function () {
	var rqid_val=document.getElementsByName("requestid")[0].value;    
	var nodenum0 = jQuery("#nodesnum0").val();
	var indexnum0 = jQuery("#indexnum0").val();
	if(nodenum0 >0){
		 for(var index=0;index<indexnum0;index++ ){
            if(jQuery(dpkid_dt1+index).length>0){
                var dpkid_dt1_val =jQuery(dpkid_dt1+index).val();
                
                jQuery(xx_dt1+index+"span").html("<a href=\"javascript:showxx('"+dpkid_dt1_val+"','"+rqid_val+"','"+index+"')\">详细</a>");                           
            }
         }
		
	}
	checkCustomize = function(){
		var jhfkzje_val = jQuery(jhfkzje).val();
		var pzfkzje_val = jQuery(pzfkzje).val();
		var sjfkzje_val = jQuery(sjfkzje).val();
		if(jhfkzje_val == ""){
			jhfkzje_val = "0";
		}
		if(pzfkzje_val == ""){
			pzfkzje_val = "0";
		}
		if(sjfkzje_val == ""){
			sjfkzje_val = "0";
		}
		if(Number(pzfkzje_val)>Number(jhfkzje_val)){
			window.top.Dialog.alert("批准付款总金额不能大于计划付款总金额");
			return false;
		}
		if(Number(sjfkzje_val)>Number(pzfkzje_val)){
			window.top.Dialog.alert("实际付款总金额不能大于批准付款总金额");
			return false;
		}
		return true;
		
	}
});
function showxx(dpkids,rqid,index) {
	var title = "";
	var url = "/goodbaby/pklc/payment-plan-detail-Url.jsp?dpkids="+dpkids+"&rqid="+rqid;	
	var diag_vote = new window.top.Dialog();
	diag_vote.currentWindow = window;
	diag_vote.Width = 1000;
	diag_vote.Height = 750;
	diag_vote.Modal = true;
	diag_vote.Title = title;
	diag_vote.URL = url;
	diag_vote.isIframe=false;
	diag_vote.CancelEvent=function(){diag_vote.close();	
	};
	diag_vote.show();
		
}
	
</script>
