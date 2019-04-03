<%@ page language="java" contentType="text/html; charset=UTF-8"%>
<%@ page import="weaver.general.Util"%>
<%@ page import="java.util.*,weaver.hrm.appdetach.*"%>
<%@ include file="/systeminfo/init_wev8.jsp" %>
<%@ taglib uri="/WEB-INF/weaver.tld" prefix="wea"%>
<%@ taglib uri="/browserTag" prefix="brow"%>

<%
Integer lg=(Integer)user.getLanguage();
weaver.general.AccountType.langId.set(lg);
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
int typeid = Util.getIntValue(request.getParameter("typeid"),0);
int wfname = Util.getIntValue(Util.null2String(request.getParameter("wfname")),0);
String toDate = Util.null2String(request.getParameter("toDate"));

int searchType = Util.getIntValue(request.getParameter("searchType"),0);
String pageId = "JG2018062204";
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

						
	</wea:group>
	
	<wea:group context="">

	</wea:group>
	
</wea:layout>

</div>
	</FORM>
	<%
	
	String wk_ids = "";
	String backfields = " id,getwfcreater(requestid) as creator,requestid,receivedate||' '||receivetime as tDateTime,getwfNower(requestid) as userid,"
       				+" nvl(isreminded,0) as isreminded,case isprocessed when '1' then 'Y' when '2' then 'Y' else 'N' end as isprocessed,"
       				+" OPERATEDATE||' '||OPERATETIME as opDateTime,getAddDateTime(receivedate,substr(receivetime, 0, 8),(select max(nodepasshour * 60 + nodepassminute) from workflow_nodelink w where w.nodeid = f.nodeid)) as adt "; 
	String fromSql  = " from WorkflowProcessedMattersView f ";
	String sqlWhere = " where (getEmpISLook("+curr_user+",userid,1346) > 0 or  userid = " + curr_user + ") ";
	if(!"".equals(name)){
		sqlWhere = sqlWhere + " and f.userid in (select id from hrmresource where workcode in(select workcode from hrmresource where id = " + name + ")) ";
	}
	if(typeid > 0){
		sqlWhere = sqlWhere + " and f.workflowid in(select id from workflow_base where workflowtype = '" + typeid + "') ";
	}
	if(wfname > 0){
		sqlWhere = sqlWhere + " and f.workflowid = '" + wfname + "' ";
	}
	if(!"".equals(toDate)){
		sqlWhere = sqlWhere + " and f.receivedate &gt;=  '" + toDate + "' ";
	}

	String orderby = " id " ;
	String tableString = "";

//out.println("select " + backfields + " " +fromSql + sqlWhere);
//  右侧鼠标 放上可以点击
String  operateString= "";
operateString = "";	
tableString =" <table tabletype=\"checkbox\" pagesize=\""+ PageIdConst.getPageSize(pageId,user.getUID(),pageId)+"\" pageId=\""+pageId+"\">"+
		" <sql backfields=\""+backfields+"\" sqlform=\""+fromSql+"\" sqlwhere=\""+Util.toHtmlForSplitPage(sqlWhere)+"\"  sqlorderby=\""+orderby+"\"  sqlprimarykey=\"id\" sqlsortway=\"desc\" sqlisdistinct=\"false\"/>"+
	operateString+
    " <head>";                                                                                                                                                  
	tableString +=
	  " <col width=\"5%\"  text=\"流程号\" column=\"requestid\" orderkey=\"requestid\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"  href=\"/workflow/request/ViewRequest.jsp\"  />"+
	  " <col width=\"17%\" text=\"流程名称\" column=\"requestid\" orderkey=\"requestid\"  transmethod=\"weaver.workflow.workflow.WorkflowRequestComInfo.getRequestName\" linkkey=\"requestid\" linkvaluecolumn=\"requestid\"  href=\"/workflow/request/ViewRequest.jsp\"  />"+
	  " <col width=\"5%\" text=\"创建人\" column=\"creator\" orderkey=\"creator\" transmethod=\"weaver.hrm.resource.ResourceComInfo.getLastname\"  />"+
	 " <col width=\"12%\" text=\"到达日期\" column=\"tDateTime\" orderkey=\"tDateTime\"  />"+
	 " <col width=\"12%\" text=\"超时时间\" column=\"adt\" orderkey=\"adt\" />"+
	  " <col width=\"12%\" text=\"审批完成时间\" column=\"opDateTime\" orderkey=\"opDateTime\"   />"+
//	  " <col width=\"7%\" text=\"剩余时间\" column=\"pOverS\" orderkey=\"pOverS\"   />"+
	" <col width=\"6%\" text=\"自动流转标识\" column=\"isprocessed\" orderkey=\"isprocessed\"   />"+
	" <col width=\"7%\" text=\"当前处理人\" column=\"userid\" orderkey=\"userid\" />"+
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
