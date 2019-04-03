<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
    var lxkyje="#field10284";//立项可用金额
    var sfbg="#field8351";//是否变更--人民币金额
    var bgce1="#field10283";//变更差额
    var xzht="#field8308";//选择合同
    var jd_dt1="#field8339_";//明细1-阶段
    var bl_dt1="#field8340_";//明细1-比例
    var je_dt1="#field10368_";//明细1-金额
    var fkrq_dt1="#field10129_";//明细1-付款日期
    var sffk_dt1="#field10363_";//明细1-是否付款
    var ssht_dt1="#field10364_";//明细1-所属合同明细id
     jQuery(document).ready(function(){
          jQuery(xzht).bindPropertyChange(function (){ 
          	  var xzht_val=jQuery(xzht).val();
          	  var nodesnum0 = jQuery("#nodesnum0").val();
          	  if(nodesnum0 >0){
          	jQuery("[name = check_node_0]:checkbox").attr("checked", true);
          	  deleteRow0(0);
          }
             if(xzht_val !=''){
             	 dodetail(xzht_val);
             }
         });
         
        checkCustomize = function () {
        	      var sfbg_val=jQuery(sfbg).val();
        		var lxkyje_val=jQuery(lxkyje).val();
        		var bgce_val=jQuery(bgce1).val();
        		if(sfbg_val == '0'){
        		    	if(lxkyje_val ==''){
                			lxkyje_val = '0';	
                	       }
                	   	if(bgce_val ==''){
                			bgce_val = '0';	
                	       }
                	      if(Number(bgce_val)>Number(lxkyje_val)){
          	      	  alert("变更差额大于立项可用预算,请检查");
          	      	  return false;
          	           }
        	      }
        	      return true;
        }
     });
     
     function dodetail(xzht_val){
	     var indexnum1=  jQuery("#indexnum0").val();
	   var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
	xhr.open("GET","/gvo/ec/project/gethtdetail.jsp?hth="+xzht_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
		var text = xhr.responseText;
		text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
		var text_arr = text.split("@@@");
		var length1=Number(text_arr.length)-1+Number(indexnum1);
		for(var i=indexnum1;i<length1;i++){
		  addRow0(0);
		  var tmp_arr = text_arr[i-indexnum1].split("###");
		  var sffk_dt1_val=tmp_arr[4];
		  jQuery(sffk_dt1+i).val(sffk_dt1_val);
		   jQuery(ssht_dt1+i).val(tmp_arr[5]);
		   jQuery(jd_dt1+i).val(tmp_arr[0]);
		   jQuery(bl_dt1+i).val(tmp_arr[1]);
		   jQuery(je_dt1+i).val(tmp_arr[2]);
		   jQuery(fkrq_dt1+i).val(tmp_arr[3]);
		  if(sffk_dt1_val == '0'){
			  jQuery(fkrq_dt1+i+"browser").attr('disabled',true);
			  jQuery(jd_dt1+i).attr("readonly", "readonly");
			  jQuery(bl_dt1+i).attr("readonly", "readonly");
			  jQuery(je_dt1+i).attr("readonly", "readonly");
			  
	       }
	        jQuery(jd_dt1+i+"span").html("");
	        jQuery(bl_dt1+i+"span").html("");
	        jQuery(je_dt1+i+"span").html("");
	        jQuery(fkrq_dt1+i+"spanimg").html("");
	     }
          }
	  }
	 }
       xhr.send(null);
     }
     }
</script>
