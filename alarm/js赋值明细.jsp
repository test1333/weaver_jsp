<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
var alarmid = "#field6021";
        var action_id = "field6032_"; 
	var xdfa_id = "field6033_"; 
	var famb_id = "field6034_"; 
	var sjwc_id = "field6035_"; 
	var jzrc_id = "field6036_"; 
	var wcbl_id =  "field6037_"; 
       var flag_id= "#field6221";
                                   
jQuery(document).ready(function() {
       var flag_val = jQuery(flag_id).val();

      if(flag_val!='1'){
       setTimeout("testa()",1000);
      }
});
function testa(){
     var xhr = null;
     if (window.ActiveXObject) {//IE浏览器
        xhr = new ActiveXObject("Microsoft.XMLHTTP");
     } else if (window.XMLHttpRequest) {
	xhr = new XMLHttpRequest();
     }
     if (null != xhr) {

	var alarmid_val = jQuery(alarmid).val();
	xhr.open("GET","/alarm/Insertactionplan.jsp?val="+alarmid_val, false);
	xhr.onreadystatechange = function () {
	if (xhr.readyState == 4) {
	  if (xhr.status == 200) {
	    var text = xhr.responseText;  
	    text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');
            var text_arr = text.split("@@@");
	    for(var i=0;i<text_arr.length-1;i++){
	      addRow0(0);
	      var tmp_arr = text_arr[i].split("###");							
	      jQuery("#"+action_id+i).val(tmp_arr[0]);
              jQuery("#"+action_id+i+"span").text("");
	      jQuery("#"+xdfa_id+i).val(tmp_arr[1]);
	      jQuery("#"+famb_id+i).val(tmp_arr[2]);			
	      jQuery("#"+sjwc_id+i).val(tmp_arr[3]);							
              jQuery("#"+jzrc_id+i).val(tmp_arr[4]);	
              jQuery("#"+jzrc_id+i+"span").text(tmp_arr[4]);
	      jQuery("#"+wcbl_id+i).val(tmp_arr[5]);
	      }	
              jQuery(flag_id).val("1");						
	    }
	  }
	}
	xhr.send(null);
     }
   }
</script>
out.print("select "+backfields+" from "+fromSql+sqlWhere+" order by"+orderby);






























