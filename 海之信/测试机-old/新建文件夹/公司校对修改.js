<script type="text/javascript">
    var ssjt = "#field13054";
    var gs = "#field13060_";
    var lx = "#field13059"
	jQuery(document).ready(function () {
      	jQuery(ssjt).bindPropertyChange(function (){ 
              alert("11");
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
			xhr.open("GET","/seahonor/crm/jsp/sureModifyCustom.jsp?ssjt="+ssjt_val+"&lx="+lx_val, false);
			xhr.onreadystatechange = function () {

					if (xhr.readyState == 4) {
						if (xhr.status == 200) {
							var text = xhr.responseText;
							text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');		
							var text_arr = text.split("@@@");
                            alert(text);
                             var length1=Number(text_arr.length)-1+Number(indexnum0);
							for(var i=indexnum0;i<length1;i++){                                                          
								addRow0(0);
								var tmp_arr = text_arr[i-indexnum0].split("###");							
								jQuery(gs+i).val(tmp_arr[0]);							
								jQuery(gs+i+"span").text(tmp_arr[0]);																									
						}
					}	
				}
			}
			xhr.send(null);			
		}

        })
    });

    function deletedetail(){
      var indexnum0=  jQuery("#indexnum0").val();
      if(indexnum0>0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        deleteRow0(0);                                                               
      }  
    }
</script>