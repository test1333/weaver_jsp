<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var dpkid_dt1="#field16164_";
var xx_dt1="#field16165_";  

jQuery(document).ready(function () {
	var nodenum0 = jQuery("#nodesnum0").val();
	var indexnum0 = jQuery("#indexnum0").val();
	if(nodenum0 >0){
		 for(var index=0;index<indexnum0;index++ ){
            if(jQuery(dpkid_dt1+index).length>0){
                var dpkid_dt1_val =jQuery(dpkid_dt1+index).val();
                
                jQuery(xx_dt1+index+"span").html("<a href=\"javascript:showxx('"+dpkid_dt1_val+"','0','"+index+"')\">详细</a>");                           
            }
         }
		
	}
});
function showxx(dpkids,canedit,index) {
	var title = "";
	var url = "/systeminfo/BrowserMain.jsp?url=/goodbaby/pklc/payment-plan-detail-Url.jsp?dpkids="+dpkids+"&canedit="+canedit;
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
