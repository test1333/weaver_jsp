<!-- script代码，如果需要引用js文件，请使用与HTML中相同的方式。 -->
<script type="text/javascript">
	var skipbutton="#field9618span";
var dp="field9624_";
var ck="field9623_";
var rek="field9625_";
var ksrq="field6355_";
var jsrq="field6356_";
var dprq="field9628_"
var plyd="field6361_";
    jQuery(document).ready(function () {
    		jQuery("button[name=addbutton0]").live("click", function () {
			var indexnum2 = jQuery("#indexnum0").val()-1;
                        
				jQuery("#"+ck+indexnum2+"span").html("<input id='ck"+indexnum2+"'  type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 120px;width:120px;height:25px;font-size:20px; display:none;' value='Ticket&nbsp;information' onclick='showInfo("+indexnum2+")' >");
			jQuery("#"+dp+indexnum2+"span").html("<input id='dp"+indexnum2+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 110px;width:110px;height:25px;font-size:20px; display:none' value='Book&nbsp;the&nbsp;ticket' onclick='skip("+indexnum2+")' >");
				bindchange(indexnum2);
		});
	jQuery("#indexnum0").bindPropertyChange(function () {
		var nowRow = parseInt($G("indexnum0").value) - 1;
		var plyd_val=jQuery("#"+plyd+nowRow).val();
	 	if(plyd_val=='2'){
	 		jQuery("#"+ck+nowRow+"span").html("<input  id='ck"+nowRow+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 120px;width:120px;height:25px;font-size:20px; ' value='Ticket&nbsp;information' onclick='showInfo("+nowRow+")'>");
			jQuery("#"+dp+nowRow+"span").html("<input id='dp"+nowRow+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 110px;width:110px;height:25px;font-size:20px; ' value='Book&nbsp;the&nbsp;ticket' onclick='skip("+nowRow+")' >");
	      }else{
	      	   jQuery("#"+ck+nowRow+"span").html("<input  id='ck"+nowRow+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 120px;width:120px;height:25px;font-size:20px; display:none;' value='Ticket&nbsp;information' onclick='showInfo("+nowRow+")'>");
			jQuery("#"+dp+nowRow+"span").html("<input id='dp"+nowRow+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 110px;width:110px;height:25px;font-size:20px; display:none;' value='Book&nbsp;the&nbsp;ticket' onclick='skip("+nowRow+")' >");
	      } 	  
		        

	bindchange(nowRow);
	});
			var nodenum0 = jQuery("#nodesnum0").val();
              var indexnum1= jQuery("#indexnum0").val();
		 if(nodenum0 >0){
              	  for(var index=0;index<indexnum1;index++ ){
                       if(jQuery("#"+ck+index).length>0){
                       	    	var plyd_val=jQuery("#"+plyd+index).val();
                       	    	if(plyd_val=='2'){
                       	    		jQuery("#"+ck+index+"span").html("<input  id='ck"+index+"'   type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 120px;width:120px;height:25px;font-size:20px; ' value='Ticket&nbsp;information' onclick='showInfo("+index+")' >");
                       	  		jQuery("#"+dp+index+"span").html("<input id='dp"+index+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 110px;width:110px;height:25px;font-size:20px; ' value='Book&nbsp;the&nbsp;ticket' onclick='skip("+index+")' >");
                       	    	}else{	
                       	   	jQuery("#"+ck+index+"span").html("<input  id='ck"+index+"'   type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 120px;width:120px;height:25px;font-size:20px; display:none;' value='Ticket&nbsp;information' onclick='showInfo("+index+")' >");
                       	  	jQuery("#"+dp+index+"span").html("<input id='dp"+index+"' type=button   class='e8_btn_top_first' style='overflow: hidden; white-space: nowrap; text-overflow: ellipsis;  max-width: 110px;width:110px;height:25px;font-size:20px; display:none;' value='Book&nbsp;the&nbsp;ticket' onclick='skip("+index+")' >");
                           }
                       bindchange(index);
                       }
                      }
              }
		
    	});
function bindchange(index){
	 jQuery("#"+plyd+index).bind('change',function(){  
	         	var plyd_val=jQuery("#"+plyd+index).val();
	            if(plyd_val=='2'){
	             jQuery("#ck"+index).css('display','block');
	             jQuery("#dp"+index).css('display','block');
	            }else{
	                jQuery("#ck"+index).css('display','none');
	                jQuery("#dp"+index).css('display','none');
	            }	
	 
	  });     
}	
	

function skip(index){
         var rek_val = jQuery("#"+rek+index).val();
	 window.open("/mubea/zhjxsj/skip.jsp?Remark="+rek_val, "_blank");
}
function showInfo(index){
  	var title = "Ticket&nbsp;information";
        var rek_val = jQuery("#"+rek+index).val();
        var dprq_val = jQuery("#"+dprq+index).val();
  		var url = "/systeminfo/BrowserMain.jsp?url=/mubea/zhjxsj/jsp/forward.jsp?typex=ck,"+rek_val+","+dprq_val+","+dprq_val;
		var diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1000;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
	
		diag_vote.show();
}
</script>

<script type="text/javascript" src="/mubea/js/timecompare.js"></script>






