<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="hsproject.dao.*" %>
<%@ page import="hsproject.bean.*" %>
<%@ page import="hsproject.util.*" %>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<%@page import="weaver.cpt.util.html.HtmlElement"%>
<%@page import="java.util.Map.Entry"%>
<%@page import="org.json.JSONObject"%>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>

<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="PrjSettingsComInfo" class="weaver.proj.util.PrjSettingsComInfo" scope="page"/>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="AccountType" class="weaver.general.AccountType" scope="page" />
<jsp:useBean id="LicenseCheckLogin" class="weaver.login.LicenseCheckLogin" scope="page" />
<HTML>
	<HEAD>
		<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
		<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
		<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/lib/jquery.bgiframe.min_wev8.js'></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/jquery.autocomplete_wev8.js'></script>
		<script type='text/javascript' src='/js/jquery-autocomplete/browser_wev8.js'></script>
		<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/jquery.autocomplete_wev8.css" />
		<link rel="stylesheet" type="text/css" href="/js/jquery-autocomplete/browser_wev8.css" />
		<SCRIPT language="JavaScript" src="/js/weaver_wev8.js"></SCRIPT>
		<link rel="stylesheet" href="/css/ecology8/request/requestTopMenu_wev8.css" type="text/css" />
		<link rel="stylesheet" href="/wui/theme/ecology8/jquery/js/zDialog_e8_wev8.css" type="text/css" />
		<link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/js/swfupload/swfupload_wev8.js"></script>
		<script type="text/javascript" src="/js/swfupload/swfupload.queue_wev8.js"></script>
		<script type="text/javascript" src="/js/swfupload/fileprogress_wev8.js"></script>
		<script type="text/javascript" src="/js/swfupload/handlers_wev8.js"></script>
		<link href="/js/swfupload/default_wev8.css" rel="stylesheet" type="text/css" />
		<script type="text/javascript" src="/js/swfupload/swfupload_wev8.js"></script>
		<script type="text/javascript" src="/js/swfupload/swfupload.queue_wev8.js"></script>
		<script type="text/javascript" src="/js/swfupload/fileprogressBywf_wev8.js"></script>
		<script type="text/javascript" src="/js/swfupload/handlersBywf_wev8.js"></script>
		<style>
		.checkbox {
			display: none
		}
		</style>
	</head>
	<%
	int language =user.getLanguage();
	Calendar now = Calendar.getInstance();
	
	int userid = user.getUID();
	String imagefilename = "/images/hdReport_wev8.gif";
	String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
	String needfav ="1";
	String needhelp ="";
	boolean flagaccount = weaver.general.GCONST.getMOREACCOUNTLANDING();
	String prjtype = Util.null2String(request.getParameter("prjtype"));
	ProjectGroupDao pgd = new ProjectGroupDao();
	ValueTransMethod vtm = new ValueTransMethod();
	List<ProjectGroupBean> pgblist = pgd.getGroupData();
	EditTransMethod etm = new EditTransMethod();
	%>
	<BODY>
		<div id="tabDiv">
			<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
		</div>
		<div id="dialog">
			<div id='colShow'></div>
		</div>
		<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
		<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
		<%
		RCMenu += "{刷新,javascript:refersh(),_self} " ;
		//RCMenu += "{导出,javascript:_xtable_getAllExcel(),_self} " ;
		RCMenuHeight += RCMenuHeightStep ;
		%>
		<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>
		<FORM id=report name=report action="/hsproject/project/list/hs-add-project.jsp" method=post enctype="multipart/form-data">
			<input type="hidden" name="requestid" value="">
			<input type="hidden" name="prjtype" id="prjtype" value="<%=prjtype%>">
			<table id="topTitle" cellpadding="0" cellspacing="0">
				<tr>
					<td></td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span title="<%=SystemEnv.getHtmlLabelName(23036,user.getLanguage())%>" class="cornerMenu"></span>
				</tr>
			</table>
			<%
//int fieldcount=0;//用来定位字段
//int fieldsize=0;//用来定位字段数量
int groupcount=0;//用来定位组
%>
			<!-- 系统布局组件 wea:layout wea:group wea:item -->   
			<wea:layout type="2col">
			<wea:group context="项目">
			<wea:item>多人力资源必填</wea:item>
			<wea:item>
			 <brow:browser name='hrmids02'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp?type=17'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#'>
                </brow:browser>
			</wea:item>	
			<wea:item>多人力资源可编辑</wea:item>
			<wea:item>
			 <brow:browser name='hrmids02'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp?type=17'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#'>
                </brow:browser>
			</wea:item>
			<wea:item>单人力资源必填</wea:item>
			<wea:item>
				<brow:browser name='manager'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?resourceid=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>单人力资源可编辑</wea:item>
			<wea:item>
				<brow:browser name='manager'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/hrm/resource/HrmResource.jsp?id=' 
				completeUrl='/data.jsp'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp?resourceid=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>文档必填</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			<wea:item>文档编辑</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>文档只读</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='0'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>多文档必填</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>	
			<wea:item>多文档编辑</wea:item>
			<wea:item>
				<brow:browser name='envaluedoc'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true'
				linkUrl='/docs/docs/DocDsp.jsp?isrequest=1&id=' 
				completeUrl='/data.jsp?type=9'
				width='80%'
				isSingle='true'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/docs/docs/MutiDocBrowser.jsp?isworkflow=1?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			<wea:item>多部门必填</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/MutiDepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>

			<wea:item>多部门编辑</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/MutiDepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/MutiDepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			
			<wea:item>部门必填</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/DepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>

			<wea:item>部门编辑</wea:item>
			<wea:item>
			<brow:browser name='department'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='/hrm/company/DepartmentBrowser.jsp?id=' 
				completeUrl='/data.jsp?type=4'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp?resourceids=#id#'>
				</brow:browser>
			</wea:item>
			<wea:item>多分部编辑</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>多分部必填</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser3.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>分部编辑</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='1'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>分部必填</wea:item>
			<wea:item> 
			<brow:browser name='subcompany1'
				viewType='0'
				browserValue=''
				isMustInput='2'
				browserSpanValue=""
				hasInput='true' 
				linkUrl='' 
				completeUrl='/data.jsp?type=164'
				width='80%'
				isSingle='false'
				hasAdd='false'
				browserUrl='/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp?resourceids=#id#'>
				</brow:browser>
            </wea:item>
			<wea:item>日期必填</wea:item>

			<wea:item>
			<button type="button" class="Calendar" onclick="onShowBeginDate(txtBeginDate_1,spanBeginDate_1,txtEndDate_1,spanEndDate_1,txtBeginTime_1,spanBeginTime_1,txtEndTime_1,spanEndTime_1,txtWorkLong_1)"></button>
			<span id="spanBeginDate_1"></span>
			<input type="hidden" name="txtBeginDate" id="txtBeginDate_1" value=""> 
			<button type="button" class="Clock" onclick="onShowBeginTime(txtBeginDate_1,spanBeginDate_1,txtEndDate_1,spanEndDate_1,txtBeginTime_1,spanBeginTime_1,txtEndTime_1,spanEndTime_1,txtWorkLong_1)"></button>
			<span id="spanBeginTime_1"></span>
			<input type="hidden" name="txtBeginTime" id="txtBeginTime_1" value=""></td>
			</wea:item>
			<script language=javascript>

			function checkDateValidity(begindate,begintime,enddate,endtime,errormsg){
				var isValid = true;
				if(compareDate(begindate,begintime,enddate,endtime) == 1){
					Dialog.alert(errormsg);
					isValid = false;
				}
				return isValid;
			}


			/*Check Date */
			function compareDate(date1,time1,date2,time2){

				var ss1 = date1.split("-",3);
				var ss2 = date2.split("-",3);

				date1 = ss1[1]+"-"+ss1[2]+"-"+ss1[0] + " " +time1;
				date2 = ss2[1]+"-"+ss2[2]+"-"+ss2[0] + " " +time2;

				var t1,t2;
				t1 = Date.parse(date1);
				t2 = Date.parse(date2);
				if(t1==t2) return 0;
				if(t1>t2) return 1;
				if(t1<t2) return -1;

				return 0;
			}



			function ItemCount_KeyPress_Plus()
			{
				if(!(window.event.keyCode >= 48 && window.event.keyCode <= 57))
				{
					window.event.keyCode = 0;
				}
			}
			</script>
			
	
	<wea:item><%=SystemEnv.getHtmlLabelName(22194,user.getLanguage())%></wea:item>
	<wea:item>
			<script type="text/javascript">
				var oUpload;
				window.onload = function() {
				  var settings = {
						flash_url : "/js/swfupload/swfupload.swf",
						upload_url: "/proj/data/uploadPrjAcc.jsp",	// Relative to the SWF file
						post_params: {"method" : "uploadPrjAcc","secid":"123"},
						file_size_limit : "20 MB",
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
							jQuery("#accdocids").val(jQuery("#accdocids").val()+","+a);
						}
					}
				}
		
				function uploadComplete(fileObj) {
					try {
						/*  I want the next upload to continue automatically so I'll call startUpload here */
						if (this.getStats().files_queued === 0) {
							frmain.submit();
							document.getElementById(this.customSettings.cancelButtonId).disabled = true;
						} else {	
							this.startUpload();
						}
					} catch (ex) { this.debug(ex); }
		
				}
			</script>
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
		    <button type="button" class="AddDoc" style="display:none;" name="addacc" onclick="addannexRow()">添加</button>
		    <input type="hidden" name="accessory_num" value="1">
		</wea:item>
	</wea:group>
	</wea:layout>
	
</FORM>
	<script type="text/javascript">
		 function onBtnSearchClick() {
			report.submit();
		}
		function refersh() {
  			window.location.reload();
  		}
   </script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/selectDateTime_wev8.js"></script>
	<SCRIPT language="javascript" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	
</BODY>
</HTML>