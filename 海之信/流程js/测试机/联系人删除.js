<script type="text/javascript">
           var gjz = "#field14371";
          var jdzt = "";
            var jdzt2 ="";
          var gs_dt = "field14411_";
          var cz="field14390_";
           var bs_dt="field14412_";
           
          var jdzt_dt="wdfield14389";
          var wwm_dt="wdfield14392";
          var lxrcm_dt="wdfield14393";
          var ssjt_dt="wdfield14394";
          var ssgs_dt="wdfield14395";
          var bm_dt="wdfield14396";
          var zw_dt="wdfield14397";
          var yddh_dt="wdfield14398";
          var bgdh_dt="wdfield14399";
          var swcz_dt="wdfield14400";
          
          var bgdz_dt="wdfield14401";
          var yzbm_dt="wdfield14402";
          var dzyx_dt="wdfield14403";
          
          var wxh_dt="wdfield14404";
          var jtdz_dt="wdfield14405";
          var zzdh_dt="wdfield14406";
          
          var sr_dt="wdfield14407";
          var qz_dt="wdfield14408";
          var zzzt_dt="wdfield14409";
          var lzsj_dt="wdfield14410";
	jQuery(document).ready(function () {
//	alert("111");
		
              
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
					xhr.open("GET","/seahonor/crm/jsp/getDeleteContact.jsp?gjz="+gjz_val, false);
					xhr.onreadystatechange = function () {

							if (xhr.readyState == 4) {
								if (xhr.status == 200) {
									var text = xhr.responseText;
									text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
							       //alert(text);
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
									     var ssgsurl="";
									     if(tmp_arr[10] !=""){
									     	 ssgsurl= "<a href=\\\"/formmode/view/ViewMode.jsp?type=0&modeId=52&formId=-59&billid="+tmp_arr[10]+"\\\" target=\\\"_blank\\\">"+tmp_arr[11]+"</a>";
									     }
									     var ssjturl="";
									     if(tmp_arr[8] !=""){
									     	 ssjturl= "<a href=\\\"/formmode/view/ViewMode.jsp?type=0&modeId=61&formId=-68&billid="+tmp_arr[8]+"\\\" target=\\\"_blank\\\">"+tmp_arr[9]+"</a>";
									     }
									     
									   //var gsname="<span class=\\\"e8_showNameClass\\\"><a href=\\\"/formmode/view/ViewMode.jsp?type=0&modeId=52&formId=-59&billid="+tmp_arr[0]+"\\\" target=\\\"_blank\\\">"+tmp_arr[1]+"</a> </span>";
									   var datatxt="{'wdfield14411': '"+tmp_arr[0]+"','wdfield14411span': '"+tmp_arr[1]+"','wdfield14412': '"+tmp_arr[2]+"','wdfield14412span': '"+tmp_arr[2]+"','wdfield14390': '"+urlval+"','wdfield14390span': '"+url+"',";
		                               datatxt=datatxt+"'wdfield14389':'"+tmp_arr[3]+"','wdfield14389span':'"+tmp_arr[4]+"','wdfield14392':'"+tmp_arr[5]+"','wdfield14392span':'"+tmp_arr[5]+"','wdfield14393':'"+tmp_arr[6]+"','wdfield14393span':'"+tmp_arr[7]+"','wdfield14394':'"+tmp_arr[8]+"','wdfield14394span':'"+ssjturl+"',";
		                               datatxt=datatxt+"'wdfield14395':'"+tmp_arr[10]+"','wdfield14395span':'"+ssgsurl+"','wdfield14396':'"+tmp_arr[12]+"','wdfield14396span':'"+tmp_arr[12]+"','wdfield14397':'"+tmp_arr[13]+"','wdfield14397span':'"+tmp_arr[13]+"','wdfield14398':'"+tmp_arr[14]+"','wdfield14398span':'"+tmp_arr[14]+"',";
		                               datatxt=datatxt+"'wdfield14399':'"+tmp_arr[15]+"','wdfield14399span':'"+tmp_arr[15]+"','wdfield14400':'"+tmp_arr[16]+"','wdfield14400span':'"+tmp_arr[16]+"','wdfield14401':'"+tmp_arr[17]+"','wdfield14401span':'"+tmp_arr[17]+"','wdfield14402':'"+tmp_arr[18]+"','wdfield14402span':'"+tmp_arr[18]+"',";
		                               datatxt=datatxt+"'wdfield14403':'"+tmp_arr[19]+"','wdfield14403span':'"+tmp_arr[19]+"','wdfield14404':'"+tmp_arr[20]+"','wdfield14404span':'"+tmp_arr[20]+"','wdfield14405':'"+tmp_arr[21]+"','wdfield14405span':'"+tmp_arr[21]+"','wdfield14406':'"+tmp_arr[22]+"','wdfield14406pan':'"+tmp_arr[22]+"',";
		                               datatxt=datatxt+"'wdfield14407':'"+tmp_arr[23]+"','wdfield14407span':'"+tmp_arr[23]+"','wdfield14408':'"+tmp_arr[24]+"','wdfield14408span':'"+tmp_arr[25]+"','wdfield14409':'"+tmp_arr[26]+"','wdfield14409span':'"+tmp_arr[27]+"','wdfield14410':'"+tmp_arr[28]+"','wdfield14410span':'"+tmp_arr[28]+"','key': "+i+",'fatherKey': 0}";
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
     wfDetail.doEdit = function(dn,key,fieldId) {
    //console.log(dn,key,fieldId)
	    if(dn=="0"&&fieldId=="14411"){
	         //alert("11"); 
	        var detail = wfDetail.doGet(dn);
		    var datas = detail.datas;	
		    $.each(datas, function(i, value) {
		        if(key==this.key){
		         var gsid=this.wdfield14411;
		         var gsmc=this.wdfield14411span;
		         //alert(gsid+" "+gsmc);
		         this.wdfield14390="";
		          this.wdfield14390span="";
		         if(gsid !=""){
		             var tmp_arr=geteditinfo(gsid);
		             //var bs=getbs(gsid);
		             var url="";
		             var urlval="";
		             if(tmp_arr[2]=='1'){
						url="<a href=\"javascript:showInfo(\'"+tmp_arr[0]+"\')\">已关联</a>";
						urlval="已关联"
					}else{
						url="未关联";
						urlval="未关联";
					}
				 var ssgsurl="";
				if(tmp_arr[10] !=""){
					ssgsurl= "<a href=\"/formmode/view/ViewMode.jsp?type=0&modeId=52&formId=-59&billid="+tmp_arr[10]+"\" target=\"_blank\">"+tmp_arr[11]+"</a>";
				}
				var ssjturl="";
				if(tmp_arr[8] !=""){
					ssjturl= "<a href=\"/formmode/view/ViewMode.jsp?type=0&modeId=61&formId=-68&billid="+tmp_arr[8]+"\" target=\"_blank\">"+tmp_arr[9]+"</a>";
				}
			   
			  this.wdfield14412=tmp_arr[2];
			  this.wdfield14412span=tmp_arr[2];
			  this.wdfield14390=urlval;
			  this.wdfield14390span=url;
			  this.wdfield14389=tmp_arr[3];
			  this.wdfield14389span=tmp_arr[4];
			  this.wdfield14392=tmp_arr[5];
			  this.wdfield14392span=tmp_arr[5];
			  
			  this.wdfield14393=tmp_arr[6];
			  this.wdfield14393span=tmp_arr[7];
			  this.wdfield14394=tmp_arr[8];
			  this.wdfield14394span=ssjturl;
			  this.wdfield14395=tmp_arr[10];
			  this.wdfield14395span=ssgsurl;
			  this.wdfield14396=tmp_arr[12];
			  this.wdfield14396span=tmp_arr[12];
			  this.wdfield14397=tmp_arr[13];
			  this.wdfield14397span=tmp_arr[13];
			  this.wdfield14398=tmp_arr[14];
			  this.wdfield14398span=tmp_arr[14];
			  
			  this.wdfield14399=tmp_arr[15];
			  this.wdfield14399span=tmp_arr[15];
			  this.wdfield14400=tmp_arr[16];
			  this.wdfield14400span=tmp_arr[16];
			  this.wdfield14401=tmp_arr[17];
			  this.wdfield14401span=tmp_arr[17];
			  this.wdfield14402=tmp_arr[18];
			  this.wdfield14402span=tmp_arr[18];
			  this.wdfield14403=tmp_arr[19];
			  this.wdfield14403span=tmp_arr[19];
			  this.wdfield14404=tmp_arr[20];
			  this.wdfield14404span=tmp_arr[20];
			  this.wdfield14405=tmp_arr[21];
			  this.wdfield14405span=tmp_arr[21];
			  
			  this.wdfield14406=tmp_arr[22];
			  this.wdfield14406span=tmp_arr[22];
			  this.wdfield14407=tmp_arr[23];
			  this.wdfield14407span=tmp_arr[23];
			  this.wdfield14408=tmp_arr[24];
			  this.wdfield14408span=tmp_arr[25];
			  this.wdfield14409=tmp_arr[26];
			  this.wdfield14409span=tmp_arr[27];
			  this.wdfield14410=tmp_arr[28];
			  this.wdfield14410span=tmp_arr[28];
		         }
		        }	
		    })
	    }
    }
   function dodetail(){
  	 
  	   var detail = wfDetail.doGet(0);
		var datas = detail.datas;
		$.each(datas, function(i, value) {
		   var gsid=this.wdfield14411;
		   var gsmc=this.wdfield14411span;
		   this.wdfield14390="";
		   this.wdfield14390span="";
          var ssjtid=this.wdfield14394;
		   var ssjtspan=this.wdfield14394span;
		  var ssgsid=this.wdfield14395;
		  var ssgsspan=this.wdfield14395span;
		   if(gsid !=""){
			   var bs=this.wdfield14412;
			   
			   var url="";
			   var urlval="";
			   if(bs=='1'){
				url="<a href=\"javascript:showInfo(\'"+gsid+"\')\">已关联</a>";
				urlval="已关联";
			   }else{
				url="未关联";
				urlval="未关联";
			   }
			    var ssgsurl="";
				if(ssgsid !=""){
						ssgsurl= "<a href=\\\"/formmode/view/ViewMode.jsp?type=0&modeId=52&formId=-59&billid="+ssgsid+"\\\" target=\\\"_blank\\\">"+ssgsspan+"</a>";
				}
				var ssjturl="";
				if(ssjtid !=""){
					ssjturl= "<a href=\\\"/formmode/view/ViewMode.jsp?type=0&modeId=61&formId=-68&billid="+ssjtid+"\\\" target=\\\"_blank\\\">"+ssjtspan+"</a>";
				}
			  this.wdfield14394span=ssjturl;
			  this.wdfield14395span=ssgsurl;
			  this.wdfield14390=urlval;
			  this.wdfield14390span=url;
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
		xhr1.open("GET","/seahonor/crm/jsp/getIsConnectContact.jsp?gsid="+gsid, false);
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
  
   function geteditinfo(lxrid){
  	  var dataarr=[];
  	  var xhr3 = null;
				if (window.ActiveXObject) {//IE浏览器
					 
				xhr3 = new ActiveXObject("Microsoft.XMLHTTP");
  				
				} else if (window.XMLHttpRequest) {
					xhr3 = new XMLHttpRequest();
				}
				lxrid=encodeURIComponent(lxrid);
				if (null != xhr3) {				
					xhr3.open("GET","/seahonor/crm/jsp/geteditDeleteContact.jsp?lxrid="+lxrid, false);
					xhr3.onreadystatechange = function () {

							if (xhr3.readyState == 4) {
								if (xhr3.status == 200) {
									var text = xhr3.responseText;
									text = text.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
							        //alert(text);
							       var text_arr = text.split("@@@");
		                           	var tmp_arr = text_arr[0].split("###");	 
		                           dataarr=tmp_arr;
		                   
								
							}	
						}
					}
					xhr3.send(null);			
				}	 
				//alert(dataarr);   
  	  return dataarr;
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
    function bindchange(index1){
    		jQuery("#"+gs_dt+index1).bindPropertyChange(function (){ 
    		   var gs_dt_val = jQuery("#"+gs_dt+index1).val();
    		   	jQuery("#"+cz+index1).val("");							
			jQuery("#"+cz+index1+"span").html("");
			if(gs_dt_val !=''){
				jQuery.post("/seahonor/crm/jsp/getIsConnectContact.jsp", {
                    'gsid': gs_dt_val
                }, function (data) {
                    //alert(data);
                    	data = data.replace(/^(\s|\xA0)+|(\s|\xA0)+$/g, '');	
                    	jQuery("#"+bs_dt+index1).val(data);							
				jQuery("#"+bs_dt+index1+"span").text(data);
				var url="";
				if(data=='1'){
				url="<a href=\"javascript:showInfo('"+gs_dt_val+"')\">已关联</a>";
				}else{
				url="未关联";
				}
				jQuery("#"+cz+index1).val(url);							
				jQuery("#"+cz+index1+"span").html(url);
                 
                });
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





