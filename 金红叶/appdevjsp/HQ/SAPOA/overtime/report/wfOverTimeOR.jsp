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
	.th1 {
		text-align:center;
		height:26px; 
		background-color:#EDFAF8;
	}
	
	.table-head{padding-right:17px;}
	.table-body{width:100%; height:500px; overflow-y:scroll;}
	.table-head table,.table-body table{width:100%;}
	.table-body table tr:nth-child(2n+1){background-color:#f2f2f2;}
	
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
	hrmname = hrmname + uFlag + ResourceComInfo.getLastname(tName);
	uFlag = ",";
}

int typeid=Util.getIntValue(request.getParameter("typeid"),0);
int wfname = Util.getIntValue(Util.null2String(request.getParameter("wfname")),0);
String toDate = Util.null2String(request.getParameter("toDate"));
if(toDate.length() != 10){
	Calendar calendar = Calendar.getInstance();
	calendar.set(Calendar.DAY_OF_YEAR, calendar.get(Calendar.DAY_OF_YEAR) - 30);
	Date today = calendar.getTime();
	SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
	String result = format.format(today);
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
<FORM id=report name=report action="" method=post>
	<input type="hidden" name="ids" value="">
		<table id="topTitle" cellpadding="0" cellspacing="0">
			<tr>
				<td>
					</td>
					<td class="rightSearchSpan" style="text-align:right;">
						<span id="advancedSearch" class="advancedSearch" style="display:;"><%=SystemEnv.getHtmlLabelNames("347",user.getLanguage())%></span>
						<span title="<%=SystemEnv.getHtmlLabelNames("23036",user.getLanguage())%>" class="cornerMenu"></span>
					</td>
			</tr>
		</table>

	<div class="advancedSearchDiv" id="advancedSearchDiv" style="display:none;">

<wea:layout type="4col">
	<wea:group context="<%=SystemEnv.getHtmlLabelNames("15774",user.getLanguage()) %>">
		
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
	
	<wea:group context="">
		<wea:item type="toolbar">
			<input class="e8_btn_submit" type="submit" name="submit_1" onClick="OnSearch()" value="<%=SystemEnv.getHtmlLabelName(197, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input class="e8_btn_cancel" type="button" name="reset" onclick="resetCondtion()" value="<%=SystemEnv.getHtmlLabelName(2022, user.getLanguage()) %>"/>
			<span class="e8_sep_line">|</span>
			<input type="button" value="<%=SystemEnv.getHtmlLabelName(31129,user.getLanguage())%>" class="e8_btn_cancel" id="cancel"/>
		</wea:item>
	</wea:group>
	
</wea:layout>

</div>
</FORM>
	<br>
	
<div align="center" style="width: 99%;">
	<div class="table-head">
	 <table border="1" bordercolor="#a0c6e5" style="border-collapse:collapse;"  width="100%" align="center">
	 	 <colgroup>
		 	 <col width="3%"></col> <col width="6%"></col> <col width="11%"> </col> <col width="15%"></col> <col width="11%"></col> 
			<col width="6%"></col> <col width="6%"></col> <col width="6%"> </col> <col width="6%"></col> 
			<col width="6%"></col> <col width="6%"></col> <col width="6%"></col> <col width="6%"> </col> 
			<col width="6%"></col>
	 	 </colgroup>
		<thead>
	 	 <tr>
			<th rowspan="2" class="th1">序号</th>
			<th rowspan="2" class="th1">工号</th>
			 <th rowspan="2" class="th1">姓名</th>
			 <th rowspan="2" class="th1">部门</th>
			 <th rowspan="2" class="th1">职务</th>
			 <th colspan="4" class="th1"> 待办</th>
			 <th colspan="5" class="th1">已办 </th>
		 </tr>
		<tr>
			 <th class="th1">流程数</th><th class="th1">已超时</th><th class="th1">1天内超时</th><th class="th1">1天后超时</th>	
			 <th class="th1">流程数</th><th class="th1">已超时</th><th class="th1">超时自动</th><th class="th1">超时1天</th><th class="th1">超时>1天</th>
		 </tr>
		</thead>
	</table>
    </div>
    <div class="table-body">
    <table>
    		<colgroup>
		 	 <col width="3%"></col> <col width="6%"></col> <col width="11%"> </col> <col width="15%"></col> <col width="11%"></col> 
			<col width="6%"></col> <col width="6%"></col> <col width="6%"> </col> <col width="6%"></col> 
			<col width="6%"></col> <col width="6%"></col> <col width="6%"></col> <col width="6%"> </col> 
			<col width="6%"></col>
	 	</colgroup>
		<tbody>
	<%
		String pending1 = " wfPendingMattersNum(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
		String pending2 = " getDoOver(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		String pending3 = " getDoOverS(workcode,480,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
//		String pending4 = " getDoOverE(workcode,480,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
		String pending4 = " '' ";
//		String pending5 = " getDoOverE(workcode,960,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
		String pending5 = " getDoOverE(workcode,480,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
		
		String doneWf1 = " wfProcessedMattersNum(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		String doneWf2 = " getDoneOver(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		String doneWf3 = " wfOvertimeAutoDealNum(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		String doneWf4 = " getDoneOverS(workcode,480,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
//		String doneWf5 = " getDoneOverS(workcode,960,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		String doneWf5 = " '' ";
//		String doneWf6 = " getDoneOverE(workcode,960,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		String doneWf6 = " getDoneOverE(workcode,480,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
		 
		String backfields = " id,workcode,lastname,departmentid,jobtitle," + pending1 + " as pNum,"
			+" " + pending2 + " as pOver," + pending3 + " as pOverS," + pending4 + " as pOverE1," + pending5 + " as pOverE2, "
			+" " + doneWf1 + " as dNum," + doneWf2 + " as dOver," + doneWf3 + " as dAuto ,"
			+" " + doneWf4 + " as dOverS1," + doneWf5 + " as dOverS2," + doneWf6 + " as dOverE "; 
		String fromSql  = " from hrmresource ";
		String sqlWhere = " where status in(0,1,2,3) and (getEmpISLook("+curr_user+",id,1346) > 0 or  id = "+curr_user+")";
		if(!"".equals(name)){
			sqlWhere = sqlWhere + " and id in (" + name + ") ";
		}
		
		String sql = "select " + backfields + " " +fromSql + sqlWhere;
		//out.println("sql = " + sql);
		 rs.executeSql(sql);
		 String tmpTrStart = "<td class=\"td1\">"; 
		 String tmpTrEnd = "</td>";
		 int flag = 1;
		while(rs.next()){
			String tmpID = Util.null2String(rs.getString("id"));
			String workcode = Util.null2String(rs.getString("workcode"));
			String lastname = Util.null2String(rs.getString("lastname"));
			String departmentid = Util.null2String(rs.getString("departmentid"));
			String jobtitle = Util.null2String(rs.getString("jobtitle"));
			String pNum = Util.null2String(rs.getString("pNum"));
			String pOver = Util.null2String(rs.getString("pOver"));
			String pOverS = Util.null2String(rs.getString("pOverS"));
			String pOverE1 = Util.null2String(rs.getString("pOverE1"));
			String pOverE2 = Util.null2String(rs.getString("pOverE2"));
			String dNum = Util.null2String(rs.getString("dNum"));
			String dOver = Util.null2String(rs.getString("dOver"));
			String dAuto = Util.null2String(rs.getString("dAuto"));
			String dOverS1 = Util.null2String(rs.getString("dOverS1"));
			String dOverS2 = Util.null2String(rs.getString("dOverS2"));
			String dOverE = Util.null2String(rs.getString("dOverE"));
			out.println("<tr>");
			out.println(tmpTrStart);out.println(flag++);out.println(tmpTrEnd); // 序号
			
			out.println(tmpTrStart);out.println(workcode);out.println(tmpTrEnd);	// 工号
			out.println(tmpTrStart);out.println(lastname);out.println(tmpTrEnd);	// 姓名
			out.println(tmpTrStart);out.println(DepartmentComInfo.getDepartmentname(departmentid));out.println(tmpTrEnd);	// 部门
			out.println(tmpTrStart);out.println(JobTitlesComInfo.getJobTitlesname(jobtitle));out.println(tmpTrEnd);	// 职务
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openNewInfo(0,"+tmpID+");\">"); out.println(pNum);out.println("</a>");
			out.println(tmpTrEnd);	// 流程数
			
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openNewInfo(1,"+tmpID+");\">"); out.println(pOver); out.println("</a>");
			out.println(tmpTrEnd);	// 已超时数
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openNewInfo(2,"+tmpID+");\">"); out.println(pOverS); out.println("</a>");
			out.println(tmpTrEnd);	// 1天内超时数
			
	//		out.println(tmpTrStart);
	//		out.println("<a href=\"javascript:openNewInfo(3,"+tmpID+");\">"); out.println(pOverE1); out.println("</a>");
	//		out.println(tmpTrEnd);	// 1天后超时数
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openNewInfo(4,"+tmpID+");\">"); out.println(pOverE2); out.println("</a>");
			out.println(tmpTrEnd);	// 1天后超时数
			
	//		out.println(tmpTrStart);
//			out.println("<a href=\"javascript:openNewInfo(4,"+tmpID+");\">"); out.println(pOverE2); out.println("</a>");
	//		out.println(tmpTrEnd);	// 2天后超时数
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openDoneList("+tmpID+");\">");out.println(dNum);out.println("</a>");
			out.println(tmpTrEnd);	// 流程数
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openDoneInfo(1,"+tmpID+");\">"); out.println(dOver); out.println("</a>");
			out.println(tmpTrEnd);	// 总超时数
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openDoneAutoInfo("+tmpID+");\">"); out.println(dAuto); 	out.println("</a>");
			out.println(tmpTrEnd);	// 超时自动处理数
			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openDoneInfo(2,"+tmpID+");\">"); out.println(dOverS1); out.println("</a>");
			out.println(tmpTrEnd);	// 超时1天处理
			
	//		out.println(tmpTrStart);
	//		out.println("<a href=\"javascript:openDoneInfo(3,"+tmpID+");\">"); out.println(dOverS2); out.println("</a>");
	//		out.println(tmpTrEnd);	// 超时2天处理
			
	//		out.println(tmpTrStart);
	//		out.println("<a href=\"javascript:openDoneInfo(4,"+tmpID+");\">"); out.println(dOverE); out.println("</a>");
	//		out.println(tmpTrEnd);	// 超时2天以上处理

			
			out.println(tmpTrStart);
			out.println("<a href=\"javascript:openDoneInfo(4,"+tmpID+");\">"); out.println(dOverE); out.println("</a>");
			out.println(tmpTrEnd);	// 超时1天以上处理
			
			out.println("</tr>");
		}
	%>
	 </tbody>
	</table>
</div>

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
	}	
	
	function openDoneList(name) {
		var url = "wfDoneList2.jsp?name="+name+"&typeid=<%=typeid%>&wfname=<%=wfname%>&toDate=<%=toDate%>";
		window.open(url); 
	}
	
	function openDoneAutoInfo(name) {
		var url = "wfDoneList1.jsp?name="+name+"&typeid=<%=typeid%>&wfname=<%=wfname%>&toDate=<%=toDate%>";
		window.open(url); 
	}
	
	function openDoneInfo(searchType,name) {
		var url = "wfDoneList.jsp?name="+name+"&searchType="+searchType+"&typeid=<%=typeid%>&wfname=<%=wfname%>&toDate=<%=toDate%>";
		window.open(url); 
	}
	
	function openNewInfo(searchType,name) {
		var url = "wfPendingList.jsp?name="+name+"&searchType="+searchType+"&typeid=<%=typeid%>&wfname=<%=wfname%>";
		
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
