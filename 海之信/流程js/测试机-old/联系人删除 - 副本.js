<script type="text/javascript">
           var gjz = "#field14153";
          var jdzt = "#field14154";
            var jdzt2 ="#disfield14154";
          var gs_dt = "field14226_";
          var cz="field14182_";
	jQuery(document).ready(function () {
		jQuery("button[name=addbutton0]").live("click", function () {
			var indexnum2 = jQuery("#indexnum0").val();
			bindchange(indexnum2-1);
		});
		var nodenum0 = jQuery("#nodesnum0").val();
              var indexnum1= jQuery("#indexnum0").val();
              if(nodenum0 >0){
              	  for(var index=0;index<indexnum1;index++ ){
                       if(jQuery("#"+gs_dt+index).length>0){
                       	    var gs_dt_val=jQuery("#"+gs_dt+index).val();
                       	    if(gs_dt_val !=''){
                       	    	jQuery("#"+cz+index+"span").html("<a href=\"javascript:showInfo('"+gs_dt_val+"')\">查看</a>");
                       	    }
                       	    	bindchange(index);
                       }
                      }
              }
              
		jQuery(gjz).bindPropertyChange(function (){ 
			var gjz_val = jQuery(gjz).val();
			var jdzt_val=jQuery(jdzt).val();
			if(jdzt_val != '' ){
			    jQuery(jdzt).val("");
			    jQuery(jdzt2).val("");
			     jQuery(jdzt+ "span").html("<img align='absmiddle' src='/images/BacoError_wev8.gif'>");			    
			}
			deletedetail();
        	})
        	jQuery(jdzt).bindPropertyChange(function (){ 
			var gjz_val = jQuery(gjz).val();
			var jdzt_val=jQuery(jdzt).val();
		       
			deletedetail();
			if(gjz_val ==''){
		          alert("请先填写关键字");
		          return;
		       }
			if(jdzt_val !=''){
			 var indexnum0=  jQuery("#indexnum0").val();
		        var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					xhr = new ActiveXObject("Microsoft.XMLHTTP");
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				if (null != xhr) {				
					xhr.open("GET","/seahonor/crm/jsp/getDeleteContact.jsp?gjz="+gjz_val+"&jdzt="+jdzt_val, false);
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
										jQuery("#"+gs_dt+i).val(tmp_arr[0]);							
										jQuery("#"+gs_dt+i+"span").text(tmp_arr[1]);
										jQuery("#"+gs_dt+i+"spanimg").html("");
										var url="<a href=\"javascript:showInfo('"+tmp_arr[0]+"')\">查看</a>";
										jQuery("#"+cz+i).val(url);							
										jQuery("#"+cz+i+"span").html(url);
											bindchange(i);																						
								}
							}	
						}
					}
					xhr.send(null);			
				}
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
    function bindchange(index1){
    		jQuery("#"+gs_dt+index1).bindPropertyChange(function (){ 
    		   var gs_dt_val = jQuery("#"+gs_dt+index1).val();
    		   	jQuery("#"+cz+index1).val("");							
			jQuery("#"+cz+index1+"span").html("");
			if(gs_dt_val !=''){
				var url="<a href=\"javascript:showInfo('"+gs_dt_val+"')\">查看</a>";
				jQuery("#"+cz+index1).val(url);							
				jQuery("#"+cz+index1+"span").html(url);
			}
    		})
    }
      function showInfo(id) {

		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/jsp/deleteConnectInfoLXRUrl.jsp?customID="+id;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 800;
		diag_vote.Height = 600;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
	
		diag_vote.show();
		
	}
</script>




