<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page" />
<jsp:useBean id="WorkflowComInfo" class="weaver.workflow.workflow.WorkflowComInfo" scope="page" />
<jsp:useBean id="xssUtil" class="weaver.filter.XssUtil"/>
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="rs" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />
<jsp:useBean id="JobTitlesComInfo" class="weaver.hrm.job.JobTitlesComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<style>
	.checkbox {
		display: none
	}
	.td1 {
		text-align:center;
		height:30px; 
	}
	.e8_btn_submit{
		padding-left:18px !important;
		padding-right:18px !important;
		height:30px;
		line-height:30px;
	}
	.e8_btn_cancel{
		padding-left:18px !important;
		padding-right:18px !important;
		height:30px;
		line-height:30px;
	}
	.e8_sep_line{
		height:30px;
		top:2px;
		line-height:30px;
		position:relative;
		color:#cccccc;
	}
</style>

</head>
<%
String imagefilename = "/images/hdReport_wev8.gif";
String titlename =SystemEnv.getHtmlLabelName(20536,user.getLanguage());
String needfav ="1";
String needhelp ="";

int curr_user = user.getUID();

String name = Util.null2String(request.getParameter("name"));
if(name.length() < 1) {
	name = "" + curr_user;
}

String hrmname = "";
String names[] = name.split(",");
String uFlag = "";
for(String tName : names){
	hrmname = hrmname + ResourceComInfo.getLastname(tName);
	uFlag = ",";
}

int typeid=Util.getIntValue(request.getParameter("typeid"),0);
int wfname = Util.getIntValue(Util.null2String(request.getParameter("wfname")),0);
String toDate = Util.null2String(request.getParameter("toDate"));

Calendar calendar = Calendar.getInstance();
calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - 30);
Date today = calendar.getTime();
SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
String result = format.format(today);


if(toDate.length() != 10){
	toDate = result;
}
String pageId = "JG2018062201";
%>

<BODY>
<div id="tabDiv">
	<span class="toggleLeft" id="toggleLeft" title="<%=SystemEnv.getHtmlLabelName(32814,user.getLanguage()) %>"><%=SystemEnv.getHtmlLabelName(20536,user.getLanguage()) %></span>
</div>
<div id="dialog">
 <div id='colShow'></div>
</div>
<input type="hidden" name="pageId" id="pageId" value="<%= pageId %>"/>
	<%@ include file="/systeminfo/TopTitle_wev8.jsp" %>
	<%@ include file="/systeminfo/RightClickMenuConent_wev8.jsp" %>
<%
	RCMenu += "{"+SystemEnv.getHtmlLabelName(197,user.getLanguage())+",javascript:onBtnSearchClick(),_self} " ;
	RCMenuHeight += RCMenuHeightStep ;
%>
	<%@ include file="/systeminfo/RightClickMenu_wev8.jsp" %>




	
</div>

	<br>
	<FORM id=report name=report action="wfOverTimeOR.jsp" method=post>
<div align="center">
	<wea:layout type="4col" attributes="{'expandAllGroup':'true'}">
	 <wea:group context='基本查询'>
		<wea:item>日期</wea:item>
		<wea:item>
				<BUTTON type=button class=calendar id=SelectDate onclick=onShowDate(toDateSpan,toDate)></BUTTON>&nbsp;
					    <SPAN id=toDateSpan ><%=toDate%></SPAN>
					    <input class="inputstyle" type="hidden" id="toDate" name="toDate" value="<%=toDate%>">
		</wea:item>
		
		<wea:item>姓名</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="name" browserValue='<%=name %>' 
					browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MutiResourceBrowser.jsp?resourceids="
					hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='2'
					completeUrl="/data.jsp?type=1" width="328px" browserSpanValue='<%=hrmname %>' >
			</brow:browser>
		</wea:item>
			
		<wea:item>流程类型</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="typeid"
					browserValue='<%=typeid+"" %>'
					browserUrl="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkTypeBrowser.jsp"
					_callback="" width="328px"
					hasInput="true" isSingle="true" hasBrowser="true"
					isMustInput="1" completeUrl="/data.jsp"
					browserDialogWidth="600px"
					browserSpanValue='<%=WorkTypeComInfo.getWorkTypename(typeid+"")%>'>
				</brow:browser>
			
		</wea:item>	
		
		<wea:item>流程名</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="wfname" browserValue='<%=wfname==0?"":(String.valueOf(wfname))%>' 
			 	browserUrl='<%="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkflowBrowser.jsp?sqlwhere="+xssUtil.put("where isbill=1 and formid<0") %>'
				hasInput="true" isSingle="true" hasBrowser = "true" isMustInput="1"
				completeUrl="/data.jsp" linkUrl=""  width="328px" onPropertyChange="updateBrowserSpan()"
				browserDialogWidth="600px"
				browserSpanValue='<%=WorkflowComInfo.getWorkflowname(String.valueOf(wfname))%>'>
			</brow:browser>
		</wea:item>
	</wea:group>
	</wea:layout>
	
	<br>
	<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
	<span class="e8_sep_line">|</span>
	<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
		
</div>
</FORM>
	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function resetCondtion(){
		var nowDate = '<%=result%>';
		jQuery("#toDateSpan").text(nowDate);
		jQuery("#toDate").val(nowDate);
		
		var empID = '<%=curr_user%>';
		var empName = '<%=ResourceComInfo.getLastname(""+curr_user)%>';
		jQuery("#namespan").text(empName);
		jQuery("#name").val(empID);
		
		jQuery("#typeidspan").text("");
		jQuery("#typeid").val("");
		
		jQuery("#wfnamespan").text("");
		jQuery("#wfname").val("");
				
	}	
	
	function openDoneList(name) {
		var url = "/tmc/wfDoneList2.jsp?name="+name+"&typeid=<%=typeid%>&wfname=<%=wfname%>&toDate=<%=toDate%>";
		window.open(url); 
	}
	
	function openDoneAutoInfo(name) {
		var url = "/tmc/wfDoneList1.jsp?name="+name+"&typeid=<%=typeid%>&wfname=<%=wfname%>&toDate=<%=toDate%>";
		window.open(url); 
	}
	
	function openDoneInfo(searchType,name) {
		var url = "/tmc/wfDoneList.jsp?name="+name+"&searchType="+searchType+"&typeid=<%=typeid%>&wfname=<%=wfname%>&toDate=<%=toDate%>";
		window.open(url); 
	}
	
	function openNewInfo(searchType,name) {
		var url = "/tmc/wfPendingList.jsp?name="+name+"&searchType="+searchType+"&typeid=<%=typeid%>&wfname=<%=wfname%>";
		
	//	var diag_vote = new window.top.Dialog();
	//	diag_vote.currentWindow = window;
	//	diag_vote.Width = 1400;
	//	diag_vote.Height = 750;
	//	diag_vote.Modal = true;
	//	diag_vote.Title = title;
	//	diag_vote.URL = url;
	//	diag_vote.isIframe=false;
	//	diag_vote.show();
	
		window.open(url); 
	}
	
	function onCheckup(){
		if(window.confirm('你是否确认打印吗？')){
			var ids = _xtable_CheckedCheckboxId();
			if(ids != ""){
				openNewInfo(ids);
			}else{
	        	top.Dialog.alert("<%=SystemEnv.getHtmlLabelName(20149,user.getLanguage())%>");
	    	}
	    }
	}
	function onShowSubcompanyid1(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/SubcompanyBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#subcompanyid1span").html(data.name);
				jQuery("#subcompanyid1").val(data.id);
				makechecked();
			}else{
				jQuery("#subcompanyid1span").html("");
				jQuery("#subcompanyid1").val("");
			}
		}
	}
	
	function onShowDepartmentid(){
		data = window.showModalDialog("/systeminfo/BrowserMain.jsp?url=/hrm/company/DepartmentBrowser.jsp");
		if (data!=null){
			if (data.id!= ""){
				jQuery("#departmentidspan").html(data.name);
				jQuery("#departmentid").val(data.id);
				makechecked();
			}else{
				jQuery("#departmentidspan").html("");
				jQuery("#departmentid").val("");
			}
		}
	}
	
		function makechecked() {
			if ($GetEle("subcompanyid1").value != "") {
				$($GetEle("chkSubCompany")).css("display", "");
				$($GetEle("lblSubCompany")).css("display", "");
			} else {
				$($GetEle("chkSubCompany")).css("display", "none");
				$($GetEle("chkSubCompany")).attr("checked", "");
				$($GetEle("lblSubCompany")).css("display", "none");
			}
			jQuery("body").jNice();
		}
		function onBtnSearchClick() {
			report.submit();
		}
		function setCheckbox(chkObj) {
			if (chkObj.checked == true) {
				chkObj.value = 1;
			} else {
				chkObj.value = 0;
			}
		}
			function updateBrowserSpan(){
		if(event.propertyName=='value'){
			var title = $("#workflowidspan").find("a").text();
			$("#workflowidspan").html("<span class=\"e8_showNameClass\">"+title+"</span>");
		}
	}
	</script>
	<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
