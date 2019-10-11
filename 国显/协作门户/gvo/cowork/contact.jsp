<%@page import="weaver.general.TimeUtil"%>
<%@ page import="weaver.general.Util" %>
<%@ page import="weaver.conn.*" %>
<%@ page import="java.util.Date"%>
<%@ page import="gvo.cowork.PortalTransUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" %> 
<%@ include file="/systeminfo/init_wev8.jsp" %>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="rs_dt" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="CoworkService" class="weaver.cowork.CoworkService" scope="page" />
<jsp:useBean id="DocSearchManage" class="weaver.docs.search.DocSearchManage" scope="page" />
<jsp:useBean id="sharemanager" class="weaver.share.ShareManager" scope="page" />
<html>
<%
int userid=user.getUID();
PortalTransUtil ptu = new PortalTransUtil();
String sql = "select name from nickname where userid = "+userid;
String sql_dt = "";
rs.executeQuery(sql);
boolean hasnickname = false;
if(rs.getCounts()>0){
 hasnickname = true;
}

if(!hasnickname) {
  response.sendRedirect("/cowork/nickname/coworknicknameview.jsp?loca=99") ;
   return ;
}
String accsize ="8";
String accsec="14024";//目录测14024 正5801
String attach="";



%>
<head>
	<title>联系我们</title>
	<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />
	<link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
<script type="text/javascript" src="/js/swfupload/swfupload_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/swfupload.queue_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/fileprogress_wev8.js"></script>
<script type="text/javascript" src="/js/swfupload/handlers_wev8.js"></script>
</head>
<style type="text/css">
	*{
		padding:0px;
		margin:0px;
		font-family: "微软雅黑";
	}
	html,body{
		width:100%;
		height:100%;
	}
	.contact{
		height:100%;	
	}
	.head{
		height:70px;
		line-height: 70px;
		font-size: 20px;
		border-bottom: 1px solid #ebedf0;
		padding-left: 50px;
	}
	.contact_info{
		border-bottom: 1px solid #ebedf0;
		padding-bottom: 10px;
		margin-top:20px;
		padding-bottom: 20px;
	}
	.contact_info div{
		margin-top:10px;
		padding-left: 50px;
	}
	.contact_text_tips{
		padding-left: 50px;
		font-size: 18px;
		margin-top:20px;
	}
	.operation{
		position:relative;
		margin-top:10px;
	}
	.submit{
		position:absolute;
		top:0px;
		right:50px;
		margin-left: 50px;
		width:40px;
		text-align:center; 
		height:25px;
		line-height: 25px;
		background-color:rgb(5,80,246);
		color:rgb(255,255,255);
		cursor: pointer;
	}
	.type{
		position: absolute;
		top:0px;
		left:50px;
		margin-right: 50px;
	}
	.info{
		margin-top:20px;
		margin-left: 50px;
		margin-right: 50px;
		height:200px;
	}
	.info textarea{
		width:100%;
		height:100%;
		text-indent: 2px;
	}
	#info{
		resize:none
	}
	.progressContainer {
	margin: 5px;
	padding: 4px;
	border: solid 1px #E8E8E8;
	background-color: #F7F7F7;
	overflow: hidden;
	margin-left: 50px;
}
</style>
<script type="text/javascript">
			var oUpload;
				
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
						
						button_image_url : "",	// Relative to the SWF file
						button_placeholder_id : "spanButtonPlaceHolder",
		
						button_width: 100,
						button_height: 18,
						button_text : '<span class="button" style="background:url(\"/gvo/cowork/img/sc.png\")"></span>',
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

					
					
					try{
						oUpload = new SWFUpload(settings);
						jQuery("#spanButtonPlaceHolder").html("<span><img src=\"/gvo/cowork/img/sc.png\"  border=\"0\"></span>");
						jQuery("#spanButtonPlaceHolder").css({"background":"","bottom":"","padding-left":"","cursor":"","position":"","z-index":""})
						//jQuery("#spanButtonPlaceHolder").css({"background-color":"rgb(5,80,246)","padding-left":""})
					} catch(e){alert(e)}
				}
		
				function fileDialogComplete_1(){
					document.getElementById("btnCancel1").disabled = false;
					fileDialogComplete
				}
				function uploadSuccess(fileObj,serverdata){
					var data=eval(serverdata);
					//alert(data);
					if(data){
						var a=data;
						if(a>0){
							if(jQuery("#attach").val() == ""){

								jQuery("#attach").val(a);
							}else{
							
								jQuery("#attach").val(jQuery("#attach").val()+","+a);
								
							}
						}
					}
				}
		
				function uploadComplete(fileObj) {
					try {
						/*  I want the next upload to continue automatically so I'll call startUpload here */
						if (this.getStats().files_queued === 0) {
							
							report.submit();
							document.getElementById(this.customSettings.cancelButtonId).disabled = true;
						} else {	
							this.startUpload();
						}
					} catch (ex) { this.debug(ex); }
		
				}
			</script>
<body>
	<div class= "contact">
		<div class = "head">联系我们</div>
		<div class = "content">
			<div class = "contact_info">
				<div>您有任何方式通以下方式联系我们</div>
				<div>
					电子邮件：
					970026874@qq.com
				</div>
				<div>
					联系方式：12345678990
				</div>
			</div>
			<div class = "contact_text">
				<FORM id=report name=report action="/gvo/cowork/submit-contact.jsp" method=post enctype="multipart/form-data">
	<input type="hidden" name="attach" id="attach" value="<%=attach %>">
					<div class = "operation">
						<div class = "contact_text_tips">欢迎留言</div>
						<div class = "submit">提交</div>	
					</div>	
					<div style="clear: both"></div>
					<div class = "info">
						<textarea placeholder="请输入留言内容" name="info" id = "info"></textarea>
					</div>
					<div style="margin-left: 50px;margin-top: 20px">
									<span> 
										<span id="spanButtonPlaceHolder">
										
										</span><!--选取多个文件-->
									</span>
									&nbsp;&nbsp;
									<span style="color:#262626;cursor:hand;TEXT-DECORATION:none" disabled onclick="oUpload.cancelQueue();" id="btnCancel1">
										<span><img src="/gvo/cowork/img/qc.png"  border="0"></span>
										<span style="height:19px"><font style="margin:0 0 0 -1"></font><!--清除所有选择--></span>
									</span>
								</div>
								<div class="fieldset flash" id="fsUploadProgress"></div>
								<div id="divStatus"></div>
								
								<input class=inputstyle style="display:none;" type=file name="accessory1" onchange='accesoryChanage(this)' style="width:100%">
								<span id="shfj_span"></span>
					
								<button type="button" class=AddDoc style="display:none;" name="addacc" onclick="addannexRow()"><%=SystemEnv.getHtmlLabelName(611,user.getLanguage())%></button>
								<input type=hidden name=accessory_num value="1">
					
					</div>
				</form> 
			</div>
		</div>
	</div>
</body>
<script type="text/javascript">
	jQuery(document).ready(function(){
		
		var flag ="0"
		//sunmit 点击事件
		jQuery(".submit").click(function(){
			var info = jQuery("#info").val();
			if(flag !="0"){
				alert("请勿重复提交");
				return;
			}else{
				flag = "1";
			}
			if(!oUpload){
					report.submit();
			}else{
				try {
					if(oUpload.getStats().files_queued === 0){
								report.submit();
					}else {
						oUpload.startUpload();
					}
				} catch (e) {
				
				}
			}
		
		})
		
	});
	function bindcount(){
		alert("1234");
		//jQuery("#spanButtonPlaceHolder").text("");
		//jQuery("#spanButtonPlaceHolder").css("background","url(\"/gvo/cowork/img/sc.png\") left top no-repeat")
	}
</script>
</html>
