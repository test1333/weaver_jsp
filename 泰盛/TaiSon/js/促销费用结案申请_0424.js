<script type="text/javascript">
           var fysqlc = "#field7892";
           var hhmc = "field5999_";
          var fykm = "field7883_";
          var ygfy = "field6008_";
          var ygxs = "field6000_";
          var ygxsje = "field6002_";
          var hh = "field5998_";
             var yzffs = "field6006_";
            var yzffs2 ="disfield6006_";
             var bcbxje = "field7884_";
          var cgsqmxid="field7896_";
	jQuery(document).ready(function () {
              
		jQuery(fysqlc).bindPropertyChange(function (){ 
			var fysqlc_val = jQuery(fysqlc).val();
				deletedetail();
			if(fysqlc_val != '' ){
			  		 var indexnum0=  jQuery("#indexnum0").val();
		        var xhr = null;
				if (window.ActiveXObject) {//IEä¯ÀÀÆ÷
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {				
					xhr.open("GET","/TaiSon/feiyong/getcgsqmx.jsp?fysqlc="+fysqlc_val, false);
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
										jQuery("#"+cgsqmxid+i).val(tmp_arr[0]);							
										jQuery("#"+cgsqmxid+i+"span").text(tmp_arr[1]);
										jQuery("#"+hhmc+i).val(tmp_arr[2]);							
										jQuery("#"+hhmc+i+"span").text(tmp_arr[2]);
										jQuery("#"+fykm+i).val(tmp_arr[3]);							
										jQuery("#"+fykm+i+"span").text(tmp_arr[4]);
										jQuery("#"+ygfy+i).val(tmp_arr[5]);							
										jQuery("#"+ygfy+i+"span").text(tmp_arr[5]);
										jQuery("#"+ygxs+i).val(tmp_arr[6]);							
										jQuery("#"+ygxs+i+"span").text(tmp_arr[6]);
										jQuery("#"+ygxsje+i).val(tmp_arr[7]);							
										jQuery("#"+ygxsje+i+"span").text(tmp_arr[7]);
										jQuery("#"+hh+i).val(tmp_arr[8]);							
										jQuery("#"+hh+i+"span").text(tmp_arr[9]);
									 	jQuery("#"+yzffs+i).val(tmp_arr[10]);							
										jQuery("#"+yzffs2+i).val(tmp_arr[10]);
										jQuery("#"+bcbxje+i).val(tmp_arr[11]);	
										 jQuery("#"+bcbxje+i+"span").html("");	
																							
								}
							}	
						}
					}
					xhr.send(null);			
				}	    
				calSum(0);
			}
		
        	})
        
    });
   function deletedetail(){
      var indexnum0=  jQuery("#nodesnum0").val();
      if(indexnum0>0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        deleteRow0(0);                                                               
      }  
    }
</script>




