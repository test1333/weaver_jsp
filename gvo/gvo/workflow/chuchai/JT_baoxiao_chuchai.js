
var aboutWf = "#field8827";
var aboutWf_span = aboutWf + "span";
var sqlwhere =" where workflow_requestbase.workflowid in(62,1772,712) ";

// 重新绑定事件
jQuery(aboutWf).parent().find(".Browser").removeAttr("onclick").bind("click",function() {       
aboutWfBrowser();});
		
function aboutWfBrowser() {
   
	var id1 = window
			.showModalDialog("/systeminfo/BrowserMain.jsp?url=/gvo/workflow/waixun/MultiRequestBrowser.jsp?sqlwhere="+ sqlwhere);	
	if (id1) {
		var ids = id1.id;
                
		var names = id1.name;

               // alert(ids);
		if (ids.length > 0) {
                        var tmp_val = "";
			//alert(names.substring(1) + " : " + ids.substring(1));
			var ids_1 = ids.split(",");
			var names_1 = names.split(",");
			for(var i=0;i<ids_1.length;i++){
			     if(ids_1[i].length>0){
                            	 tmp_val = tmp_val + "<a href='/workflow/request/ViewRequest.jsp?isrequest=1&requestid="+ids_1[i]+"' target='_blank'>"+names_1[i]+"</a>";

 			if(i!=ids_1.length-1){tmp_val=tmp_val+", ";}
			      }
                        }
			jQuery(aboutWf).val(ids);
			jQuery(aboutWf_span).html(tmp_val);
		} else {
			jQuery(aboutWf).val("");
			jQuery(aboutWf_span).html("");
		}
	}
}
