
<script type="text/javascript">

var valid = "#field6940_"; // 客户编号
var pm = "#field6872_";
var km = "#field6870_";
var bma = "#field6873_";
var bm = "#field6871_";
var gg = "#field6865_";
var dw = "#field6866_";
var sl = "#field6867_";
var dj = "#field6874_";
var je = "#field6875_";
var xqrq = "#field6868_";
var bz = "#field6869_";

var cgdj="#field6936";

	jQuery(document).ready(function () {
		jQuery(cgdj).bindPropertyChange(function (){ 
             var nodesnum0=  jQuery("#nodesnum0").val();
			 var indexnum1 = jQuery("#indexnum0").val();
                if(nodesnum0>0){
                      jQuery("[name = check_node_0]:checkbox").attr("checked", true);
                    deleteRow0(0);                                                               
                }  
			var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var cgdj_val = jQuery(cgdj).val();
			xhr.open("GET","/dp/purchase/getInfo.jsp?id="+cgdj_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
                                                        alert(text);
							var text_arr = text.split("@@@");
                              var length1=Number(text_arr.length)-1+Number(indexnum1);
							for(var i=indexnum1;i<length1;i++){                                                          
								addRow0(0);
								var tmp_arr = text_arr[i-indexnum1].split("###");							
								jQuery(valid+i).val(tmp_arr[0]);							
								jQuery(valid+i+"span").text(tmp_arr[0]);
								
						}
					}	
				}
			}
			xhr.send(null);			
		}
	 })
	 
 
 });

 
    

</script>






