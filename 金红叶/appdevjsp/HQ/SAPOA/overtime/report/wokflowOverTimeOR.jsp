<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.text.SimpleDateFormat"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>
<jsp:useBean id="WorkTypeComInfo" class="weaver.workflow.workflow.WorkTypeComInfo" scope="page" />
<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
//weaver.general.AccountType.langId.set(user.getLanguage());
%>
<jsp:useBean id="RecordSet" class="weaver.conn.RecordSet" scope="page" />
<jsp:useBean id="ResourceComInfo" class="weaver.hrm.resource.ResourceComInfo" scope="page" />
<jsp:useBean id="DepartmentComInfo" class="weaver.hrm.company.DepartmentComInfo" scope="page" />

<HTML>
<HEAD>
<LINK href="/css/Weaver_wev8.css" type=text/css rel=STYLESHEET>
<script type="text/javascript" src="/appres/hrm/js/mfcommon_wev8.js"></script>
<script language=javascript src="/js/ecology8/hrm/HrmSearchInit_wev8.js"></script>
<style>
	.checkbox {
		display: none
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

int typeid=Util.getIntValue(request.getParameter("typeid"),0);
String wfname = Util.null2String(request.getParameter("wfname"));
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
			<brow:browser viewType="0"  name="name" browserValue="<%=name %>"
				browserOnClick=""
				browserUrl="/systeminfo/BrowserMain.jsp?url=/hrm/resource/MultiResourceBrowserByRight.jsp?selectedids="
				hasInput="true" isSingle="false" hasBrowser = "true" isMustInput='1'
				completeUrl="/data.jsp" width="265px"
				browserSpanValue="<%=Util.toScreen(ResourceComInfo.getResourcename(name),user.getLanguage())%>">
			</brow:browser>
		</wea:item>
			
		<wea:item>流程类型</wea:item>
		<wea:item>
			<brow:browser viewType="0" name="typeid"
					browserValue='<%=typeid+"" %>'
					browserUrl="/systeminfo/BrowserMain.jsp?url=/workflow/workflow/WorkTypeBrowser.jsp"
					_callback="" width="250px"
					hasInput="false" isSingle="true" hasBrowser="true"
					isMustInput="1" completeUrl="/data.jsp"
					browserDialogWidth="600px"
					browserSpanValue='<%=WorkTypeComInfo.getWorkTypename(typeid+"")%>'>
				</brow:browser>
		</wea:item>	
		
		<wea:item>流程名</wea:item>
		<wea:item>
			<input type=text name=wfname class=Inputstyle size="30" value='<%=wfname%>'>
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
	<%
	
	String wk_ids = "";
	
	if(!"".equals(name)){
		wk_ids = wk_ids + " and id in (" + name + ") ";
	}
	if(!"".equals(toDate)){
		wk_ids = wk_ids + " and id in (" + name + ") ";
	}
	if(typeid > 0){
		
	}
	if(!"".equals(wfname)){
		
	}
	
	String pending1 = " wfPendingMattersNum(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
	String pending2 = " getDoOver(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String pending3 = " getDoOverS(workcode,1440,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String pending4 = " getDoOverE(workcode,1440,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
	String pending5 = " getDoOverE(workcode,2880,'" + toDate + "'," + typeid + ",'" + wfname + "') ";
	
	String doneWf1 = " wfProcessedMattersNum(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String doneWf2 = " getDoneOver(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String doneWf3 = " wfOvertimeAutoDealNum(workcode,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String doneWf4 = " getDoneOverS(workcode,1440,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String doneWf5 = " getDoneOverS(workcode,2880,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	String doneWf6 = " getDoneOverE(workcode,2880,'" + toDate + "'," + typeid + ",'" + wfname + "')  ";
	 
	String backfields = " id,workcode,lastname,departmentid,jobtitle," + pending1 + " as pNum,"
		+" " + pending2 + " as pOver," + pending3 + " as pOverS," + pending4 + " as pOverE1," + pending5 + " as pOverE2, "
		+" " + doneWf1 + " as dNum," + doneWf2 + " as dOver," + doneWf3 + " dAuto ,"
		+" " + doneWf4 + " as dOverS1," + doneWf5 + " as dOverS2," + doneWf6 + " as dOverE "; 
	String fromSql  = " from hrmresource ";
	String sqlWhere = " where status in(0,1,2,3) and (getEmpISLook("+curr_user+",id,1346) > 0 or  id = "+curr_user+")";
	if(!"".equals(name)){
		sqlWhere = sqlWhere + " and id in (" + name + ") ";
	}

	String orderby = " id " ;
	String tableString = "";


// out.println("select " + backfields + " " +fromSql + sqlWhere);
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageId,user.getUID(),pageId)+"\" pageId=\""+pageId+"\">"+
		" <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
	operateString+
    " <head>";                                                                                                                                                  
	tableString+="	<col width=\"6%\"  text=\"工号\" column=\"workcode\" orderkey=\"workcode\"  />"+
	  " <col width=\"7%\" text=\"姓名\" column=\"lastname\" orderkey=\"lastname\" />"+
	  " <col width=\"10%\" text=\"部门\" column=\"departmentid\" orderkey=\"departmentid\" transmethod=\"weaver.hrm.company.DepartmentComInfo.getDepartmentname\"  />"+
	 " <col width=\"9%\" text=\"职务\" column=\"jobtitle\" orderkey=\"jobtitle\" transmethod=\"weaver.hrm.job.JobTitlesComInfo.getJobTitlesname\" />"+
	 " <col width=\"6%\" text=\"待办流程数\" column=\"pNum\" orderkey=\"pNum\" linkkey=\"workcode\" linkvaluecolumn=\"workcode\"  href=\"/tmc/report/finance/borrow/rmbBorrowFrame.jsp\" />"+
	  " <col width=\"6%\" text=\"待办已超时数\" column=\"pOver\" orderkey=\"pOver\"   />"+
	  " <col width=\"6%\" text=\"待办1天内超时数\" column=\"pOverS\" orderkey=\"pOverS\"   />"+
	" <col width=\"6%\" text=\"待办1天后超时数\" column=\"pOverE1\" orderkey=\"pOverE1\"   />"+
	" <col width=\"6%\" text=\"待办2天后超时数\" column=\"pOverE2\" orderkey=\"pOverE2\"   />"+
	" <col width=\"6%\" text=\"已办流程数\" column=\"dNum\" orderkey=\"dNum\"   />"+
	" <col width=\"6%\" text=\"已办总超时数\" column=\"dOver\" orderkey=\"dOver\"   />"+
	" <col width=\"6%\" text=\"超时自动处理数\" column=\"dAuto\" orderkey=\"dAuto\"   />"+
	" <col width=\"6%\" text=\"超时1天处理\" column=\"dOverS1\" orderkey=\"dOverS1\"   />"+
	" <col width=\"6%\" text=\"超时2天处理\" column=\"dOverS2\" orderkey=\"dOverS2\"   />"+
	" <col width=\"6%\" text=\"超时2天以上处理\" column=\"dOverE\" orderkey=\"dOverE\"   />"+
      " </head>"+
      " </table>";
%>
	<wea:SplitPageTag isShowTopInfo="false" tableString="<%=tableString%>" mode="run" />

	<script type="text/javascript">
		
	//搜索
	function OnSearch(){
		jQuery("#report").submit();
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
	</script>
		<SCRIPT language="javascript" src="/js/datetime_wev8.js"></script>
	<SCRIPT language="javascript" defer="defer" src="/js/JSDateTime/WdatePicker_wev8.js"></script>
	<script type="text/javascript" src="/js/selectDateTime_wev8.js"></script>
</BODY>
</HTML>
