<!DOCTYPE html>
<%@ page import="weaver.general.Util" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<HTML><HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<LINK href="/wui/theme/ecology8/jquery/js/e8_zDialog_btn_wev8.css" type=text/css rel=STYLESHEET>
<link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/swfupload/swfupload_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogress_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/handlers_wev8.js"></script>
<SCRIPT language="javascript" src="/js/weaver_wev8.js"></script>
<%
	String id = Util.null2String(request.getParameter("id"));
	String bdbh = Util.null2String(request.getParameter("bdbh"));
	String rabdbh = Util.null2String(request.getParameter("bdbh"));
	if(id.length() == 0){
		RecordSet.executeSql("select * from uf_zy where bdbh = '" + bdbh +"'");
		if(RecordSet.next()){
			id = Util.null2String(RecordSet.getString("id")); 
		}
	}
	
	String accsize ="20";
	String accsec="9";//目录
	
%>
	<style type="text/css">
		.td_warp {
			width:95%;
			display: inline-block;
			text-align: center;
			height:33px;
			line-height: 33px;
			background-color: rgb(16,160,234);
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		.td_warpMore {
			width:95%;
			display: inline-block;
			text-align: center;
			height:60px;
			line-height: 33px;
			background-color: rgb(16,160,234);
			float:left;
			margin-bottom:3%;
			color:rgb(255,255,255);
		}
		
		.warp_cont{
			height:30px;
			width:90%;
			line-height: 25px;
		}
		.warp{
			width:97%;
		}
		.title{
			margin:2% auto;
			text-align: center;
		}
		.btnSummbit{  
			background-color:#10A0EA;  
			border:none;  
			height:40px;  
			color:white;  
			font-size:18px;  
			width:150px  
		} 
		
	    	.bg{
			width: 80px;
			height: 40px;
			background-color: #33CCFF;
			float:left;
		}
		.bg:hover{
			background-color: #FFCC66;
		}
		.div_warp div{
			float:left;
			width:10%;
			margin-left:3%;
		}
		.bg1{
			width: 80px;
			height: 40px;
			background-color: #FF6633;
			float:left;
		}
		.bg1:hover{
			background-color: #FFCC66;
		}
	</style>
	<script type="text/javascript">
			var oUpload;
			var oUpload_scip;	
			var oUpload_scjh;
			var oUpload_csbg;
			var count=0;
				window.onload = function() {
				  var settings = {
						flash_url : "/js/swfupload/swfupload.swf",
						upload_url: "/proj/data/uploadPrjAcc.jsp",	// Relative to the SWF file
						post_params: {"method" : "uploadPrjAcc","secid":"<%=accsec %>"},
						file_size_limit : "<%=accsize %> MB",
						file_types : "*.*",
						file_types_description : "All Files",
						file_upload_limit : 100,
						file_queue_limit : 0,
						custom_settings : {
							progressTarget : "fsUploadProgress",
							cancelButtonId : "btnCancel"
						},
						debug: false,
						 

						// Button settings
						
						button_image_url : "/js/swfupload/add_wev8.png",	// Relative to the SWF file
						button_placeholder_id : "spanButtonPlaceHolder",
		
						button_width: 100,
						button_height: 18,
						button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
						button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
						button_text_top_padding: 0,
						button_text_left_padding: 18,
							
						button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
						button_cursor: SWFUpload.CURSOR.HAND,
						
						// The event handler functions are defined in handlers.js
						file_queued_handler : fileQueued,
						file_queue_error_handler : fileQueueError,
						file_dialog_complete_handler : fileDialogComplete_1,
						upload_start_handler : uploadStart,
						upload_progress_handler : uploadProgress,
						upload_error_handler : uploadError,
						upload_success_handler : uploadSuccess,
						upload_complete_handler : uploadComplete,
						queue_complete_handler : queueComplete	// Queue plugin event
					};
					 var settings_scip = {
						flash_url : "/js/swfupload/swfupload.swf",
						upload_url: "/proj/data/uploadPrjAcc.jsp",	// Relative to the SWF file
						post_params: {"method" : "uploadPrjAcc","secid":"<%=accsec %>"},
						file_size_limit : "<%=accsize %> MB",
						file_types : "*.*",
						file_types_description : "All Files",
						file_upload_limit : 100,
						file_queue_limit : 0,
						custom_settings : {
							progressTarget : "fsUploadProgress_scip",
							cancelButtonId : "btnCancel"
						},
						debug: false,
						 

						// Button settings
						
						button_image_url : "/js/swfupload/add_wev8.png",	// Relative to the SWF file
						button_placeholder_id : "spanButtonPlaceHolder_scip",
		
						button_width: 100,
						button_height: 18,
						button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
						button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
						button_text_top_padding: 0,
						button_text_left_padding: 18,
							
						button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
						button_cursor: SWFUpload.CURSOR.HAND,
						
						// The event handler functions are defined in handlers.js
						file_queued_handler : fileQueued,
						file_queue_error_handler : fileQueueError,
						file_dialog_complete_handler : fileDialogComplete_scip,
						upload_start_handler : uploadStart,
						upload_progress_handler : uploadProgress,
						upload_error_handler : uploadError,
						upload_success_handler : uploadSuccess_scip,
						upload_complete_handler : uploadComplete,
						queue_complete_handler : queueComplete	// Queue plugin event
					};
					
					 var settings_scjh = {
						flash_url : "/js/swfupload/swfupload.swf",
						upload_url: "/proj/data/uploadPrjAcc.jsp",	// Relative to the SWF file
						post_params: {"method" : "uploadPrjAcc","secid":"<%=accsec %>"},
						file_size_limit : "<%=accsize %> MB",
						file_types : "*.*",
						file_types_description : "All Files",
						file_upload_limit : 100,
						file_queue_limit : 0,
						custom_settings : {
							progressTarget : "fsUploadProgress_scjh",
							cancelButtonId : "btnCancel"
						},
						debug: false,
						 

						// Button settings
						
						button_image_url : "/js/swfupload/add_wev8.png",	// Relative to the SWF file
						button_placeholder_id : "spanButtonPlaceHolder_scjh",
		
						button_width: 100,
						button_height: 18,
						button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
						button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
						button_text_top_padding: 0,
						button_text_left_padding: 18,
							
						button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
						button_cursor: SWFUpload.CURSOR.HAND,
						
						// The event handler functions are defined in handlers.js
						file_queued_handler : fileQueued,
						file_queue_error_handler : fileQueueError,
						file_dialog_complete_handler : fileDialogComplete_scjh,
						upload_start_handler : uploadStart,
						upload_progress_handler : uploadProgress,
						upload_error_handler : uploadError,
						upload_success_handler : uploadSuccess_scjh,
						upload_complete_handler : uploadComplete,
						queue_complete_handler : queueComplete	// Queue plugin event
					};
					
					 var settings_csbg = {
						flash_url : "/js/swfupload/swfupload.swf",
						upload_url: "/proj/data/uploadPrjAcc.jsp",	// Relative to the SWF file
						post_params: {"method" : "uploadPrjAcc","secid":"<%=accsec %>"},
						file_size_limit : "<%=accsize %> MB",
						file_types : "*.*",
						file_types_description : "All Files",
						file_upload_limit : 100,
						file_queue_limit : 0,
						custom_settings : {
							progressTarget : "fsUploadProgress_csbg",
							cancelButtonId : "btnCancel"
						},
						debug: false,
						 

						// Button settings
						
						button_image_url : "/js/swfupload/add_wev8.png",	// Relative to the SWF file
						button_placeholder_id : "spanButtonPlaceHolder_csbg",
		
						button_width: 100,
						button_height: 18,
						button_text : '<span class="button"><%=SystemEnv.getHtmlLabelName(21406,user.getLanguage())%></span>',
						button_text_style : '.button { font-family: Helvetica, Arial, sans-serif; font-size: 12pt; } .buttonSmall { font-size: 10pt; }',
						button_text_top_padding: 0,
						button_text_left_padding: 18,
							
						button_window_mode: SWFUpload.WINDOW_MODE.TRANSPARENT,
						button_cursor: SWFUpload.CURSOR.HAND,
						
						// The event handler functions are defined in handlers.js
						file_queued_handler : fileQueued,
						file_queue_error_handler : fileQueueError,
						file_dialog_complete_handler : fileDialogComplete_csbg,
						upload_start_handler : uploadStart,
						upload_progress_handler : uploadProgress,
						upload_error_handler : uploadError,
						upload_success_handler : uploadSuccess_csbg,
						upload_complete_handler : uploadComplete,
						queue_complete_handler : queueComplete	// Queue plugin event
					};
					
					try{
						oUpload = new SWFUpload(settings);
						oUpload_scip = new SWFUpload(settings_scip);
						oUpload_scjh = new SWFUpload(settings_scjh);
						oUpload_csbg = new SWFUpload(settings_csbg);
					} catch(e){alert(e)}
				}
		
				function fileDialogComplete_1(){
					document.getElementById("btnCancel1").disabled = false;
					fileDialogComplete
				}
				function fileDialogComplete_scip(){
					document.getElementById("btnCancel1_scip").disabled = false;
					fileDialogComplete
				}
				function fileDialogComplete_scjh(){
					document.getElementById("btnCancel1_scjh").disabled = false;
					fileDialogComplete
				}
				function fileDialogComplete_csbg(){
					document.getElementById("btnCancel1_csbg").disabled = false;
					fileDialogComplete
				}
				
				function uploadSuccess(fileObj,serverdata){
					
					var data=eval(serverdata);
					//alert(data);
					if(data){
						var a=data;
						if(a>0){
							if(jQuery("#scx").val() == ""){

								jQuery("#scx").val(a);
							}else{
							
								jQuery("#scx").val(jQuery("#scx").val()+","+a);
							}
						}
					}
					//alert("scx"+jQuery("#scx").val());
				}
				function uploadSuccess_scip(fileObj,serverdata){
				
					var data=eval(serverdata);
					//alert(data);
					if(data){
						var a=data;
						if(a>0){
							if(jQuery("#scip").val() == ""){

								jQuery("#scip").val(a);
							}else{
							
								jQuery("#scip").val(jQuery("#scip").val()+","+a);
								
							}
						}
						//alert("scip"+jQuery("#scip").val());
					}
				}
				
			function uploadSuccess_scjh(fileObj,serverdata){
				
					var data=eval(serverdata);
					//alert(data);
					if(data){
						var a=data;
						if(a>0){
							if(jQuery("#scjh").val() == ""){

								jQuery("#scjh").val(a);
							}else{
							
								jQuery("#scjh").val(jQuery("#scjh").val()+","+a);
								
							}
						}
						//alert("scjh"+jQuery("#scjh").val());
					}
				}
				
				function uploadSuccess_csbg(fileObj,serverdata){
				
					var data=eval(serverdata);
					//alert(data);
					if(data){
						var a=data;
						if(a>0){
							if(jQuery("#csbg").val() == ""){

								jQuery("#csbg").val(a);
							}else{
							
								jQuery("#csbg").val(jQuery("#csbg").val()+","+a);
								
							}
						}
						//alert("csbg"+jQuery("#csbg").val());
					}
				}
				
				function uploadComplete(fileObj) {
					try {
						/*  I want the next upload to continue automatically so I'll call startUpload here */
						if (this.getStats().files_queued === 0) {
							count = count+1;
							//alert(count);
							if(count == 4){
								weaver.submit();
							}
							document.getElementById(this.customSettings.cancelButtonId).disabled = true;
						} else {	
							this.startUpload();
						}
					} catch (ex) { this.debug(ex); }
		
				}
			</script>		
<SCRIPT>
	var diag_vote;
	function Foo(bttID){
		
		var title = "";
		var url = "/hehui/qa/ra/qaRAListOtherDetail1.jsp?mainid="+bttID;
//		alert(url);
		diag_vote = new window.top.Dialog();
		diag_vote.currentWindow = window;
		diag_vote.Width = 1700;
		diag_vote.Height = 800;
		diag_vote.Modal = true;
		diag_vote.Title = title;
		diag_vote.URL = url;
		diag_vote.isIframe=false;
		diag_vote.CancelEvent=function(){
			diag_vote.close();
			window.location.reload();
		};
		diag_vote.show();
	}
	
	function closeDialog(){
		diag_vote.close();
	}
	
	function delitem(bttID){
		if(window.confirm('你是确认删除？')){
			var urlx = "/hehui/qa/ra/qaRASMList.jsp?uf=del&dtid="+bttID+"&id=<%=id%>";
	//		alert("urlx = " + urlx);
			$.get(urlx,function(data,status){
				 jQuery("#tableChlddivx").html(data);
			});
		}
	}
	
	function submitData(){
		var sData = jQuery("#syxm_dt").val();
		// alert("sData = " + sData);
		if(sData.length > 0 && sData != "-1"){
			if(window.confirm('你是确认增加？')){
				var urlx = "/hehui/qa/ra/qaRASMList.jsp?uf=add&syxm="+sData+"&id=<%=id%>";
		//		alert("urlx = " + urlx);
				$.get(urlx,function(data,status){
					 jQuery("#tableChlddivx").html(data);
				});

			}
		}else{
			alert("请选择一种实验目的！");
		}
		
	}
	
	function savaDataBt(){
		var flag_scx="1";
		var flag_scip="1";
		var flag_scjh ="1";
		var flag_csbg = "1";
		var checkIDS = jQuery("#checkIDS").val();
	//	alert("checkIDS = " + checkIDS);
		if (check_form(weaver,checkIDS)){
			if((!oUpload || oUpload.getStats().files_queued === 0) && (!oUpload_scip || oUpload_scip.getStats().files_queued === 0)&& (!oUpload_scjh || oUpload_scjh.getStats().files_queued === 0)&& (!oUpload_csbg || oUpload_csbg.getStats().files_queued === 0) ){
				weaver.submit();
			}else{
				if(!oUpload || oUpload.getStats().files_queued === 0){
					count = count+1;
					flag_scx = "0";
				}
				if(!oUpload_scip || oUpload_scip.getStats().files_queued === 0){
					count = count+1;
					flag_scip="0";
				}
				if(!oUpload_scjh || oUpload_scjh.getStats().files_queued === 0){
					count = count+1;
					flag_scjh = "0";
				}
				if(!oUpload_csbg || oUpload_csbg.getStats().files_queued === 0){
					count = count+1;
					flag_csbg = "0";
				}
				if(flag_scx == "1"){
					oUpload.startUpload();
				}
				if(flag_scip == "1"){
					oUpload_scip.startUpload();
				}
				if(flag_scjh == "1"){
					oUpload_scjh.startUpload();
				}
				if(flag_csbg == "1"){
					oUpload_csbg.startUpload();
				}
			}
			
		//weaver.submit();
		}
	} 
	
	function changeSyzl(){
		var syzl_val = jQuery("#syzl  option:selected").text();
		// DVT MVT   syjd  ra
		if(syzl_val=='DVT'||syzl_val=='MVT'){
			//jQuery("#yzxh").attr("disabled",false).css("background-color","");
			jQuery("#syjd_1").css("display","none");
			jQuery("#syjd_2").show();
			
			// 必填字段 校验加上 checkIDS
			var checkIDS = jQuery("#checkIDS").val();
			// 文本修改成只读
			jQuery("#ecbh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#ecbhmage").html("");
			// 文本修改成只读
			jQuery("#dcbh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#dcbhmage").html("");
			if(checkIDS.indexOf(",dcbh") >= 0){
				checkIDS = checkIDS.replace(",dcbh","");
			}
			if(checkIDS.indexOf(",ecbh") >= 0){
				checkIDS = checkIDS.replace(",ecbh","");
			}
			if(checkIDS.indexOf(",syjd") < 0){
				checkIDS = checkIDS + ",syjd";
			}
			jQuery("#checkIDS").val(checkIDS);
		}else if(syzl_val == "DC"){
		//	alert("==");
			// DC编号必填
			jQuery("#dcbh").attr("disabled",false).css("background-color","");
			jQuery("#dcbhmage").html("");
			var checkIDS = jQuery("#checkIDS").val(); 
			if(checkIDS.indexOf(",dcbh") < 0){
				checkIDS = checkIDS + ",dcbh";
				// 把必填的感叹号 增加上，添加前，判断文本框中是否值,有值不添感叹号
				if(jQuery("#dcbh").val().length <=0){
					jQuery("#dcbhmage").html("<img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\">");
				}
			}
			// 文本修改成只读
			jQuery("#ecbh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#ecbhmage").html("");
			jQuery("#checkIDS").val(checkIDS);
		}else if(syzl_val == "EC"){
		//	alert("==");
			// EC编号必填
			jQuery("#ecbh").attr("disabled",false).css("background-color","");
			jQuery("#ecbhmage").html("");
			var checkIDS = jQuery("#checkIDS").val(); 
			if(checkIDS.indexOf(",ecbh") < 0){
				checkIDS = checkIDS + ",ecbh";
				// 把必填的感叹号 增加上，添加前，判断文本框中是否值,有值不添感叹号
				if(jQuery("#ecbh").val().length <=0){
					jQuery("#ecbhmage").html("<img src=\"/images/BacoError_wev8.gif\" align=\"absMiddle\">");
				}
			}
			// 文本修改成只读
			jQuery("#dcbh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#dcbhmage").html("");
			jQuery("#checkIDS").val(checkIDS);
		}else{
			var checkIDS = jQuery("#checkIDS").val();
			// 文本修改成只读
			jQuery("#ecbh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#ecbhmage").html("");
			// 文本修改成只读
			jQuery("#dcbh").attr("disabled","disabled").css("background-color","#EEEEEE;");
			// 把必填的感叹号 出掉。
			jQuery("#dcbhmage").html("");
			if(checkIDS.indexOf(",dcbh") >= 0){
				checkIDS = checkIDS.replace(",dcbh","");
			}
			if(checkIDS.indexOf(",ecbh") >= 0){
				checkIDS = checkIDS.replace(",ecbh","");
			}
			jQuery("#syjd_1").css("display","block");
			jQuery("#syjd_2").hide();
			// 必填字段 校验去掉
			var checkIDS = jQuery("#checkIDS").val();
			if(checkIDS.indexOf(",syjd") >= 0){
				checkIDS = checkIDS.replace(",syjd","");
			}
			jQuery("#checkIDS").val(checkIDS);
		}
		
		
		
	}
	function onChangeSharetype(docid,fieldid){
		var delspan="span_id_"+docid;
		var field_id="#field_id_"+docid;
		var field_del="#field_del_"+docid;
		
		  var attachids=jQuery("#"+fieldid).val();
		if(document.all(delspan).style.visibility=='visible'){
          document.all(delspan).style.visibility='hidden';
          jQuery(field_del).val("0"); 
		  if(attachids==""){
			  jQuery("#"+fieldid).val(docid);
		  }else{
			  attachids=attachids+","+docid;
			  jQuery("#"+fieldid).val(attachids);
		  }
        }else{
			
          document.all(delspan).style.visibility='visible';
         jQuery(field_del).val("1"); 
    	  var attachArr=attachids.split(",");
		  var flag="";
		  var newids = "";
		  for(var i=0;i<attachArr.length;i++){
			if(attachArr[i] !=docid){
				newids = newids+flag+attachArr[i];
				flag=","; 
			}
		  }
		  attachids = newids;
		  jQuery("#"+fieldid).val(attachids);
        }
	}

	function checkchange(fieldid){
	
			var field_val=jQuery("#"+fieldid).val();
			if(field_val == ""){
				field_val ="0";
			}
			if(field_val=="0"){
				jQuery("#"+fieldid).val("1");
			}else{
				jQuery("#"+fieldid).val("0");
			}
	
		}
</SCRIPT>
</head>
<%
	

	if(id.length() < 1){
		return;
	}
	String bt = ""; //标题
//	String bdbh = ""; //表单编号
	String sqr = ""; //申请人
	String gh = ""; //工号
	String ssbm = ""; //所属部门
	String sqrq = ""; //申请日期
	String cc = ""; //尺寸
	String cpxh = ""; //产品型号
	String kh = ""; //客户
	String cpxhjb = ""; //产品型号级别(如一代)
	String syzsl = ""; //实验总数量(MDL)
	String syzslp = ""; //实验总数量(Panel)
	String cldj = ""; //有机材料类别
	String syzl = ""; //试验种类
	String syjd = ""; //试验阶段
	String yzxh = ""; //RA验证序号
	String ecbh = ""; //EC编号
	String dcbh = ""; //DC编号
	String sjxyx = ""; //是否需要新Code
	String sfxytp = ""; //是否需要TP新配置文件
	String cl = ""; //量测
		String gx = ""; String gh1 = ""; String tp = "";  //  光学   功耗   TP
	String gcxm = ""; //观察项目  
		String hz = ""; String wg = ""; //  画质  外观
	String jcsj = ""; //检查时间(hr)
		String sj1 = ""; String sj2 = ""; String sj3 = ""; String sj4 = ""; String sj5 = ""; String qt = "";
	String sqrlxfs = ""; //申请人联系方式 
	String bgyylb = ""; //变更原因类别 
	String sqjjcd = ""; //申请紧急程度 
	String csyy = ""; //实验目的 
	String bgqsm = ""; //变更前说明
	String bghsm = ""; //变更后说明
	String scx = ""; //上传新Code
	String scip = ""; //上传TP新配置文件 
	String xsjg = ""; //测试结果 
		String xsjg1 = "";
	String scjh = ""; //上传附件‘计划’
	String czr = ""; //操作人 
	String czsm = ""; //操作说明  
	String csbg = ""; //RA测试报告  
	String yaqzsj = ""; //样品取走时间
	RecordSet.executeSql("select * from uf_zy where id = " + id);
	if(RecordSet.next()){
		bt = Util.null2String(RecordSet.getString("bt")); //标题
		bdbh = Util.null2String(RecordSet.getString("bdbh")); //表单编号
		sqr = Util.null2String(RecordSet.getString("sqr")); //申请人
		gh = Util.null2String(RecordSet.getString("gh")); //工号
		ssbm = Util.null2String(RecordSet.getString("ssbm")); //所属部门
		sqrq = Util.null2String(RecordSet.getString("sqrq")); //申请日期
		cc = Util.null2String(RecordSet.getString("cc")); //尺寸
		cpxh = Util.null2String(RecordSet.getString("cpxh")); //产品型号
		kh = Util.null2String(RecordSet.getString("kh")); //客户
		cpxhjb = Util.null2String(RecordSet.getString("cpxhjb")); //产品型号级别(如一代)
		syzsl = Util.null2String(RecordSet.getString("syzsl")); //实验总数量(MDL)
		syzslp = Util.null2String(RecordSet.getString("syzslp")); //实验总数量(Panel)
		cldj = Util.null2String(RecordSet.getString("cldj")); //有机材料类别
		syzl = Util.null2String(RecordSet.getString("syzl")); //试验种类
		syjd = Util.null2String(RecordSet.getString("syjd")); //试验阶段
		yzxh = Util.null2String(RecordSet.getString("yzxh")); //RA验证序号
		ecbh = Util.null2String(RecordSet.getString("ecbh")); //EC编号
		dcbh = Util.null2String(RecordSet.getString("dcbh")); //DC编号
		sjxyx = Util.null2String(RecordSet.getString("sjxyx")); //是否需要新Code
		sfxytp = Util.null2String(RecordSet.getString("sfxytp")); //是否需要TP新配置文件
		cl = Util.null2String(RecordSet.getString("cl")); //量测
			 gx = Util.null2String(RecordSet.getString("gx")); gh1 = Util.null2String(RecordSet.getString("gh1"));  tp = Util.null2String(RecordSet.getString("tp"));  //  光学   功耗   TP
		gcxm = Util.null2String(RecordSet.getString("gcxm")); //观察项目  
			 hz = Util.null2String(RecordSet.getString("hz")); wg = Util.null2String(RecordSet.getString("wg")); //  画质  外观
		jcsj = Util.null2String(RecordSet.getString("jcsj")); //检查时间(hr)
			sj1 = Util.null2String(RecordSet.getString("sj1"));sj2 = Util.null2String(RecordSet.getString("sj2"));sj3 = Util.null2String(RecordSet.getString("sj3"));
			sj4 = Util.null2String(RecordSet.getString("sj4"));sj5 = Util.null2String(RecordSet.getString("sj5"));qt = Util.null2String(RecordSet.getString("qt"));
		sqrlxfs = Util.null2String(RecordSet.getString("sqrlxfs")); //申请人联系方式 
		bgyylb = Util.null2String(RecordSet.getString("bgyylb")); //变更原因类别 
		sqjjcd = Util.null2String(RecordSet.getString("sqjjcd")); //申请紧急程度 
		csyy = Util.null2String(RecordSet.getString("csyy")); //实验目的 
		bgqsm = Util.null2String(RecordSet.getString("bgqsm")); //变更前说明
		bghsm = Util.null2String(RecordSet.getString("bghsm")); //变更后说明
		scx = Util.null2String(RecordSet.getString("scx")); //上传新Code
		scip = Util.null2String(RecordSet.getString("scip")); //上传TP新配置文件 
		xsjg = Util.null2String(RecordSet.getString("xsjg")); //测试结果 
			xsjg1 = Util.null2String(RecordSet.getString("xsjg1"));
		scjh = Util.null2String(RecordSet.getString("scjh")); //上传附件‘计划’
		czr = Util.null2String(RecordSet.getString("czr")); //操作人 
		czsm = Util.null2String(RecordSet.getString("czsm")); //操作说明  
		csbg = Util.null2String(RecordSet.getString("csbg")); //RA测试报告  
		yaqzsj = Util.null2String(RecordSet.getString("yaqzsj")); //样品取走时间
	}

	String imagefilename = "/images/hdHRMCard_wev8.gif";
	String titlename = "展示";
	String needfav ="1";
	String needhelp ="";
	String sql = "";
%>
<BODY>
<div align="center">
	<div class= "title">
		<h1>RA_信赖性实验室综合实验单管理查询</h1>
	</div>
	<FORM id=weaver name=weaver action="/hehui/qa/ra/submit-qaRAListOther-info.jsp" method=post enctype="multipart/form-data">
		<input type = "hidden" id="checkIDS" name="checkIDS"  value="syzsl,yzxh,syjd"> 
		<input type = "hidden" id="raid" value = "<%=id%>" name = "raid"/>
		<input type = "hidden" id="rabdbh" value = "<%=rabdbh%>" name = "rabdbh"/>
		<input type = "hidden" id="scx" value = "<%=scx%>" name = "scx"/>
		<input type = "hidden" id="scip" value = "<%=scip%>" name = "scip"/>
		<input type = "hidden" id="scjh" value = "<%=scjh%>" name = "scjh"/>
		<input type = "hidden" id="csbg" value = "<%=csbg%>" name = "csbg"/>
			<!--存放必填字段ID-->
	<table class="warp">
		<colgroup><col width="12%"/><col width="16%"/><col width="8%"/><col width="16%"/>
					<col width="16%"/><col width="20%"/><col width="18%"/><col width="16%"/></colgroup>
		<tbody>
			<tr>
				<td class="td_warp">标题</td>
				<td ><input type = "text" class="warp_cont"  value = "<%=bt%>" name = "bt" disabled title="<%=bt%>" /></td>
				<td class="td_warp">表单编号</td>
				<td  ><input type = "text" class="warp_cont"  value = "<%=bdbh%>" name = "bdbh" disabled title="<%=bdbh%>" /></td>
				<td class="td_warp">申请人</td>
				<td ><%=Util.toScreen(ResourceComInfo.getResourcename(sqr),user.getLanguage())%></td>
				<td  class="td_warp">工号</td>
				<td class="warp_cont"><input type = "text" class="warp_cont" value = "<%=gh%>"  disabled title="<%=gh%>"  /></td>
			</tr>
			<tr>
				<td class="td_warp">所属部门</td>
				<td ><%=Util.toScreen(DepartmentComInfo.getDepartmentname(ssbm),user.getLanguage())%></td>
				<td class="td_warp">申请日期</td>
				<td ><input type = "text"  class="warp_cont" value = "<%=sqrq%>" name = "sqrq"  disabled  /></td>
				<td class="td_warp">尺寸</td>
				<td >  
					<select name="cc">
		    				<option value=-1></option>   
		    				<%
							int cc_int = -1;
							if(cc.length() > 0 ) {
								cc_int = Integer.parseInt(cc);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='cc' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
						<option value=<%=tmp_val%>  <%if(cc_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">产品类型</td>
				<td > 
					<select name="cpxh">
		    				<option value=-1></option>   
		    				<%
		    					int cpxh_int = -1;
							if(cpxh.length() > 0 ) {
								cpxh_int = Integer.parseInt(cpxh);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='cpxh' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(cpxh_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
			</td>
			</tr>
			<tr>
				<td class="td_warp">客户</td>
				<td >
					<select name="kh">
		    				<option value=-1></option>   
		    				<%
		    					int kh_int = -1;
							if(kh.length() > 0 ) {
								kh_int = Integer.parseInt(kh);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='kh' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(kh_int==tmp_val){ %>selected <%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">产品型号级别</td>
				<td ><input type = "text" class="warp_cont" value = "<%=cpxhjb%>" name = "cpxhjb"/></td>
				<td class="td_warp">实验总数量(MDL)</td>
				<td ><input type = "text"  class="warp_cont" value = "<%=syzsl%>"  id = "syzsl" name = "syzsl" onchange = "checkinput('syzsl','syzslmage')"/>
				<span id="syzslmage"><%if("".equals(syzsl)){%><img src="/image/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
				<td class="td_warp">实验总数量(Panel)</td>
				<td ><input type = "text" class="warp_cont" value = "<%=syzslp%>" id="syzslp" name = "syzslp" onchange = "checkinput('syzslp','syzslpmage')"/>
				<span id="syzslpmage"><%if("".equals(syzslp)){%><img src="/image/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			</tr>
			<tr> 
				<td class="td_warp">有机材料类别</td>
				<td >
					<select name="cldj">
		    				<option value=-1></option>   
		    				<%
		    					int cldj_int = -1;
							if(cldj.length() > 0 ) {
								cldj_int = Integer.parseInt(cldj);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='cldj' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(cldj_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">试验种类</td> 
				<td >
					<select name="syzl" id= "syzl" onchange="changeSyzl()">
		    				<option value=-1></option>   
		    				<%
		    					int syzl_int = -1;
							if(syzl.length() > 0 ) {
								syzl_int = Integer.parseInt(syzl);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='syzl' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(syzl_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">试验阶段</td>
				<td >
					<div id="syjd_1" style="display:none"> 
						<input type = "text" id="syjd_1_1" name = "syjd_1_1" disabled size="10" />
					</div>
					<div id="syjd_2">
						<select name="syjd" id="syjd">
								<option value=-1></option>   
								<%
									int syjd_int = -1;
								if(syjd.length() > 0 ) {
									syjd_int = Integer.parseInt(syjd);
								}
									sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='syjd' and cancel=0 order by listorder asc";
								RecordSet.executeSql(sql);
								while(RecordSet.next()){
									String tmp_name = Util.null2String(RecordSet.getString("selectname"));
									int tmp_val = RecordSet.getInt("selectvalue");
								%>
									<option value=<%=tmp_val%>  <%if(syjd_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
							<%}%>
						</select>
					</div>
				</td>
				<td class="td_warp">RA验证序号</td>
				<td ><input type = "text" class="warp_cont" value = "<%=yzxh%>" id="yzxh" name = "yzxh" onchange = "checkinput('yzxh','yzxhmage')"/>
					<span id="yzxhmage"><%if("".equals(yzxh)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			</tr>
			<tr>
				<td class="td_warp">EC编号</td>
				<td ><input type = "text" class="warp_cont" value = "<%=ecbh%>" name = "ecbh" id="ecbh" onchange = "checkinput('ecbh','ecbhmage')"/>
					<span id="ecbhmage"><%if("".equals(ecbh)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>
				</td>
				<td class="td_warp">DC编号</td>
				<td ><input type = "text" class="warp_cont" value = "<%=dcbh%>" name = "dcbh" id="dcbh" onchange = "checkinput('dcbh','dcbhmage')"/>
					<span id="dcbhmage"><%if("".equals(dcbh)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>
				</td>
				<td class="td_warp">是否需要新Code</td>
				<td >
					<select name="sjxyx">
		    				<option value=-1></option>   
		    				<%
		    					int sjxyx_int = -1;
							if(sjxyx.length() > 0 ) {
								sjxyx_int = Integer.parseInt(sjxyx);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='sjxyx' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(sjxyx_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">是否需要TP新文件</td> 
				<td >
					<select name="sfxytp">
		    				<option value=-1></option>   
		    				<%
		    					int sfxytp_int = -1;
							if(sfxytp.length() > 0 ) {
								sfxytp_int = Integer.parseInt(sfxytp);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='sfxytp' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(sfxytp_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
			</tr>
			<tr>
				<td class="td_warp">量测</td>
				<td ><!--<input type = "text" class="warp_cont" value = "<%=cl%>" name = "cl"/> --> 
						<input type="checkbox" id="gx" name="gx" value="<%=gx%>" onclick="checkchange('gx')" <%if("1".equals(gx)){%>checked="checked" <%}%>  />	光学 ; &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="gh1" name="gh1" value="<%=gh1%>" onclick="checkchange('gh1')" <%if("1".equals(gh1)){%> checked="checked" <%}%> /> 功耗 ; &nbsp;&nbsp;&nbsp;&nbsp;
						<input type="checkbox" id="tp" name="tp" value="<%=tp%>" onclick="checkchange('tp')"  <%if("1".equals(tp)){%>checked="checked" <%}%> />	TP ;
				</td>
				<td class="td_warp">观察项目</td>
				<td ><!--<input type = "text" class="warp_cont"  value = "<%=gcxm%>" name = "gcxm"/> --> 
					  <input type="checkbox" id="hz" name="hz" value="<%=hz%>" onclick="checkchange('hz')"  <%if("1".equals(hz)){%>checked="checked" <%}%> />	画质 ; &nbsp;&nbsp;&nbsp;&nbsp;
					 <input type="checkbox"  id="wg" name="wg" value="<%=wg%>" onclick="checkchange('wg')"  <%if("1".equals(wg)){%> checked="checked" <%}%> /> 外观 ; 
				</td>
				<td class="td_warp">检查时间</td>
				<td ><!--<input type = "text" class="warp_cont" value = "<%=jcsj%>" name = "jcsj"/> -->
						<input type="checkbox" id="sj1" name="sj1" value="<%=sj1%>" onclick="checkchange('sj1')"  <%if("1".equals(sj1)){%>checked="checked" <%}%> />	24; 
						<input type="checkbox" id="sj2" name="sj2" value="<%=sj2%>" onclick="checkchange('sj2')" <%if("1".equals(sj2)){%> checked="checked" <%}%> /> 120;
						<input type="checkbox" id="sj3" name="sj3" value="<%=sj3%>" onclick="checkchange('sj3')" <%if("1".equals(sj3)){%>checked="checked" <%}%> />	128; 
						<input type="checkbox" id="sj4" name="sj4" value="<%=sj4%>" onclick="checkchange('sj4')" <%if("1".equals(sj4)){%>checked="checked" <%}%> />	240;<br>
						<input type="checkbox" id="qt" name="qt" value="<%=qt%>" onclick="checkchange('qt')" <%if("1".equals(qt)){%>checked="checked" <%}%> />	其他 
						<input type = "text" size="10"  value = "<%=jcsj%>" name = "jcsj"/>
				</td>
				<td class="td_warpMore">申请人联系方式(手机+座机)</td>
				<td ><input type = "text" class="warp_cont" value = "<%=sqrlxfs%>" id="sqrlxfs" name = "sqrlxfs" onchange = "checkinput('sqrlxfs','sqrlxfsmage')"/>
					<span id="sqrlxfsmage"><%if("".equals(sqrlxfs)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			
			</tr>
			<tr>
				<td class="td_warp">变更原因类型</td>
				<td >
					<select name="bgyylb">
		    				<option value=-1></option>   
		    				<%
		    					int bgyylb_int = -1;
							if(bgyylb.length() > 0 ) {
								bgyylb_int = Integer.parseInt(bgyylb);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='bgyylb' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(bgyylb_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">申请单紧急程度</td>
				<td >
					<select name="sqjjcd">
		    				<option value=-1></option>   
		    				<%
		    					int sqjjcd_int = -1;
							if(sqjjcd.length() > 0 ) {
								sqjjcd_int = Integer.parseInt(sqjjcd);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='sqjjcd' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(sqjjcd_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">实验目的</td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=csyy%>" id="csyy" name = "csyy" onchange = "checkinput('csyy','csyymage')"/>
					<span id="csyymage"><%if("".equals(csyy)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span></td>
			
			</tr>
			<tr>
				<td class="td_warpMore">变更前说明</td>
				<td colspan="3"> 
						<% 
								bgqsm = bgqsm.replaceAll("<br>", "\n");
						 %>
							<textarea rows="4" cols="72" id="bgqsm" name="bgqsm" onchange = "checkinput('bgqsm','bgqsmmage')"><%=bgqsm%></textarea>	
							<span id="bgqsmmage"><%if("".equals(bgqsm)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>	
				</td>
				
				<td class="td_warpMore">变更后说明</td>
				<td colspan="3">
						<% 
								bghsm = bghsm.replaceAll("<br>", "\n");
						 %>
					<textarea rows="4" cols="75" id="bghsm" name="bghsm" onchange = "checkinput('bghsm','bghsmmage')"> <%=bghsm%></textarea>	
					<span id="bghsmmage"><%if("".equals(bghsm)){%><img src="/images/BacoError_wev8.gif" align="absMiddle"><%}%></span>	
				
				</td>
			</tr>
			<tr>
				<td class="td_warp">上传新Code</td>
				<td colspan="3">
				<%
									if(!"".equals(scx)){
											String docid="";
											String fileName="";
											String fileId="";
											sql = "select a.docid,b.imagefileid,b.imagefilename from docimagefile a,imagefile b where a.imagefileid=b.imagefileid and a.docid in ("+ scx + ")";
											rs.execute(sql);
											while (rs.next()) {
												docid = Util.null2String(rs.getString("docid"));
												fileName = Util.null2String(rs.getString("imagefilename"));
												fileId = Util.null2String(rs.getString("imagefileid"));
								%>
								 <input type=hidden id="field_del_<%=docid%>" value="0" />
								 <a target="_blank" href="/weaver/weaver.file.FileDownload?fileid=<%=fileId%>&coworkid=-1&requestid=0&desrequestid=0"><%=fileName%></a>&nbsp&nbsp
								  <input type=hidden id="field_id_<%=docid%>" value=<%=docid%>>	
								 <button type="button" class=btnFlow accessKey=1 onclick="onChangeSharetype('<%=docid%>','scx')">
								 <%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></button>
								 <span id="span_id_<%=docid%>" name="span_id_<%=docid%>" style="visibility:hidden">
									<B><FONT COLOR="#FF0033">√</FONT></B>
								</span></br>
								<%			
											}
									}
								%>							
				<div>
									<span> 
										<span id="spanButtonPlaceHolder"></span><!--选取多个文件-->
									</span>
									&nbsp;&nbsp;
									<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload.cancelQueue();" id="btnCancel1">
										<span><img src="/js/swfupload/delete_wev8.gif"  border="0"></span>
										<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--清除所有选择--></span>
									</span>
								</div>
								<div class="fieldset flash" id="fsUploadProgress"></div>
								<div id="divStatus"></div>
								
								<input class=inputstyle style="display:none;" type=file name="accessory1" onchange='accesoryChanage(this)' style="width:100%">
								<span id="shfj_span"></span>
								(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=accsize %>M)
								<button type="button" class=AddDoc style="display:none;" name="addacc" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
								<input type=hidden name=accessory_num value="1">
				</td>
				<td class="td_warp">上传TP新配置文件 </td>
				<td colspan="3">
				<%
									if(!"".equals(scip)){
											String docid="";
											String fileName="";
											String fileId="";
											sql = "select a.docid,b.imagefileid,b.imagefilename from docimagefile a,imagefile b where a.imagefileid=b.imagefileid and a.docid in ("+ scip + ")";
											rs.execute(sql);
											while (rs.next()) {
												docid = Util.null2String(rs.getString("docid"));
												fileName = Util.null2String(rs.getString("imagefilename"));
												fileId = Util.null2String(rs.getString("imagefileid"));
								%>
								 <input type=hidden id="field_del_<%=docid%>" value="0" />
								 <a target="_blank" href="/weaver/weaver.file.FileDownload?fileid=<%=fileId%>&coworkid=-1&requestid=0&desrequestid=0"><%=fileName%></a>&nbsp&nbsp
								  <input type=hidden id="field_id_<%=docid%>" value=<%=docid%>>	
								 <button type="button" class=btnFlow accessKey=1 onclick="onChangeSharetype('<%=docid%>','scip')">
								 <%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></button>
								 <span id="span_id_<%=docid%>" name="span_id_<%=docid%>" style="visibility:hidden">
									<B><FONT COLOR="#FF0033">√</FONT></B>
								</span></br>
								<%			
											}
									}
								%>					
				<div>
									<span> 
										<span id="spanButtonPlaceHolder_scip"></span><!--选取多个文件-->
									</span>
									&nbsp;&nbsp;
									<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload.cancelQueue();" id="btnCancel1_scip">
										<span><img src="/js/swfupload/delete_wev8.gif"  border="0"></span>
										<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--清除所有选择--></span>
									</span>
								</div>
								<div class="fieldset flash" id="fsUploadProgress_scip"></div>
								<div id="divStatus_scip"></div>
								
								<input class=inputstyle style="display:none;" type=file name="accessory1_scip" onchange='accesoryChanage(this)' style="width:100%">
								<span id="shfj_span_scip"></span>
								(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=accsize %>M)
								<button type="button" class=AddDoc style="display:none;" name="addacc_scip" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
								<input type=hidden name=accessory_num_scip value="1">
				</td>
			</tr>
			<tr>
				<td class="td_warp">测试结果 </td>
				<td colspan="3">
					<select name="xsjg">
		    				<option value=-1></option>   
		    				<%
		    					int xsjg_int = -1;
							if(xsjg.length() > 0 ) {
								xsjg_int = Integer.parseInt(xsjg);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='xsjg' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(xsjg_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select> -- 
					<select name="xsjg1">
		    				<option value=-1></option>   
		    				<%
		    					int xsjg1_int = -1;
							if(xsjg1.length() > 0 ) {
								xsjg1_int = Integer.parseInt(xsjg1);
							}
		    					sql = "select selectvalue,selectname from workflow_billfield a, workflow_bill b,workflow_selectitem c where a.billid=b.id and c.fieldid=a.id  and b.tablename='uf_zy' and a.fieldname='xsjg1' and cancel=0 order by listorder asc";
							RecordSet.executeSql(sql);
							while(RecordSet.next()){
								String tmp_name = Util.null2String(RecordSet.getString("selectname"));
								int tmp_val = RecordSet.getInt("selectvalue");
		    				%>
								<option value=<%=tmp_val%>  <%if(xsjg1_int==tmp_val){ %>selected<%} %>><%=tmp_name%></option>
						<%}%>
					</select>
				</td>
				<td class="td_warp">上传附件‘计划’</td>
				<td colspan="3">
				<%
									if(!"".equals(scjh)){
											String docid="";
											String fileName="";
											String fileId="";
											sql = "select a.docid,b.imagefileid,b.imagefilename from docimagefile a,imagefile b where a.imagefileid=b.imagefileid and a.docid in ("+ scjh + ")";
											rs.execute(sql);
											while (rs.next()) {
												docid = Util.null2String(rs.getString("docid"));
												fileName = Util.null2String(rs.getString("imagefilename"));
												fileId = Util.null2String(rs.getString("imagefileid"));
								%>
								 <input type=hidden id="field_del_<%=docid%>" value="0" />
								 <a target="_blank" href="/weaver/weaver.file.FileDownload?fileid=<%=fileId%>&coworkid=-1&requestid=0&desrequestid=0"><%=fileName%></a>&nbsp&nbsp
								  <input type=hidden id="field_id_<%=docid%>" value=<%=docid%>>	
								 <button type="button" class=btnFlow accessKey=1 onclick="onChangeSharetype('<%=docid%>','scjh')">
								 <%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></button>
								 <span id="span_id_<%=docid%>" name="span_id_<%=docid%>" style="visibility:hidden">
									<B><FONT COLOR="#FF0033">√</FONT></B>
								</span></br>
								<%			
											}
									}
								%>					
						<div>
									<span> 
										<span id="spanButtonPlaceHolder_scjh"></span><!--选取多个文件-->
									</span>
									&nbsp;&nbsp;
									<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload.cancelQueue();" id="btnCancel1_scjh">
										<span><img src="/js/swfupload/delete_wev8.gif"  border="0"></span>
										<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--清除所有选择--></span>
									</span>
								</div>
								<div class="fieldset flash" id="fsUploadProgress_scjh"></div>
								<div id="divStatus_scjh"></div>
								
								<input class=inputstyle style="display:none;" type=file name="accessory1_scjh" onchange='accesoryChanage(this)' style="width:100%">
								<span id="shfj_span_scjh"></span>
								(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=accsize %>M)
								<button type="button" class=AddDoc style="display:none;" name="addacc_scjh" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
								<input type=hidden name=accessory_num_scjh value="1">
				</td>
			</tr>
			<tr>
				<td class="td_warp">操作人</td>
				<td colspan="3">
					<brow:browser viewType="0"  name="czr" browserValue="<%=czr %>"
						browserOnClick=""
						browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?selectedids="
						hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
						completeUrl="/data.jsp" width="165px"
						browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(czr),user.getLanguage())%>">
					</brow:browser>
				</td>
				<td class="td_warp">操作说明 </td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=czsm%>" name = "czsm"/></td>
			</tr>
			<tr>
				<td class="td_warp">RA测试报告</td>
				<td colspan="3">
				<%
									if(!"".equals(csbg)){
											String docid="";
											String fileName="";
											String fileId="";
											sql = "select a.docid,b.imagefileid,b.imagefilename from docimagefile a,imagefile b where a.imagefileid=b.imagefileid and a.docid in ("+ csbg + ")";
											rs.execute(sql);
											while (rs.next()) {
												docid = Util.null2String(rs.getString("docid"));
												fileName = Util.null2String(rs.getString("imagefilename"));
												fileId = Util.null2String(rs.getString("imagefileid"));
								%>
								 <input type=hidden id="field_del_<%=docid%>" value="0" />
								 <a target="_blank" href="/weaver/weaver.file.FileDownload?fileid=<%=fileId%>&coworkid=-1&requestid=0&desrequestid=0"><%=fileName%></a>&nbsp&nbsp
								  <input type=hidden id="field_id_<%=docid%>" value=<%=docid%>>	
								 <button type="button" class=btnFlow accessKey=1 onclick="onChangeSharetype('<%=docid%>','csbg')">
								 <%=SystemEnv.getHtmlLabelName(91,user.getLanguage())%></button>
								 <span id="span_id_<%=docid%>" name="span_id_<%=docid%>" style="visibility:hidden">
									<B><FONT COLOR="#FF0033">√</FONT></B>
								</span></br>
								<%			
											}
									}
								%>					
						<div>
									<span> 
										<span id="spanButtonPlaceHolder_csbg"></span><!--选取多个文件-->
									</span>
									&nbsp;&nbsp;
									<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload.cancelQueue();" id="btnCancel1_csbg">
										<span><img src="/js/swfupload/delete_wev8.gif"  border="0"></span>
										<span style="height:19px"><font style="margin:0 0 0 -1"><%=SystemEnv.getHtmlLabelName(21407,user.getLanguage())%></font><!--清除所有选择--></span>
									</span>
								</div>
								<div class="fieldset flash" id="fsUploadProgress_csbg"></div>
								<div id="divStatus_csbg"></div>
								
								<input class=inputstyle style="display:none;" type=file name="accessory1_csbg" onchange='accesoryChanage(this)' style="width:100%">
								<span id="shfj_span_csbg"></span>
								(<%=SystemEnv.getHtmlLabelName(18642,user.getLanguage())%>:<%=accsize %>M)
								<button type="button" class=AddDoc style="display:none;" name="addacc_csbg" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
								<input type=hidden name=accessory_num_csbg value="1">
				</td>
				<td class="td_warp">样品取走时间</td>
				<td colspan="3"><input type = "text" class="warp_cont" value = "<%=yaqzsj%>" name = "yaqzsj"/></td>
			</tr>
		</tbody>
	</table>
	</form>
	<br><hr><br>
	<div id="tableChlddivx">
		<table align="center" width = "95%">
			<colgroup><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
						<col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/><col width="7%"/>
			</colgroup>
			<tbody>
			<tr><td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td>  <td > &nbsp;</td> <td > &nbsp;</td> 
				<td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td> <td > &nbsp;</td>  <td > &nbsp;</td> <td > &nbsp;</td> 
			<!--  系统开始记录表里信息    一个内容占据四行,   一行即一个TR占用 3个值内容   -->
			 <%
				sql  = "select id,(select syxm  from uf_syxm u where u.id=f.syxm) as syxm1 "
					+" ,(select COUNT(1) from uf_ycjm_dt1 where mainid=f.id and zt=1) as fnum "
					+" from uf_ycjm f where lcmxid in(select lcmxid from uf_zy_dt9 where mainid=" + id + ") order by id ";
				RecordSet.executeSql(sql);	
				int lineFlag = 0;
				while(RecordSet.next()){
					String t_id = Util.null2String(RecordSet.getString("id"));  		// 唯一标示
					String t_syxm = Util.null2String(RecordSet.getString("syxm1"));  // 实验目的
					
					int fnum = RecordSet.getInt("fnum");  // 是否有异常
										
					if(lineFlag%14 == 0){
						out.println("</tr><tr height=\"58px\">");
					}
					
					if(fnum > 0){
						out.println("	<td> <div class= \"bg1\"  onclick=\"Foo("+t_id+");\">");
					}else{
						out.println("	<td> <div class= \"bg\"  onclick=\"Foo("+t_id+");\">");
					}
					// 增加显示名和连接
					out.println(t_syxm + " : " + t_id);
					// 增加删除按钮
					out.println("  </div>&nbsp;<img src=\"/images/delete_wev8.gif\" height=\"20px\" onmouseover=\"this.style.border='1px solid #009933'\" onmouseout=\"this.style.border='none'\"    onclick=\"delitem(" + t_id + ")\">  ");
					// 增加隐藏字段	
					out.println("<input type=\"hidden\" name=\"uq_" + t_id + "\" value=\"" + t_id + "\" > ");
					out.println("	</td>");

					lineFlag++;
				}
			%>
		</tr>
	</tbody></table>
	</div>
	<br><br>
	<div width="500px"> 
		<select name="syxm_dt" id="syxm_dt" style="font-size:60px; ">
			<option value=-1></option>   
		<%
			sql  = "select id,syxm from uf_syxm";
			RecordSet.executeSql(sql);
			while(RecordSet.next()){
				String tmp_id =Util.null2String(RecordSet.getString("id")); 
				String tmp_syxm =Util.null2String(RecordSet.getString("syxm")); 
				out.println("<option value=\""+ tmp_id +"\">" + tmp_syxm + "</option>");
			}
		%>
		</select>
		&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		<input type="button" value="插入实验项目" id="zd_btn_submit" class="btnSummbit" onclick="submitData()">
	</div> 
	
	<br><br>
	
		<input type="button" value="提交" id="zd_btn_save" class="btnSummbit" onclick="savaDataBt()">

		<br><br><br>
		</div>
	
</BODY>
</HTML>
