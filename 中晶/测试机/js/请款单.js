<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var splx_main="#field6869";        //审批类型
var splx_dt ="#field6799_";  //明细审批类型
var fplx_dt1 = "#field6783_";//发票类型
var fph_dt1 = "#field6782_";//发票号
var rqid="#requestid";
var qksm_dt1 = "#field7105_";//请款说明明细1
var xl_dt1 = "#field6860_";//小类
var zrdw_dt1 = "#field6777_";//责任单位
var yfxm_dt1 = "#field6779_";//研发项目明细1

var sfszfb="#field7232";//是否设置分部
var fyssfb="#field6764";//费用所属分部
jQuery(document).ready(function() {
	var sfszfb_val = jQuery(sfszfb).val();
	if(sfszfb_val=='0'){
		 jQuery(fyssfb+"_browserbtn").attr('disabled',false);
		 jQuery(fyssfb+"__").removeAttr("readonly");	 
	}else{
		jQuery(fyssfb+"_browserbtn").attr('disabled',true);	
		jQuery(fyssfb+"__").attr("readonly", "readonly");
	}
	jQuery(sfszfb).bindPropertyChange(function(){
	  var sfszfb_val = jQuery(sfszfb).val();
	if(sfszfb_val=='0'){
		 jQuery(fyssfb+"_browserbtn").attr('disabled',false);	
		 jQuery(fyssfb+"__").removeAttr("readonly");
	}else{
		jQuery(fyssfb+"_browserbtn").attr('disabled',true);	
		jQuery(fyssfb+"__").attr("readonly", "readonly");
	}
	});
	jQuery("button[name=addbutton0]").live("click", function () {
	  	   var indexnum0=jQuery("#indexnum0").val()-1;
		   copydetail(indexnum0);
	});
   checkCustomize = function() {
      var indexnum0=jQuery("#indexnum0").val();
      var nodesnum0=jQuery("#nodesnum0").val();
	  var countnum=0;
	  var rqid_val=document.getElementsByName("requestid")[0].value;	
	  for(var i=0;i<indexnum0;i++){
	    if(jQuery(fph_dt1+i).length>0){	
		  countnum = countnum+1;	 	 	 
		  var fplx_dt1_val=jQuery(fplx_dt1+i).val();	
		  var fph_dt1_val=jQuery(fph_dt1+i).val();		
		  var result=checkdzfp(fph_dt1_val,rqid_val);
		  if(fplx_dt1_val =="2" && fph_dt1_val != "" && result == "1"){
			alert("明细第"+countnum+"行发票号（"+fph_dt1_val+"）重复请检查");
			return false;
		  }
	    }
	  }
      for(var x=0;x<indexnum0;x++){
         for(var y=x+1;y<indexnum0;y++){
           if(jQuery(splx_dt+y).length>0){
                var d_val_val = jQuery(splx_dt+x).val();
                var d_val_val2 = jQuery(splx_dt+y).val();
                var num1=x+1;var num2=y+1;
                if(d_val_val!=d_val_val2){
                  window.top.Dialog.alert("提交失败:明细"+num1+"和明细"+num2+"审批类型不一致，请检查后重新提交!");
                  return false;
                }         
             }
          }
      }
       var tmp=jQuery(splx_dt +"0").val();
       jQuery(splx_main).val(tmp);
       jQuery(splx_main).text(tmp);
       return true;
   }
})
function copydetail(indexnum){
	   var index0=-1;
	   for (var index=indexnum-1;index>=0;index--){
		    if(jQuery(qksm_dt1+index).length>0){
				index0=index;
				break;
			}
	   }
	   if(index0 == -1){
		   return;
	   }
	   jQuery(qksm_dt1+indexnum).val(jQuery(qksm_dt1+index0).val());
	   jQuery(qksm_dt1+indexnum+"span").text(jQuery(qksm_dt1+index0+"span").text());
	   jQuery(xl_dt1+indexnum).val(jQuery(xl_dt1+index0).val());
	   jQuery(xl_dt1+indexnum+"span").text(jQuery(xl_dt1+index0+"span").text());
	    jQuery(xl_dt1+indexnum+"spanimg").html("");
	   jQuery(zrdw_dt1+indexnum).val(jQuery(zrdw_dt1+index0).val());
	   jQuery(zrdw_dt1+indexnum+"span").text(jQuery(zrdw_dt1+index0+"span").text());
	   jQuery(yfxm_dt1+indexnum).val(jQuery(yfxm_dt1+index0).val());
	   jQuery(yfxm_dt1+indexnum+"span").text(jQuery(yfxm_dt1+index0+"span").text());
   }
function checkdzfp(fphm,requestid){
	var result="";
	var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
		xhr.open("GET","/zj/jsp/check_dzfp.jsp?fphm="+fphm+"&requestid="+requestid, false);
		xhr.onreadystatechange = function () {
		if (xhr.readyState == 4) {
		  if (xhr.status == 200) {
			var text = xhr.responseText;
			text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
			result = text;
	         }
		  }
	 }
       xhr.send(null);
     }
     return result;
}
</script>

