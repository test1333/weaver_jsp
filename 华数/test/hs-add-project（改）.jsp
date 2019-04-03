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
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />

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
			<table id="body" cellpadding="0" cellspacing="0">
			<!-- 系统布局组件 wea:layout wea:group wea:item -->   
			<%//多人力资源按钮 1、必填，2、编辑%>	
			<tr style="height:1px!important;display:;" class="Spacing">
				<td class="paddingLeft18" colspan="2">
					<div class="intervalDivClass">
				</div></td>
			</tr>	
			<tr class="" _trrandom="98235874">
				<td style="display:" id="" name="" _samepair="" class="fieldName" colspan="">
					项目成员
				</td>
				<td style="display:" id="" name="" _samepair="" class="field" colspan="">
		
				<span class="browser" id="hrmids02_span"><div class="e8_os" style="width:80%;">

				<div class="e8_innerShow e8_innerShow_button e8_innerShow_button_right30" style="max-height:66px;"><span class="e8_spanFloat"><span class="e8_browserSpan"><button class="e8_browflow" type="button" id="hrmids02_browserbtn" onclick="__browserNamespace__.showModalDialogForBrowser(event,'/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#','/hrm/resource/HrmResource.jsp?id=','hrmids02',false,2,'',{name:'hrmids02',hasInput:true,zDialog:true,needHidden:true,dialogTitle:''});"></button></span></span></div>
				<div class="e8_innerShow e8_innerShowMust" style="max-height:66px;"><span name="hrmids02spanimg" class="e8_spanFloat" id="hrmids02spanimg">
				<img align="absmiddle" src="/images/BacoError_wev8.gif"></span></div><div class="e8_outScroll" id="outhrmids02div" style="width: 100%; margin-right: -30px; overflow-y: hidden; outline: none;" tabindex="5003"><div class="e8_innerShow e8_innerShowContent" id="innerContenthrmids02div" style="max-height: 66px; margin-right: 30px; overflow-y: hidden; outline: none;" tabindex="5004"><div style="margin-left:31px;" id="innerhrmids02div" hasadd="false" hasbrowser="true"><input type="hidden" value="" issingle="false" ismustinput="2" viewtype="0" onpropertychange="" temptitle="" name="hrmids02" id="hrmids02"><span style="float:none;" name="hrmids02span" id="hrmids02span"></span>
				<input onblur="__browserNamespace__.setAutocompleteOff(this);" type="text" value="" issingle="false" class="e8_browserInputMore ac_input" name="hrmids02__" id="hrmids02__" onkeydown="__browserNamespace__.delByBS(event,'hrmids02__',2,true,{browserBoxId:'hrmids02_span'});" onpropertychange="" autocomplete="off" style="width: 17px;"></div></div><div id="ascrail2004" style="width: 8px; z-index: 10003; position: absolute; top: 323px; left: 202px; height: 22px; display: none; opacity: 0;"><div style="position: relative; top: 0px; float: right; width: 8px; height: 0px; background-color: rgb(153, 153, 153); border: none; background-clip: padding-box; border-radius: 5px;"></div></div></div></div></span><script type="text/javascript">$('#hrmids02_span').e8Browser({name:'hrmids02',viewType:'0',browserValue:'',isMustInput:'2',browserSpanValue:'',hasInput:'true',linkUrl:'/hrm/resource/HrmResource.jsp?id=',completeUrl:'/data.jsp?type=17',browserUrl:'/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids=#id#',width:'80%',hasAdd:false,isSingle:false});</script>
				</td>		
			</tr>
			<%//人力资源按钮 1、必填，2、编辑%>			
			<tr style="height:1px!important;display:;" class="Spacing">
				<td class="paddingLeft18" colspan="2">
					<div class="intervalDivClass">
				</div></td>
			</tr>
			<tr class="" _trrandom="82772524">
				<!-- 琛屽厓绱犲畾涔夊尯 -->
				<td style="display:" id="" name="" _samepair="" class="fieldName" colspan="">
					经理
				</td>
				<td style="display:" id="" name="" _samepair="" class="field" colspan="">

			<div class="e8_os">

				<div class="e8_innerShow e8_innerShow_button e8_innerShow_button_right30" style="max-height:2200px;">
				<span class="e8_spanFloat">
				<span class="e8_browserSpan ">
				<button class="e8_browflow" id="manager_browserbtn" type="button" onclick="__browserNamespace__.showModalDialogForBrowser(event,'/systeminfo/BrowserMain.jsp?url=/hrm/resource/ResourceBrowser.jsp','#','manager',true,2,'',{name:'manager',hasInput:true,zDialog:true,needHidden:true,dialogTitle:'',arguments:'',_callback:getPassnoworktime});"></button>
				</span>
				</span>
				</div>
				<div class="e8_innerShow e8_innerShowMust">
				<span name="managerspanimg" class="e8_spanFloat" id="managerspanimg">
				<img align="absmiddle" src="/images/BacoError_wev8.gif">
				</span>
				</div>
				<div class="e8_outScroll" id="outmanagerdiv" style="width:100%;margin-right:-30px;">
				<div class="e8_innerShow e8_innerShowContent" style="max-height: 2200px; margin-right: 30px; overflow-y: hidden; outline: none;" id="innerContentmanagerdiv" tabindex="5001">
				<div style="margin-left:31px;" id="innermanagerdiv" hasadd="false" hasbrowser="true">
				<input type="hidden" value="" issingle="true" ismustinput="2" viewtype="0" onpropertychange="" temptitle="" name="manager" id="manager">
				<span style="float:none;" name="managerspan" id="managerspan"></span>
				<input onblur="__browserNamespace__.setAutocompleteOff(this)" type="text" value="" issingle="true" class="e8_browserInput ac_input" name="manager__" id="manager__" onpropertychange="" onkeydown="__browserNamespace__.delByBS(event,'manager__',2,true,{});" autocomplete="off" style="width: 17px; display: none;">
				</div>
				</div>
				</div>
			</div>
				<script type="text/javascript">
				window.setTimeout(function(){
					var isSingle=true;

				var browserBoxId='';

				var browserBox = null;

				if(browserBoxId){

				browserBox=jQuery('#'+browserBoxId);

				}

				if(!browserBox||browserBox.length()==0){

				browserBox=jQuery('#managerspan').closest('div.e8_os');

				}

				var _this = browserBox;

				if(isSingle=="false"||isSingle==false){
					browserBox.hover(function(){

				if(!_this.data("_perfect")){

				_this.find("#outmanagerdiv").perfectScrollbar();_this.data("_perfect",true);

				}

				},function(){});

				};

				browserBox.hover(function(){

				if(!_this.data("_autocomplete")){

				__browserNamespace__.hoverShowNameSpan(_this.find("span.e8_showNameClass"));__browserNamespace__.e8autocomplete({nameAndId:'manager',inputNameAndId:'manager__',isMustInput:2,hasAdd:false,completeUrl:"/data.jsp",isSingle:true,extraParams:{"_exclude":"getNameAndIdVal"},row_height:22,linkUrl:"#",needHidden:true,sb:{},_callback:'getPassnoworktime',_callbackParams:'',type:'',browserBox:''});

				__browserNamespace__.e8formatInitData({nameAndId:'manager',name:'manager',isMustInput:2,hasInput:true,browserBox:''});

				_this.data("_autocomplete",true);

				}

				},function(){});},500);</script>	
				</td>					
			</tr>
			
			
			
			<%//自定义浏览按钮 1、必填，2、编辑%>
			<tr style="height:1px!important;display:;" class="Spacing">
				<td class="paddingLeft18" colspan="2">
					<div class="intervalDivClass">
				</div></td>
			</tr>
			<tr class="" _trrandom="76853241">
				<!-- 琛屽厓绱犲畾涔夊尯 -->
				<td style="display:" id="" name="" _samepair="" class="fieldName" colspan="">
					上级项目
				</td>
				<td style="display:" id="" name="" _samepair="" class="field" colspan="">

				<span class="browser" id="parentid_span"><div class="e8_os" style="width:80%;">

				<div class="e8_innerShow e8_innerShow_button" style="max-height:2200px;"><span class="e8_spanFloat"><span class="e8_browserSpan"><button class="e8_browflow" type="button" id="parentid_browserbtn" onclick="__browserNamespace__.showModalDialogForBrowser(event,'/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp?resourceids=#id#','/proj/data/ViewProject.jsp?isrequest=1&amp;ProjID=','parentid',true,1,'',{name:'parentid',hasInput:true,zDialog:true,needHidden:true,dialogTitle:''});"></button></span></span></div>
				<div class="e8_innerShow e8_innerShowMust"><span name="parentidspanimg" class="e8_spanFloat" id="parentidspanimg"></span></div><div class="e8_outScroll" id="outparentiddiv" style="width:100%;margin-right:-30px;"><div class="e8_innerShow e8_innerShowContent" id="innerContentparentiddiv" style="max-height: 2200px; margin-right: 30px; overflow-y: hidden; outline: none;" tabindex="5002"><div style="margin-left:31px;" id="innerparentiddiv" hasadd="false" hasbrowser="true"><input type="hidden" value="" issingle="true" ismustinput="1" viewtype="0" onpropertychange="" temptitle="" name="parentid" id="parentid"><span style="float:none;" name="parentidspan" id="parentidspan"></span>
				<input onblur="__browserNamespace__.setAutocompleteOff(this);" type="text" value="" issingle="true" class="e8_browserInput ac_input" name="parentid__" id="parentid__" onkeydown="__browserNamespace__.delByBS(event,'parentid__',1,true,{browserBoxId:'parentid_span'});" onpropertychange="" autocomplete="off" style="width: 17px;"></div></div></div></div></span><script type="text/javascript">$('#parentid_span').e8Browser({name:'parentid',viewType:'0',browserValue:'',isMustInput:'1',browserSpanValue:'',hasInput:'true',linkUrl:'/proj/data/ViewProject.jsp?isrequest=1&ProjID=',completeUrl:'/data.jsp?type=8',browserUrl:'/systeminfo/BrowserMain.jsp?url=/proj/data/ProjectBrowser.jsp?resourceids=#id#',width:'80%',hasAdd:false,isSingle:true});</script>
				</td>		
			</tr>
			<%//文档 1、必填，2、编辑%>
			<tr style="height:1px!important;display:;" class="Spacing">
				<td class="paddingLeft18" colspan="2">
					<div class="intervalDivClass">
				</div></td>
			</tr>
			<tr class="" _trrandom="67826332">
				<!-- 琛屽厓绱犲畾涔夊尯 -->
				<td style="display:" id="" name="" _samepair="" class="fieldName" colspan="">
					评价书
				</td>
				<td style="display:" id="" name="" _samepair="" class="field" colspan="">

				<span class="browser" id="envaluedoc_span"><div class="e8_os" style="width:80%;">

				<div class="e8_innerShow e8_innerShow_button" style="max-height:2200px;"><span class="e8_spanFloat"><span class="e8_browserSpan"><button class="e8_browflow" type="button" id="envaluedoc_browserbtn" onclick="__browserNamespace__.showModalDialogForBrowser(event,'/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#','/docs/docs/DocDsp.jsp?isrequest=1&amp;id=','envaluedoc',true,1,'',{name:'envaluedoc',hasInput:true,zDialog:true,needHidden:true,dialogTitle:''});"></button></span></span></div>
				<div class="e8_innerShow e8_innerShowMust"><span name="envaluedocspanimg" class="e8_spanFloat" id="envaluedocspanimg"></span></div><div class="e8_outScroll" id="outenvaluedocdiv" style="width:100%;margin-right:-30px;"><div class="e8_innerShow e8_innerShowContent" id="innerContentenvaluedocdiv" style="max-height: 2200px; margin-right: 30px; overflow-y: hidden; outline: none;" tabindex="5007"><div style="margin-left:31px;" id="innerenvaluedocdiv" hasadd="false" hasbrowser="true"><input type="hidden" value="" issingle="true" ismustinput="1" viewtype="0" onpropertychange="" temptitle="" name="envaluedoc" id="envaluedoc"><span style="float:none;" name="envaluedocspan" id="envaluedocspan"></span>
				<input onblur="__browserNamespace__.setAutocompleteOff(this);" type="text" value="" issingle="true" class="e8_browserInput ac_input" name="envaluedoc__" id="envaluedoc__" onkeydown="__browserNamespace__.delByBS(event,'envaluedoc__',1,true,{browserBoxId:'envaluedoc_span'});" onpropertychange="" autocomplete="off" style="width: 17px;"></div></div></div></div></span><script type="text/javascript">$('#envaluedoc_span').e8Browser({name:'envaluedoc',viewType:'0',browserValue:'',isMustInput:'1',browserSpanValue:'',hasInput:'true',linkUrl:'/docs/docs/DocDsp.jsp?isrequest=1&id=',completeUrl:'/data.jsp?type=9',browserUrl:'/systeminfo/BrowserMain.jsp?url=/docs/docs/DocBrowser.jsp?isworkflow=1?resourceids=#id#',width:'80%',hasAdd:false,isSingle:true});</script>

				</td>
			</tr>
			<%//时间 1、必填，2、编辑%>
			<tr>
			<td>
			<button type="button" class="Calendar" onclick="onShowBeginDate(txtBeginDate_1,spanBeginDate_1,txtEndDate_1,spanEndDate_1,txtBeginTime_1,spanBeginTime_1,txtEndTime_1,spanEndTime_1,txtWorkLong_1)"></button>
				<div class="e8_innerShow e8_innerShowMust">
				<span name="managerspanimg" class="e8_spanFloat" id="managerspanimg">
				<img align="absmiddle" src="/images/BacoError_wev8.gif">
				</span>
			</div>
			<span id="spanBeginDate_1"></span>
			<input type="hidden" name="txtBeginDate" id="txtBeginDate_1" value=""> 
		
			<button type="button" class="Clock" onclick="onShowBeginTime(txtBeginDate_1,spanBeginDate_1,txtEndDate_1,spanEndDate_1,txtBeginTime_1,spanBeginTime_1,txtEndTime_1,spanEndTime_1,txtWorkLong_1)"></button>
			<div class="e8_innerShow e8_innerShowMust">
				<span name="managerspanimg" class="e8_spanFloat" id="managerspanimg">
				<img align="absmiddle" src="/images/BacoError_wev8.gif">
				</span>
			</div>
			<span id="spanBeginTime_1"></span>
			<input type="hidden" name="txtBeginTime" id="txtBeginTime_1" value="">
			
			</td>			
			</tr>
		
			</table>
			            
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