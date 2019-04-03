<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var xz_dt1="#field11679_";//明细1 行项目
var hb_dt1="#field11680_";//明细1 货币
    jQuery(document).ready(function(){
		jQuery("#fs").html("<input type=button class='e8_btn_top_first'  style='width:70px;height:30px' value='发送' onclick='senddata()' >");
		
    });
	function senddata(){
	  
			
	  var dtids= getDetailId();
	  if(dtids == ""){
		  alert("请先选择明细");
		  return;
	  }
	  if(!checkhb()){
		 alert("请选择相同货币的明细");
		  return;
	  }
	  sendData(dtids)
	}
	function sendData(dtids){
		var xhr = null;
	   if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
	   } else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
  	  }
  	   if (null != xhr) {
  	   	   	xhr.open("GET","/hhgd/sap/send-quotation-data.jsp?dtids="+dtids, false);
			xhr.onreadystatechange = function () {
				if (xhr.readyState == 4) {
				  if (xhr.status == 200) {
					var text = xhr.responseText;
					text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
					alert(text);
				  }
				}
	        }
            xhr.send(null);
     }
		
	}
	function getDetailId(){
		var flag="";
		var dtids="";
		var indexnum0=  jQuery("#indexnum0").val();
		for(var index=0;index<indexnum0;index++){
			if(jQuery(xz_dt1+index).length>0){
				if(jQuery(xz_dt1+index).is(':checked') == true){					
					var dtid=document.getElementsByName('dtl_id_0_'+index)[0].value;
						dtids=dtids+flag+dtid;
						flag=",";
				}
			}
		}
		return dtids;
	}
	
	function checkhb(){
		var hbold_val="-11";
		var indexnum0=  jQuery("#indexnum0").val();
		for(var index=0;index<indexnum0;index++){
			if(jQuery(xz_dt1+index).length>0){
				if(jQuery(xz_dt1+index).is(':checked') == true){					
					if(hbold_val == "-11"){
						hbold_val = jQuery(hb_dt1+index).val();
					}else{
						if(hbold_val != jQuery(hb_dt1+index).val()){
						return false;	
						}
					}
				}
			}
		}
		return true;
	}
</script>
