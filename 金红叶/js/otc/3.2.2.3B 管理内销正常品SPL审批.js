<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var xc_dt2 = "#field31305_";//项次 明细2
//var zz_dt2 = "#field31306_";//纸种 明细2
//var pp_dt2 = "#field31310_";//品牌 明细2
//var kz_dt2 = "#field31307_";//克重 明细2
var yf_dt2 = "#field31318_";//月返 明细2
var jf_dt2 = "#field31319_";//季返 明细2
//var nf_dt2 = "#field31320_";//年返 明细2
var wh_dt2 = "#field31665_";//维护 明细2

var yearq="#field31280";//年起
var yearz="#field31282";//年止
var monthq="#field32027";//月起
var monthz="#field32028";//月止
jQuery(document).ready(function () {
	var dqczr = wf__info.f_bel_userid;
	var rqid = document.getElementsByName("requestid")[0].value;
	var workflowid = document.getElementsByName("workflowid")[0].value;
	var indexnum1= jQuery("#indexnum1").val();
	for(var index=0;index<indexnum1;index++ ){
        if(jQuery(wh_dt2+index).length>0){
			var xc_dt2_val=jQuery(xc_dt2+index).val();
			if(xc_dt2_val !=''){
				jQuery(wh_dt2+index+"span").html("<a href=\"javascript:editInfo('"+xc_dt2_val+"','"+dqczr+"','"+rqid+"','"+workflowid+"','"+index+"')\">维护</a>");
			}
        }
    }	
	checkCustomize = function(){
		var yearq_val=jQuery(yearq).val();
		var yearz_val=jQuery(yearz).val();
		var monthq_val=jQuery(monthq).val();
		var monthz_val=jQuery(monthz).val();
		if(yearq_val !="" && yearz_val !="" && monthq_val !="" && monthz_val !=""){
			if(yearz_val == yearq_val && monthq_val > monthz_val){
			   window.top.Dialog.alert("工厂核决有效期止必须大于工厂核决有效期起,请检查");
			   return false;
			}
			
			if(yearz_val < yearq_val){
			   window.top.Dialog.alert("工厂核决有效期止必须大于工厂核决有效期起,请检查");
			   return false;			
			}
		}
		
		return true;
	}
})
 function editInfo(xc,dqczr,rqid,wfid,index) { 
		var title = "";
		var url = "/appdevjsp/HQ/OTC/forward.jsp?xc="+xc+"&dqczr="+dqczr+"&rqid="+rqid+"&wfid="+wfid;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 900;
		diag_vote.Height = 500;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;		
		diag_vote.CancelEvent=function(){diag_vote.close();
			jQuery.post("/appdevjsp/HQ/OTC/getitemdata.jsp", {
                    'xc': xc,
                    'rqid':rqid,
                    'wfid':wfid
                }, function (data) {
                    //alert(data);
                    	data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						var text_arr = data.split("###");
						jQuery(yf_dt2+index).val(text_arr[0]);
						jQuery(jf_dt2+index).val(text_arr[1]);
                    	
            });	
		};
		diag_vote.show();
		
	}
</script>
