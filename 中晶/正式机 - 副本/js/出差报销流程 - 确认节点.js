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
	
	var sftj_dt1 = "#field6859_";//是否提交
   jQuery(document).ready(function(){
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
			 for(var i=0;i<indexnum0;i++){
			 	if(jQuery(fph_dt1+i).length>0){	
			 	   
					//是否超标
					var lx_dt1_val = jQuery(lx_dt1+i).val();
					var sfcb_dt1_val=jQuery(sfcb_dt1+i).val();
					var sftj_dt1_val=jQuery(sftj_dt1+i).val();
					if(lx_dt1_val=="1" && sfcb_dt1_val == "0" && sftj_dt1_val !="0"){
						alert("存在未归档的费用超标流程,无法提交");
						return false;
					}
		        }
		    }
			//jQuery(sfzjsp_dt1).val(sfzjsp_dt1_val);
			//jQuery(dissfzjsp_dt1).val(sfzjsp_dt1_val);
    		return true;
        }
   })
   
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
