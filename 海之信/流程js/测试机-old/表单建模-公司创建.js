
<script type="text/javascript">
        var px1 = "#field13864";
        var px2 = "#field13865";
        var px3 = "#field13866";


var dm= "#field12659";
var zh= "#field12660";
var hy= "#field12661";
var gsjc ="#field12601";
jQuery(document).ready(function(){

	var nameCheck = "#field6699";  // 客户名称验证
	var telCheck = "#field6700";  // 客户电话验证信息
	var webCheck = "#field6701";  // 网站验证信息
        var kh = "#field10173";
        var gys = "#field10174";
        var hzhb = "#field10175";
        var ybgsgx = "#field10141";

 jQuery("#field12692").css("width","50%");
jQuery("#field12693").css("width","50%");

jQuery("#field12659").css("width","50%");
jQuery("#field12660").css("width","50%");
jQuery("#field12661").css("width","50%");
    jQuery(dm).bind('change',function(){   
         getJCName();
    });   
    jQuery(zh).bind('change',function(){   
         getJCName();
    });   
    jQuery(hy).bind('change',function(){   
         getJCName();
    });   

    jQuery(px1).bind('change',function(){   
         getJCName();
    });   
 jQuery(px2).bind('change',function(){   
         getJCName();
    }); 
 jQuery(px3).bind('change',function(){   
        getJCName();
    }); 
      checkCustomize = function(){ 
          var tmp_kh = jQuery(kh).attr("checked");
          var tmp_gys = jQuery(gys).attr("checked")
          var tmp_hzhb = jQuery(hzhb).attr("checked")
          var tmp_ybgsgx = jQuery(ybgsgx).val();
           if(tmp_kh == false && tmp_gys == false && tmp_hzhb == false){
                alert("请选择与本公司的关系。")
                return false;
           }
        
                    
          if(tmp_kh == true){
          if(tmp_gys == true){
            if(tmp_hzhb == true){
              jQuery(ybgsgx).val('6');
            }else{
              jQuery(ybgsgx).val('3');
            }
          }else if(tmp_hzhb == true){
            jQuery(ybgsgx).val('4');
          }else{
            jQuery(ybgsgx).val('0');
          }
        }else if(tmp_gys == true){
           if(tmp_hzhb == true){
             jQuery(ybgsgx).val('5');
           }else{
              jQuery(ybgsgx).val('1');

           }
        }else if(tmp_hzhb == true){
             jQuery(ybgsgx).val('2');
        }else{
             jQuery(ybgsgx).val('');
        }


		var name_val = jQuery(nameCheck).val();
		
		if(name_val=="重复"){
			alert("名称重复，请查询后重新填写！");
			return false;
		}
		
		var tel_val = jQuery(telCheck).val();
		
		if(tel_val=="重复"){
			alert("电话信息重复，请查询后重新填写！");
			return false;
		}
		
		var web_val = jQuery(webCheck).val();
		
		if(web_val=="重复"){
			alert("网站信息重复，请查询后重新填写！");
			return false;
		}

		return true;
	}

	
	
});
function getJCName(){
	var dm_val=jQuery(dm).val();
	var zh_val=jQuery(zh).val();
	var hy_val=jQuery(hy).val();
	var px1_val=jQuery(px1).val();
	var px2_val=jQuery(px2).val();
	var px3_val=jQuery(px3).val();
	var result='';	
	if(px1_val == '' || px2_val=='' || px3_val== '')	{
         result = dm_val+zh_val+hy_val;
    }else if(px1_val==px2_val || px1_val==px3_val || px2_val==px3_val){
        result = dm_val+zh_val+hy_val;
    }else{
    	if(px1_val=='0'){
    		if(px2_val=='1'){
    			  result = dm_val+zh_val+hy_val;
    		}else{
    	      	result = dm_val+hy_val+zh_val;
    	      }
      }else if(px1_val=='1'){
      	  if(px2_val=='0'){
    			  result = zh_val+dm_val+hy_val;
    		}else{
    	      	result = hy_val+dm_val+zh_val;
    	      }
      }else{
      	  if(px2_val=='0'){
    			  result = zh_val+hy_val+dm_val;
    		}else{
    	      	result = hy_val+zh_val+dm_val;
    	      }
  	}
    }
    jQuery(gsjc).val(result);
   	jQuery(gsjc+"span").text(result);
}

</script>