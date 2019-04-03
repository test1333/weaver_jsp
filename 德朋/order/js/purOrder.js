
<script type="text/javascript">

var valid = "#field6968_"; // 客户编号
var ljrksl= "#field7684_"; // 
var cgsl= "#field6829_"; // 
var rksl= "#field6653_"; // 

var cgdj="#field6938";

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
			xhr.open("GET","/dp/order/js/purOrder.jsp?reqid="+cgdj_val, false);
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
								jQuery(valid+i).val(tmp_arr[0]);							
								jQuery(valid+i+"span").text(tmp_arr[0]);
                                                                jQuery(ljrksl+i).val(tmp_arr[1]);							
								jQuery(ljrksl+i+"span").text(tmp_arr[1]);
								
						}
					}	
				}
			}
			xhr.send(null);			
		}
           calSum(0);
           var nodesnum0=jQuery("#nodesnum0").val();
           var indexnum0=jQuery("#indexnum0").val();
          if(nodesnum0>0){
              for(var index=0;index<indexnum0;index++){
		    if(jQuery(rksl+index).length>0){
			bindchange(index);
		    }
	       }
	   }
	 })

	 checkCustomize = function () {
           var nodesnum1=jQuery("#nodesnum0").val();
           var indexnum1=jQuery("#indexnum0").val();
          if(nodesnum1>0){
              for(var index=0;index<indexnum1;index++){
		    if(jQuery(rksl+index).length>0){
			  var rksl_val = jQuery(rksl+index).val();
                          var ljrksl_val = jQuery(ljrksl+index).val();
                          var cgsl_val = jQuery(cgsl+index).val();
                          if(Number(rksl_val)+Number(ljrksl_val)>Number(cgsl_val)){
                              alert("累计入库数量+本次入库数量大于采购数量，请重新填写。\n当前累计入库数量 "+ljrksl_val );
                              return false;
                          }
		    }
	       }
	   }
         }
 
 });

 function bindchange(index){
	 jQuery(rksl+index).bindPropertyChange(function () {
               var rksl_val = jQuery(rksl+index).val();
               var ljrksl_val = jQuery(ljrksl+index).val();
               var cgsl_val = jQuery(cgsl+index).val();
               if(Number(rksl_val)+Number(ljrksl_val)>Number(cgsl_val)){
               alert("累计入库数量+本次入库数量大于采购数量，请重新填写。\n当前累计入库数量 "+ljrksl_val );
                }
			
	})

 }

 
    

</script>

























