<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var fycdf = "#field17308";     //费用承担方
var rqid = "#field17726";
var bxr="#field17306";//报销人
var bxje_dt1="#field17768_";//报销金额明细1
var jmid_dt1="#field17783_";//建模id明细1
var bxje_dt2="#field17773_";//报销金额明细2
var jmid_dt2="#field17784_";//建模id明细2
var cjr="#field17304";//创建人
var dqccz="#field17810";//当前操作者
jQuery(document).ready(function(){
    showhide();
    jQuery(fycdf).bind("change",function(){
      showhide();
   });
   jQuery("#hzxcd").html("<a href=\"javascript:showInfo(\'0\')\">海之信承担</a>");
   jQuery("#khcd").html("<a href=\"javascript:showInfo(\'1\')\">客户承担</a>");
   doUrl();
  });
function showhide(){
    var fycdf_val = jQuery(fycdf).val();
    if(fycdf_val == ""){
      jQuery("#ycmx1").hide();	 
      jQuery("#ycmx2").hide();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
    }else if(fycdf_val == "0"){
      jQuery("#ycmx1").show();
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
    }else if(fycdf_val == "1"){
      jQuery("#ycmx1").show();
      jQuery("#ycmx2").show();
      jQuery("#ycmx3").hide();
      jQuery("#ycmx4").hide();
    }else if(fycdf_val == "2"){
      jQuery("#ycmx3").show();
      jQuery("#ycmx4").show();
      jQuery("#ycmx1").hide();
      jQuery("#ycmx2").hide();
    }
} 

function showInfo(type) {
        var rqid_val=jQuery(rqid).val();
		if(rqid_val == '' || rqid_val == '0'){
				alert("请先保存流程再进行创建");
				return;
		}
		var bxr_val=jQuery(bxr).val();
		if(bxr_val==""){
			alert("请先填写报销人");
				return;
		}
		var title = "";
		var url = "/formmode/view/AddFormMode.jsp?modeId=261&formId=-417&type=1&field17575="+bxr_val+"&field17574="+rqid_val+"&field17589="+type;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.maxiumnable = true;
		diag_vote.Width = 1200;
		diag_vote.Height = 1000;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		 diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		diag_vote.show();
		
}  
function doUrl(){
  	var indexnum0=  jQuery("#indexnum0").val();
  	for(var i=0;i<indexnum0;i++){
  	   if(jQuery(bxje_dt1+i).length>0){
  	       var bxje_dt1_val=jQuery(bxje_dt1+i).val();
  	       var jmid_dt1_val=jQuery(jmid_dt1+i).val();
  	       var typex="";
  	       var url="";
  	       bxje_dt1_val=Number(bxje_dt1_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
	  	   url="<a href=\"javascript:showInfo2(\'"+jmid_dt1_val+"\')\">"+bxje_dt1_val+"</a>";
	  	   jQuery(bxje_dt1+i+"span").html(url);
  	       
  	       
  	      
        }		   
    }
	var indexnum1=  jQuery("#indexnum1").val();
  	for(var i=0;i<indexnum1;i++){
  	   if(jQuery(bxje_dt2+i).length>0){
  	       var bxje_dt2_val=jQuery(bxje_dt2+i).val();
  	       var jmid_dt2_val=jQuery(jmid_dt2+i).val();
  	       var typex="";
  	       var url="";
  	       bxje_dt2_val=Number(bxje_dt2_val).toFixed(2).replace(/(\d)(?=(\d{3})+\.)/g, '$1,');
	  	   url="<a href=\"javascript:showInfo2(\'"+jmid_dt2_val+"\')\">"+bxje_dt2_val+"</a>";
	  	   jQuery(bxje_dt2+i+"span").html(url);
  	       
  	       
  	      
        }		   
    }
}

function showInfo2(billid) {
		var bxr_val=jQuery(bxr).val();
	    var cjr_val=jQuery(cjr).val();
		 var dqccz_val=jQuery(dqccz).val();
		var title = "";
		var url = "/formmode/view/AddFormMode.jsp?type=0&modeId=261&formId=-417&billid="+billid;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.maxiumnable = true;
		diag_vote.Width = 1200;
		diag_vote.Height = 1000;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		if(bxr_val==dqccz_val || cjr_val==dqccz_val){
		   	diag_vote.CancelEvent=function(){diag_vote.close();window.location.reload();};
		}
		diag_vote.show();
		
}  
</script>











