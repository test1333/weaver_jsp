
    function logout(){
		window.location='/bsdt/Logout.jsp';
	}
   function onService(id,url){
   
     		addClickCount(id);//常用
     		
     		if(url=='-1' || url=='') return;
     		openWin(url);
	}
	
	function openWin(url){
		 checkUserIsNull();
		 var width = screen.availWidth-10 ;
		    var height = screen.availHeight-50 ;
		    var szFeatures = "top=0," ;
	 	    szFeatures +="left=0," ;
		    szFeatures +="width="+width+"," ;
		    szFeatures +="height="+height+"," ;
		    szFeatures +="directories=no," ;
		    szFeatures +="status=yes,toolbar=no,location=no," ;
		    szFeatures +="menubar=no," ;
		    szFeatures +="scrollbars=yes," ;
		    szFeatures +="resizable=yes" ; //channelmode
		    window.open(url,"",szFeatures) ;
	}
	
	function addClickCount(id){
		$.ajax({
			  type: 'POST',
			  url: '/bsdt/servlet/servicesServlet.jsp',
			  async:true,
			  data: {action:"addClickCount",servicesid:id},
			  success: function(data){
			  }
		});
		
	}
	
	function checkUserIsNull(){
		var returnval = "";
		$.ajax({
			  type: 'POST',
			  url: '/bsdt/servlet/servicesServlet.jsp',
			  async:false,
			  data: {action:"checkUserIsNull"},
			  success: function(data){
			  	var json = eval(data);
			  	if(json==0){
			  		window.location='/bsdt/login.jsp?action=responseLogin';
			  	}
				returnval= json;
			  }
			  
		});
		return returnval;
	}
    
    
  	function SetUp(){
  	 		checkUserIsNull();
			displaywindow("服务信息","/bsdt/service/addService.jsp");
	//	}else{
		//	alert("您没有权限，请联系管理员!");
		///	return false;
		//}
	}
		
	function displaywindow(title,url){
		 checkUserIsNull();
	     diag_vote = new window.top.Dialog();
	     diag_vote.currentWindow = window;	
	     diag_vote.Width = 1020;
	     diag_vote.Height = 580;
	     diag_vote.Modal = true;
	     diag_vote.Title = title
		 diag_vote.URL = url;
		 diag_vote.isIframe=false;
		 diag_vote.isIframe=false;
		 diag_vote.CancelEvent=function(){
			window.location.reload();
		 };
		 diag_vote.show();
	}	
	
  	function displayService(title,serviceId){
			displaywindow2(title,"/bsdt/service/DisplayService.jsp?id="+serviceId);
	}
	
	function showService(serviceId){
		$.ajax({
			url : "/bsdt/service/GetServiceInfo.jsp",
			type : "post",
			async : false,
			processData : false,
			data : "serviceId="+serviceId,
			dataType : "html",
			success: function do4Success(msg){ 
				var msginfo = jQuery.trim(msg);
				var msgs = msginfo.split("|");
				//fwmc+"|"+sxsm+"|"+xgwd+"|"+sxbh+"|"+sxjc+"|"+cnqx+"|"+sldz+"|"+swfzr+"|"+zxdh+"|"+jddh+"|"+bmlxdx+"|"+fwlxdx+"|"+fwlj+"|"+lct+"|"+lctName+"|"+xgwdName;
				jQuery("#fwmcTitleId").html(msgs[0]);
				jQuery("#fwmcid").html(msgs[0]);
				jQuery("#sxsmid").html(msgs[1]);
				jQuery("#sxbhid").html(msgs[3]);
				jQuery("#sxjcid").html(msgs[4]);
				jQuery("#cnqxid").html(msgs[5]);
				jQuery("#sldzid").html(msgs[6]);
				jQuery("#swfzrid").html(msgs[7]);
				jQuery("#zxdhid").html(msgs[8]);
				jQuery("#jddhid").html(msgs[9]);
				jQuery("#bmlxid").html(msgs[10]);
				jQuery("#fwlxid").html(msgs[11]);
				jQuery("#fwljid").val(msgs[12]);
				//相关资料
				var xgzlids = msgs[2];
				 
				var xgzlNames = msgs[15];
				var xgzlidArr = xgzlids.split(",");
				var xgzlNameArr = xgzlNames.split(",");
				var xgzlStr = "";
				var inno = 0;
				 
				if(xgzlids.trim()!=""){
					for(var index=0;index<xgzlidArr.length;index++){
						if(inno==0){
							xgzlStr += "<span><i class='icon-cloud-download'></i><a href='/weaver/weaver.file.FileDownload?fileid="+xgzlidArr[index]+"' target='_blank' title='"+xgzlNameArr[index]+"'>"+xgzlNameArr[index]+"</a></span>";
							inno++;
						}else{
							xgzlStr += "<br><span><i class='icon-cloud-download'></i><a href='/weaver/weaver.file.FileDownload?fileid="+xgzlidArr[index]+"' target='_blank' title='"+xgzlNameArr[index]+"'>"+xgzlNameArr[index]+"</a></span>";
						}
					}
				}
				 
				jQuery("#xgzlid").html(xgzlStr);
				//流程图
				var lctids = msgs[13];
				var lctNames = msgs[14];
				var lctidArr = lctids.split(",");
				var lctNameArr = lctNames.split(",");
				var lctStr = "";
				inno=0;
				if(lctids.trim()!=""){
					for(var index=0;index<lctidArr.length;index++){
						if(inno==0){
							lctStr += "<span><i class='icon-cloud-download'></i><a href='/weaver/weaver.file.FileDownload?fileid="+lctidArr[index]+"' target='_blank' title='"+lctNameArr[index]+"'>"+lctNameArr[index]+"</a></span>";
							inno++;
						}else{
							lctStr += "<br><span><i class='icon-cloud-download'></i><a href='/weaver/weaver.file.FileDownload?fileid="+lctidArr[index]+"' target='_blank' title='"+lctNameArr[index]+"'>"+lctNameArr[index]+"</a></span>";
						}
					}
				}
				jQuery("#lctid").html(lctStr);
			}
		});	
	}	
	
	//提交流程
	function submitWf(serviceId){
		var checkval = checkUserIsNull();
		var wfUrl = jQuery("#fwljid").val();
		if(checkval=="1"){
			window.open(wfUrl); 
		}else{
			$.ajax({
				  type: 'POST',
				  url: '/bsdt/setCookie.jsp',
				  async:false,
				  data: {wfUrl:wfUrl},
				  success: function(data){
				  }
			});
		}
	}
	//图片 messageurl  /messager/images/icon_m_wev8.jpg 男  /messager/images/icon_w_wev8.jpg女
	//待办 
	function openToDo(){
		var url = "/workflow/request/RequestView.jsp";
		openWin(url);
	}
	//已办
	function havaToDo(){
		
		var url ="/workflow/request/RequestHandled.jsp";
		openWin(url);
	}
	
	function openWorkFolw(requestid){
		var url = "/workflow/request/ViewRequest.jsp?requestid="+requestid;	
		openWin(url);
	}	
	function openDoc(docid){
		var url = "/docs/docs/DocDsp.jsp?id="+docid;	
		openWin(url);
	}
	
	function openMetting(){
		var url = "/meeting/search/MeetingSearch.jsp";	
		openWin(url);
	}

	function onServiceType(typeId,obj){
			$("a[name='serviceType']").each(function(){
					$(this).attr("class","btn dker btn-sm");
			});
			$(obj).attr("class","btn btn-white btn-sm");
		$("#serviceTypeId").val(typeId);
	}

	function onDepartType(typeId,obj){
			$("a[name='departId']").each(function(){
					$(this).attr("class","btn dker btn-sm");
			});
			$(obj).attr("class","btn btn-white btn-sm");
		$("#departId").val(typeId);
	}
	
	function onHrmType(typeId,obj){
		$("a[name='hrmType']").each(function(){
				$(this).attr("class","btn dker btn-sm");
		});
		$(obj).attr("class","btn btn-white btn-sm");
		$("#hrmTypeId").val(typeId);
	}
	
	function onRoleType(typeId,obj){
		$("a[name='roleId']").each(function(){
				$(this).attr("class","btn dker btn-sm");
		});
		$(obj).attr("class","btn btn-white btn-sm");
		$("#roleId").val(typeId);
	}
	
	function addCollection(serviceId,servicestype){
		$.ajax({
			  type: 'POST',
			  url: '/bsdt/servlet/servicesServlet.jsp',
			  async:true,
			  data: {action:"addCollection",servicestype:servicestype,servicesid:serviceId},
			  success: function(data){
			  	var json = eval(data);
			  	if(json==0){
			  		Dialog.alert("已添加到收藏夹成功！");
			  	}
			  }
			  
		});
	}
  