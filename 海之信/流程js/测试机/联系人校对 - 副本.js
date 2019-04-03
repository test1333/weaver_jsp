<script type="text/javascript">
    var ssjt = "#field11845";
	var ssgs = "#field11846";
    var lxr = "field11817_";
    var lx = "#field11815"
   var yddh="#field11820_";
   var bgdh="#field11822_";
   var dzyx="#field11821_";
       var yjdzt="field11818_";
    var xjdzt="field11819_";
	jQuery(document).ready(function () {
        
		jQuery(lx).bindPropertyChange(function (){ 
            jQuery(ssjt).val("");
			jQuery(ssjt+"span").text("");
			 jQuery(ssgs).val("");
			jQuery(ssgs+"span").text("");
		})

      	jQuery(ssjt).bindPropertyChange(function (){ 
        deletedetail();
		var lx_val = jQuery(lx).val();
               if(lx_val == ''){
                          lx_val = '5';
                  }
         var ssjt_val = jQuery(ssjt).val();
		 var url="/seahonor/crm/jsp/sureModifyContact.jsp?qf=1&ssjt="+ssjt_val+"&lx="+lx_val;
        if(ssjt_val != ''){
        insertDetail(url);
        }

        })

		jQuery(ssgs).bindPropertyChange(function (){ 
        deletedetail();
		var lx_val = jQuery(lx).val();
                if(lx_val == ''){
                          lx_val = '3';
                 }
         var ssgs_val = jQuery(ssgs).val();
		 var url="/seahonor/crm/jsp/sureModifyContact.jsp?qf=0&ssjt="+ssgs_val+"&lx="+lx_val;
        if(ssgs_val != ''){
        insertDetail(url);
        }
        })

      checkCustomize = function(){
      var num=jQuery("#indexnum0").val();
      for(var index=0;index<=num;index++){
         if(jQuery(yddh+index).length>0){
          var tmp_yddh = jQuery(yddh+index).val();
          var tmp_bgdh = jQuery(bgdh+index).val();
          var tmp_dzyx = jQuery(dzyx+index).val();
        if(tmp_yddh =='' && tmp_bgdh =='' && tmp_dzyx =='' ){
           alert("请填写联系人的办公电话或移动电话或电子邮箱");
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

    function insertDetail(url1){

		var indexnum0=  jQuery("#indexnum0").val();
        var xhr = null;
		if (window.ActiveXObject) {//IE浏览器
			xhr = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xhr = new XMLHttpRequest();
		}
		if (null != xhr) {			
			xhr.open("GET",url1, false);
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
				
								jQuery("#"+lxr+i).val(tmp_arr[0]);							
								jQuery("#"+lxr+i+"span").text(tmp_arr[1]);
								document.getElementById(lxr+i+"spanimg").innerHTML = ""; 																							
						}
					}	
				}
			}
			xhr.send(null);			
		}
	}

    function deletedetail(){
      var indexnum0=  jQuery("#nodesnum0").val();
      if(indexnum0>0){
        jQuery("[name = check_node_0]:checkbox").attr("checked", true);
        deleteRow0(0);                                                               
      }  
    }
</script>


















