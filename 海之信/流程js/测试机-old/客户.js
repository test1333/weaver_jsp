<script type="text/javascript">
    var ssjt = "#field13054";
    var gs = "field13060_";
    var lx = "#field13059";
    var yjdzt="field13056_";
    var xjdzt="field13057_";
    
    var kh="field13042_";
    var gys="field13043_";
    var hzhb="field13044_";
	jQuery(document).ready(function () {
        
		jQuery(lx).bindPropertyChange(function (){ 
            jQuery(ssjt).val("");
			jQuery(ssjt+"span").text("");
		})

      	jQuery(ssjt).bindPropertyChange(function (){ 
        deletedetail();
        var indexnum0=  jQuery("#indexnum0").val();
        var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {
			var lx_val = jQuery(lx).val();
            var ssjt_val = jQuery(ssjt).val();
                        if(lx_val == ''){
                          lx_val = '5';
                        }
			xhr.open("GET","/seahonor/crm/jsp/sureModifyCustom.jsp?ssjt="+ssjt_val+"&lx="+lx_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
							var text_arr = text.split("@@@");
                                                         var length1=Number(text_arr.length)-1+Number(indexnum0);
							for(var i=indexnum0;i<length1;i++){                                                          
								addRow0(0);
								var tmp_arr = text_arr[i-indexnum0].split("###");							
								jQuery("#"+gs+i).val(tmp_arr[0]);							
								jQuery("#"+gs+i+"span").text(tmp_arr[1]);
								document.getElementById(gs+i+"spanimg").innerHTML = ""; 																							
						}
					}	
				}
			}
			xhr.send(null);			
		}

        })
        	checkCustomize = function () {
        		 var indexnum0=  jQuery("#indexnum0").val();
        		 for(index=0;index<indexnum0;index++){
		     	if(jQuery("#"+yjdzt+index).length>0){
		     	    var tmp_kh = jQuery("#"+kh+index).attr("checked");
                               var tmp_gys = jQuery("#"+gys+index).attr("checked")
                               var tmp_hzhb = jQuery("#"+hzhb+index).attr("checked")
                                if(tmp_kh == false && tmp_gys == false && tmp_hzhb == false){
                				alert("请选择与本公司的关系。");
               					return false;
                                 }
                                 
		                 var yjdzt_val=jQuery("#"+yjdzt+index).val();
		                 var xjdzt_val=jQuery("#"+xjdzt+index).val();
		                 if(yjdzt_val == '0' && xjdzt_val=='0'){
		                  alert("请修改新校对状态后再提交。");
		                  return false;
		                 }
		             }
	      	}
	      	return true;
             }
        	
    });

    function deletedetail(){
      var indexnum0=  jQuery("#nodesnum0").val();
      if(indexnum0>0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        deleteRow0(0);                                                               
      }  
    }
</script>



