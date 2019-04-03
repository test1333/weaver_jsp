<script type="text/javascript">
           var gjz = "#field14349";
          var gs_dt = "field14345_";
          var cz="field14352_";
          var bs_dt="field14347_";
          var jdzt_dt="wdfield14351";
          var gswwm_dt="wdfield14354";
          var gsjc_dt="wdfield14355";
          var ssjt_dt="wdfield14356";
          var gsdz_dt="wdfield14357";
          var gsdh_dt="wdfield14358";
          var gscz_dt="wdfield14359";
          var yzbm_dt="wdfield14360";
          var zcdz_dt="wdfield14361";
          var cxzt_dt="wdfield14362";
          
          var gswz_dt="wdfield14364";
          var zczb_dt="wdfield14365";
          var sszb_dt="wdfield14366";
          
          var khyh_dt="wdfield14367";
          var yhzh_dt="wdfield14368";
          var sh_dt="wdfield14369";
          var wxgzh_dt="wdfield14370";
	jQuery(document).ready(function () {
		alert("111");
		jQuery(gjz).bind('change',function(){
			var gjz_val = jQuery(gjz).val();
				deletedetail();
			if(gjz_val != '' ){
			  		 var indexnum0=  jQuery("#indexnum0").val();
		        var xhr = null;
				if (window.ActiveXObject) {//IE浏览器
					 
					 	 	xhr = new ActiveXObject("Microsoft.XMLHTTP");
  				
				} else if (window.XMLHttpRequest) {
					xhr = new XMLHttpRequest();
				}
				gjz_val=encodeURIComponent(gjz_val);
				if (null != xhr) {				
					xhr.open("GET","/seahonor/crm/jsp/getDeleteCustom.jsp?gjz="+gjz_val, false);
					xhr.onreadystatechange = function () {

							if (xhr.readyState == 4) {
								if (xhr.status == 200) {
									var text = xhr.responseText;
									text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
							        alert(text);
							       var text_arr = text.split("@@@");
		                           
		                           
		                           
		                           var detail = wfDetail.doGet(0);
		                           	var datas = detail.datas;
		                           	var datalength=0;
		                             $.each(datas, function(i, value) {
		                             	  datalength=datalength+1;
		                              })  
		                             // alert(datalength);
		                              datalength=datalength+1;
		                              var length1=Number(text_arr.length)-1+Number(datalength);
		                              	for(var i=datalength;i<length1;i++){    
		                            	var tmp_arr = text_arr[i-datalength].split("###");	 
		                            		var url="";
		                            		var urlval="";
		                            	if(tmp_arr[2]=='1'){
									       url="<a href=\\\"javascript:showInfo(\\\'"+tmp_arr[0]+"\\\')\\\">已关联</a>";
									       urlval="已关联"
									       }else{
									        url="未关联";
									        urlval="未关联";
									       }
									   //var gsname="<span class=\\\"e8_showNameClass\\\"><a href=\\\"/formmode/view/ViewMode.jsp?type=0&modeId=52&formId=-59&billid="+tmp_arr[0]+"\\\" target=\\\"_blank\\\">"+tmp_arr[1]+"</a> </span>";
									   var datatxt="{'wdfield14345': '"+tmp_arr[0]+"','wdfield14345span': '"+tmp_arr[1]+"','wdfield14347': '"+tmp_arr[2]+"','wdfield14347span': '"+tmp_arr[2]+"','wdfield14352': '"+urlval+"','wdfield14352span': '"+url+"',";
		                               datatxt=datatxt+"'wdfield14351':'"+tmp_arr[3]+"','wdfield14351span':'"+tmp_arr[4]+"','wdfield14354':'"+tmp_arr[5]+"','wdfield14354span':'"+tmp_arr[5]+"','wdfield14355':'"+tmp_arr[6]+"','wdfield14355span':'"+tmp_arr[6]+"','wdfield14356':'"+tmp_arr[7]+"','wdfield14356span':'"+tmp_arr[8]+"',";
		                               datatxt=datatxt+"'wdfield14357':'"+tmp_arr[9]+"','wdfield14357span':'"+tmp_arr[9]+"','wdfield14358':'"+tmp_arr[10]+"','wdfield14358span':'"+tmp_arr[10]+"','wdfield14359':'"+tmp_arr[11]+"','wdfield14359span':'"+tmp_arr[11]+"','wdfield14360':'"+tmp_arr[12]+"','wdfield14360span':'"+tmp_arr[12]+"',";
		                               datatxt=datatxt+"'wdfield14361':'"+tmp_arr[13]+"','wdfield14361span':'"+tmp_arr[13]+"','wdfield14362':'"+tmp_arr[14]+"','wdfield14362span':'"+tmp_arr[15]+"','wdfield14364':'"+tmp_arr[16]+"','wdfield14364span':'"+tmp_arr[16]+"','wdfield14365':'"+tmp_arr[17]+"','wdfield14365span':'"+tmp_arr[17]+"',";
		                               datatxt=datatxt+"'wdfield14366':'"+tmp_arr[18]+"','wdfield14366span':'"+tmp_arr[18]+"','wdfield14367':'"+tmp_arr[19]+"','wdfield14367span':'"+tmp_arr[19]+"','wdfield14368':'"+tmp_arr[20]+"','wdfield14368span':'"+tmp_arr[20]+"','wdfield14369':'"+tmp_arr[21]+"','wdfield14369span':'"+tmp_arr[21]+"',";
		                               datatxt=datatxt+"'wdfield14370':'"+tmp_arr[22]+"','wdfield14370span':'"+tmp_arr[22]+"','key': "+i+",'fatherKey': 0}";
		                               //alert(datatxt);
		                              var datajson= eval('(' + datatxt + ')'); 
		                              //alert(datajson);
		                              
		                              wfDetail.doLoading(0,true);
		                              datas.push(datajson);
		                              wfDetail.doLoading(0,false);
		                              wfDetail.doSet(0, datas, false, i);
		                          
		                            }
								
							}	
						}
					}
					xhr.send(null);			
				}	    
			}
		
        	})
           
    });
    //页面初始化
    wfDetail.doCbSingle = function(dn) { 
    	if(dn=="0"){
    		dodetail();
	   //setTimeout('dodetail()',5000);
      }	   
    } 
   // wfDetail.doAdd = function(dn,key,index,isCopy) { 
    //console.log(dn,key,index,isCopy)
   // 	alert("111");
//  }
    //编辑时触发
    wfDetail.doEdit = function(dn,key,fieldId) {
    //console.log(dn,key,fieldId)
	    if(dn=="0"&&fieldId=="14345"){
	    
	        var detail = wfDetail.doGet(dn);
		    var datas = detail.datas;	
		    $.each(datas, function(i, value) {
		        if(key==this.key){
		         var gsid=this.wdfield14345;
		         var gsmc=this.wdfield14345span;
		         //alert(gsid+" "+gsmc);
		         this.wdfield14352="";
		          this.wdfield14352span="";
		         if(gsid !=""){
		         
		             var bs=getbs(gsid);
		             var url="";
		             var urlval="";
		             if(bs=='1'){
						 url="<a href=\"javascript:showInfo(\'"+gsid+"\')\">已关联</a>";
						 urlval="已关联";
					}else{
						 url="未关联";
						 urlval="未关联";
					}
				  this.wdfield14352=urlval;
		          this.wdfield14352span=url;
		          this.wdfield14347=bs;
		          this.wdfield14347span=bs;
		         }
		        }	
		    })
		    wfDetail.doSet(0, datas, false, key);
	    }
    }
  function dodetail(){
  	 
  	   var detail = wfDetail.doGet(0);
		var datas = detail.datas;
		$.each(datas, function(i, value) {
		   var gsid=this.wdfield14345;
		   var gsmc=this.wdfield14345span;
		   this.wdfield14352="";
		   this.wdfield14352span="";
		   if(gsid !=""){
			   var bs=this.wdfield14347;
			   
			   var url="";
			   var urlval="";
			   if(bs=='1'){
				url="<a href=\"javascript:showInfo(\'"+gsid+"\')\">已关联</a>";
				urlval="已关联";
			   }else{
				url="未关联";
				urlval="未关联";
			   }
			  this.wdfield14352=urlval;
			  this.wdfield14352span=url;
			  //alert(this.wdfield14352span);
		   }
	    })
	   	wfDetail.doSet(0,datas,false,0);
  }
  function getbs(gsid){
 	var bs="0";
 	var xhr1 = null;
	if (window.ActiveXObject) {//IE浏览器
			xhr1 = new ActiveXObject("Microsoft.XMLHTTP");
  	} else if (window.XMLHttpRequest) {
			xhr1 = new XMLHttpRequest();
	}
	if (null != xhr1) {				
		xhr1.open("GET","/seahonor/crm/jsp/getIsConnectCustom.jsp?gsid="+gsid, false);
		xhr1.onreadystatechange = function () {
			if (xhr1.readyState == 4) {
				if (xhr1.status == 200) {
					var text = xhr1.responseText;
						text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
						//alert("text"+text);
						bs=text;	
									
				}	
			}
		}
		xhr1.send(null);			
	}
   return bs;
   	  
  }
   function deletedetail(){
   	   var jsonArray =[];
	   var detail = wfDetail.doGet(0);
		var datas = detail.datas;
		var datalength=0;
		$.each(datas, function(i, value) {
		       datalength=datalength+1;
		 })
 		if(datalength>0){
   	    if(confirm("是否要清空明细？")){
		}else{
			return false;
		}
     	}
		datas=jsonArray;
		wfDetail.doSet(0,datas,false,0);
    }
    function bindchange(){
    
    }
      function showInfo(id) {

		var title = "";
		var url = "/systeminfo/BrowserMain.jsp?url=/seahonor/crm/jsp/deleteConnectInfoUrl.jsp?customID="+id;
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





