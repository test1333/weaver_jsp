<script type="text/javascript">
	var fplx_dt1 = "#field6543_";//发票类型
	var fph_dt1 = "#field6542_";//发票号
	var rqid="#requestid";
	var lx_dt1 = "#field6896_";//类型
	var je_dt1 = "#field6541_";//金额
	var xdje_dt1 = "#field6894_";//限定金额
	var sfcb_dt1 = "#field6907_";//是否超标
	var dissfcb_dt1 = "#disfield6907_";//是否超标 
	
	var sfzjsp_dt1 = "#field6910";//是否超标
	var dissfzjsp_dt1 = "#disfield6910";//是否超标 
	var clrq_dt1 = "#field6533_";//出差日期明细1
	var jsrq_dt1 = "#field6534_";//结束日期明细1
	var fykm_dt1 = "#field6896_";//费用科目
	var disfykm_dt1 = "#disfield6896_";//费用科目dis
	var nr_dt1 = "#field6536_";//内容明细1
	var cslx_dt1 = "#field6897_";//城市类型
	
	var ccrq="#field6518";//出差日期
	var ccsj="#field6519";//出差时间
	var jsrq="#field6520";//结束日期
	var jssj="#field6521";//结束时间
	var ccjt="#field6877";//出差津贴
   jQuery(document).ready(function(){
	   jQuery("button[name=addbutton0]").live("click", function () {
	  	   var indexnum0=jQuery("#indexnum0").val()-1;
		   copydetail(indexnum0);
		});
		jQuery(ccrq).bindPropertyChange(function(){
			var ccrq_val=jQuery(ccrq).val();
			var ccsj_val=jQuery(ccsj).val();
			var jsrq_val=jQuery(jsrq).val();
			var jssj_val=jQuery(jssj).val();
			if(ccrq_val !="" && ccsj_val !="" && jsrq_val !="" && jssj_val !="" ){
				var result=getcczb(ccrq_val,ccsj_val,jsrq_val,jssj_val);
				jQuery(ccjt).val(result);
				jQuery(ccjt+"span").text(result);
			}
			
		});
		jQuery(ccsj).bindPropertyChange(function(){
			var ccrq_val=jQuery(ccrq).val();
			var ccsj_val=jQuery(ccsj).val();
			var jsrq_val=jQuery(jsrq).val();
			var jssj_val=jQuery(jssj).val();
			if(ccrq_val !="" && ccsj_val !="" && jsrq_val !="" && jssj_val !="" ){
				var result=getcczb(ccrq_val,ccsj_val,jsrq_val,jssj_val);
				jQuery(ccjt).val(result);
				jQuery(ccjt+"span").text(result);
			}
			
		});
		jQuery(jsrq).bindPropertyChange(function(){
			var ccrq_val=jQuery(ccrq).val();
			var ccsj_val=jQuery(ccsj).val();
			var jsrq_val=jQuery(jsrq).val();
			var jssj_val=jQuery(jssj).val();
			if(ccrq_val !="" && ccsj_val !="" && jsrq_val !="" && jssj_val !="" ){
				var result=getcczb(ccrq_val,ccsj_val,jsrq_val,jssj_val);
				jQuery(ccjt).val(result);
				jQuery(ccjt+"span").text(result);
			}
			
		});
		jQuery(jssj).bindPropertyChange(function(){
			var ccrq_val=jQuery(ccrq).val();
			var ccsj_val=jQuery(ccsj).val();
			var jsrq_val=jQuery(jsrq).val();
			var jssj_val=jQuery(jssj).val();
			if(ccrq_val !="" && ccsj_val !="" && jsrq_val !="" && jssj_val !="" ){
				var result=getcczb(ccrq_val,ccsj_val,jsrq_val,jssj_val);
				jQuery(ccjt).val(result);
				jQuery(ccjt+"span").text(result);
			}
			
		});
    	checkCustomize = function () {
	    	var indexnum0=  jQuery("#indexnum0").val();
	    	var countnum=0;
			var sfzjsp_dt1_val="0";
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
					//是否超标
					var lx_dt1_val = jQuery(lx_dt1+i).val();
					var je_dt1_val = jQuery(je_dt1+i).val().replace(/,/g,'');
					var xdje_dt1_val = jQuery(xdje_dt1+i).val().replace(/,/g,'');
					if(lx_dt1_val == "1"){
						if(Number(je_dt1_val)>Number(xdje_dt1_val)){
						   	jQuery(sfcb_dt1+i).val("0");
							jQuery(dissfcb_dt1+i).val("0");
							sfzjsp_dt1_val="1";
							
						}else{
							jQuery(sfcb_dt1+i).val("1");
							jQuery(dissfcb_dt1+i).val("1");
						}
					}
		        }
		    }
			jQuery(sfzjsp_dt1).val(sfzjsp_dt1_val);
			jQuery(dissfzjsp_dt1).val(sfzjsp_dt1_val);
			if(sfzjsp_dt1_val == "1"){
			 if(confirm("你的住宿费已超标，是否需要发起特批流程？，若不需要，请修改金额后，重新提交")){
			 }else{
				return false;
			 }
			}
    		return true;
        }
   })
   function copydetail(indexnum){
	   var index0=-1;
	   for (var index=indexnum-1;index>=0;index--){
		    if(jQuery(clrq_dt1+index).length>0){
				index0=index;
				break;
			}
	   }
	   if(index0 == -1){
		   return;
	   }
	   jQuery(clrq_dt1+indexnum).val(jQuery(clrq_dt1+index0).val());
	   jQuery(clrq_dt1+indexnum+"span").text(jQuery(clrq_dt1+index0+"span").text());
	   jQuery(jsrq_dt1+indexnum).val(jQuery(jsrq_dt1+index0).val());
	   jQuery(jsrq_dt1+indexnum+"span").text(jQuery(jsrq_dt1+index0+"span").text());
	   //
	   //jQuery(fykm_dt1+indexnum).val(jQuery(fykm_dt1+index0).val());
	   //jQuery(disfykm_dt1+indexnum).val(jQuery(disfykm_dt1+index0).val());
	   //jQuery(fykm_dt1+indexnum+"span").html("");
	   jQuery(cslx_dt1+indexnum).css('display','none');
	   jQuery(nr_dt1+indexnum).val(jQuery(nr_dt1+index0).val());
	   jQuery(nr_dt1+indexnum+"span").text(jQuery(nr_dt1+index0+"span").text());
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
function getcczb(ccrq,ccsj,jsrq,jssj){
	var result="";
	$.ajax({
             type: "POST",
             url: "/zj/jsp/getccjb.jsp",
             data: {'ccrq':ccrq, 'ccsj':ccsj, 'jsrq':jsrq, 'jssj':jssj},
             dataType: "text",
			 async:false,//同步
             success: function(data){
                        data=data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
						result=data;
                      }
         });
	
     return result;
}
</script>
